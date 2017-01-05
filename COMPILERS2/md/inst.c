
/************************************************************************
 *                                                                      *
 * Copyright (c) 1987, 1988, 1989, 1990, 1991, 1992 -                   *
 *     The Rector and Visitors of the University of Virginia            *
 *                                                                      *
 * This code may not be distributed further without permission          *
 *      from the University of Virginia.                                *
 * This code is distributed WITHOUT ANY WARRANTY.  No claims are        *
 *      made as to whether it serves any particular purpose or even     *
 *      works at all.                                                   *
 *                                                                      *
 ************************************************************************/

/************************************************************************

 Revision Control information

 $Source: /home/baird/CVS/adl/zephyr/zephyr/backend/vpo/mips-dde/inst.c,v $
 $Date: 2016/05/04 19:42:19 $
 $Revision: 1.1 $
 $Name:  $

 Log of changes:

 $Log: inst.c,v $
 Revision 1.1  2016/05/04 19:42:19  baird
 Added directory for mips-DDE backend

 Revision 1.16  2003/09/02 19:30:27  jdh8d
 disallowed ST=reg;r[25]=reg; as it's not legal on target

 Revision 1.15  2003/09/02 18:49:44  jdh8d
 fixed assumption in sll/srl/sra where immedmode!=conmode

 Revision 1.14  2003/09/02 15:41:40  jdh8d
 minor fixes

 Revision 1.13  2003/03/18 16:44:18  jdh8d
 *** empty log message ***

 Revision 1.12  2002/07/12 21:24:51  clc5q
 Eliminate warning messages

 Revision 1.11  2002/07/11 20:08:45  clc5q
 Clean up #include chains. Use #include instead of extern to get access
 to global variables from other modules.

 Revision 1.10  2002/06/12 16:26:54  jdh8d
 disallowed F[]=d[]; rtls and the like

 Revision 1.9  2002/06/05 20:08:54  jdh8d
 Changes to support the stache, including routines to build a callgraph.

 Some cosmetic changes.

 Minor bug fixes.

 Changed build scripts to build the mips compiler for SimpleScalar if
 SSAS is set to "-DSS_AS"

 Revision 1.8  2001/10/31 18:43:10  jdh8d
 *** empty log message ***

 Revision 1.7  2001/05/28 20:36:04  jdh8d
 *** empty log message ***

 Revision 1.7  2000/07/18 18:46:08  jdh8d
 changes to get mips to compile/run under new system

 Revision 1.5  1999/12/04 21:40:48  jwd
 Added check in function addr to make sure that offsets from a global
 were not larger than sixteen bits (32767). The SGI assembler complains
 if the offset is larger.
 Revision 1.4  1999/12/04 21:35:03  jwd
 Made code labels begin with a dot at the beginning.  This is the SGI convention.

 Changed how the type for the loads and stores in assembly language instructions
 is determined.  Previously we used the mem type. However, we no longer use 'F'
 memory type.  We changed the load and store functions to look at the dst type for
 loads, and the src type for stores.  This also required allowig loads of 'R' type into
 'f' type registers, and vice versa for stores.
 Revision 1.3  1999/07/08 18:14:14  jwd
 Ansified the source.

 Also changed the comment formatting string. The MIPS assembler uses
 the preprocessor so the # for a comment cannot begin in column 1.

*************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include "../lib/vpo.h"
#include "../lib/assign.h"
#include "../lib/combine.h"

#include "recdef.h"
#include "addrdef.h"
#include "instdef.h"
#include "inst.h"
#include "regs.h"
#include "regs2.h"
#include "dde_inst.h"

#ifdef MEASURE
#include "../lib/measure.h"
#include "linstinfo.h"

#define ST(a, b, c, d, e) stinstinfo(a, b, c, d, e)

struct addr_entry __lab = { LONG, LABEL };
struct addr_entry __rg0 = { LONG, RREGISTER };

#define LAB &(__lab)
#define RG0 &(__rg0)
#else
#define ST(a, b, c, d, e)
#endif

extern int sw_adl;
extern int dde;

int minargrefs = 2;      /* Minimum number of argument references    */
                         /* required to make register replacement    */
                         /* economical                               */
int minlocrefs = 1;      /* Minimum number of local variable refs    */
                         /* required to make register replacement    */
                         /* economical                               */

int condret = 0;         /* indicates if RETURN can be the target    */
                         /* of a conditional jump, i.e., conditional */
                         /* returns are supported by the machine     */

int dassem = 0;          /* Assembly output flag                     */

char *labprt = ".%s:\n";    /* Used to print a label for the assembler  */
char *acomment = " #%s\n";  /* Used to print a comment to the assembler */

int str_ptr, i_ptr;
struct addr_entry itable[ITABSIZE];

static char *r_regs[32] = { "$0", "$1", "$2", "$3",
                            "$4", "$5", "$6", "$7",
                            "$8", "$9", "$10", "$11",
                            "$12", "$13", "$14", "$15",
                            "$16", "$17", "$18", "$19",
                            "$20", "$21", "$22", "$23",
                            "$24", "$25", "$26", "$27",
                            "$28", "$sp", "$fp", "$31" };
static char *f_regs[16] = { "$f0", "$f2", "$f4", "$f6",
                            "$f8",  "$f10", "$f12", "$f14",
                            "$f16", "$f18", "$f20", "$f22",
                            "$f24", "$f26", "$f28", "$f30" };

static char *i2op[14] = { "", "\tadd", "\tand", "\tdiv", "\tdivu",
                          "\tmul", "\tor", "\trem", "\tremu",
                          "\tsll", "\tsra", "\tsrl", "\tsub", "\txor" };
static char *i2expr[14] = { "", " + ", " & ", " / ", " / ", " * ", " | ", " % ",
                            " % ", " << ", " >> ", " >> ", " - ", " ^ " };


/*
 * addr - build record for addressing mode
 */
struct addr_entry *addr(int type, int mode, struct addr_entry *p1,
 struct addr_entry *p2, struct addr_entry *p3) {

    register struct addr_entry *t;
    int x;

    /*
     * Allocate an initialize an address record for this item
     */

    t = &(itable[(i_ptr++)]);
    t->type = type;
    t->mode = mode;
    t->arg1.ptr = p1;
    t->arg2.ptr = p2;
    t->arg3.ptr = p3;

    switch (mode) {
//      case DDEREGISTER:
      case RREGISTER:
      case FREGISTER:
      case DREGISTER:
      case HREGISTER:
        t->cost = 1;
        break;

      case FCONST:
        t->cost = 2;
        break;

      case ICONST:
        if (!atoi((char *) p1))
          t->cost = 0;
        else
          t->cost = 2;
        break;

      case LIDENT:
        ikind |= LOCREF;

      case GIDENT:
      case SPILLOC:
      case LABEL:
        t->cost = 2;
        break;

      case EXPR:
        if (isreloc(p2) && isreloc(p3))
          erflag = TRUE;
        if ((int) p1 == ANDI && isreloc(p2))
          erflag = TRUE;
        t->cost = 2;
        break;

      case IMMED:
        t->cost = p1->cost;
        break;

      case ABSOLUTE:
        /* check to make sure any constant is not greater than 65K */
        if (ConstantTooBig(p1))
           	erflag = 1;
	else
        	t->cost = 5;
        break;

      case REGDFR:
      case DISP:
        if (ConstantTooBig(p1))
           	erflag = 1;
	else
        	t->cost = 5;
        break;

      case TEMPADDR:
        t->cost = 2;
        break;

      default:
        (void) fprintf(stderr, "vpo (addr): bad addressing mode %d\n", mode);
        exit(1);
      }

    return(t);
}

/*
 * icompare - compare two addr_entry type records for equality
 */
