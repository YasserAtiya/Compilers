/*
 *
 *Yasser Atiya
 *11/15/2016
 *Assignment 8
 *Invariant Code Motion
 *motion.c
 *
*/
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "opts.h"
#include "vars.h"
#include "vect.h"
#include "strings.h"
#include "io.h"

int findpreheader(struct loopnode *loop);
void determineinvregs(struct loopnode *loop);
void findwrites(struct loopnode *loop);
int findandhoist(struct loopnode *curloop, bvect everyitr);
bvect executedeveryiteration(bvect everyitr,struct loopnode *curloop);
int hoist(struct loopnode *loop, struct assemline *curline, bvect everyitr);
extern struct instinfo insttypes[];

/*
 * codemotion - perform loop invariant code motion on each loop
 */
void codemotion(int *changes)
{
   extern struct loopnode *loops;
   struct loopnode *curloop;
   bvect everyitr;

   //For each loop
   for(curloop = loops; curloop; curloop = curloop->next)
   {

      //If no preheader, move on
      if(!findpreheader(curloop))
         continue;

      //Determine invariant variables and sets
      determineinvregs(curloop);

      //Find any writes to memory
      findwrites(curloop);

      //Find blocks executed every iteration
      everyitr = executedeveryiteration(everyitr,curloop);

      //Find hoistable instructions
      if(findandhoist(curloop,everyitr))
      {
         *changes = 1;
      }

      //Perform cse in changed preheader
      cseinblk(curloop->preheader,changes);

   }


}

int findandhoist(struct loopnode *curloop, bvect everyitr)
{
   struct assemline *curline;
   struct blist *curblk;
   int changes = 0;
   varstate holder;
   varinit(holder);

   /*Find*/
   //For all instructions in all loop blocks
   for(curblk = curloop->blocks; curblk; curblk = curblk->next)
   {
      for(curline = curblk->ptr->lines; curline; curline = curline->next)
      {


         //Intersect uses with invariant registers
         intervar(holder,curloop->invregs,curline->uses);

         //If we use invariant variables, and do not set condition codes
         //Or have loads and no writes
         if(varcmp(curline->uses,holder) &&
            ((curline->type == ARITH_INST &&
               !insttypes[curline->instinfonum].setscc) ||
            (!curloop->anywrites && curline->type == LOAD_INST)))
         {
            //Hoist
            if(hoist(curloop,curline,everyitr))
               changes = 1;
         }

      }
   }

   return changes;
}

//Hoist instruction out of loop, create replacement instructions
int hoist(struct loopnode *loop, struct assemline *curline, bvect everyitr)
{

   char *reg, *invreg;
   reg = allocstring("");
   invreg = allocstring(curline->items[curline->numitems-1]);

   //Line to be inserted before header, move line replacing curline
   struct assemline *preheaderline, *newmove;

   preheaderline = newline(curline->text);
   setupinstinfo(preheaderline);
   newmove = newline("");

   //Registers active in loop
   varstate regs;
   varinit(regs);

   unionvar(regs,loop->invregs,loop->sets);

   //If instruction may cause exception, and is not executed every iteration
   if((curline->type == LOAD_INST || strstr(curline->text,"div"))
      && !bin(everyitr,curline->blk->num))
   {
      //Return
      return 0;
   }

   //Otherwise, hoist
   //Allocate new register
   if(!allocreg(insttypes[curline->instinfonum].datatype,regs,reg))
   {
      return 0;
   }

   //Place in preheader with new destination
   //Replace destination in text
   strcpy(preheaderline->text,"\t");
   strcat(preheaderline->text,curline->items[0]);
   strcat(preheaderline->text,"\t");
   strcat(preheaderline->text,curline->items[1]);
   strcat(preheaderline->text,",");

   if(curline->numitems == 4)
   {
      preheaderline->items[3] = allocstring(reg);
      strcat(preheaderline->text,preheaderline->items[2]);
      strcat(preheaderline->text,",");
      strcat(preheaderline->text,preheaderline->items[3]);
   }
   else
   {
      preheaderline->items[2] = allocstring(reg);
      strcat(preheaderline->text,preheaderline->items[2]);
   }

   preheaderline->text = allocstring(preheaderline->text);

   //Insert into loop preheader, before final line
   preheaderline =
      insline(loop->preheader,loop->preheader->lineend,preheaderline->text);

   //If the final line is not a branch or jump, move it past final line
   if(loop->preheader->lineend->type != BRANCH_INST &&
      loop->preheader->lineend->type != JUMP_INST &&
      preheaderline != loop->preheader->lineend)
   {
      hookupline(loop->preheader,preheaderline,loop->preheader->lineend);
      loop->preheader->lineend = preheaderline;
      preheaderline->next = NULL;
   }


   //Insert new set and remove old set
   setupinstinfo(preheaderline);

   insreg(reg,loop->invregs,calcregpos(reg));

   //Replace with move in loop
   createmove(insttypes[curline->instinfonum].datatype,reg,invreg,newmove);

   //Insert new move before currentline
   newmove = insline(curline->blk,curline,newmove->text);

   //Set up instruction info
   setupinstinfo(newmove);

   //Delete currentline
   delline(curline);

   curline = newmove;

   //Increment optimization count
   incropt(CODE_MOTION);

   return 1;
}


