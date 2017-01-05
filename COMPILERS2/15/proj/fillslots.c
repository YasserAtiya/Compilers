/*
 *
 *Yasser Atiya
 *11/22/2016
 *Assignment 9
 *Fill Delay Slots
 *fillslots.c
 *
*/
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"
#include "opts.h"
#include "string.h"
#include "io.h"
#include "flow.h"

int checkavailability(struct assemline *curline, struct assemline *line);
struct assemline* findfiller(struct assemline *line);
void fill(struct assemline *line,struct assemline *fillline);
extern struct instinfo insttypes[];

/*
 * filldelayslots - fill the delay slots of the transfers of control in a
 *                  function
 */
void filldelayslots()
{
   extern struct bblk *top;
   struct bblk *cblk;
   struct assemline *curline, *fillline;

   //Find call instruction, or branch, or jump

   //Loop through all blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {
      //Loop through all lines of each block
      for(curline = cblk->lines; curline; curline = curline->next)
      {
         fillline = NULL;

         //If we have a call instruction, jump instruction, or branch
         if(curline->type == CALL_INST || curline->type == JUMP_INST ||
            curline->type == BRANCH_INST)
            {
               //We fill the line in front of it with one from before
               fillline = findfiller(curline);

               //If we found a potential line to fill with
               if(fillline)
               {
                  //Place it in delay slot
                  fill(curline,fillline);

                  //Move past current line
                  curline = fillline;
               }
               else
                  continue;

            }
      }
   }
}

//Fill the delay slot
void fill(struct assemline *line,struct assemline *fillline)
{

   //If we are for a jump
   if(line->type == JUMP_INST)
   {
      strcpy(line->text,"\tba\t");
      strcat(line->text,(line->items[1]));
      line->text = allocstring(line->text);
   }

   //Set up line after instruction of choice
   unhookline(fillline);
   fillline = insline(line->blk,line,fillline->text);
   setupinstinfo(fillline);
   unhookline(line);
   line = insline(fillline->blk,fillline,line->text);
   setupinstinfo(line);

   //Check control flow
   check_cf();

   //Increment optimization counter
   incropt(FILL_DELAY_SLOTS);

}

//Find a line that can fill
struct assemline* findfiller(struct assemline *line)
{
   struct assemline *curline;

   //Cycle through block
   for(curline = line; curline; curline = curline->prev)
   {
      //If line sets conditional code, and is not save instruction
      if(curline->type != COMMENT_LINE && curline->type != DEFINE_LINE &&
         curline->type != SAVE_INST && curline->type != BRANCH_INST &&
         curline->type != JUMP_INST && curline->type != CALL_INST &&
         !insttypes[curline->instinfonum].setscc)
         {
            //Find line that does not need to worry about others after
            if(checkavailability(curline,line))
               return curline;
         }
   }

   return NULL;

}

//Check current line against lines after to see if it can be placed in slot
int checkavailability(struct assemline *curline, struct assemline *line)
{
   //Line we are comparing potential fill with
   struct assemline *compline;

   //Cycle through block
   for(compline = curline; compline; compline = compline->next)
   {

      //If we are comparing to a call instruction, or comparing same line
      if(compline->type == CALL_INST || !strcmp(compline->text,curline->text))
         continue;

      //If set is used after
      if(varcommon(compline->uses,curline->sets) ||
      //If use is set after
         varcommon(curline->uses,compline->sets))
      {
         //Line cannot be used to fill
         return 0;
      }

   }

   //Line can be used
   return 1;

}
