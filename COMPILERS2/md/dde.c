
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "../lib/vpo.h"
#include "../lib/misc.h"
#include "interface.h"
#include "regs.h"
#include "common.h"

#define PREDREG DRTREG
extern struct locuse *locs;

int getddetype(char *val) {
   int type = NULL;
   if(ismem(val)) {
      switch(*val) {
         case  'D':
            type = DDTREG;
            break;
         case  'F':
            type = DFTREG;
            break;
         case  'R': case 'W': case 'B':
            type = DRTREG;
            break;
         default:
            assert(0 && "Unknown memory reference type.");
            break;
      }
   } else {
      switch(regtype(val)) {
         case RTREG:
           type = DRTREG;
           break;
         case HTREG:
           type = DHTREG;
           break;
         case FTREG:
           type = DFTREG;
           break;
         case DTREG:
           type = DDTREG;
           break;
         default:
            assert(0 && "Unknown register type.");
      }
   }
   return type;
}

void *define_node() {
  struct list *node = new_basic_block(NULL);
  return (void *) node;
}

void *create_ro_pred(void *node)
{
   struct bblock *blk = (struct bblock *) node;
   struct bblock *phblk = preheader(blk);
   char reg[REGSTRING+1], buff[MAXSTRING];

   // Assign a unique number to the new RTL
   struct list *rtl = add_rtl(phblk, phblk->rtls, "", rinit());
   rtl->rnum = gen_addr(rtl);
   rtl->is_dde = 1;

   // Create VPO register string
   makereg(reg, DRTREG, 0);

   sprintf(buff, "M[%s+%d]=RO;", reg, rtl->rnum);
   update_rtl(rtl, buff);
   return (void *) rtl;
}

void *copy_pred(void *node, void *pred)
{
  struct bblock *blk = (struct bblock *) node;
  struct list *rtl = add_rtl(blk, blk->rtls, "", rinit());
  struct list *prtl = (struct list *) pred;
  char buff[MAXSTRING];
  char reg1[REGSTRING+1], reg2[REGSTRING+1];
  rtl->rnum = gen_addr(rtl);
  rtl->is_dde = 1;

  // Create VPO register string
  makereg(reg1, DRTREG, 0);

  // Set the RTL string
  sprintf(buff, "M[%s+%d]=M[%s+%d];", reg1, rtl->rnum, reg1, prtl->rnum);
  update_rtl(rtl, buff);
  return (void *) rtl;
}

void *create_op(void *node, void *lop, void *rop, char op)
{
  struct bblock *blk = (struct bblock *) node;
  struct list *loprtl = (struct list *) lop;
  struct list *roprtl = (struct list *) rop;
  char reg1[REGSTRING+1], reg2[REGSTRING+1], reg3[REGSTRING+1];
  char buff[MAXSTRING];

  struct list *rtl = add_rtl(blk, blk->rtls, "", rinit());
  rtl->rnum = gen_addr(rtl);
  rtl->is_dde = 1;

  // Create VPO Register String for predicates.
  makereg(reg1, DRTREG, 0);

  // Create the RTL for the op
  sprintf(buff, "M[%s+%d]=M[%s+%d]%cM[%s+%d];", reg1,
     rtl->rnum, reg1, loprtl->rnum, op, reg1, roprtl->rnum);
  update_rtl(rtl, buff);
  return (void *) rtl;
}

void *create_and(void *node, void *pred1, void *pred2)
{
  return create_op(node, pred1, pred2, '&');
}

void *create_or(void *node, void *pred1, void *pred2)
{
  return create_op(node, pred1, pred2, '|');
}

void *create_not(void *node, void *op) {
  struct bblock *blk = (struct bblock *) node;
  struct list *oprtl = (struct list *) op;
  char reg1[REGSTRING+1], reg2[REGSTRING+1];
  char buff[MAXSTRING];

  struct list *rtl = add_rtl(blk, blk->rtls, "", rinit());
  rtl->rnum = gen_addr(rtl);
  rtl->is_dde = 1;

  // Create VPO Register String for predicates.
  makereg(reg1, DRTREG, 0);

  // Write the RTL value
  sprintf(buff, "M[%s+%d]=~M[%s+%d];", reg1, rtl->rnum,
     reg1, oprtl->rnum);
  update_rtl(rtl, buff);
  return (void *) rtl;
}

