/*
 * Yasser Atiya
 * Assignment 5
 * Register Allocation
 * 10/18/2016
 */


#include <stdio.h>
#include <strings.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"
#include "opts.h"

void replacelines(char* reg, struct varinfo var);
void replacedefineline(char* reg, struct varinfo var);
void replaceloadsandstores(char* reg, struct varinfo var);
void subtractregistersinuse(varstate);

/*
 * regalloc - perform register allocation
 */
void regalloc(int *changes)
{

   //Varstate for registers and one to hold
   varstate regs, holder;

   //Initialize holder varstate
   varinit(holder);

   //Initialize register varstate
   varinit(regs);

   //Go through all registers used in function and remove them from the varstate
   subtractregistersinuse(regs);

   //Array for register string
   char *reg;
   reg = allocstring("");

   //Array of variables, and number of variables
   extern struct varinfo vars[];
   extern int numvars;

   //Counter variable
   int i,numregs;

   numregs = varcommon(regs,regs);

   //Loop through variables
   for(i = 0; i < numvars; i++)
   {
      //If we do not reference the variable indirectly,
      //and successfully allocate a register to it
      if(!vars[i].indirect && allocreg(vars[i].type,regs,reg))
      {
         //Loop through all lines and replace variable lines when needed
         replacelines(reg,vars[i]);

         //Remove register from varstate
         insreg(reg,regs,numregs+i);

         //Update number of registers in varstate
         numregs = varcommon(regs,regs);
      }
   }


}

//Replace lines in function referencing variables
void replacelines(char* reg, struct varinfo var)
{

   //Relace define line
   replacedefineline(reg,var);

   //Replace loads and stores with moves
   replaceloadsandstores(reg,var);

}

//Replaces loads and stores in functions with moves
void replaceloadsandstores(char* reg, struct varinfo var)
{

   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   //Current assembly line within current block
   struct assemline *curline;

   //Holder for variable name found in line
   char *varname = allocstring("");

   //Replace define lines
   //Loop through blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {

      //Loop through lines
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         //Replace load instructions
         if(curline->type == LOAD_INST &&
            sscanf(curline->items[1], "[%%fp+%[^]]", varname) == 1)
         {
            //Compare variable in load with variable passed in
            if(strcmp(varname,var.name) == 0)
            {
               //Create move insruction to replace load
               createmove(var.type,reg,curline->items[2],curline);
            }
         }

         //Replace store instructions
         if(curline->type == STORE_INST &&
            sscanf(curline->items[2], "[%%fp+%[^]]", varname) == 1)
         {
            //Compare variable in store with variable passed in
            if(strcmp(varname,var.name) == 0)
            {
               //Create move insruction
               createmove(var.type,curline->items[1],reg,curline);
            }
         }
      }
   }
}

void replacedefineline(char* reg, struct varinfo var)
{
   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   //Current assembly line within current block
   struct assemline *curline;

   //String that holds new define line
   char line[MAXLINE];

   //Replace define lines
   for(cblk = top; cblk; cblk = cblk->down)
   {
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         if(strcmp(curline->items[0],var.name) == 0)
         {
            //Replace string define line with comment line
            strcpy(line,"! ");
            strcat(line,curline->items[0]);
            strcat(line," = ");
            strcat(line,reg);
            curline->text = allocstring(line);


            //Replace items
            strcpy(line,"! ");
            strcat(line,var.name);
            curline->items[0] = allocstring(line);


            strcpy(line," ");
            strcat(line,reg);
            curline->items[1] = allocstring(line);

            //End function
            return;

         }
      }
   }

}

void subtractregistersinuse(varstate regs)
{
   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   //Current assembly line within current block
   struct assemline *curline;

   //Iterate through all lines of function, remove them from reg varstate
   for(cblk = top; cblk; cblk = cblk->down)
   {
      for(curline = cblk->lines; curline; curline = curline->next)
      {
         //Add line's sets and uses to reg varstate
         unionvar(regs,regs,curline->sets);
         unionvar(regs,regs,curline->uses);
      }
   }
}
