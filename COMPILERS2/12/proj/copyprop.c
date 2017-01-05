/*
 *
 *Yasser Atiya
 *10/25/2016
 *Assignment 6
 *Copy propogation
 *
*/
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"
#include "io.h"
#include "string.h"


void propagate(struct assemline *line, char *copy, char *target);

/*
 * localcopyprop - perform copy propagation
 */
void localcopyprop(int *changes)
{

   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   //Create line
   struct assemline *curline, *replaceline, *lasttobepropogated;

   //Varstate holding use and set states for propogating
   varstate restricted;

   varstate holder;
   varinit(holder);


   char *target,*copy;

   //Initialize non-general purpose registers as restricted from live/dead
   varinit(restricted);
   insreg("%g0",restricted,1);
   insreg("%fp",restricted,2);
   insreg("%sp",restricted,3);


   //Loop through blocks
   for(cblk = top; cblk; cblk = cblk->down)
   {

      //Loop through lines of blocks
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         //If we have a register to register assignment
         if(curline->type == MOV_INST &&
            varcommon(curline->sets, restricted) == 0)
         {


            //Record its sets to replace uses later on
            target = curline->items[2];

            //Record its uses to replace them later on
            copy = curline->items[1];

            if(!strcmp(copy,target) || !isreg(copy))
            {
               continue;
            }

            //Reset last line to be propogated
            lasttobepropogated = NULL;

            for(replaceline = curline->next; replaceline;
                replaceline = replaceline->next)
            {

               //If we find an opportunity to replace our replacee
               if(regexists(target,replaceline->uses) &&
                  replaceline->type != RETURN_INST
                  && replaceline->type != CALL_INST)
               {
                  //Replace replacee, modify text, and items
                  propagate(replaceline,copy,target);

                  //Edit deads of original line
                  if(regexists(copy,curline->deads))
                  {
                     varinit(holder);
                     insreg(copy,holder,1);
                     minusvar(curline->deads,curline->deads,holder);
                  }

                  //Set last line to be propogated
                  lasttobepropogated = replaceline;

               }

               //If our replacee or replacer is set again
               if(regexists(target,replaceline->sets) ||
                  regexists(copy,replaceline->sets))
               {
                  break;
               }

            }

            //Replace last propogated line deads
            if(lasttobepropogated)
            {
               varinit(holder);
               insreg(copy,holder,1);
               unionvar(lasttobepropogated->deads,lasttobepropogated->deads,
                        holder);
            }


         }
      }
   }
}

//Perform copy propogation
void propagate(struct assemline *line, char *copy, char *target)
{

   //Replacement string
   char *rep;

   //Change uses
   delreg(target,line->uses,32);
   insreg(copy,line->uses,32);

   //Get location of replacement within text line
   rep = strstr(line->text,target);

   if(!rep)
      return;

   //Copy in new register
   strncpy(rep,copy,strlen(target));

   //Allocate new string
   line->text = allocstring(line->text);

   //Sets up rest of instruction info
   setupinstinfo(line);

   //Increment number of times optimization has been completed
   incropt(COPY_PROPAGATION);

}
