/*
 * Yasser Atiya
 * Assignment 3
 * Live and Dead Variable Analysis
 * 10/4/2016
 */

#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"
#include "analysis.h"
#include "opts.h"

void calcusesanddefs();
void calcinsandouts();

/*
 * calclivevars - calculate live variable information
 */
void calclivevars()
{

   //Calculate uses and defs for each block
   calcusesanddefs();

   //Calculate ins and outs for each block
   calcinsandouts();

}

//Calculate ins and outs of each block using sets and defs
void calcinsandouts()
{

   //Top block of program
   extern struct bblk *top;

   //Varstates used as oldin, holder
   varstate oldin,holder;

   //Varstate used for restricted registers
   varstate restricted;

   //Initialize non-general purpose registers as restricted from live/dead
   varinit(restricted);
   insreg("%g0",restricted,1);
   insreg("%fp",restricted,2);
   insreg("%sp",restricted,3);

   varinit(oldin);
   varinit(holder);

   //Declare block variables: current block
   struct bblk *cblk;

   //Current block's successors
   struct blist *csuccs;

   //Flag for changes
   int change;

   //Algorithm for computing ins and outs for block using uses and defs
   do {
      change = 0;
      for(cblk = top; cblk; cblk = cblk->down)
      {
         varinit(cblk->outs);
         for(csuccs = cblk->succs; csuccs; csuccs = csuccs->next)
            unionvar(cblk->outs,cblk->outs,csuccs->ptr->ins);
         varcopy(oldin,cblk->ins);
         minusvar(holder,cblk->outs,cblk->defs);
         unionvar(cblk->ins,cblk->uses,holder);
         if(!varcmp(cblk->ins,oldin))
            change = 1;
      }
   } while(change);

   //Ensure we are not including restricted registers
   for(cblk = top; cblk; cblk = cblk->down)
   {
      minusvar(cblk->outs,cblk->outs,restricted);
      minusvar(cblk->ins,cblk->ins,restricted);
   }

}

void calcusesanddefs()
{

   //Top block of program
   extern struct bblk *top;

   //Declare assembly line variables: current lines
   struct assemline *curline;

   //Varstate used as holder
   varstate v;

   //Initialize holder
   varinit(v);

   //Declare block variables: current block
   struct bblk *cblk;

   //Cycle through all blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {
      //Loop through all lines in block
      for(curline = cblk->lines; curline; curline = curline->next)
      {


         //If current line uses any registers or variables
         if(!varempty(curline->uses))
         //Check if current line is using any variables/regs not yet set
         {

            //Find difference between line's uses and block's defs
            minusvar(v,curline->uses,cblk->defs);

            //Union that with block's uses
            unionvar(cblk->uses,cblk->uses,v);

         }

         //Clear varstate for reuse
         varinit(v);

         //If current line sets any registers or variables
         if(!varempty(curline->sets))
         //Check if current line sets any lines not previously used
         {

            //First difference line's sets with block's uses
            minusvar(v,curline->sets,cblk->uses);

            //Then union subsequent set with defs of block
            unionvar(cblk->defs,cblk->defs,v);

         }

      }

   }

}

/*
 * calcdeadvars - calculate dead variable information
 */
void calcdeadvars()
{

   //Top block of program
   extern struct bblk *top;

   //Declare assembly line variables: current lines, innerloop line
   struct assemline *curline, *innerline;

   //Varstates used: dead variables for a block, line uses suspected to be dead
   //variables and registers that cannot be dead, and a holder varstate
   varstate deads,suspects,holder,holder2,restricted;

   //Initialize non-general purpose registers as restricted from live/dead
   varinit(restricted);
   insreg("%g0",restricted,1);
   insreg("%fp",restricted,2);
   insreg("%sp",restricted,3);

   varinit(deads);
   varinit(holder);
   varinit(suspects);

   //Declare block variables: current block
   struct bblk *cblk;

   //Loop through all blocks from top to bottom
   for(cblk = top; cblk; cblk = cblk->down)
   {

      //Find dying variables and registers by diffing ins and outs
      minusvar(deads,cblk->ins,cblk->outs);
      //Loop through all lines in block

      for(curline = cblk->lines; curline; curline = curline->next)
      {

         //Clear suspects varstate
         varinit(suspects);

         /*Finding last use of register used in inst, and in ins but not outs*/

         //If there is some intersection between the uses of the line and deads
         if(varcommon(curline->uses,deads) != 0)
         {
            //Get variables and registers used that could be dead
            intervar(suspects,curline->uses,deads);

            if(!varempty(suspects))
               //Loop through all lines after
               for(innerline=curline->next;innerline;innerline=innerline->next)
               {

                  //Remove variables and registers from list
                  minusvar(suspects,suspects,innerline->uses);

               }

         }

         //If a variable or register is used for the last time before being set
         if(!varempty(curline->uses))
         {

            //Reset holder
            varinit(holder);
            varinit(holder2);

            //Union uses of variable as possible suspects
            unionvar(holder,curline->uses,holder);

            innerline = NULL;

            //If we are dealing with last line in block
            if(curline == cblk->lineend)
            {

               //Subtract set of outs from set of uses for line
               minusvar(holder,curline->uses,cblk->outs);

               //Add set of uses that are not outs to suspects
               unionvar(suspects,suspects,holder);

            }
            else
               //Loop through all lines after
               for(innerline=curline->next;innerline;innerline=innerline->next)
               {

                  //If used is set after, add to suspects, if not incremented
                  //Union intersection with holder
                  if(varcommon(innerline->uses,innerline->sets) == 0)
                  {
                     intervar(holder2,holder,innerline->sets);
                     unionvar(suspects,holder2,suspects);
                  }

                  //If used is used after, remove from holder
                  if(varcommon(holder,innerline->uses) != 0)
                  {
                     minusvar(holder,holder,innerline->uses);
                  }

               }


            minusvar(holder,holder,cblk->outs);

            //Add new suspects to suspect list
            unionvar(suspects,holder,suspects);

         }

         minusvar(curline->deads,curline->deads,cblk->outs);


         //If a variable or register is used and set in the same line
         if(varcommon(curline->uses,curline->sets) != 0)
         {
            //Add the variables and registers that are both set and used
            intervar(holder,curline->uses,curline->sets);
            unionvar(suspects,holder,suspects);

         }


         //Union remaining suspects with line's dead registers
         if(!varempty(suspects))
         {
            //Remove restricted variables
            minusvar(suspects,suspects,restricted);

            //Add remaining suspects to deads for line
            unionvar(curline->deads,curline->deads,suspects);
         }

      }
   }

}
