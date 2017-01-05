/*
 *
 *Yasser Atiya
 *11/15/2016
 *Assignment 8
 *Common Subexpression Elimination
 *cse.c
 *
*/
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"
#include "strings.h"

int lookforrepeats(struct assemline *line);
int performcse(struct assemline *target, struct assemline *replacer);
int linesmatch(struct assemline *defaultline, struct assemline *curline);

extern struct instinfo insttypes[];

/*
 * cseinblk - perform local common subexpression elimination in a block
 */
void cseinblk(struct bblk *cblk, int *changes)
{
   struct assemline* curline;

   //Cycle through all lines in block
   for(curline = cblk->lines; curline; curline = curline->next)
   {
      //If we have an arithmetic isntruction
      if(curline->type == ARITH_INST)
         //Look for chances to perform cse in rest of lines in blk
         if(lookforrepeats(curline))
            //Update changes when necessary
            *changes = 1;
   }

}

//Perform common subexpression elimination
int performcse(struct assemline *target, struct assemline *replacer)
{
   struct assemline *newline;
   char holder1[MAXLINE], holder2[MAXLINE];

   //Create new line
   dumpvarstate(holder1,replacer->sets);
   dumpvarstate(holder2,target->sets);
   holder1[strlen(holder1)-1] = '\0';
   holder2[strlen(holder2)-1] = '\0';

   //If line creation failed, return 0
   if(strcmp(holder2,"") == 0 || strcmp(holder1,"") == 0)
   {
      return 0;
   }

   //Insert new line
   newline = insline(target->blk,target,holder1);

   //Create new move instruction
   createmove(insttypes[target->instinfonum].datatype,holder1,holder2,newline);

   //Delete old line
   delline(target);

   incropt(LOCAL_CSE);

   return 1;
}

//Check for common subexpression
int linesmatch(struct assemline *defaultline, struct assemline *curline)
{
   int i = 0;

   //If same instruction
   if(!strcmp(defaultline->items[0],curline->items[0]))
      //Loop through all but last item and check if they match
      for(i = 0; i < defaultline->numitems-1; i++)
      {
         if(strcmp(defaultline->items[i],curline->items[i])  != 0)
            return 0;
      }
   //If not same instruction, return 0
   else
      return 0;

   //If we have not failed, return 1
   return 1;
}

//Look for opportunities to perform cse
int lookforrepeats(struct assemline *line)
{
   struct assemline *curline;
   int changed = 0;

   //Loop through all lines after current line
   for(curline = line->next; curline; curline = curline->next)
   {

         //Check if reuse by comparing uses between two lines
         if(curline->type == ARITH_INST && linesmatch(line,curline))
         {
            //Perform common subexpression elimination
            if(performcse(curline,line))
               changed = 1;
         }

         //Check if resets register
         if(varcommon(line->sets,curline->sets) ||
            varcommon(line->uses,curline->sets) )
            return changed;

   }

   //Return whether or not any changes have been made
   return changed;

}

/*
 * localcse - perform local common subexpression elimination
 */
void localcse(int *changes)
{
   struct bblk *cblk;
   extern struct bblk *top;

   for (cblk = top; cblk; cblk = cblk->down)
      cseinblk(cblk, changes);
}
