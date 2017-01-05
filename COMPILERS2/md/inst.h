
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

 $Source: /home/baird/CVS/adl/zephyr/zephyr/backend/vpo/mips-dde/inst.h,v $
 $Date: 2016/05/04 19:42:19 $
 $Revision: 1.1 $
 $Name:  $

 Log of changes:

 $Log: inst.h,v $
 Revision 1.1  2016/05/04 19:42:19  baird
 Added directory for mips-DDE backend

 Revision 1.4  2002/07/19 19:09:48  clc5q
 Clean up #include chains. Use #include instead of extern to get access
 to global variables from other modules.

 Revision 1.3  2002/07/11 20:08:15  clc5q
 Clean up #include chains. Use #include instead of extern to get access
 to global variables from other modules.

 Revision 1.2  2002/06/05 20:08:54  jdh8d
 Changes to support the stache, including routines to build a callgraph.

 Some cosmetic changes.

 Minor bug fixes.

 Changed build scripts to build the mips compiler for SimpleScalar if
 SSAS is set to "-DSS_AS"

 Revision 1.1  2000/09/15 23:06:19  jwd
 Initial revision
 Revision 1.1  2000/07/18 16:17:59  jdh8d
 blah


*************************************************************************/

#ifndef INST_H
#define INST_H

#include "addrdef.h"
#include "recdef.h"
#include "dde_inst.h"

extern int minlocrefs;
extern int minargrefs;
extern int dassem;
extern int str_ptr;
extern int i_ptr;
extern char *labprt;
extern char *acomment;
extern int dde;
extern int condret;             /* indicates if RETURN can be the target
                                 * of a conditional jump, i.e., conditional
                                 * returns are supported by the machine
                                 */

struct addr_entry *
addr(int, int, struct addr_entry *, struct addr_entry *, struct addr_entry *);

int icompare(struct addr_entry *, struct addr_entry *);
void dump_addr(struct addr_entry *);
int isreloc(struct addr_entry *);
struct addr_entry *initexpr(struct addr_entry *, int, struct addr_entry *);
struct addr_entry *addexpr(struct addr_entry *, int, struct addr_entry *);
struct addr_entry *displacement(struct addr_entry *, int, int);
struct addr_entry *memref(int, struct addr_entry *);
void bb(struct sem_rec *);
void bc(struct sem_rec *, char);
void binst(struct sem_rec *);
void cvt(struct sem_rec *);
void fcmp(struct sem_rec *);
void jal(struct sem_rec *);
void jmp(struct sem_rec *);
void l(struct sem_rec *);
void li(struct sem_rec *);
void mfc(struct sem_rec *);
void mfu(struct sem_rec *, struct sem_rec *);
void mov(struct sem_rec *);
void mtc(struct sem_rec *);
void nop(void);
void retrn(void);
void neg(struct sem_rec *);
void not(struct sem_rec *);
void cmpset(struct sem_rec *);
void s(struct sem_rec *);
void samemem(struct sem_rec *);
void wtof(struct sem_rec *);

#endif
