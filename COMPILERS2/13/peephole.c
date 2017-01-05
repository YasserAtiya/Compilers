/*
 * Yasser Atiya
 * Assignment 7
 * Peephole Optimizer
 * 11/8/2016
 */
#include <stdio.h>
#include <stdlib.h>
#include "opt.h"
#include "io.h"
#include "misc.h"
#include "vars.h"
#include "opts.h"
#include "strings.h"

extern int numpeeprules;
const int MAXLINES = 200;

//Struct for parsed line of rules.txt
struct Line
{
   //Text
   char *text;
   //Flag for 3 argument instruction
   int threeargs;
   //Dead variables after instruction
   char *deads;
   //Arguments that must be registers only
   char *regsonly;
   //String for actual instruction name
   char *instruction;
   //All passed in arguments, with commas
   char *arguments;
   //First argument
   char *argument1;
   //Second argument
   char *argument2;
   //Third argument
   char *argument3;

   //Wild arguments
   int wildargs;
   //Flag stating that entire line is wildcard
   int wildline;
   //Flag stating that instruction mneumonic is wildcard
   int wildinst;

   //Argument 1 is literal
   int arg1lit;
   //Argument 2 is literal
   int arg2lit;
   //Argument 3 is literal
   int arg3lit;
};


//Struct for entire rule in rules.txt
struct Rule
{
   //Array of pointers to match lines
   struct Line *matchlines[200];

   //Array of pointers to replacement lines
   struct Line *replacelines[200];

   //Number of matchlines
   int nummatchlines;

   //Number of replacelines
   int numreplacelines;

   //$ arguments
   char *arguments[200];

};

struct Rule Rules[MAXRULES];



//Parse rule for individual lines
struct Line* parseline(char* rule);
//Define deads field and registersonly field for current line object
int grabdeadsandregisters(struct Line *line);
//Check if matchline matches instruction
int linematches(struct assemline *line, int rulenumber, int linenum);
//Check if all matchlines match in rule
int rulematches(struct assemline *line, int rulenumber);
//Replace all lines that match
struct assemline* replacelines(struct assemline *line, int rulenumber);
//Check to make sure all registers in regsonly field are registers in line
int regsonlymatch(struct assemline *line, int rulenumber, int linenum);
//Make sure all registers match for instruction and matchline
int regsmatch(struct assemline *line, int rulenumber, int linenum);
//Make sure deads match between instruction and matchline
int deadsmatch(struct assemline *line, int rulenumber, int linenum);
//Make sure instruction mneumonic matches between instruction and matchline
int instmatches(struct assemline *line, int rulenumber, int linenum);
//Reset all read in rules
void reinitializerules();

/*
 * readinrules - read in the peephole rules from the rules file
 */
void readinrules()
{

   int i = 0, secondhalf = 0;

   //File containting rules
   FILE *rulesfile;
   rulesfile = fopen("rules.txt","r");

   //Line read from file
   char line[MAXLINE];

   //Current line object being defined
   struct Line *curline;

   //Reinitialize number of peeprules
   numpeeprules = 0;
   //Set number of matchlines and replacelines to 0
   Rules[numpeeprules].nummatchlines = Rules[numpeeprules].numreplacelines = 0;

   //Make sure we have a rulesfile
   if(!rulesfile)
   {

   }

   //Find rules
   //Grab line at a time from rules.txt file
   while(fgets(line,MAXLINE,rulesfile))
   {

      //Catch '=' indicating change from matchlines to replacelines
      if(strstr(line,"="))
      {
         //Set flag that we are now reading replacelines rather than matchlines
         secondhalf = 1;
         //Reset line counter
         i = 0;
         continue;
      }
      //Catch newline indicating beginning of new rule
      else if(Rules[numpeeprules].numreplacelines == 1)
      {
         //Indicate beginning of new rule
         secondhalf = 0;
         //Increment number of peeprules
         numpeeprules++;

         //Reset number of read in lines
         Rules[numpeeprules].nummatchlines = 0;
         Rules[numpeeprules].numreplacelines = 0;
         continue;
      }
      //Parse line and assign it to new line in current rule
      else
      {
         //Parse line into different sections
         curline = parseline(line);

         //If parsing matchlines
         if(!secondhalf)
         {
            //Set current matchline to parsed line
            Rules[numpeeprules].
               matchlines[Rules[numpeeprules].nummatchlines] = curline;

            //Increment number of matchlines
            Rules[numpeeprules].nummatchlines++;

         }
         //If matching replace lines
         else
         {
            //Set current replace line to parsed line
            Rules[numpeeprules].
               replacelines[Rules[numpeeprules].numreplacelines] = curline;

            //Increment number of replace lines
            Rules[numpeeprules].numreplacelines++;
         }

         //Iterate current line counter
         i++;


      }


   }

   //Increment number of peeprules
   numpeeprules++;
}


