/*
 *
 *Yasser Atiya
 *10/25/2016
 *Assignment 6
 *Dead Assignment Elimination
 *
*/

#include <stdio.h>
#include "opt.h"
#include "vars.h"
#include "analysis.h"
#include "opts.h"

//Array of assemlines with suspects
int localelimination(struct assemline *line);

/*
 * deadasgelim - perform dead assignment elimination
 */
void deadasgelim()
{

   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   //Create line
   struct assemline *curline, *prevline;

   //Initialize non-general purpose registers as restricted from live/dead
   varstate restricted;
   varinit(restricted);
   insreg("%g0",restricted,1);
   insreg("%fp",restricted,2);
   insreg("%sp",restricted,3);

   for(cblk = top; cblk; cblk = cblk->down)
   {

      //Loop through lines of blocks
      for(curline = cblk->lines; curline; curline)
      {

         //If our currentline has sets and none of them are in restricted
         //Grab assignment
         if(curline->type != CALL_INST &&
            curline->type != BRANCH_INST &&
            curline->type != SAVE_INST && curline->type != RESTORE_INST &&
            curline->type != JUMP_INST && !varempty(curline->sets) &&
            varcommon(curline->sets,restricted) == 0)
         {

            //If there is a previous line, record it
            if(curline->prev)
               prevline = curline->prev;

            //Check if confirmed dead or alive within block
            if(localelimination(curline) != 0)
            {

               //Increment or decrement line
               if(!curline && curline->prev)
                  curline = prevline;
               else
                  curline = curline->next;

               //If so, on to next line
               continue;
            }

            //If set is not an out of block, delete assignment
            if(varcommon(curline->sets,cblk->outs) == 0)
            {

               //If no previousline, go to next line
               if(!curline->prev)
                  prevline = curline->next;

               //Delete line and increment optimization counter
               incropt(DEAD_ASG_ELIM);
               delline(curline);

               //Go to next line
               curline = prevline;
            }
         }
         //Increment line
         curline = curline->next;
      }
   }
}

//Search through all lines of block occuring after argument for first use or set
//of argument's set register or variable
int localelimination(struct assemline *line)
{

   struct assemline *cline;

   //Loop through lines of blocks
   for(cline = line->next; cline; cline = cline->next)
   {

      //Subtract uses from suspect varstate
      if(!varempty(cline->uses))
      {
         if(varcommon(cline->uses,line->sets) != 0)
         {
            //Return concluded, not deleted
            return -1;
         }
      }

      //If our currentline has sets that reset sets in passed in line
      if(varcommon(cline->sets,line->sets) != 0 && cline->type != CALL_INST)
      {

         //Update counter, delete line
         incropt(DEAD_ASG_ELIM);
         delline(line);

         //Return concluded, deleted
         return 1;

      }
   }

   //Return inconclusive
   return 0;
}