int icompare(struct addr_entry *a1, struct addr_entry *a2) {

    if (!a1)
      return(!a2);
    if (!a2)
      return(FALSE);
    if (a1->type != a2->type)
      return(FALSE);
    if (a1->mode == a2->mode) {
      switch (a1->mode) {

        case EXPR:
          return((a1->arg1.str == a2->arg1.str) &&
                 icompare(a1->arg2.ptr, a2->arg2.ptr) &&
                 icompare(a1->arg3.ptr, a2->arg3.ptr));

        case DISP:
          return(icompare(a1->arg1.ptr, a2->arg1.ptr) &&
                 icompare(a1->arg2.ptr, a2->arg2.ptr));

        case SPILLOC:
        case IMMED:
        case ABSOLUTE:
        case REGDFR:
          return(icompare(a1->arg1.ptr, a2->arg1.ptr));

        case LABEL:
        case FCONST:
        case ICONST:
          return(((int) a1->arg2.ptr) == ((int) a2->arg2.ptr) &&
                 !strncmp(a1->arg1.str, a2->arg1.str, (int) a1->arg2.ptr));

        case RREGISTER:
        case FREGISTER:
        case DREGISTER:
        case HREGISTER:
        case GIDENT:
        case LIDENT:
	  return (cmploc(a1->arg1.str, a2->arg1.str)==0);

        default:
          (void) fprintf(stderr, "vpo (icompare): unknown mode %d\n", a1->mode);
          exit(1);
        }
      }
    return(FALSE);
}

/*
 * dump_addr - emit a address expression in assembly format
 */
void dump_addr(struct addr_entry *t) {
   register char *s;
   register int x;
   fflush(stdout);
   switch (t->mode) {

      case EXPR:
         switch ((int) t->arg1.str) {

            case NEGI:
               (void) putchar('-');
               dump_addr(t->arg2.ptr);
               break;

            case NOTI:
               (void) putchar('~');
               dump_addr(t->arg2.ptr);
               break;

            case ADDI:

               /*
                * All this horsing around is here because the %@%#!^&#
                * assembler on the sgi's has to have relocatable symbols
                * given to it in very special ways.
                */
               if (isreloc(t->arg3.ptr)) {
                  dump_addr(t->arg3.ptr);
                  (void) putchar(' ');
               if (EXPRMODE(t->arg2.ptr) &&
                  ((int) t->arg2.ptr->arg1.ptr) == NEGI) {
                  (void) putchar('-');
                  (void) putchar(' ');
                  dump_addr(t->arg2.ptr->arg2.ptr);
               }
               else {
                 (void) putchar('+');
                 (void) putchar(' ');
                 dump_addr(t->arg2.ptr);
               }
            }
            else {
               dump_addr(t->arg2.ptr);
               (void) putchar(' ');
               if (EXPRMODE(t->arg3.ptr) &&
                ((int) t->arg3.ptr->arg1.ptr) == NEGI) {
                  (void) putchar('-');
                  (void) putchar(' ');
                  dump_addr(t->arg3.ptr->arg2.ptr);
               }
               else {
                  (void) putchar('+');
                  (void) putchar(' ');
                  dump_addr(t->arg3.ptr);
               }
            }
            break;

          default:
             dump_addr(t->arg2.ptr);
             (void) fputs(i2expr[(int) t->arg1.str], stdout);
             dump_addr(t->arg3.ptr);
             break;
        }
        break;

      case GIDENT:
           if(strcmp(globalname(t->arg1.str),"VPO_get_old_sp")==0 ||
	      strcmp(globalname(t->arg1.str),"VPO_get_current_ret_addr")==0)
        		(void) fputs("0", stdout);
	   else
        		(void) fputs(globalname(t->arg1.str), stdout);
        break;

      case LIDENT:
        (void) fprintf(stdout, "%d", localrecord(t->arg1.str)->offset);
        break;

      case LABEL:
	 /* We want labels to have a dot in front */
         (void) putchar('.');

      case ICONST:
      case FCONST:
        s = t->arg1.str;
        for (x = (int) t->arg2.ptr; x--; s++)
          (void) putchar(*s);
        break;

      case SPILLOC:
        (void) printf("%d", spilloff + atoi(t->arg1.ptr->arg1.str));
        break;

      case RREGISTER:
      case HREGISTER:
        (void) fputs(r_regs[gpregmap[regnum(t->arg1.str)]], stdout);
          break;

      case FREGISTER:
      case DREGISTER:
        (void) fputs(f_regs[fpregmap[regnum(t->arg1.str)]], stdout);
        break;

      case IMMED:
          dump_addr(t->arg1.ptr);
        break;

      case ABSOLUTE:
        dump_addr(t->arg1.ptr);
        break;

      case DISP:
        dump_addr(t->arg2.ptr);

      case REGDFR:
        (void) putchar('(');
        dump_addr(t->arg1.ptr);
        (void) putchar(')');
        break;

      default:
        (void) fprintf(stderr, "vpo (dump_addr): unknown addressing mode %d\n",
                               t->mode);
        exit(1);
      }
}

/*
 * isreloc - is there a relocatable symbol in the expression
 */
int isreloc(struct addr_entry *p) {

    while (p) {
      switch (p->mode) {

        case GIDENT:
        case LABEL:
          return(TRUE);

        case EXPR:
        case DISP:
          if (isreloc(p->arg2.ptr))
            return(TRUE);
          p = p->arg3.ptr;
          break;

	case IMMED:
	case ABSOLUTE:
	  p = p->arg1.ptr;
	  break;

        default:
          return(FALSE);
        }
      }
    return(FALSE);
}

/*
 * initexpr - setup addr_entry to hold one register and an expression
 */
struct addr_entry *initexpr(struct addr_entry *reg, int neg,
 struct addr_entry *exp) {
    struct addr_entry *texp;

    texp = (neg) ? addr(ANY, EXPR, AE NEGI, exp, AN) : exp;
    return(addr(ANY, TEMPADDR, reg, texp, AN));
}

/*
 * addexpr - build expression onto the second argument
 */
struct addr_entry *addexpr(struct addr_entry *rexp, int op,
 struct addr_entry *exp) {

    rexp->arg2.ptr = addr(ANY, EXPR, AE op, rexp->arg2.ptr, exp);
    return(rexp);
}

/*
 * displacement - change the address item to a displacement mode address
 */
struct addr_entry *displacement(struct addr_entry *a, int type, int mode) {

    a->type = ANY;
    a->mode = DISP;
    a->cost = 6;
    return (a);
}

/*
 * memref - add type to memory reference item
 */
struct addr_entry *memref(int type, struct addr_entry *p) {

    p->type = type;
    return(p);
}

/*
 * bb - check semantics of compare and branch
 */
void bb(struct sem_rec *t) {

#ifdef MEASURE
    if (REGMODE(t->sem.bb.right) && !regnum(t->sem.bb.right->arg1.str)) {
      if (!strcmp(t->sem.bb.rel, "eq"))
        insttype = BEQZI;
      else if (!strcmp(t->sem.bb.rel, "ne"))
        insttype = BNEZI;
      else if (!strcmp(t->sem.bb.rel, "ge"))
        insttype = BGEZI;
      else if (!strcmp(t->sem.bb.rel, "le"))
        insttype = BLEZI;
      else if (!strcmp(t->sem.bb.rel, "lt"))
        insttype = BLTZI;
      else if (!strcmp(t->sem.bb.rel, "gt"))
        insttype = BGTZI;
      else if (!strcmp(t->sem.bb.rel, "geu"))
        insttype = BGEUI;
      else if (!strcmp(t->sem.bb.rel, "leu"))
        insttype = BLEUI;
      else if (!strcmp(t->sem.bb.rel, "ltu"))
        insttype = BLTUI;
      else
        insttype = BGTUI;
      }
    else if (!strcmp(t->sem.bb.rel, "eq"))
      insttype = BEQI;
    else if (!strcmp(t->sem.bb.rel, "ne"))
      insttype = BNEI;
    else if (!strcmp(t->sem.bb.rel, "ge"))
      insttype = BGEI;
    else if (!strcmp(t->sem.bb.rel, "le"))
      insttype = BLEI;
    else if (!strcmp(t->sem.bb.rel, "lt"))
      insttype = BLTI;
    else if (!strcmp(t->sem.bb.rel, "gt"))
      insttype = BGTI;
    else if (!strcmp(t->sem.bb.rel, "geu"))
      insttype = BGEUI;
    else if (!strcmp(t->sem.bb.rel, "leu"))
      insttype = BLEUI;
    else if (!strcmp(t->sem.bb.rel, "ltu"))
      insttype = BLTUI;
    else
      insttype = BGTUI;
#endif
    if (dassem) {
      (void) putchar('\t');
      (void) putchar('b');
      (void) fputs(t->sem.bb.rel, stdout);
      if (!REGMODE(t->sem.bb.right) || regnum(t->sem.bb.right->arg1.str) ||
          !strcmp(t->sem.bb.rel, "geu") || !strcmp(t->sem.bb.rel, "leu") ||
          !strcmp(t->sem.bb.rel, "ltu") || !strcmp(t->sem.bb.rel, "gtu")) {
        (void) putchar('\t');
        dump_addr(t->sem.bb.left);
        (void) putchar(',');
        dump_addr(t->sem.bb.right);
        ST(insttype, LONG, t->sem.bb.left, t->sem.bb.right, LAB);
        }
      else {
        /*(void) putchar('z'); */
        (void) putchar('\t');

        dump_addr(t->sem.bb.left);
	(void) printf(",$0");
        ST(insttype, LONG, t->sem.bb.left, LAB, AN);
        }
      (void) putchar(',');
      dump_addr(t->sem.bb.lbl);
      (void) putchar('\n');
      }
    else
      icost = 10;
}