/*
 * applypeeprules - apply peephole rules to the function
 */
void applypeeprules(int *changes)
{

   //First block of function
   extern struct bblk *top;

   //Counter variable
   int i;

   //Current block
   struct bblk *cblk;

   //Current line
   struct assemline *curline;

   //Array of count of applications of each rule
   extern int numrulesapplied[MAXRULES];

   //Loop through all blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {
      //Loop through lines in current block
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         //Ignore commentlines and define lines
         if(curline->type == DEFINE_LINE || curline->type == COMMENT_LINE)
            continue;

         //Iterate through peeprules and attempt to apply them to instruction
         for(i = 0; i < numpeeprules; i++)
         {

            //Reset arguments for current check
            reinitializerules();

            //If line matches last match line of rule, and line has predecessors
            if(linematches(curline, i,Rules[i].nummatchlines-1))
            {
               //Loop upwards and match previous lines to previous matchlines
               if(rulematches(curline,i))
               {
                  //If all are matched, replace matchlines with replacelines
                  curline = replacelines(curline,i);


                  //Increase counter for all peephole rules
                  incropt(PEEPHOLE_OPT);

                  //Increment counter for specific rule
                  numrulesapplied[i]+=1;

                  //Apply all rules again
                  i = 0;
               }

            }
         }
      }
   }
}

//If passed in line matches final line of rule
int linematches(struct assemline *line, int rulenumber, int linenum)
{

   //Current matchline being compared
   struct Line *curmatchline;
   curmatchline = Rules[rulenumber].matchlines[linenum];

   //If line is composed exclusively of wildcard
   if(curmatchline->wildline)
   {
      //Store entire line as argument to be used later
      Rules[rulenumber].
         arguments[atoi(strstr(curmatchline->instruction,"$")+1)] = line->text;
      return 1;
   }

   //Make sure inst matches
   if(instmatches(line,rulenumber,linenum) == 1)
   {
      //Check that registers match
      if(regsmatch(line,rulenumber,linenum) == 1)
      {
         //Check that deads match only
         if(line->deads && deadsmatch(line,rulenumber,linenum) == 1)
         {
            //Make sure regonly registers are registers
            if(regsonlymatch(line,rulenumber,linenum) == 1)
            {
               //Line matches
               return 1;
            }
         }
      }
   }

   //Line does not match if control flow reaches here
   return 0;
}

//When rule can be applied, replace matchlines with replaceline
struct assemline* replacelines(struct assemline *line, int rulenumber)
{
   //Counter for matchlines, flag for no previous line
   int i = 0, noprev = 0;

   //Holds replacement line text
   char newline[MAXLINE];

   //Current predeccesor of line
   struct assemline *curline, *prevline, *replaceline, *nextline;

   //Set current line being replaced
   curline = line;
   //Sets next line to be replaced
   prevline = curline->prev;




   //Loop through all previous lines and delete them, replace with replace line
   for(i = 0; i < Rules[rulenumber].nummatchlines; i++)
   {
      //Passover define lines and comment lines
      if(curline->type == DEFINE_LINE || curline->type == COMMENT_LINE)
      {

         //Undo increment
         i--;






         //Move to previous line and slide over all other pointers
         if(prevline->prev)
         {
            curline = prevline;
            prevline = prevline->prev;
            nextline = curline->next;
         }
         else
         {
            nextline = curline;
            curline = prevline;
            noprev = 1;
         }

         continue;

      }



      //Delete current line
      delline(curline);

      //Move to previous line
      if(prevline->prev)
      {
         curline = prevline;
         prevline = prevline->prev;
         nextline = curline->next;
      }
      else
      {
         nextline = curline;
         curline = prevline;
         noprev = 1;
      }




   }

