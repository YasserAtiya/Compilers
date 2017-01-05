/*
 *Yasser Atiya
 *COP6622 Assignment 2
 *9/27/2016
 *reverse.c
 */

#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "opts.h"
#include "string.h"

//Function that takes assembly branch line, and reverses its branch condition
void reversecondition(struct assemline* line);

/*
 * reversebranches - avoid jumps by reversing branches
 */
void reversebranches() {
	
	//Current block
	struct bblk *cblk;

	//Used blocks
	struct bblk *a, *b, *c, *d;

   //The current predecessor of the cblk
	struct blist *curpred, *cpred;

   //Line with conditional branch in predecessor
	struct assemline *branchline;

	//Entry block for program
	extern struct bblk *top;

	//Current assembly line in block A
	struct assemline *curline;

	//Loop through blist
	for(cblk = top; cblk; cblk = cblk->down)
	{

		//Reset block variables
		a = NULL;
		b = NULL;
		c = NULL;
		d = NULL;

		//If block only contains one line and that line is a branch
		if(cblk->lineend && cblk->lineend == cblk->lines &&
		   (cblk->lineend->type == JUMP_INST ||
		    cblk->lineend->type == CALL_INST ))
			//Current block is a candidate for branch reversal
			b = cblk;
		else
			continue;

		//If we have a candidate for reversal
		if(b)
		{

		   //Ensure we are working with new assemline for branching
		   branchline = NULL;

		   //Loop through all predecessors to find one with conditional branch
		   for(curpred=cblk->preds; curpred; curpred=curpred->next)
		   {
			    
				//Loop through all lines, if it is a branch, we've done our work
				for(curline = curpred->ptr->lineend; 
					 curline; 
					 curline = curline->prev)
				{

					if(curline && curline->type == BRANCH_INST)
	            {
		    			//Set current predecessor as block a
						a = curpred->ptr;
						branchline = curline;
						break;
					}

				}

			    //If block a (predecessor) has a conditional branch
				if(branchline)
				{

					//If block b follows block a positionally
					if(a->down == b)
			    	{	

						//if b is only proceded by a
						if(!curpred->next) 
			    		{	

							//if c follows b positionally
							if(strcmp(b->down->label,branchline->items[1]) == 0)
			    			{
			    				//Assign Block C to block directly following B	
			    				c = b->down;

								//Loop through all of Block C's predecessors
								for(cpred=c->preds; cpred; cpred=cpred->next)
								{

									//if block C has A as a predecessor
									if(cpred->ptr->num == curpred->ptr->num)
									{

										//Perform Branch Reversal
									   
									   //Assign branched to block from B to variable
									   if(b->succs->ptr)
									   	d = b->succs->ptr;
										else
											continue;

									   //Change branch in Block A to Block D
										strcpy(branchline->items[1],
											allocstring(d->label));

										//Reverse condition of branch
										reversecondition(branchline);

										//Change actual text
								      strcpy(branchline->text,
								        	allocstring(strcat(
								        		allocstring("\t"),branchline->items[0])));
								      
								      strcpy(branchline->text,allocstring(
								       	strcat(branchline->text,
								       		allocstring("\t"))));
									      
								      strcpy(branchline->text,allocstring(
								        	strcat(branchline->text,
								        		branchline->items[1])));

 									   //Add A to predecessor list of D
								      addtoblist(&(d->preds),a);

								      //Add D to successor list of A
								      addtoblist(&(a->succs),d);

										//Remove A from predecessor list of B
								      delfromblist(&b->preds,a);

								      //Remove B from successor list of A
								      delfromblist(&a->succs,b);

 										//Delete C from B's successor list
								      delfromblist(&b->succs,c);

								      //Make C next positional Block for A
								      c->up = a;

								      //Make A previous positional Block for C 
								      a->down = c;

								      //Delete B
								      deleteblk(b);

										//To make fallthrough, C, top successor
								      delfromblist(&a->succs,c);
								      addtoblist(&a->succs,c);

								      //Increment count of transformation applied
								      incropt(REVERSE_BRANCHES);

										//exit
										break;
									}
								}
							}
						}
					}
				}						
		   }
		}
	}

	//Ensure control flow is maintained
	check_cf();
}

/*
 * reversecondition
 * Takes in branch assembly line and reverses condition
 */
void reversecondition(struct assemline* line)
{
	if(strcmp(line->items[0], "bge") == 0)
		strcpy(line->items[0],allocstring("bl"));
	else if(strcmp(line->items[0], "ble") == 0)
		strcpy(line->items[0],allocstring("bg"));
	else if(strcmp(line->items[0], "bl") == 0)
		strcpy(line->items[0],allocstring("bge"));
	else if(strcmp(line->items[0], "bg") == 0)
		strcpy(line->items[0],allocstring("ble"));
	else if(strcmp(line->items[0], "bne") == 0)
		strcpy(line->items[0],allocstring("be"));
	else if(strcmp(line->items[0], "be") == 0)
		strcpy(line->items[0],allocstring("bne"));
	else if(strcmp(line->items[0], "bpos") == 0)
		strcpy(line->items[0],allocstring("bneg"));
	else if(strcmp(line->items[0], "bneg") == 0)
		strcpy(line->items[0],allocstring("bpos"));
}