/*
 * bc - branch coprocessor true and false
 */
void bc(struct sem_rec *t, char cond) {

#ifdef MEASURE
    insttype = (cond == 'f') ? BCFI : BCTI;
#endif
    if (dassem) {
      (void) fputs("\tbc1", stdout);
      (void) putchar(cond);
      (void) putchar('\t');
      dump_addr(t->sem.bc.lbl);
      (void) putchar('\n');
      ST(insttype, LONG, LAB, AN, AN);
      }
      icost = 12;
}

/*
 * binst - check semantics of binary instruction
 */
void binst(struct sem_rec *t) {

    if (dassem) {
      (void) fputs(i2op[t->sem.binst.op], stdout);
      if (LONGTYPE(t->sem.binst.dst) &&
          (t->sem.binst.op == ADDI || t->sem.binst.op == SUBI))
        (void) putchar('u');
      else if (REALTYPE(t->sem.binst.dst))
        (void) printf(".%c", TYPECHAR(t->sem.binst.dst));
      else if(IMMEDMODE(t->sem.binst.right) && t->sem.binst.op == ORI)
         putchar('i');

      (void) putchar('\t');

      dump_addr(t->sem.binst.dst);
      (void) putchar(',');
      dump_addr(t->sem.binst.left);
      (void) putchar(',');
      dump_addr(t->sem.binst.right);
      (void) putchar('\n');
      ST(t->sem.binst.op, t->sem.binst.dst->type,
         t->sem.binst.dst, t->sem.binst.left, t->sem.binst.right);
      }
    else {
      if (isreloc(t->sem.binst.left) || isreloc(t->sem.binst.right))
	{
	reason="isreloc(t->sem.binst.left) || isreloc(t->sem.binst.right)";
        erflag = 1;
	}
      else if (t->sem.binst.op == SLLI && IMMEDMODE(t->sem.binst.right))
	{
		if(CONMODE(t->sem.binst.right->arg1.ptr))
		{
              		if(atoi(t->sem.binst.right->arg1.ptr->arg1.str) > 31 ||
                 		atoi(t->sem.binst.right->arg1.ptr->arg1.str) < 0 )
				{
					reason="Bad constant on SLLI";
        				erflag = 1;
				}
		}
		else
		{
			reason="FIXME:  const expr not handled in slli";
        		erflag = 1;
		}
	}
      else if (t->sem.binst.op == SRLI && IMMEDMODE(t->sem.binst.right))
	{
		if(CONMODE(t->sem.binst.right->arg1.ptr))
		{
              		if(atoi(t->sem.binst.right->arg1.ptr->arg1.str) > 31 ||
                 		atoi(t->sem.binst.right->arg1.ptr->arg1.str) < 0 )
			{
				reason="Bad constant on SRLI";
        			erflag = 1;
			}
		}
		else
		{
			reason="FIXME:  const expr not handled in slri";
        		erflag = 1;
		}
	}
      else if (t->sem.binst.op == SRAI && IMMEDMODE(t->sem.binst.right))
	{
		if(CONMODE(t->sem.binst.right->arg1.ptr))
		{
              		if(atoi(t->sem.binst.right->arg1.ptr->arg1.str) > 31 ||
                 		atoi(t->sem.binst.right->arg1.ptr->arg1.str) < 0 )
			{
				reason="Bad constant on SRAI";
        			erflag = 1;
			}
		}
		else
		{
			reason="FIXME:  const expr not handled in srai";
        		erflag = 1;
		}
	}
      else if ((t->sem.binst.op == ANDI || t->sem.binst.op == ORI) && IMMEDMODE(t->sem.binst.right)) {
        if(!unsigned_bits_fit(t->sem.binst.right, 12)
        && !(icompare(t->sem.binst.left, t->sem.binst.dst) && unsigned_bits_fit(t->sem.binst.right, 16))) {
          erflag = 1;
          reason = "constant out of range";
        }
      }
      else if (!signed_bits_fit(t->sem.binst.right, 12)) {
	reason="constant out of range";
        erflag = 1;
      }
   }
      icost = 10 + t->sem.binst.dst->cost + t->sem.binst.left->cost +
              t->sem.binst.right->cost;
}

/*
 * cvt - check semantics of convert request
 */
void cvt(struct sem_rec *t) {

    if (dassem) {
      if (DOUBLETYPE(t->sem.cvt.dst))
        (void) fputs("\tcvt.d.s\t", stdout);
      else
        (void) fputs("\tcvt.s.d\t", stdout);
      dump_addr(t->sem.cvt.dst);
      (void) putchar(',');
      dump_addr(t->sem.cvt.src);
      (void) putchar('\n');
      ST(CVTI, t->sem.cvt.dst->type, t->sem.cvt.dst, t->sem.cvt.src, AN);
      }
    else {
      if (!REALTYPE(t->sem.cvt.dst) || !REALTYPE(t->sem.cvt.src) ||
          COMPATIBLE(t->sem.cvt.dst, t->sem.cvt.src))
        erflag = 1;
      icost = 10 + t->sem.cvt.dst->cost + t->sem.cvt.src->cost;
      }
}

/*
 * fcmp - check semantics of float compare instruction
 */
void fcmp(struct sem_rec *t) {

#ifdef MEASURE
    int itype;
    int strcmp();

    if (!strcmp(t->sem.fcmp.rel, "eq"))
      itype = CEQI;
    else if (!strcmp(t->sem.fcmp.rel, "le"))
      itype = CLEI;
    else
      itype = CLTI;
#endif
    if (dassem) {
      (void) fputs("\tc.", stdout);
      (void) fputs(t->sem.fcmp.rel, stdout);
      (void) printf(".%c\t", TYPECHAR(t->sem.fcmp.left));
      dump_addr(t->sem.fcmp.left);
      (void) putchar(',');
      dump_addr(t->sem.fcmp.right);
      (void) putchar('\n');
      ST(itype, t->sem.fcmp.left->type,
         t->sem.fcmp.left, t->sem.fcmp.right, AN);
      }
    else {
      if (!COMPATIBLE(t->sem.fcmp.left, t->sem.fcmp.right))
        erflag = 1;
      icost = 10;
      }
}

/*
 * jal - check semantics of jump and link (jal)
 */
