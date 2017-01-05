#include <stdlib.h>
#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "opts.h"
#include "flow.h"
#include "string.h"

//Function that does the work for every found chain opportunity
void performbranchchaining(struct bblk *cblk);

/*
 * remvbranchchains - remove branch chains
 */
void remvbranchchains()
{

    //Current block
    struct bblk *cblk;

    //Entry block for program
    extern struct bblk *top;
  
    //Loop through blist
    for(cblk = top; cblk; cblk = cblk->down)
    {
  
      //Check if there is a line, only one line, and line is a branch
      if(cblk->lineend && cblk->lineend == cblk->lines && 
          (cblk->lineend->type == JUMP_INST || 
            cblk->lineend->type == BRANCH_INST))
      {

        //Retarget predecessors of chaining blk to successor of chained block
        performbranchchaining(cblk);

      }

    }

    //Make sure we did not mess up control flow
    check_cf();

}

/*
 * Pass in chaining block, remove it from successorlist of predessessors
 * Remove it from predessessor list of the block it is chaining to others
 * Replace it as successor of all of its predecessors using its target 
 * Edit text in line
 * Make sure fallthrough is on top of successor list
 */
 void performbranchchaining(struct bblk *cblk)
 {
    //The chained blk
    struct bblk *tblk;

    //The current predecessor of the cblk
    struct blist *curpred;

    //Record successor of chaining block
    tblk = cblk->succs->ptr;

    //Loop through all predessessors, replace the suspect with its successor
    for(curpred=cblk->preds; curpred; curpred=curpred->next)
    {
      //Make sure we are not falling through to the chaining block
      if(curpred->ptr->down == cblk)
        return;
      //Make sure we are removing a block that is an actual successor
      else if(!delfromblist(&(curpred->ptr->succs), cblk))
      {
        //Print error if block not in blist and quit
        fprintf(stderr,"performbranchchaining, retargeted block not found\n");
        quit(1);
      }
      else
      {

        //Add tblk as successor to cblks curpred
        addtoblist(&(curpred->ptr->succs),tblk);

        //Add curpred as predessessor or tblk
        addtoblist(&tblk->preds,curpred->ptr);

        //Delete predessessor from predessessor list of cblk
        delfromblist(&cblk->preds,curpred->ptr);

        //Perform changes in text
        curpred->ptr->lineend->items[1] = tblk->label;

        //Assume only two items, so concatenate them together with tab between
        curpred->ptr->lineend->text = 
          strcat(curpred->ptr->lineend->items[0], "\t");
        curpred->ptr->lineend->text = 
          strcat(curpred->ptr->lineend->text,curpred->ptr->lineend->items[1]);

        //If we have a fallthrough as not the head of successor list
        if(curpred->ptr->succs && curpred->ptr->succs->next && 
            curpred->ptr->succs->ptr != curpred->ptr->down)
        {

          struct bblk *hold = curpred->ptr->down;

          //Next block is not the chaining block remove it and add it as head
          if(hold != cblk)
          {
            delfromblist(&(curpred->ptr->succs),hold);
            addtoblist(&(curpred->ptr->succs),hold);
          }

        }

      }

    }

 } 
