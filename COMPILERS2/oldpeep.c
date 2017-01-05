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
   //Flag stating that entire line is wildcard
   int wildline;
   //
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
int grabdeadsandregisters(struct Line *line);
int linematches(struct assemline *line, int rulenumber, int linenum);
int rulematches(struct assemline *line, int rulenumber);
struct assemline* replacelines(struct assemline *line, int rulenumber);
int regsonlymatch(struct assemline *line, int rulenumber, int linenum);
int regsmatch(struct assemline *line, int rulenumber, int linenum);
int deadsmatch(struct assemline *line, int rulenumber, int linenum);
int instmatches(struct assemline *line, int rulenumber, int linenum);
void reinitializerules();

/*
 * readinrules - read in the peephole rules from the rules file
 */
void readinrules()
{

   int i = 0, secondhalf = 0;
   FILE *rulesfile;
   rulesfile = fopen("rules.txt","r");
   char line[MAXLINE];
   struct Line *curline;

   numpeeprules = 0;
   Rules[numpeeprules].nummatchlines = Rules[numpeeprules].numreplacelines = 0;

   if(!rulesfile)
   {
      fprintf(stderr, "Error: Rule file open failed!\n");
   }

   //Find rules
   //Grab line at a time from file
   while(fgets(line,MAXLINE,rulesfile))
   {

      curline = malloc(sizeof(struct Line));
      curline->wildline = 0;

      //Catch '=' indicating change from matchlines to replacelines
      if(strstr(line,"="))
      {
         secondhalf = 1;
         i = 0;
         continue;
      }
      //Catch newline indicating beginning of new rule
      else if(Rules[numpeeprules].numreplacelines == 1)
      {
         secondhalf = 0;
         numpeeprules++;
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
            Rules[numpeeprules].
               matchlines[Rules[numpeeprules].nummatchlines] = curline;
            Rules[numpeeprules].nummatchlines++;

         }
         //If matching replace lines
         else
         {
            Rules[numpeeprules].
               replacelines[Rules[numpeeprules].numreplacelines] = curline;
            Rules[numpeeprules].numreplacelines++;
         }

         //Iterate current line counter
         i++;

      }

   }
   numpeeprules++;
}


/*
 * applypeeprules - apply peephole rules to the function
 */
void applypeeprules(int *changes)
{
   extern struct bblk *top;

   int i;

   struct bblk *cblk;

   struct assemline *curline;

   extern int numrulesapplied[MAXRULES];

   //Loop through all blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {
      //Loop through lines in current block
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         if(curline->type == DEFINE_LINE || curline->type == COMMENT_LINE)
            continue;

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

                  //Increment counter
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

   struct Line *curmatchline;
   curmatchline = Rules[rulenumber].matchlines[linenum];

   //If line is composed exclusively of
   if(curmatchline->wildline)
   {
      Rules[rulenumber].
         arguments[atoi(strstr(curmatchline->instruction,"$")+1)] = line->text;
      return 1;
   }
   else if(!curmatchline)
      return 0;

   //Make sure inst matches
   if(instmatches(line,rulenumber,linenum) == 1)
   {
      //Check that registers match
      if(regsmatch(line,rulenumber,linenum) == 1)
      {
         //Check that deads match only
         if(line->deads && deadsmatch(line,rulenumber,linenum) == 1)
         {
            //Make sure regonly registers are registers DOES NOT WORK
            if(regsonlymatch(line,rulenumber,linenum) == 1)
            {
               //Line matches
               return 1;
            }
         }
      }
   }

   //Line does not match
   return 0;
}

struct assemline* replacelines(struct assemline *line, int rulenumber)
{
   int i = 0, noprev = 0;

   char newline[MAXLINE];

   //Current predeccesor of line
   struct assemline *curline, *prevline, *replaceline, *nextline;

   curline = line;
   prevline = curline->prev;