void jal(struct sem_rec *t) {
    char temp[10];
    int n;
    register char *a;
    struct addr_entry* target;


	if(t->sem.jal.target==NULL)
	{
		reason="ST= and r[25]= to different addrs";
		erflag=1;
		return;
	}

    if (dassem) {

      target=t->sem.jal.target;
      if(target->mode==ABSOLUTE)
     	   target=target->arg1.ptr;
      if(target->mode==GIDENT && strcmp(globalname(target->arg1.str),
     	   "VPO_get_old_sp")==0)
      {
	   /* put the return old stack pointer into $2 */
     	   fprintf(stdout, "\tsub\t$2, $sp, %d\n", stack_build_size);
      }
      else if(target->mode==GIDENT && strcmp(globalname(target->arg1.str),
     	   "VPO_get_current_ret_addr")==0)
      {
	   /* put the return old stack pointer into $2 */
     	   fprintf(stdout, "\tlw\t$2, %d($sp)\n", ret_addr_offset);
      }

      else
      {
	if(swpp || swpu)
	{
		static int jal_counter=1;
		printf(".globl jal_counter%d\n", jal_counter);
		printf("jal_counter%d:\n", jal_counter++);

	}
      	//(void) fputs("\tjal\t", stdout);
      	if (ABSMODE(t->sem.jal.target))
        {
                fputs("\tjal\t",stdout);
        	dump_addr(t->sem.jal.target);
        }
      	else
        {
                fputs("\tjalr\t$31,",stdout);
        	dump_addr(t->sem.jal.target->arg1.ptr);
//                fputs(",$31",stdout);
        }
      	(void) putchar('\n');
      }
      ST(JALI, LONG, t->sem.jal.target, AN, AN);
      }
    else {

	/* check that the dstreg is proper */
      	if (t->sem.jal.dstreg)
	{
		if(t->sem.jal.dstreg->mode!=RREGISTER)
		{
			erflag=TRUE;
			reason="dstreg not r-reg";
		}
		if(regnum(t->sem.jal.dstreg->arg1.str)!=25)
		{
			erflag=TRUE;
			reason="reg set is not r[25];";
		}
	}
      	if (!(t->sem.jal.target->mode & (ABSOLUTE | REGDFR)))
	{
		reason="Improper mode for target address";
        	erflag = 1;
	}

      /*
       * Set up side effects, the argument is a mask with bits set
       * to indicate which registers are used to pass arguments.
       * the encoding is as follows:
       *
       *                MSB       LSB
       *                 5 4 3 2 1 0
       *
       *       bit 0: set if general-purpose register 4 used
       *       bit 1: set if general-purpose register 5 used
       *       bit 2: set if general-purpose register 6 used
       *       bit 3: set if general-purpose register 7 used
       *       bit 4: set if floating-point register 12 used
       *       bit 5: set if floating-point register 14 used
       */
      if (side_effect) {
	  struct list* next;
	  char* a;
          assert(curptr);
          next=curptr->next;
          if(next && (next->type&PARMLINE) != PARMLINE)
                        next=NULL;
	  if(next)
	  {
          	assert(next);
	  	a=next->val;
	  	while(a=gtrg(a))
	  	{
			char new[REGSTRING+10];
			char reg[REGSTRING];
			char *b;
			copyloc(reg, unskiploc(a));
			*skiploc(reg)=0;
			sprintf(new, "=%s;", reg);
			b=new;
                	while (*side_effect = *b++)
                        	side_effect++;

	  	}
	  }
        }
      icost = 50 + t->sem.jal.target->cost;
      }
}

/*
 * jmp - check semantics of jmp instruction
 */
void jmp(struct sem_rec *t) {

    if (dassem) {
      (void) fputs("\tj\t", stdout);
      dump_addr(t->sem.jmp.target);
      (void) putchar('\n');
      ST(JMPI, LONG, t->sem.jmp.target, AN, AN);
      }
    else
      icost = 12;
}

/*
 * l - check semantics of load operation
 */
void l(struct sem_rec *t)
{
    int x;
#ifdef MEASURE
    int itype;
#endif

/*
    if (dassem && dde)
    {

    }*/
    if (dassem)
    {
      (void) fputs("\tl", stdout);
      if (REALTYPE(t->sem.l.dst))
        (void) printf(".%c", TYPECHAR(t->sem.l.dst));
      else
        (void) printf("%c", TYPECHAR(t->sem.l.mem));
#ifdef MEASURE
      itype = LDI;
#endif
      if (t->sem.l.unsign && CONMODE(t->sem.l.unsign))
      {
        (void) putchar('u');
#ifdef MEASURE
        itype = LDUI;
#endif
      }
      (void) putchar('\t');
      dump_addr(t->sem.l.dst);
      (void) putchar(',');
      dump_addr(t->sem.l.mem);
      (void) putchar('\n');
#ifdef MEASURE
      t->sem.l.mem->mode |= MEMREF;
      ST(itype, t->sem.l.mem->type, t->sem.l.dst, t->sem.l.mem, AN);
#endif
    }
    else
    {
      if (t->sem.l.unsign)
      {

        /*
         * A load signed byte or halfword also performs a sign extension,
         * while a load unsigned byte or halfword also performs a zero-fill.
         */
        if (!CONMODE(t->sem.l.unsign))
	{
          x = atoi(t->sem.l.unsign->arg1.ptr->arg1.str);
          if (!(LONGTYPE(t->sem.l.dst) && WORDTYPE(t->sem.l.mem) && x == 16) &&
              !(LWTYPE(t->sem.l.dst) && BYTETYPE(t->sem.l.mem) && x == 24))
	  {
	    reason="bad unsigned zero-fill";
            erflag = 1;
	  }
        }
        else
	{
          x = atoi(t->sem.l.unsign->arg1.str);
          if (!(LWTYPE(t->sem.l.dst) && WORDTYPE(t->sem.l.mem) && x == 65535) &&
              !(!REALTYPE(t->sem.l.dst) && BYTETYPE(t->sem.l.mem) && x == 255))
	  {
	    reason="bad sign extend";
            erflag = 1;
	  }
        }

      }
      else if (!COMPATIBLE(t->sem.l.mem, t->sem.l.dst))
      {
	if( ( REALTYPE(t->sem.l.dst) && !REALTYPE(t->sem.l.mem)) ||
	    (!REALTYPE(t->sem.l.dst) &&  REALTYPE(t->sem.l.mem)))
	{
	  reason="l.dst and l.mem are not compatible types";
          erflag = 1;
	}
	if(REALTYPE(t->sem.l.dst))
	{
		if(FLOATTYPE(t->sem.l.dst) && !FLOATTYPE(t->sem.l.mem))
		{
          		reason="s.src and s.mem are not compatible types";
          		erflag = 1;
		}
		if(DOUBLETYPE(t->sem.l.dst) && !DOUBLETYPE(t->sem.l.mem))
		{
          		reason="s.src and s.mem are not compatible types";
          		erflag = 1;
		}
	}

/* old compatibility check   it's nonsense to me and giving me hell.
	I rewrote it
   6-8-00 jdh8d

        if (!(BYTETYPE(t->sem.l.dst) && LWTYPE(t->sem.l.mem)) &&
            !(WORDTYPE(t->sem.l.dst) && LONGTYPE(t->sem.l.mem)) &&
            !(FLOATTYPE(t->sem.l.dst) && LONGTYPE(t->sem.l.mem)))
          erflag = 1;
*/
      }
      if(!signed_bits_fit(t->sem.l.mem, 12))
      {
           	erflag = 1;
		reason="Constant too big";
      }
    }
      icost = 20 + t->sem.l.mem->cost + t->sem.l.dst->cost;
}

/*
 * li - load immediate
 */
void li(struct sem_rec *t) {

    if (dassem) {
      if (isreloc(t->sem.li.src)) {
        (void) fputs("\tla\t", stdout);
        dump_addr(t->sem.li.dst);
        (void) putchar(',');
        dump_addr(t->sem.li.src);
        ST(LAI, t->sem.li.dst->type, t->sem.li.dst, t->sem.li.src, AN);
        }
      else if (REALTYPE(t->sem.li.dst)) {
        (void) printf("\tli.%c\t", TYPECHAR(t->sem.li.dst));
        dump_addr(t->sem.li.dst);
        (void) putchar(',');
        dump_addr(t->sem.li.src);
        ST(LII, t->sem.li.dst->type, t->sem.li.dst, t->sem.li.src, AN);
        }
      else if (CONMODE(t->sem.li.src) && !atoi(t->sem.li.src->arg1.str)) {
        (void) fputs("\tmove\t", stdout);
        dump_addr(t->sem.li.dst);
        (void) fputs(",$0", stdout);
        ST(MOVI, t->sem.li.dst->type, t->sem.li.dst, RG0, AN);
        }
      else {
        (void) fputs("\tli\t", stdout);
        dump_addr(t->sem.li.dst);
        (void) putchar(',');
        dump_addr(t->sem.li.src);
        ST(LII, t->sem.li.dst->type, t->sem.li.dst, t->sem.li.src, AN);
        }
      (void) putchar('\n');
      }
    else {
      if (!COMPATIBLE(t->sem.li.dst, t->sem.li.src))
        erflag = 1;
      }
      if(!REALTYPE(t->sem.li.dst)) {
        if(!signed_bits_fit(t->sem.li.src, 12) && !unsigned_bits_fit(t->sem.li.src, 12))
          erflag = 1;
      }
      icost = 5 + t->sem.li.dst->cost;
}