void *create_psi(void *node, void *pred, void *truedef,
                void *falsedef)
{
  struct bblock *blk = (struct bblock *) node;
  struct list *predrtl = (struct list *) pred;
  struct list *truertl = (struct list *) truedef;
  struct list *falsertl = (struct list *) falsedef;
  char buff[MAXSTRING];
  char reg[REGSTRING];
  struct list *rtl = add_rtl(blk, blk->rtls, "", rinit());
  rtl->rnum = gen_addr(rtl);
  rtl->is_dde = 1;

  makereg(reg, DRTREG, 0);

  sprintf(buff, "M[%s+%d]=M[%s+%d]?M[%s+%d]:M[%s+%d];", reg, rtl->rnum, reg, predrtl->rnum,
     reg, truertl ? truertl->rnum : 0, reg, falsertl ? falsertl->rnum : 0);

  update_rtl(rtl, buff);
  return (void *)rtl;
}

void *create_eta(void *node, void *pred, void *def)
{
  struct bblock *blk = (struct bblock *) node;
  struct list *predrtl = (struct list *) pred;
  struct list *defrtl = (struct list *) def;
  char buff[MAXSTRING];
  char reg[REGSTRING];
  struct list *rtl = add_rtl(blk, blk->rtls,
              "", rinit());
  rtl->rnum = gen_addr(rtl);
  rtl->is_dde = 1;

  makereg(reg, DRTREG, 0);
  sprintf(buff, "M[%s+%d]=M[%s+%d]@M[%s+%d];", reg,
     rtl->rnum, reg, predrtl->rnum, reg, defrtl->rnum);

  update_rtl(rtl, buff);
  return (void *)rtl;
}

static int same_mem(char *mem, void *use) {
  char *end = strchr(mem, ']');
  char *loc = gtloc(mem);
  int known_deps = 0;
  if(loc && loc <= end) {
    struct locuse *lptr;
    for(lptr=locs;lptr;lptr=lptr->next)
      if(strncmp(loc-LOCALLOCLENGTH, lptr->code, LOCALLOCLENGTH) == 0)
        break;
    if(lptr == use) {
      return TRUE;
    }
  }
  return FALSE;
}

void dde_replace_sets(struct list *rtl, int rnum) {
  char *c, *val;
  char buff[MAXSTRING], reg[REGSTRING];

  c = val = buff;
  strcpy(buff, rtl->val);
  makereg(reg, DRTREG, 0);

  // Look at each location in the rtl
  while(c && (c = skiploc(c)) && *c) {
    int replace = 0;
    if(ismem(val)) {
      // Memory access - find end of representation M[ ... ]
      c = strchr(val, ']') + 1;
      if(*c == '=')
         replace = 1;
    } else if(isRegister(val) && *c == '=') {
      replace = 1;
      c = val + REGLOCLENGTH;
    } else if(is_pc(val) && strchr(val, ',')) {
      replace = 1;
      c = val + strlen("PC");
    }

    if(replace) {
       int off = c - buff;
       int n = 0;
       sprintf(val, "M[%s+%d]%n%s", reg, rnum, &n, rtl->val + off);
       c = val + n;
    }

    val = c;
  }

  update_rtl(rtl, buff);
}

static void replace_uses(struct list *rtl, char *use, int defnum) {
  char *c, *val;
  char buff[MAXSTRING], reg[REGSTRING];

  c = val = buff;
  strcpy(buff, rtl->val);
  makereg(reg, DRTREG, 0);

  // Look at each location in the rtl
  while(c && (c = skiploc(c)) && *c) {

    int replace = 0;
    if(ismem(val)) {
      // Memory access - find end of representation M[ ... ]
      c = strchr(val, ']') + 1;
      // If the memory location is the same
      if((*c != '=') && same_mem(val, use))
         replace = 1;
    } else if(isRegister(val) && *c != '=') {

      // Register use
      if(use == get_regident(val))  {
         replace = 1;
         c = val + REGLOCLENGTH;
      }
    }

    if(replace) {
       int off = c - buff;
       int n = 0;
       sprintf(val, "M[%s+%d]%n%s", reg, defnum, &n, rtl->val + off);
       c = val + n;
    }
    val = c;
  }

  update_rtl(rtl, buff);
}

void update_use(void *inst, void *var, void *def) {
  struct list *setter = (struct list *) def;
  struct list *user = (struct list *) inst;

  if(setter && var) {
    replace_uses(user->ddeptr, var, setter->rnum);
//    replace_uses(user->ddeptr,  var, setter->rnum);
  }
}
