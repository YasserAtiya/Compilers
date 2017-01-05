#include <stdio.h>
#include "opt.h"
#include "misc.h"
#include "vars.h"

/*
 * cseinblk - perform local common subexpression elimination in a block
 */
void cseinblk(struct bblk *cblk, int *changes)
{
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