/*
 * mfc - move from coprocessor to general-purpose register
 */
void mfc(struct sem_rec *t) {

    if (dassem) {
      (void) fputs("\tmfc1\t", stdout);
      dump_addr(t->sem.mfc.dst);
      (void) putchar(',');
      dump_addr(t->sem.mfc.src);
      (void) putchar('\n');
      ST(MFCI, t->sem.mfc.dst->type, t->sem.mfc.dst, t->sem.mfc.src, AN);
      }
    else {
      if (!LONGTYPE(t->sem.mfc.dst) && !FLOATTYPE(t->sem.mfc.src))
        erflag = 1;
      icost = 10;
      }
}

/*
 * mfu - move double from coprocessor to general-purpose register
 */
void mfu(struct sem_rec *i1, struct sem_rec *i2) {

#ifdef GCC_AS
        assert(("DMFC1 does'nt work in gcc :(\n",0));
#else
#ifdef SS_AS
        assert(("DMFC1 does'nt work in gcc :(\n",0));
#endif
#endif

    if (dassem) {
      if(sw_adl)
      (void) fputs("\tmfc1.d\t", stdout);
      else
      (void) fputs("\tdmfc1\t", stdout);
      dump_addr(i1->sem.mfc.dst);
      (void) putchar(',');
      dump_addr(i1->sem.mfc.src);
      (void) putchar('\n');
      ST(MFCI, i1->sem.mfc.dst->type, i1->sem.mfc.dst, i1->sem.mfc.src, AN);
      }
    else {
      if (!LONGTYPE(i1->sem.mfc.dst) && !DOUBLETYPE(i1->sem.mfc.src) ||
          !icompare(i1->sem.mfc.src, i2->sem.mfc.src) ||
          (regnum(i1->sem.mfc.dst->arg1.str) !=
           regnum(i2->sem.mfc.dst->arg1.str) - 1))
        erflag = 1;
      icost = 10;
      }
}

/*
 * mov - check semantics of mov instruction
 */
void mov(struct sem_rec *t) {

    if (dassem) {
      if (REALTYPE(t->sem.mov.src))
        (void) printf("\tmov.%c\t", TYPECHAR(t->sem.mov.src));
      else
        (void) fputs("\tmove\t", stdout);
      dump_addr(t->sem.mov.dst);
      (void) putchar(',');
      dump_addr(t->sem.mov.src);
      (void) putchar('\n');
      ST(MOVI, t->sem.mov.dst->type, t->sem.mov.dst, t->sem.mov.src, AN);
      }
    else {
      if (!COMPATIBLE(t->sem.mov.dst, t->sem.mov.src)) {
        if (!(LONGTYPE(t->sem.mov.src) && BWTYPE(t->sem.mov.dst)) &&
            !(WORDTYPE(t->sem.mov.src) && BYTETYPE(t->sem.mov.dst)))
          erflag = 1;
        }
      if (icompare(t->sem.mov.dst, t->sem.mov.src))
        icost = 0;
      else
        icost = 3 + t->sem.mov.dst->cost + t->sem.mov.src->cost;
      }
}

/*
 * mtc - move to coprocessor from gp register
 */
void mtc(struct sem_rec *t) {

    if (dassem) {
      if (DOUBLETYPE(t->sem.mfc.dst))
	if(sw_adl)
        (void) fputs("\tmtc1.d\t", stdout);
	else
        (void) fputs("\tdmtc1\t", stdout);
      else
        (void) fputs("\tmtc1\t", stdout);
      dump_addr(t->sem.mfc.src);
      (void) putchar(',');
      dump_addr(t->sem.mfc.dst);
      (void) putchar('\n');
      ST(MTCI, t->sem.mfc.dst->type, t->sem.mfc.dst, t->sem.mfc.src, AN);
      }
    else {
      if (!REALTYPE(t->sem.mfc.dst) || !LONGTYPE(t->sem.mfc.src))
        erflag = 1;
      icost = 10;

      if(DOUBLETYPE(t->sem.mtc.dst)) {
         char *c;
          c = t->sem.mtof.src->arg1.str;
          if (isreg(c) && (regnum(c) % 2 == 1))
          {
              erflag = 1;
              reason="double register specifier must be even (was odd)";
          }
      }
    }
}

/*
 * nop - check semantics of noop
 */
void nop() {
    icost = 0;
}

/*
 * retrn - check semantics of return
 */
void retrn() {
    char *a;

    if (dassem) {
      (void) puts("\tj\t$31");
      ST(JMPI, LONG, RG0, AN, AN);
      }
    else {
      icost = 10;
      if (side_effect && sret)
        for (a = sret; *side_effect = *a++; side_effect++);
      }
}

/*
 * neg - check semantics of negate operation
 */
void neg(struct sem_rec *t) {

    if (dassem) {
      if (REALTYPE(t->sem.neg.src))
        (void) printf("\tneg.%c\t", TYPECHAR(t->sem.neg.src));
      else
//#ifndef SS_AS
//        (void) fputs("\tnegu\t", stdout);
//#else
	(void) fputs("\tsubu\t", stdout);
//#endif
      dump_addr(t->sem.neg.dst);
      (void) putchar(',');
//#ifdef SS_AS
	if(!REALTYPE(t->sem.neg.src))
		(void)fputs("$0, ", stdout);
//#endif
      dump_addr(t->sem.neg.src);
      (void) putchar('\n');
      ST(NEGI, t->sem.neg.dst->type, t->sem.neg.dst, t->sem.neg.src, AN);
      }
    else {
      if (!COMPATIBLE(t->sem.mov.src, t->sem.mov.dst))
        erflag = 1;
      icost = 2 + t->sem.mov.src->cost;
      }
}

/*
 * not - check semantics of move complement operation
 */
void not(struct sem_rec *t) {

    if (dassem) {
      (void) fputs("\tnor\t", stdout);
      dump_addr(t->sem.not.dst);
      (void) printf(",$0,");
      dump_addr(t->sem.not.src);
      (void) putchar('\n');
      ST(NOTI, t->sem.neg.dst->type, t->sem.neg.dst, t->sem.neg.src, AN);
      }
    else {
      if (!COMPATIBLE(t->sem.not.src, t->sem.not.dst) ||
          REALTYPE(t->sem.not.src))
        erflag = 1;
      icost = 2 + t->sem.not.src->cost;
      }
}

/*
 * cmpset - check semantics of compare and set instruction
 */
void cmpset(struct sem_rec *t) {
#ifdef MEASURE
    int itype;
#endif

    if (dassem) {
      (void) putchar('\t');
      (void) putchar('s');
      (void) fputs(t->sem.cmpset.rel, stdout);
      (void) putchar('\t');
      dump_addr(t->sem.cmpset.dst);
      (void) putchar(',');
      dump_addr(t->sem.cmpset.left);
      (void) putchar(',');
      dump_addr(t->sem.cmpset.right);
      (void) putchar('\n');
#ifdef MEASURE
      if (!strcmp(t->sem.cmpset.rel, "eq"))
        itype = SEQI;
      else if (!strcmp(t->sem.cmpset.rel, "ne"))
        itype = SNEI;
      else if (!strcmp(t->sem.cmpset.rel, "ge"))
        itype = SGEI;
      else if (!strcmp(t->sem.cmpset.rel, "le"))
        itype = SLEI;
      else if (!strcmp(t->sem.cmpset.rel, "lt"))
        itype = SLTI;
      else if (!strcmp(t->sem.cmpset.rel, "gt"))
        itype = SGTI;
      else if (!strcmp(t->sem.cmpset.rel, "geu"))
        itype = SGEUI;
      else if (!strcmp(t->sem.cmpset.rel, "leu"))
        itype = SLEUI;
      else if (!strcmp(t->sem.cmpset.rel, "ltu"))
        itype = SLTUI;
      else
        itype = SGTUI;
#endif
      ST(itype, t->sem.cmpset.dst->type,
         t->sem.cmpset.dst, t->sem.cmpset.left, t->sem.cmpset.right);
      }
    else {
      if (!LONGTYPE(t->sem.cmpset.left) || !LONGTYPE(t->sem.cmpset.right) ||
          !LONGTYPE(t->sem.cmpset.dst))
        erflag = 1;
      else if (isreloc(t->sem.cmpset.right) || isreloc(t->sem.cmpset.left))
        erflag = 1;
      icost = 10;
      }
}