   //Create line text
   //If entire line is not wildcard
   if(!Rules[rulenumber].replacelines[0]->wildline)
   {
      strcpy(newline, "\t");

      //If a wild instruction mneumonic
      if(Rules[rulenumber].replacelines[0]->wildinst)
      {

         //Index into arguements for actual mneumonic and cat it to newline text
         strcat(newline,Rules[rulenumber].
            arguments[atoi(Rules[rulenumber].replacelines[0]->instruction+1)]);

      }
      //Otherwise just cat mneumonic of matchline to newline text
      else
         strcat(newline,Rules[rulenumber].replacelines[0]->instruction);

      //Add second tab
      strcat(newline,"\t");

      //Check for first argument
      if(Rules[rulenumber].replacelines[0]->argument1)
      {

         //If not literal, index into argument array
         if(!Rules[rulenumber].replacelines[0]->arg1lit)
         {

            strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument1)]);

         }
         //If literal, concatenate to newline text
         else
            strcat(newline,Rules[rulenumber].replacelines[0]->argument1);
      }

      //Check for second argument
      if(Rules[rulenumber].replacelines[0]->argument2)
      {
         //Add comma
         strcat(newline,",");


         //If not literal, index into argument array
         if(!Rules[rulenumber].replacelines[0]->arg2lit)
            strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument2)]);
         //If literal, concatenate to newline text
         else
            strcat(newline,Rules[rulenumber].replacelines[0]->argument2);

      }

      //Check for third argument
      if(Rules[rulenumber].replacelines[0]->argument3)
      {
         strcat(newline,",");
         if(!Rules[rulenumber].replacelines[0]->arg3lit)
            strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument3)]);
         else
            strcat(newline,Rules[rulenumber].replacelines[0]->argument3);

      }

      strcat(newline,"\t");

   }
   //If entire line is wildcard
   else
   {

      strcpy(newline,Rules[rulenumber].
         arguments[atoi(strstr(Rules[rulenumber].
            replacelines[0]->instruction,"$")+1)]);
   }

   //Insert new line
   if(!noprev)
   {
      replaceline = insline(prevline->blk,prevline->next,newline);
   }
   else
   {
      replaceline = insline(prevline->blk,prevline->blk->lines,newline);
   }



   //Set up newline's info
   setupinstinfo(replaceline);




   //All lines matched return success
   return replaceline;
}

//Checks that Regs only field is validated
int regsonlymatch(struct assemline *line, int rulenumber, int linenum)
{


   //Create character arrays for all possible deads
   char* ruletoken;

   //Current matchline
   struct Line *curmatchline;

   curmatchline = Rules[rulenumber].matchlines[linenum];

   //Check to make sure there is a regsonly field
   if(!curmatchline->regsonly)
   {

      return 1;
   }

   ruletoken = strtok(curmatchline->deads,"$");

   //Iterate through every character after $ and index into array of arguments
   while(ruletoken)
   {
      //Grab character




      //Convert to int equivalent and use to index array, then check if isreg
      if(isreg(Rules[rulenumber].arguments[atoi(ruletoken)]) != 1)
         return 0;

      ruletoken = strtok(NULL,"%");

   }



   //If we have not returned 0 by now, we are successful
   return 1;
}

//Match deads
int deadsmatch(struct assemline *line, int rulenumber, int linenum)
{

   //Create character arrays for all possible deads
   char deads[MAXLINE], *token, *ruletoken;

   //Counter
   int i = 1;

   //Current match line
   struct Line *curmatchline;

   curmatchline = Rules[rulenumber].matchlines[linenum];

   //Dump varstate into character array
   dumpvarstate(deads,line->deads);

   //If one line has deads and the other doesn't
   if(!curmatchline->deads && deads)
      return 0;
   else if(varempty(line->deads) && !curmatchline->deads)
   {
      return 1;
   }

   //Tokenize line, with : delimiter
   token = strtok(deads,":");
   ruletoken = strtok(curmatchline->deads,"$");

   //Iterate through every character after $ and index into array of arguments
   while(ruletoken || token)
   {
      //If still deads for one of the lines
      if(!token || !ruletoken)
         return 0;

      //Index into array using character from matchline, and check it against
      if(strcmp(token,Rules[rulenumber].arguments[atoi(ruletoken)]) != 0)
         return 0;

      //Parse to next dead in line
      token = strtok(NULL,"%");
      ruletoken = strtok(NULL,"%");
   }


   return 1;
}