bvect executedeveryiteration(bvect everyitr,struct loopnode *loop)
{
   struct blist *curblk;
   bvect tails;
   tails = bnone();
   everyitr = ball();

   //Initialize every iteration bvect to include all loop blocks
   for(curblk = loop->blocks; curblk; curblk = curblk->next)
   {
      //Insert all block numbers into vector
      binsert(&everyitr,curblk->ptr->num);
   }

   //Loop through all header's preds
   for(curblk = loop->header->preds; curblk; curblk = curblk->next)
   {
      //Look for predecessor that is dominated by block header, that is a tail
      if(bin(curblk->ptr->dom,loop->header->num))
      {
         //Insert into bvect
         binsert(&tails,curblk->ptr->num);

         //Intersect doms of current tail with all members of block
         binter(&everyitr,curblk->ptr->dom);

      }
   }

   return everyitr;
}

//Find any loads in loop
void findwrites(struct loopnode *loop)
{
   struct assemline *curline;
   struct blist *cblk;

   //Loop through all blocks in loop
   for(cblk = loop->blocks; cblk; cblk = cblk->next)
   {
      for(curline = cblk->ptr->lines; curline; curline = curline->next)
      {
         if(curline->type == STORE_INST || curline->type == CALL_INST)
            loop->anywrites = 1;
      }
   }


}

//Determine loop invariant registers and variables
void determineinvregs(struct loopnode *loop)
{
   struct blist *curblk;
   struct assemline *curline;

   //Get header's ins to initialize loop invariant varstate
   varstate loopinv;
   varcopy(loopinv,loop->header->ins);

   //If var/reg is used or set in any other block, remove it from invariant list
   //Add var/reg to set list


   //Loop through all blocks in loop
   for(curblk = loop->blocks; curblk; curblk = curblk->next)
   {
      for(curline = curblk->ptr->lines; curline; curline = curline->next)
      {

            unionvar(loopinv,loopinv,curline->uses);

            //Add all vars and regs set in block to varstate
            unionvar(loop->sets,loop->sets,curline->sets);
      }
   }

   //Only invariant if used, but never set
   minusvar(loopinv,loopinv,loop->sets);

   //Copy over results
   varcopy(loop->invregs,loopinv);
}


int findpreheader(struct loopnode *loop)
{

   int numpreds = 0;
   struct blist *curpred;

   //Find loop preheader
   for(curpred = loop->header->preds; curpred; curpred = curpred->next)
   {
      //If no other successors, we have a preheader
      if(inblist(loop->blocks,curpred->ptr) ||
         curpred->ptr->num == loop->header->num)
      {
         continue;
      }

      if(numpreds == 0)
      {
         if(!curpred->ptr->succs->next)
            loop->preheader = curpred->ptr;
         numpreds = 1;
      }
      else
      {
         numpreds++;
      }

   }

   //If no loopheader found return failed, else return success
   if(numpreds == 1 && loop->preheader)
      return 1;
   else
      return 0;

}