/*
 * s - check semantics of store operation
 */
void s(struct sem_rec *t) {

/*    if (dassem && dde)
     {

     }*/
    if (dassem) {
      (void) fputs("\ts", stdout);
      if (REALTYPE(t->sem.s.src)) {
         (void) putchar('.');
         (void) printf("%c\t", TYPECHAR(t->sem.s.src));
      }
      else
         (void) printf("%c\t", TYPECHAR(t->sem.s.mem));

      dump_addr(t->sem.s.src);
      (void) putchar(',');
      dump_addr(t->sem.s.mem);
      (void) putchar('\n');
#ifdef MEASURE
      t->sem.s.mem->mode |= MEMREF;
      ST(STI, t->sem.s.mem->type, t->sem.s.mem, t->sem.s.src, AN);
#endif
      }
    else
    {
      if (!COMPATIBLE(t->sem.s.mem, t->sem.s.src))
      {
        if( ( REALTYPE(t->sem.l.dst) && !REALTYPE(t->sem.l.mem)) ||
            (!REALTYPE(t->sem.l.dst) &&  REALTYPE(t->sem.l.mem)))
        {
          reason="s.src and s.mem are not compatible types";
          erflag = 1;
        }

	if(REALTYPE(t->sem.l.dst))
	{
		if(FLOATTYPE(t->sem.l.dst) && !FLOATTYPE(t->sem.l.mem))
		{
          		reason="s.src and s.mem are not compatible types";
          		erflag = 1;
		}
		if(DOUBLETYPE(t->sem.l.dst) && !DOUBLETYPE(t->sem.l.mem))
		{
          		reason="s.src and s.mem are not compatible types";
          		erflag = 1;
		}
	}
      }
      if(!signed_bits_fit(t->sem.s.mem, 12))
      {
           	erflag = 1;
		reason="Constant too big";
      }
    }
    icost = 20 + t->sem.l.mem->cost + t->sem.l.dst->cost;

}

/*
 * samemem - allow for store into memory from memory if same item
 */
void samemem(struct sem_rec *t) {

    if (!dassem) {
      if (!icompare(t->sem.s.mem, t->sem.s.src))
        erflag = 1;
      }
      icost = 0;
}

/*
 * mtof - move to fpcoporocessor and convert to floating-point value
 */
void mtof(struct sem_rec *t) {

    if (dassem) {
      (void) fputs("\tmtc1\t", stdout);
      dump_addr(t->sem.mtof.src);
      (void) putchar(',');
      dump_addr(t->sem.mtof.dst);
      (void) putchar('\n');
      ST(MTCI, t->sem.mtof.dst->type, t->sem.mtof.dst, t->sem.mtof.src, AN);

      (void) printf("\tcvt.%c.w\t", TYPECHAR(t->sem.mtof.dst));
      dump_addr(t->sem.mtof.dst);
      (void) putchar(',');
      dump_addr(t->sem.mtof.dst);
      (void) putchar('\n');
      ST(CVTI, t->sem.mtof.dst->type, t->sem.mtof.dst, t->sem.mtof.dst, AN);
      }
    else {
      if (!REALTYPE(t->sem.mtof.dst) || !LONGTYPE(t->sem.mtof.src)){
        erflag = 1;
	reason = "dst or src wrong type";
      }
      if(!DREGMODE(t->sem.mtof.dst) != !HREGMODE(t->sem.mtof.src)) {
        erflag = 1;
        reason = "Double destination with integer source";
      }
      icost = 10 + t->sem.mtof.dst->cost + t->sem.mtof.src->cost;
    }
}

/*
 * mtoi - move from fpcoprocessor and convert to integer
 */

void mtoi(struct sem_rec *t) {

  if (dassem) {
    if(sw_adl)
    (void) printf("\ttrunc.w.%c\t", TYPECHAR(t->sem.mtoi.src));
    else
    (void) printf("\tcvt.w.%c\t", TYPECHAR(t->sem.mtoi.src));
    dump_addr(t->sem.mtoi.src);
    (void) putchar(',');
    dump_addr(t->sem.mtoi.src);
    (void) puts(",$2");
    ST(TRCI, t->sem.mtoi.dst->type, t->sem.mtoi.src, t->sem.mtoi.src, AN);

    (void) fputs("\tmfc1\t", stdout);
    dump_addr(t->sem.mtoi.dst);
    (void) putchar(',');
    dump_addr(t->sem.mtoi.src);
    (void) putchar('\n');
    ST(MFCI, t->sem.mtoi.dst->type, t->sem.mtoi.dst, t->sem.mtoi.src, AN);
  }

  else {
    if (!LONGTYPE(t->sem.mtoi.dst) || !REALTYPE(t->sem.mtoi.src)){
      erflag = 1;
      reason = "dst or src wrong type";
    }
    if(!DREGMODE(t->sem.mtof.dst) != !HREGMODE(t->sem.mtof.src)) {
        erflag = 1;
        reason = "Double destination with integer source";
    }

    icost = 10 + t->sem.mtoi.dst->cost + t->sem.mtoi.src->cost;

    /* Since the truncate is done in place, the src register is
       destroyed and the optimizer needs to know this */
    if (side_effect) {
      char new[REGSTRING+10];
      char reg[REGSTRING];
      char *b;
      copyloc(reg, t->sem.mtoi.src->arg1.str);
      *skiploc(reg)=0;
      sprintf(new, "%s=;", reg);
      b=new;
      while (*side_effect = *b++)
	side_effect++;

    }

  }
}

int GetConstant(struct addr_entry *t, int *constant) {
   char *s;
   int v=0, u=0;
   extern int ban_macros;
   switch (t->mode) {

      case EXPR:
         switch ((int) t->arg1.str) {

            case NEGI:
               if(GetConstant(t->arg2.ptr, &v)) {
                 *constant = -v;
                 return 1;
               } else {
                 return 0;
               }

            case NOTI:
               if(GetConstant(t->arg2.ptr, &v)) {
                 *constant = ~v;
                 return 1;
               } else {
                 return 0;
               }
            case ADDI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u)) {
                 *constant = v + u;
                 return 1;
               } else {
                 return 0;
               }

            case SUBI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u)) {
                 *constant = v - u;
                 return 1;
               } else {
                 return 0;
               }

            case MULI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u)) {
                 *constant = v * u;
                 return 1;
               } else {
                 return 0;
               }

            case DIVI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u) && u) {
                 *constant = v / u;
                 return 1;
               } else {
                 return 0;
               }

            case REMI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u) && u > 0) {
                 *constant = v % u;
                 return 1;
               } else {
                 return 0;
               }

            case SLLI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u) && u > 0) {
                 *constant = (unsigned)v << u;
                 return 1;
               } else {
                 return 0;
               }

            case SRLI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u) && u > 0) {
                 *constant = (unsigned)v >> u;
                 return 1;
               } else {
                 return 0;
               }

            case XORI:
               if(GetConstant(t->arg2.ptr, &v) && GetConstant(t->arg3.ptr, &u) ) {
                 *constant = v ^ u;
                 return 1;
               } else {
                 return 0;
               }

	    default:
               return 0;
               break;
         }
	break;

      case IMMED: case ABSOLUTE:
        return GetConstant(t->arg1.ptr, constant);

      case DISP:
	return GetConstant(t->arg2.ptr, constant);

      case LIDENT:
         if(ban_macros)
           *constant = localrecord(t->arg1.str)->offset;
         else
           *constant = 0;
         return 1;

      case SPILLOC:
        if(ban_macros)
           *constant = spilloff + atoi(t->arg1.ptr->arg1.str);
        else
           *constant = 0;
        return 1;

      case REGDFR:
      case GIDENT:
      case LABEL:
      case RREGISTER:
      case HREGISTER:
      case FREGISTER:
      case DREGISTER:
        return 0;

      case ICONST:
         *constant = atoi(t->arg1.str);
         return 1;

      case FCONST:
         return 0;

      default:
        (void) fprintf(stderr, "vpo (ConstantTooBig): unknown addressing mode %d\n",
                               t->mode);
        exit(1);
   }
   return 0;
}

