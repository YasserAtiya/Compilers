

#include <stdio.h>
#include "opt.h"
#include "vars.h"
#include "analysis.h"
#include "opts.h"

//Array of assemlines with suspects
struct assemline *lines[1000];


struct blist *traversed;

void traversesuccs(struct bblk *cblk);
int localelimination(struct assemline *line);
int globalelimination(struct assemline *line, struct bblk *cblk);

/*
 * deadasgelim - perform dead assignment elimination
 */
void deadasgelim()
{

   //Top block of program
   extern struct bblk *top;

   //Current block
   struct bblk *cblk;

   struct blist *cursucc;

   //Create line
   struct assemline *curline, *assignline;

   //Varstate holding use and set states for propogating
   varstate guilty, restricted;

   //Initialize varstates
   varinit(guilty);

   //Initialize non-general purpose registers as restricted from live/dead
   varinit(restricted);
   insreg("%g0",restricted,1);
   insreg("%fp",restricted,2);
   insreg("%sp",restricted,3);

   freeblist(traversed);

   char states[MAXLINE+1000];

   for(cblk = top; cblk; cblk = cblk->down)
   {

      fprintf(stderr, "CURRENT BLOCK: %u\n",cblk->num);
      //Loop through lines of blocks
      for(curline = cblk->lines; curline; curline = curline->next)
      {

         fprintf(stderr, "At top of loop\n");

         fprintf(stderr, "\nCurrent line: %s\n",curline->text);

         //If our currentline has sets and none of them are in restricted
         //Grab assignment
         if(curline && curline->type != CALL_INST &&
            curline->type != BRANCH_INST &&
            curline->type != SAVE_INST && curline->type != RESTORE_INST &&
            curline->type != JUMP_INST && !varempty(curline->sets) &&
            varcommon(curline->sets,restricted) == 0)
         {

            //Check if dead within block
            if(localelimination(curline))
            {
               continue;
            }

            //If opportunity for eliminating occured globally, delete assignment
            if(globalelimination(curline, cblk))
               delline(curline);


            freeblist(traversed);
         }

      }


   }


}

int globalelimination(struct assemline *line, struct bblk *cblk)
{
   struct blist *cursucc;
   char states[MAXLINE+1000];
   struct assemline *curline;

   for(cursucc = cblk->succs; cursucc; cursucc = cursucc->next)
   {

      if(!cursucc->ptr)
         break;

      fprintf(stderr, "Block number: %u\n",cursucc->ptr->num);

      dumpvarstate(states,line->sets);
      fprintf(stderr, "Sets in line: %s\n",states);

      dumpvarstate(states,cursucc->ptr->ins);
      fprintf(stderr, "Successor ins: %s\n",states);

      if(varcommon(line->sets,cursucc->ptr->ins) != 0 &&
         !inblist(traversed,cursucc->ptr))
      {
         dumpvarstate(states,cursucc->ptr->uses);
         fprintf(stderr, "Successor uses: %s\n",states);

         dumpvarstate(states,cursucc->ptr->defs);
         fprintf(stderr, "Successor defs: %s\n",states);
         addtoblist(&traversed,cursucc->ptr);
         //Loop through lines of blocks
         for(curline = cursucc->ptr->lines; curline; curline = curline->next)
         {
            fprintf(stderr, "\nComparing against line: %s\n",line->text);
            fprintf(stderr, "Current line: %s\n",curline->text);

            //Subtract uses from suspect varstate
            if(!varempty(curline->uses))
            {
               if(varcommon(curline->uses,line->sets) != 0)
               {
                  fprintf(stderr, " NOT DELETING ASSIGNMENT\n");
                  return 0;
               }
               else
               {
                  dumpvarstate(states,curline->uses);
                  fprintf(stderr, "Uses not in suspect: %s\n",states);
               }
            }

            //If our currentline has sets that reset sets in passed in line
            if(varcommon(curline->sets,line->sets) != 0 &&
               curline->type != CALL_INST)
            {

               fprintf(stderr, "DELETING ASSIGNMENT\n");
               fprintf(stderr, "DELETED ASSIGNMENT: %s\n", line->text);
               fprintf(stderr, "Deleted because of: %s\n", curline->text);

               incropt(DEAD_ASG_ELIM);

               return 1;

            }
         }

         //Traverse to successor
         if(globalelimination(line,cursucc->ptr))
            return 1;

      }
   }


   return 0;

}

int localelimination(struct assemline *line)
{

   struct assemline *curline;
   char states[MAXLINE+1000];

   //Loop through lines of blocks
   for(curline = line->next; curline; curline = curline->next)
   {
      fprintf(stderr, "\nComparing against line: %s\n",line->text);
      fprintf(stderr, "Current line: %s\n",curline->text);

      //Subtract uses from suspect varstate
      if(!varempty(curline->uses))
      {
         if(varcommon(curline->uses,line->sets) != 0)
         {
            fprintf(stderr, " NOT DELETING ASSIGNMENT\n");
            return 0;
         }
         else
         {
            dumpvarstate(states,curline->uses);
            fprintf(stderr, "Uses not in suspect: %s\n",states);
         }
      }

      //If our currentline has sets that reset sets in passed in line
      if(varcommon(curline->sets,line->sets) != 0 && curline->type != CALL_INST)
      {

         incropt(DEAD_ASG_ELIM);
         delline(line);

         return 1;

      }

   }

   fprintf(stderr, "Line not considered locally dead: %s\n",line->text);
   dumpvarstate(states,line->sets);
   fprintf(stderr, "Sets: %s\n",states);

   return 0;

}
