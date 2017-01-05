/*
 *
 *Yasser Atiya
 *10/6/2016
 *Assignment 4
 *Detecting Loops
 *loops.c
 *
*/
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "analysis.h"
#include "vect.h"

void calculatenaturalloops();
void calculatedominatorinformation();
void addloopblocks(struct loopnode *loop, struct bblk *tail);
void sortloops();
void traversepreds(struct loopnode *loop, struct bblk *cblk);

struct loopnode *loops;    /* head of linked list of loops */

/*
 * findloops - locate loops in the program and build the loop data structure
 */
void findloops()
{

   //Free all loops
   freeloops();

   //Calculate information on dominators
   calculatedominatorinformation();

   //Calculate all natural loops
   calculatenaturalloops();

   //Sort calculated loops
   sortloops();

}

//Calculate dominators for every block
void calculatedominatorinformation()
{

   //Top block of program
   extern struct bblk *top;

   //Block variables used: current block
   struct bblk *cblk;

   //Flag for changes to any dominator information occuring
   int change = 0;

   //Holder bvect used to determine changes
   bvect olddoms;

   //Initialize olddoms bvect
   olddoms = ball();

   //The current predecessor of the cblk
	struct blist *curpred;

   //Set current block as top block
   cblk = top;

   //Set top block as own sole dominator
   cblk->dom = bnone();
   binsert(&cblk->dom,cblk->num);

   //Loop through all blocks and set dominator as all blocks
   for(cblk = top->down; cblk; cblk = cblk->down)
      cblk->dom = ball();

   //Algorithm for calculating dominators
   do
   {
      //Set flag so that loop will exit
      change = 0;

      //For every block other than the top
      for(cblk = top->down; cblk; cblk = cblk->down)
      {

         //Save old dominatior information to check for changes
         bcpy(&olddoms,cblk->dom);

         //Loop through all direct predecessors
         for(curpred=cblk->preds; curpred; curpred=curpred->next)
         {
            //Intersect all predecessor dominants as dominants
            binter(&cblk->dom,curpred->ptr->dom);

            //Union in cblk
            binsert(&cblk->dom,cblk->num);
         }

         //Check for changes with new dominator information
         if(!bequal(olddoms,cblk->dom) && !change)
         {
            //Set flag to iterate again
            change = 1;
         }
      }
   }
   //If no changes, exit loop
   while(change == 1);

}


//Calculate natural loops that occur using dominator information
void calculatenaturalloops()
{

   //Top block of program
   extern struct bblk *top;

   //Block variables used: current block
   struct bblk *cblk;

   //The current successor of the cblk
	struct blist *cursucc;

   //Pointer to top of loop linkedlist
   extern struct loopnode *loops;

   //Current loop
   struct loopnode *curloop, *testloop;

   //Set current block as top block
   cblk = top;

   //Find backedge

   //Loop through all blocks and look for backedge
   for(cblk = top->down; cblk; cblk = cblk->down)
   {
      //Look for predecessor that dominates block, that is a backedge
      for(cursucc=cblk->succs; cursucc; cursucc=cursucc->next)
      {
         //If true, we have a backedge
         if(bin(cblk->dom,cursucc->ptr->num))
         {

               //Create empty loop
               if(!cursucc->ptr->loop)
               {
                  cursucc->ptr->loop = newloop();
                  freeblist(cursucc->ptr->loop->blocks);
               }

               //Add looptail and header to block set
               addtoblist(&cursucc->ptr->loop->blocks,cblk);
               addtoblist(&cursucc->ptr->loop->blocks,cursucc->ptr);


               //Set header
               cursucc->ptr->loop->header = cursucc->ptr;

               cursucc->ptr->loop->header->loopnest = 1;

               //Add all blocks in between the header and tail
               addloopblocks(cursucc->ptr->loop,cblk);

         }

      }

   }

   //Set loop nests, iterate through all loops
   for(testloop = loops; testloop; testloop = testloop->next)
   {
      //Check if loop we are testing has header in other loop
      for(curloop = loops; curloop; curloop = curloop->next)
      {

         //Add 1 to nesting of loop we find the header in it
         if(testloop != curloop && inblist(curloop->blocks,testloop->header) &&
            testloop->header->loopnest <= curloop->header->loopnest)
         {
            testloop->header->loopnest = curloop->header->loopnest+1;
         }
      }

   }


}