int signed_bits_fit(struct addr_entry *t, int bits) {
  int x;
  if(GetConstant(t, &x)) {
    int msb_mask = 1 << (bits - 1);
    int msb = (x & msb_mask)  >> (bits - 1);
    int allowed_bits = (1 << bits) - 1;
    /**
     * If the sign bits are all 1,
     * or all zero, return true;
     */
    if(msb)
      x -= ~allowed_bits;
    return !(x & ~allowed_bits);
  } else {
    return TRUE;
  }
}

int unsigned_bits_fit(struct addr_entry *t, int bits) {
  int x;
  if(GetConstant(t, &x)) {
    unsigned allowed_bits = (1 << bits) - 1;
    return !(x & ~allowed_bits);
  } else {
    return TRUE;
  }
}

int SignedConstTooBig(struct addr_entry *t) {
  int constant;
  return GetConstant(t, &constant) && (constant < -32768 || constant > 32767);
}

int UnsignedConstTooBig(struct addr_entry *t) {
  int constant;
  return GetConstant(t, &constant) && (constant < 0 || constant > 65535);
}

/*
 * ConstantTooBig - make sure constant doesn't exceed 16-bit signed constant
 */
int ConstantTooBig(struct addr_entry *t) {
   char *s;
   int v=0;

   switch (t->mode) {

      case EXPR:
         switch ((int) t->arg1.str) {

            case NEGI:
               v = ConstantTooBig(t->arg2.ptr);
               break;

            case NOTI:
               v = ConstantTooBig(t->arg2.ptr);
               break;

	    default:
               v = ConstantTooBig(t->arg2.ptr) || ConstantTooBig(t->arg3.ptr);
               break;
         }
	break;

      case IMMED:
        v=ConstantTooBig(t->arg1.ptr);
        break;

      case ABSOLUTE:
        v=ConstantTooBig(t->arg1.ptr);
        break;

      case DISP:
        v=ConstantTooBig(t->arg2.ptr);
	break;

      case REGDFR:
      case GIDENT:
      case LIDENT:
      case LABEL:
      case RREGISTER:
      case FREGISTER:
      case DREGISTER:
         break;


      case ICONST:
         return atoi(t->arg1.str) > 32767;

      case SPILLOC:
      case FCONST:
         return 0;

      default:
        (void) fprintf(stderr, "vpo (ConstantTooBig): unknown addressing mode %d\n",
                               t->mode);
        exit(1);
   }
   return v;
}



/*
 * divide - divide two registers, storing result in HI/LO
 */
void divide(struct sem_rec *t)
{
    ikind |= DIVI;
        if (dassem && dde)
        {
                /*Print instruction:
                  Passed in: Instruction name,
                  left operand signal/data, left base, left displacement, left predicate base, predicate displacement,
                  right operand signal/data, right base, right displacement, right predicate
                */
                #ifdef SS_AS
                                pre_vpo_ss(stdout);
                #endif
                print_dde_inst("dd_div",1,0,-1,0,0,1,0,-1,0);
                ST(DIVI, t->sem.divide.left->type, t->sem.divide.left,
                                      t->sem.divide.right, AN);
        }
        else if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tdiv\t", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                dump_addr(t->sem.divide.left);
                (void) putchar(',');
                dump_addr(t->sem.divide.right);
                (void) putchar('\n');
                ST(DIVI, t->sem.divide.left->type, t->sem.divide.left,
                                t->sem.divide.right, AN);
        }
        else
        {
      icost = 10 + t->sem.divide.left->cost + t->sem.divide.right->cost;
        }
}



/*
 * divideu - divide with no overflow/underflow two registers, storing result in HI/LO
 */
void divideu(struct sem_rec *t)
{
    ikind |= DIVUI;
    if (dassem && dde)
    {
            /*Print instruction:
              Passed in: Instruction name,
              left operand signal/data, left base, left displacement, left predicate base, predicate displacement,
              right operand signal/data, right base, right displacement, right predicate
            */
            print_dde_inst("dd_divu",1,0,-1,0,0,1,0,-1,0);
            ST(DIVI, t->sem.divideu.left->type, t->sem.divideu.left,
                                  t->sem.divideu.right, AN);
    }
    else if (dassem)        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tdivu\t", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                dump_addr(t->sem.divideu.left);
                (void) putchar(',');
                dump_addr(t->sem.divideu.right);
                (void) putchar('\n');
                ST(DIVUI, t->sem.divideu.left->type, t->sem.divideu.left,
                                t->sem.divideu.right, AN);
        }
        else
        {
      icost = 10 + t->sem.divideu.left->cost + t->sem.divideu.right->cost;
        }
}



/*
 * mflo - move from LO to a register
 */
void mflo(struct sem_rec *t)
{
    ikind |= MOVI;
        if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tmflo", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                (void) putchar('\t');
                dump_addr(t->sem.mflo.dst);
                (void) putchar('\n');
                ST(MOVI, t->sem.mflo.dst->type, t->sem.mflo.dst,
                                AN, AN);
        }
        else
        {
          if(t->sem.mflo.dst->mode!=RREGISTER && t->sem.mflo.dst->mode != HREGISTER)
                  erflag=1;
      icost = 10 + t->sem.mflo.dst->cost;
        }
}


/*
 * mfhi - move from HI to a register
 */
void mfhi(struct sem_rec *t)
{
    ikind |= MOVI;
        if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tmfhi", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                (void) putchar('\t');
                dump_addr(t->sem.mfhi.dst);
                (void) putchar('\n');
                ST(MOVI, t->sem.mfhi.dst->type, t->sem.mfhi.dst,
                                AN, AN);
        }
        else
        {
          if(t->sem.mfhi.dst->mode!=RREGISTER && t->sem.mfhi.dst->mode!=HREGISTER)
                  erflag=1;
      icost = 10 + t->sem.mfhi.dst->cost;
        }
}

/*
 * mfireg - mfhi or mflo
 */
void mfireg(struct sem_rec *t)
{
	if(2 == regnum(t->sem.mfireg.src->arg1.str))
		mflo(t);
	else
		mfhi(t);
}

/*
 * high - print hi register
 */
void highlow(struct sem_rec *t)
{
    ikind |= LUI;
    if (dassem)
    {
	if(sw_adl) {
                erflag = 1;
	        ST(LUI, t->sem.high.left->type, t->sem.high.left,
	                            t->sem.high.right, AN);
       } else {
                (void) fputs("\tlui\t", stdout);
                dump_addr(t->sem.high.left);
                (void) fputs(",%hi(", stdout);
                dump_addr(t->sem.high.right);
                (void) fputs(")\n", stdout);
                ST(LUI, t->sem.high.left->type, t->sem.high.left,
                                t->sem.high.right, AN);

       }
    }
    else
    {
         if(t->sem.high.left->mode!=RREGISTER)
              erflag=1;

         icost = 10 + t->sem.high.left->cost;
    }
}


/*
 * high - print hi register
 */
