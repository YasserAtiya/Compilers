
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

#ifndef ADDRDEF_H
#define ADDRDEF_H

/*
 * Define constants for address definitions
 */
#define EXPR (1 << 0)
#define RREGISTER (1 << 1)
#define FREGISTER (1 << 2)
#define DREGISTER (1 << 3)
#define ABSOLUTE (1 << 4)
#define DISP (1 << 5)
#define REGDFR (1 << 6)
#define IMMED (1 << 7)
#define LABEL (1 << 8)
#define GIDENT (1 << 9)
#define LIDENT (1 << 10)
#define ICONST (1 << 11)
#define FCONST (1 << 12)
#define TEMPADDR (1 << 13)
#define SPILLOC (1 << 14)
#ifdef MEASURE
#define MEMREF (1 << 15)
#endif

#define HREGISTER (1 << 16)
#define SREGISTER (1 << 17)
#define UREGISTER (1 << 18)



#define ITABSIZE 64

#define BYTE (1 << 0)          /* note these constants represent a pattern */
#define WORD (1 << 1)          /*    they don't represent # of bytes */
#define LONG (1 << 2)
#define FLOAT (1 << 3)
#define DOUBLE (1 << 4)
#define ANY (BYTE | WORD | LONG)
#define FPANY (FLOAT | DOUBLE)

#define BYTETYPE(p) ((p)->type & BYTE)
#define WORDTYPE(p) ((p)->type & WORD)
#define LONGTYPE(p) ((p)->type & LONG)
#define LWTYPE(p) ((p)->type & (LONG | WORD))
#define BWTYPE(p) ((p)->type & (BYTE | WORD))
#define FLOATTYPE(p) ((p)->type & FLOAT)
#define DOUBLETYPE(p) ((p)->type & DOUBLE)
#define REALTYPE(p) ((p)->type & (FLOAT | DOUBLE))

#define REGMODE(p) ((p)->mode & \
                   (RREGISTER | FREGISTER | DREGISTER | HREGISTER))
#define FREGMODE(p) ((p)->mode & FREGISTER)
#define DREGMODE(p) ((p)->mode & DREGISTER)
#define HREGMODE(p) ((p)->mode & HREGISTER)
#define EXPRMODE(p) ((p)->mode == EXPR)
#define CONMODE(p) ((p)->mode == ICONST)
#define ACONMODE(p) ((p)->mode & (ICONST | FCONST | GIDENT | LIDENT))
#define IMMEDMODE(p) ((p)->mode == IMMED)
#define ABSMODE(p) ((p)->mode == ABSOLUTE)

#define COMPATIBLE(p1, p2) ((p1)->type & (p2)->type)
#define TYPECHAR(p) (((p)->type == LONG) ? 'w' : \
                     ((p)->type == BYTE) ? 'b' : \
                     ((p)->type == WORD) ? 'h' : \
                     ((p)->type == FLOAT) ? 's' : \
                     ((p)->type == DOUBLE) ? 'd' : 'w')

#define AE (struct addr_entry *)
#define AN (struct addr_entry *) NULL
#define SN (struct sem_rec *) NULL

struct addr_entry {
   int type;
   int mode;
   int cost;
   union {
      struct addr_entry *ptr;
      char *str;
   } arg1;
   union {
      struct addr_entry *ptr;
      char *str;
   } arg2;
   union {
      struct addr_entry *ptr;
      char *str;
   } arg3;
};

#endif /* ADDRDEF_H */
