

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

#ifndef RECDEF_H
#define RECDEF_H

#include "addrdef.h"

#define SEMTABLESIZE 64
#define MAXFIELDS 4

struct sem_rec {
    union {
      struct addr_entry *fields[MAXFIELDS];
      struct { struct addr_entry *left, *right, *lbl; char *rel; }  bb;
      struct { struct addr_entry *lbl; }                            bc;
      struct { struct addr_entry *left, *right, *dst; int op; }     binst;
      struct { struct addr_entry *dst, *left, *right; char *rel; }  cmpset;
      struct { struct addr_entry *dst, *src; }                      cvt;
      struct { struct addr_entry *left, *right; }                   divide;
      struct { struct addr_entry *left, *right; }                   divideu;

      struct { struct addr_entry *left, *right, *nul; char *rel; }  fcmp;
      struct { struct addr_entry *target, *dstreg; }                  jal;
      struct { struct addr_entry *target; }                         jmp;
      struct { struct addr_entry *dst, *mem, *unsign; }             l;
      struct { struct addr_entry *dst, *src; }                      li;
      struct { struct addr_entry *dst, *src; }                      mfc;

      struct { struct addr_entry *dst; }                                        mfhi;
      struct { struct addr_entry *dst; }                                        mflo;



      struct { struct addr_entry *dst, *src; }                      mov;

      struct { struct addr_entry *dst, *src; }                      mtc;
      struct { struct addr_entry *dst, *src; }                      neg;
      struct { struct addr_entry *dst, *src; }                      not;
      struct { struct addr_entry *mem, *src; }                      s;
      struct { struct addr_entry *dst, *src; }                      trunc;
      struct { struct addr_entry *dst, *src; }                      wtof;
      struct { struct addr_entry *dst, *src; }                      mtof; 
      struct { struct addr_entry *dst, *src; }                      mtoi; 
      struct { struct addr_entry *left, *right; }                   high;
      struct { struct addr_entry *dst, *src, *var; }                   low;
      struct { struct addr_entry *dst; }                            brk;
      struct { struct addr_entry *left, *right; }                   multi;
      struct { struct addr_entry *left, *right, *var; }                   multu;
      struct { struct addr_entry *dst, *src; }                   mfireg;
      struct { struct addr_entry *dst, *hi, *lo; }                  cvtil;

    } sem;
};

#endif