void high(struct sem_rec *t)
{
    ikind |= LUI;
    if (dassem)
    {
	if(sw_adl) {
	        unsigned int constant;
	        if(GetConstant(t->sem.high.right, &constant)) {
	        	(void) fputs("\tlui16", stdout);
	        	(void) putchar('\t');
	        	dump_addr(t->sem.high.left);
	        	(void) fprintf(stdout,",%d\n", constant >> 16);
	        } else {
	        	(void) fputs("\tlalui", stdout);
	        	(void) putchar('\t');
	        	dump_addr(t->sem.high.left);
	        	(void) fputs(",", stdout);
	        	dump_addr(t->sem.high.right);
	        	(void) fputs("\n", stdout);
	        }
	        ST(LUI, t->sem.high.left->type, t->sem.high.left,
	                            t->sem.high.right, AN);
       } else {
                (void) fputs("\tlui\t", stdout);
                dump_addr(t->sem.high.left);
                (void) fputs(",%hi(", stdout);
                dump_addr(t->sem.high.right);
                (void) fputs(")\n", stdout);
                ST(LUI, t->sem.high.left->type, t->sem.high.left,
                                t->sem.high.right, AN);

       }
    }
    else
    {
         if(t->sem.high.left->mode!=RREGISTER)
              erflag=1;

         icost = 10 + t->sem.high.left->cost;
    }
}


/*
 * low - print low register
 */
void low(struct sem_rec *t)
{
    ikind |= ORI;
    if (dassem)
    {
	if(sw_adl) {
	        unsigned int constant;
	        if(GetConstant(t->sem.low.var, &constant)) {
	            (void) fputs("\tori", stdout);
	            (void) putchar('\t');
	            dump_addr(t->sem.low.dst);
	            (void) putchar(',');
	            dump_addr(t->sem.low.src);
	            (void) fprintf(stdout,",%d\n", constant & 0xffff);
	        } else {
	            fputs("\tlaori", stdout);
	            (void) putchar('\t');
	            dump_addr(t->sem.low.dst);
	            (void) fputs(",", stdout);
	            dump_addr(t->sem.low.var);
	            (void) fputs("\n", stdout);
	        }

	        ST(ORI, t->sem.low.dst->type, t->sem.low.src,
	                                t->sem.low.var, AN);
	} else {
		unsigned int constant;
                if(t->sem.low.var->mode == IMMED) {
                    fputs("\tori\t", stdout);
                } else {
                    fputs("\taddiu\t", stdout);
                }
                dump_addr(t->sem.low.dst);
                (void) putchar(',');
                dump_addr(t->sem.low.src);
                (void) fputs(",%lo(", stdout);
                dump_addr(t->sem.low.var);
                (void) fputs(")\n", stdout);
                ST(ORI, t->sem.low.dst->type, t->sem.low.src,
                                t->sem.low.var, AN);

	}
    } else {
             if(t->sem.low.dst->mode!=RREGISTER || t->sem.low.src->mode != RREGISTER)
                  erflag=1;

             if(!icompare(t->sem.low.dst, t->sem.low.src))
                erflag=1;
             icost = 10 + t->sem.low.dst->cost;
    }
}


/*
 * brk - print break
 */
void brk(struct sem_rec *t)
{
    ikind |= BRKI;
        if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tbreak", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                (void) fputs("\n", stdout);
                ST(BRKI, t->sem.brk.dst->type, AN,AN, AN);
        }
        else
        {

             icost = 10;
        }
}


/*
 * multi - multiply two registers, storing result in LO
 */
void multi(struct sem_rec *t)
{
    ikind |= MUL;
        if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tmultu", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                (void) fputs("\t", stdout);
                dump_addr(t->sem.multi.left);
                (void) putchar(',');
                dump_addr(t->sem.multi.right);
                (void) putchar('\n');
                ST(MUL, t->sem.multi.left->type, t->sem.multi.left,
                                t->sem.multi.right, AN);
        }
        else
        {
      icost = 10 + t->sem.multi.left->cost + t->sem.multi.right->cost;
        }
}


/*
 * cvtfi - check semantics of a convert float to integer operation
 */
void cvtfi(struct sem_rec *t) {
    ikind |= CVTI;
        if (dassem) {
#ifdef SS_AS
          pre_vpo_ss(stdout);
#endif
//          (void) printf("\tcvt.w.%c", TYPECHAR(t->sem.cvt.src));
          if(sw_adl)
          (void) printf("\ttrunc.w.%c", TYPECHAR(t->sem.cvt.src));
          else
          (void) printf("\tcvt.w.%c", TYPECHAR(t->sem.cvt.src));
#ifdef SS_AS
          dump_vpo_ss(stdout);
#endif
          (void) fputs("\t", stdout);
          dump_addr(t->sem.cvt.dst);
      (void) putchar(',');
          dump_addr(t->sem.cvt.src);
      (void) putchar('\n');
      ST(CVTI, t->sem.cvt.dst->type, t->sem.cvt.dst, t->sem.cvt.src, AN);
        }
        else {
      if (!icompare(t->sem.cvt.dst, t->sem.cvt.src))
      {
        erflag = 1;
        reason="Incompatible conversion cvt.w.*";
      }
      icost = 10 + t->sem.cvt.dst->cost + t->sem.cvt.src->cost;
        }
}

void cvtil(struct sem_rec *t) {
  ikind |= CVTI;
  int hreg = gpregmap[regnum(t->sem.cvtil.dst->arg1.str)];
  int hi = gpregmap[regnum(t->sem.cvtil.hi->arg1.str)];
  int lo = gpregmap[regnum(t->sem.cvtil.lo->arg1.str)];

  if(dassem) {
    if(hreg+1 == lo) {
      printf("\tmove\t%s,%s\n",r_regs[1], r_regs[lo]);
      printf("\tmove\t%s,%s\n",r_regs[hreg+1], r_regs[hi]);
      printf("\tmove\t%s,%s\n",r_regs[hreg], r_regs[1]);
    } else {
      if(hi != hreg+1)
        printf("\tmove\t%s,%s\n",r_regs[hreg+1], r_regs[hi]);
      if(lo != hreg)
        printf("\tmove\t%s,%s\n",r_regs[hreg], r_regs[lo]);
    }
  } else {
    if(t->sem.cvtil.dst->mode != HREGISTER)
      erflag = 1;
    icost = 0;
    if(hreg+1 == lo)
      icost = 10;
    if(hi != hreg+1)
      icost += 10 + t->sem.cvtil.dst->cost + t->sem.cvtil.hi->cost;
    if(lo != hreg)
      icost += 10 + t->sem.cvtil.dst->cost + t->sem.cvtil.lo->cost;
  }
}

/*
 * cvtif - check semantics of a convert integer to float operation
 */
void cvtif(struct sem_rec *t) {
    ikind |= CVTI;
        if (dassem) {
#ifdef SS_AS
          pre_vpo_ss(stdout);
#endif
          (void) printf("\tcvt.%c.w", TYPECHAR(t->sem.cvt.dst));
#ifdef SS_AS
          dump_vpo_ss(stdout);
#endif
          (void) fputs("\t", stdout);
          dump_addr(t->sem.cvt.dst);
      (void) putchar(',');
          dump_addr(t->sem.cvt.src);
      (void) putchar('\n');
      ST(CVTI, t->sem.cvt.dst->type, t->sem.cvt.dst, t->sem.cvt.src, AN);
        }
        else {
      if (!icompare(t->sem.cvt.dst, t->sem.cvt.src))
      {
        erflag = 1;
        reason = "Incompatible conversion cvt.*.w";
      }
      icost = 10 + t->sem.cvt.dst->cost + t->sem.cvt.src->cost;
        }

}


/*
 * multu - multiply two registers for long long
 */
void multu(struct sem_rec *t)
{
    ikind |= MUL;
	int num = atoi(t->sem.multu.var->arg1.str);
if(num==32 && t->sem.multu.left && t->sem.multu.right ){
        if (dassem)
        {
#ifdef SS_AS
                pre_vpo_ss(stdout);
#endif
                (void) fputs("\tmultu", stdout);
#ifdef SS_AS
                dump_vpo_ss(stdout);
#endif
                (void) fputs("\t", stdout);
                dump_addr(t->sem.multu.left);
                (void) putchar(',');
                dump_addr(t->sem.multu.right);
                (void) putchar('\n');
                ST(MUL, t->sem.multu.left->type, t->sem.multu.left,
                                t->sem.multu.right, AN);
        }
        else
        {
      icost = 10 + t->sem.multu.left->cost + t->sem.multu.right->cost;
        }} else {
		erflag = 1;
	}
}
