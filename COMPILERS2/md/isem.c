
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

 $Source: /home/baird/CVS/adl/zephyr/zephyr/backend/vpo/mips-dde/isem.c,v $
 $Date: 2016/05/04 19:42:19 $
 $Revision: 1.1 $
 $Name:  $

 Log of changes:

 $Log: isem.c,v $
 Revision 1.1  2016/05/04 19:42:19  baird
 Added directory for mips-DDE backend

 Revision 1.4  2002/06/05 20:08:55  jdh8d
 Changes to support the stache, including routines to build a callgraph.

 Some cosmetic changes.

 Minor bug fixes.

 Changed build scripts to build the mips compiler for SimpleScalar if
 SSAS is set to "-DSS_AS"

 Revision 1.3  2001/05/28 20:36:04  jdh8d
 *** empty log message ***

 Revision 1.2  2000/06/10 18:44:54  jwd
 Converted over to ANSI C.

 Revision 1.3  2000/07/18 18:46:08  jdh8d
 changes to get mips to compile/run under new system


*************************************************************************/

#include <stdio.h>
#include <stdlib.h>

#include "../lib/vpo.h"
#include "../lib/combine.h"

#include "addrdef.h"
#include "instdef.h"
#include "inst.h"
#include "isem.h"
#include "recdef.h"


int sem_ptr;                            /* Semantic record allocation pointer */
struct sem_rec sem_table[SEMTABLESIZE]; /* Semantic record table              */

/*
 * record - get a semantic record
 */
struct sem_rec *
record(struct addr_entry *d1, struct addr_entry *d2, struct addr_entry *d3)
{
    register struct sem_rec *t;

    t = &sem_table[sem_ptr++];
    t->sem.fields[0] = d1;
    t->sem.fields[1] = d2;
    t->sem.fields[2] = d3;
    t->sem.fields[3] = 0;
    return(t);
}

/*
 * brecord - get a semantic record for a binary operation
 */
struct sem_rec *brecord(int op, struct addr_entry *d1,
 struct addr_entry *d2) {
    register struct sem_rec *t;

    t = &sem_table[sem_ptr++];
    t->sem.binst.left = d1;
    t->sem.binst.right = d2;
    t->sem.binst.dst = AN;
    t->sem.binst.op = op;
    return(t);
}

/*
 * rrecord - get a semantic record for a relational operation
 */
struct sem_rec *rrecord(char *rel, struct addr_entry *d1,
 struct addr_entry *d2, struct addr_entry *d3) {
    register struct sem_rec *t;

    t = &sem_table[sem_ptr++];
    t->sem.bb.left = d1;
    t->sem.bb.right = d2;
    t->sem.bb.lbl = d3;
    t->sem.bb.rel = rel;
    return(t);
}

/*
 * binopi - check semantics of binary operation
 */
struct sem_rec *binopi(struct addr_entry *dst, struct sem_rec *s) {

    /*
     * Ensure that the sources are compatible with the destination
     */
    if (!COMPATIBLE(s->sem.binst.left, s->sem.binst.right) ||
        !COMPATIBLE(dst, s->sem.binst.right))
      erflag = 1;

    /*
     * We can relax types just a little when we AND
     */
    if (s->sem.binst.op == ANDI) {
      if (LWTYPE(dst) && BYTETYPE(s->sem.binst.left) &&
          IMMEDMODE(s->sem.binst.right) &&
          CONMODE(s->sem.binst.right->arg1.ptr) &&
          atoi(s->sem.binst.right->arg1.ptr->arg1.str) == 255)
        ;
      else if (LONGTYPE(dst) && WORDTYPE(s->sem.binst.left) &&
               IMMEDMODE(s->sem.binst.right) &&
               CONMODE(s->sem.binst.right->arg1.ptr) &&
               atoi(s->sem.binst.right->arg1.ptr->arg1.str) == 65535)
        ;
      else if (!COMPATIBLE(dst, s->sem.binst.left))
        erflag = 1;
      }

    /*
     * We can relax types just a little when we shift left
     */
    else if (s->sem.binst.op == SLLI) {
      if (LWTYPE(dst) && BYTETYPE(s->sem.binst.left) &&
          IMMEDMODE(s->sem.binst.right) &&
          CONMODE(s->sem.binst.right->arg1.ptr) &&
          atoi(s->sem.binst.right->arg1.ptr->arg1.str) == 24)
        ;
      else if (LONGTYPE(dst) && WORDTYPE(s->sem.binst.left) &&
               IMMEDMODE(s->sem.binst.right) &&
               CONMODE(s->sem.binst.right->arg1.ptr) &&
               atoi(s->sem.binst.right->arg1.ptr->arg1.str) == 16)
        ;
      else if (!COMPATIBLE(dst, s->sem.binst.left))
        erflag = 1;
      }

    else if (!COMPATIBLE(dst, s->sem.binst.left))
      erflag = 1;

    s->sem.binst.dst = dst;
    return(s);
}

/*
 * same - ensure that two items are the same
 */
struct addr_entry *same(struct addr_entry *i1, struct addr_entry *i2) {

    if (!icompare(i1, i2))
      erflag = 1;
    return(addr(ANY, TEMPADDR, i1, i2, AN));
}