   //Loop through all previous lines and delete them, replace with replace line
   for(i = 0; i < Rules[rulenumber].nummatchlines; i++)
   {
      //Passover define lines and comment lines
      if(curline->type == DEFINE_LINE || curline->type == COMMENT_LINE)
      {

         //Undo increment
         i--;

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

         continue;

      }


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
   if(!Rules[rulenumber].replacelines[0]->wildline)
   {
      strcpy(newline, "\t");
      strcat(newline,Rules[rulenumber].replacelines[0]->instruction);
      strcat(newline,"\t");
      if(Rules[rulenumber].replacelines[0]->argument1)
      {
         strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument1)]);
      }
      if(Rules[rulenumber].replacelines[0]->argument2)
      {
         strcat(newline,",");
         strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument2)]);
      }
      if(Rules[rulenumber].replacelines[0]->argument3)
      {
         strcat(newline,",");
         strcat(newline,Rules[rulenumber].
               arguments[atoi(Rules[rulenumber].replacelines[0]->argument3)]);
      }
      strcat(newline,"\t");

   }
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
   setupinstinfo(replaceline);

   //All lines matched return success
   return replaceline;
}

//Checks that Regs only field is validated
int regsonlymatch(struct assemline *line, int rulenumber, int linenum)
{
   //Create character arrays for all possible deads
   char *ruletoken;

   struct Line *curmatchline;

   curmatchline = Rules[rulenumber].matchlines[linenum];

   ruletoken = strtok(curmatchline->regsonly,"$");
   while(ruletoken)
   {

      if(isreg(Rules[rulenumber].arguments[atoi(ruletoken)]) != 1)
         return 0;

      //Parse to next regonly in rule
      ruletoken = strtok(NULL,",$");

   }

   return 1;
}

//Match deads
int deadsmatch(struct assemline *line, int rulenumber, int linenum)
{
   //Create character arrays for all possible deads
   char deads[MAXLINE], *token, *ruletoken;

   struct Line *curmatchline;

   curmatchline = Rules[rulenumber].matchlines[linenum];

   dumpvarstate(deads,line->deads);

   if(!curmatchline->deads && deads)
      return 0;
   else if(varempty(line->deads) &&
      strlen(curmatchline->deads) == strlen(deads))
   {
      return 1;
   }
   else if(strlen(curmatchline->deads)*4 != strlen(deads)*2)
      return 0;

   ruletoken = strtok(curmatchline->deads,"$");
   token = strtok(deads,":");
   while(token && ruletoken)
   {
      if(strcmp(token,Rules[rulenumber].arguments[atoi(ruletoken)]) != 0)
         return 0;

      //Parse to next dead in rule
      ruletoken = strtok(NULL,",$");

      //Parse to next dead in line
      token = strtok(NULL,"%");

   }
   return 1;
}

//Check if instruction mneumonic matches between two lines
int instmatches(struct assemline *line, int rulenumber, int linenum)
{
   struct Line *curmatchline;
   curmatchline = Rules[rulenumber].matchlines[linenum];

   if(strcmp(curmatchline->instruction,line->items[0]) == 0 ||
      curmatchline->wildline == 1)
   {
      if(strstr(curmatchline->instruction,"$") && curmatchline->wildline != 1)
      {
         Rules[rulenumber].
         arguments[atoi(strstr(curmatchline->instruction,"$")+1)]
            = line->items[0];
      }
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
   if(!Rules[rulenumber].arguments[atoi(curmatchline->argument1)])
      Rules[rulenumber].arguments[atoi(curmatchline->argument1)] =
         line->items[1];
   else
      if(strcmp(Rules[rulenumber].arguments[atoi(curmatchline->argument1)],
        line->items[1]) != 0)
         return 0;

   //Check second argument
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

   //Check third argument
   if(curmatchline->threeargs)
   {
      if(!Rules[rulenumber].arguments[atoi(curmatchline->argument3)])
         Rules[rulenumber].arguments[atoi(curmatchline->argument3)]
           = line->items[3];
      else
         if(strcmp(Rules[rulenumber].arguments[atoi(curmatchline->argument3)],
           line->items[3]) != 0)
            return 0;
   }

   return 1;
}

//Iterate through all matchlines in rule to see if they match previous lines
int rulematches(struct assemline *line, int rulenumber)
{
   int i = 0;
   //readinrules();

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

   curline->text = allocstring(line);

   char *token;

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
      }
      else if(tokencount == 1)
      {
         curline->argument2 = allocstring(token+1);
      }
      else if(tokencount == 2)
      {
         curline->argument3 = allocstring(token+1);
         curline->threeargs = 1;
      }

      tokencount++;
      token = strtok(NULL, ",");

   }

   if(!curline->arguments && wild)
   {
         curline->text = allocstring(line);
         curline->wildline = 1;
   }

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