//Check if instruction mneumonic matches between two lines
int instmatches(struct assemline *line, int rulenumber, int linenum)
{
   //Current matchline
   struct Line *curmatchline;
   curmatchline = Rules[rulenumber].matchlines[linenum];

   //Compare inst mneumonic in both lines if it is not wild
   if(strcmp(curmatchline->instruction,line->items[0]) == 0 ||
      curmatchline->wildline == 1 || curmatchline->wildinst == 1)
   {
      //If instruction is wild
      if(curmatchline->wildinst == 1)
      {
         //Index into argument array and given instruction to element
         Rules[rulenumber].
         arguments[atoi(strstr(curmatchline->instruction,"$")+1)]
            = line->items[0];
      }
      //Return true
      return 1;
   }
   else
      return 0;
}


int regsmatch(struct assemline *line, int rulenumber, int linenum)
{

   //Assign all args

   struct Line *curmatchline;
   curmatchline = Rules[rulenumber].matchlines[linenum];

   //Check line registers to see $ numbers
   //Check first argument
   if(curmatchline->arg1lit)
   {

      if(strcmp(curmatchline->argument1,line->items[1]) != 0)
         return 0;
   }
   else
   {
      if(!Rules[rulenumber].arguments[atoi(curmatchline->argument1)])
         Rules[rulenumber].arguments[atoi(curmatchline->argument1)] =
            line->items[1];
      else
         if(strcmp(Rules[rulenumber].arguments[atoi(curmatchline->argument1)],
           line->items[1]) != 0)
            return 0;

   }

   //Check second argument
   if(curmatchline->arg2lit)
   {

      if(strcmp(curmatchline->argument2,line->items[2]) != 0)
         return 0;

   }
   else
   {

      if(curmatchline->argument2)
      {
         if(!Rules[rulenumber].arguments[atoi(curmatchline->argument2)])
            Rules[rulenumber].
               arguments[atoi(curmatchline->argument2)] = line->items[2];
         else
            if(strcmp(Rules[rulenumber].arguments[atoi(curmatchline->argument2)],
              line->items[2]) != 0)
               return 0;

      }

   }

   //Check third argument
   if(curmatchline->threeargs && line->numitems == 4)
   {



      if(curmatchline->arg3lit)
      {
         if(strcmp(curmatchline->argument3,line->items[3]) != 0)
            return 0;
      }
      else
      {
         if(!Rules[rulenumber].arguments[atoi(curmatchline->argument3)])
            Rules[rulenumber].arguments[atoi(curmatchline->argument3)]
              = line->items[3];
         else
            if(strcmp(Rules[rulenumber].arguments[atoi(curmatchline->argument3)],
              line->items[3]) != 0)
               return 0;
      }
   }
   else if(curmatchline->threeargs || line->numitems == 4)
      return 0;
   return 1;
}

//Iterate through all matchlines in rule to see if they match previous lines
int rulematches(struct assemline *line, int rulenumber)
{
   int i = 0;

   //Current predeccesor of line
   struct assemline *curline;

   curline = line;

   //Loop through all matchlines and match them to predecessors of line
   for(i = 0; i < Rules[rulenumber].nummatchlines; i++)
   {

      //Move to previous line
      if(curline->prev && i != 0)
         curline = curline->prev;
      //If no previous line, but previous matchline, return 0
      else if(!curline->prev)
      {
         return 0;
      }

      //Passover define lines and comment lines
      if(curline->type == DEFINE_LINE || curline->type == COMMENT_LINE)
      {
         i--;
         continue;
      }

      //If match line does not match previous line, return 0
      if(!linematches(curline,rulenumber,Rules[rulenumber].nummatchlines-(i+1)))
      {
         return 0;
      }

   }

   //All lines matched return success
   return 1;
}