//Traverse all predecessors from tail to head
void traversepreds(struct loopnode *loop, struct bblk *cblk)
{
      struct blist *curpred;

      //If we have reached the head, return
      if(cblk->num == loop->header->num)
         return;

      //Add block to loop blocks
      addtoblist(&loop->blocks,cblk);

      //Take block, call this function on all predecessors of block, if not in
      //loop already
      for(curpred=cblk->preds; curpred; curpred=curpred->next)
         if(!inblist(loop->blocks,curpred->ptr))
            traversepreds(loop,curpred->ptr);

}


//We have loop header and tail, so find everything in between
void addloopblocks(struct loopnode *loop, struct bblk *tail)
{
   //Top block of program
   extern struct bblk *top;

   //Recursive function, traverses all predecessors until header
   traversepreds(loop,tail);

}


//Sorts all loops based on nesting, and in case of ties, header block number
void sortloops()
{

      //Top loop
      extern struct loopnode *loops;

      //Current loop, loop before it, and loop after it
      struct loopnode *curloop, *prevloop, *nextloop;

      //Flag for change
      int change = 0;

      //Make sure we have loops
      if(loops)
         prevloop = loops;
      else
         return;

      //Make sure we have two loops
      if(loops->next)
         curloop = loops->next;
      else
         return;

      //Make sure we have three loops
      if(loops->next->next)
         nextloop = curloop->next;
      else
      {
         //If not, sort first two loops, and end sort
         if(curloop->header->loopnest > prevloop->header->loopnest ||
            (curloop->header->loopnest == prevloop->header->loopnest &&
             curloop->header->num < prevloop->header->num))
         {
            loops = curloop;
            prevloop->next = nextloop;
            curloop->next = prevloop;
         }
         return;
      }

      //Loop that sorts until no sorting is done between two iterations
      do
      {

         //Set flag to false, to exit loop
         change = 0;

         //Iterate through all loops
         for(curloop = curloop; nextloop; curloop = curloop->next)
         {

            //In case the first loop should not be the first loop
            //If first has a higher nest, or ties and has a lower block number
            if(prevloop == loops &&
               (curloop->header->loopnest > prevloop->header->loopnest ||
                (curloop->header->loopnest == prevloop->header->loopnest &&
                 curloop->header->num < prevloop->header->num)))
            {

               //Swap it with the loop that comes after it
               loops = curloop;
               prevloop->next = nextloop;
               curloop->next = prevloop;
               prevloop = loops;
               curloop = prevloop->next;
               change = 1;

            }

            //In case the current loop needs to be swapped with next loop
            //If current has a higher nest, or ties and has a lower block number
            if(nextloop->header->loopnest > curloop->header->loopnest ||
               (nextloop->header->loopnest == curloop->header->loopnest &&
                nextloop->header->num < curloop->header->num))
            {
                  prevloop->next = nextloop;
                  curloop->next = nextloop->next;
                  nextloop->next = curloop;
                  change = 1;
                  nextloop = nextloop->next;
                  curloop = prevloop->next;
                  nextloop = curloop->next;

            }
               //If we have not reached end of list
               if(nextloop->next)
                  nextloop = nextloop->next;
               //Otherwise, exit loop
               else
                  break;

            //Move previous loop to current loop
            prevloop = prevloop->next;

         }

         //Reset all variables for next sort
         prevloop = loops;
         curloop = loops->next;
         nextloop = curloop->next;

      }
      //If no changes, exit loop
      while(change);


}