/*
 * Parse matchlines and replacelines for arguments, deads, and regsonly
*/
struct Line* parseline(char* line)
{

   //Create line to hold details
   struct Line *curline;

   //Initialize line
   curline = malloc(sizeof(struct Line));
   curline->wildline = 0;
   curline->wildargs = 0;
   curline->wildinst = 0;
   curline->threeargs = 0;
   curline->arg1lit = 0;
   curline->arg2lit = 0;
   curline->arg3lit = 0;
   curline->arguments = NULL;
   curline->argument1 = NULL;
   curline->argument2 = NULL;
   curline->argument3 = NULL;
   curline->instruction = NULL;
   curline->deads = NULL;
   curline->regsonly = NULL;
   curline->text = allocstring(line);

   char *token, *holder;

   int tokencount = 0;

   int tabcount, wild = 0;

   //get the first token
   token = strtok(line, "\t");

   //Iterate through other tokens
   while(token != NULL)
   {
      //Grab instruction type first
      if(tokencount == 0)
      {
         //Assign instruction
         curline->instruction = allocstring(token);
         if(strstr(token,"$"))
         {
            wild = 1;
         }

         token = strtok(NULL, "\t");

      }
      //Grab arguments second time through
      else if(tokencount == 1)
      {
         //Assign arguments
         curline->arguments = allocstring(token);
         break;
      }

      //Increment count of tokens
      tokencount++;

   }

   if(!curline->regsonly && tokencount == 1)
   {
      tabcount = grabdeadsandregisters(curline);
   }



   //Reset count of tokens
   tokencount = 0;

   //Get the first token
   token = strtok(curline->arguments, ",");

   //Iterate through arguments
   while(token != NULL)
   {

      if(tokencount == 0)
      {
         //Grab all of tokens characters except first
         curline->argument1 = allocstring(token+1);
         if(!strstr(token,"$"))
         {
            curline->arg1lit = 1;
            curline->argument1 = allocstring(token);


         }
      }
      else if(tokencount == 1)
      {
         curline->argument2 = allocstring(token+1);
         if(!strstr(token,"$"))
         {
            curline->arg2lit = 1;
            curline->argument2 = allocstring(token);
         }
      }
      else if(tokencount == 2)
      {
         curline->argument3 = allocstring(token+1);
         curline->threeargs = 1;
         if(!strstr(token,"$"))
         {
            curline->arg3lit = 1;
            curline->argument3 = allocstring(token);
         }
      }

      tokencount++;
      token = strtok(NULL, ",");

   }



   if(curline->arguments && wild)
      curline->wildinst = 1;
   if(!curline->arguments && wild)
   {

      curline->wildline = 1;
   }
   if(!curline->argument2 && !strstr(curline->instruction,"b"))
      curline->wildargs = 1;

   return curline;

}

int grabdeadsandregisters(struct Line *line)
{
   int i = 0,tabcount = 0,oldtabcount = 0,strcount = 0;

   char str[MAXLINE] = "";

   //Count tabs
   for(i = 0; i < strlen(line->text); i++)
   {
      if(tabcount > 2 && line->text[i] != '\t')
      {
         str[strcount] = line->text[i];
         strcount++;
      }

      if(line->text[i] == '\t')
      {
         tabcount++;
      }

      if(oldtabcount != tabcount && oldtabcount == 3)
      {
         strcount = 0;
         line->deads = allocstring(str);
         strcpy(str,"");
      }

      oldtabcount = tabcount;

   }

   if(tabcount == 3)
   {
      if(str[strlen(str)-1] == '\n')
         str[strlen(str)-1] = '\0';
      line->deads = allocstring(str);
   }
   if(tabcount == 4)
   {
      if(str[strlen(str)-1] == '\n')
         str[strlen(str)-1] = '\0';
      line->regsonly = allocstring(str);
   }

   return tabcount;
}


void reinitializerules()
{
   int i = 0, j = 0;

   for(i = 0; i < numpeeprules; i++)
   {
      for(j = 0; j < 200; j++)
         Rules[i].arguments[j] = NULL;
   }

}
