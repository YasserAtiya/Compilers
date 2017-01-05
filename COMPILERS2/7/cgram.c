
# line 2 "/home/faculty/whalley/asg5/cgram.y"
# include <stdio.h>
# include "cc.h"
# include "scan.h"
# include "semutil.h"
# include "sem.h"
# include "sym.h"

# line 10 "/home/faculty/whalley/asg5/cgram.y"
typedef union
#ifdef __cplusplus
	YYSTYPE
#endif
 {
   int inttype;
   char *str_ptr;
   struct sem_rec *rec_ptr;
   struct id_entry *id_ptr;
   } YYSTYPE;
# define ID 257
# define CON 258
# define STR 259
# define CHAR 260
# define ELSE 261
# define DOUBLE 262
# define FOR 263
# define IF 264
# define INT 265
# define RESERVED 266
# define RETURN 267
# define WHILE 268
# define DO 269
# define CONTINUE 270
# define BREAK 271
# define GOTO 272
# define LVAL 273
# define SET 274
# define SETOR 275
# define SETXOR 276
# define SETAND 277
# define SETLSH 278
# define SETRSH 279
# define SETADD 280
# define SETSUB 281
# define SETMUL 282
# define SETDIV 283
# define SETMOD 284
# define OR 285
# define AND 286
# define BITOR 287
# define BITXOR 288
# define BITAND 289
# define EQ 290
# define NE 291
# define GT 292
# define GE 293
# define LT 294
# define LE 295
# define LSH 296
# define RSH 297
# define ADD 298
# define SUB 299
# define MUL 300
# define DIV 301
# define MOD 302
# define UNARY 303
# define NOT 304
# define COM 305

#include <inttypes.h>

#ifdef __STDC__
#include <stdlib.h>
#include <string.h>
#define	YYCONST	const
#else
#include <malloc.h>
#include <memory.h>
#define	YYCONST
#endif

#include <values.h>

#if defined(__cplusplus) || defined(__STDC__)

#if defined(__cplusplus) && defined(__EXTERN_C__)
extern "C" {
#endif
#ifndef yyerror
#if defined(__cplusplus)
	void yyerror(YYCONST char *);
#endif
#endif
#ifndef yylex
	int yylex(void);
#endif
	int yyparse(void);
#if defined(__cplusplus) && defined(__EXTERN_C__)
}
#endif

#endif

#define yyclearin yychar = -1
#define yyerrok yyerrflag = 0
extern int yychar;
extern int yyerrflag;
YYSTYPE yylval;
YYSTYPE yyval;
typedef int yytabelem;
#ifndef YYMAXDEPTH
#define YYMAXDEPTH 150
#endif
#if YYMAXDEPTH > 0
int yy_yys[YYMAXDEPTH], *yys = yy_yys;
YYSTYPE yy_yyv[YYMAXDEPTH], *yyv = yy_yyv;
#else	/* user does initial allocation */
int *yys;
YYSTYPE *yyv;
#endif
static int yymaxdepth = YYMAXDEPTH;
# define YYERRCODE 256

# line 195 "/home/faculty/whalley/asg5/cgram.y"

# include <stdio.h>

extern int lineno;

/* 
 * main - read a program, and parse it
 */
main(int argc, char *argv)
{

   enterblock();
   initlex();
   enterblock();
   if (yyparse())
      yyerror("syntax error");
   exit(0);
}

/*
 * yyerror - issue error message
 */
yyerror(char msg[])
{
   fprintf(stderr, " %s.  Line %d\n", msg, lineno);
}
static YYCONST yytabelem yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
-1, 16,
	40, 18,
	-2, 10,
	};
# define YYNPROD 95
# define YYLAST 618
static YYCONST yytabelem yyact[]={

    51,    63,    64,    65,   148,   149,   153,   151,   152,   150,
    66,    67,    69,    70,    71,    72,    68,   190,   146,    45,
    63,    64,    65,    51,    69,    70,    71,    72,    68,    66,
    67,    69,    70,    71,    72,    68,    71,    72,    68,   170,
   171,   181,    45,    64,    65,   147,   146,    29,    21,    51,
    98,    66,    67,    69,    70,    71,    72,    68,    65,   145,
    79,    16,    51,   142,   185,    66,    67,    69,    70,    71,
    72,    68,    66,    67,    69,    70,    71,    72,    68,    12,
   121,    45,     8,    54,     9,   122,    26,    10,    23,    25,
    84,    85,   141,    86,    87,    88,    89,    90,    91,    92,
    93,    94,    95,    96,    15,     8,    54,     9,   106,    59,
    10,    51,   126,    84,    84,    22,   193,     6,   184,    20,
    14,    14,   157,   124,    51,    78,   125,    77,   160,     4,
    47,    83,    17,    58,   195,   143,    13,    28,    34,   159,
   178,    85,   158,    80,    56,    54,    76,    57,    74,    73,
    19,     3,     2,    27,    11,     7,    62,     1,    55,    18,
    51,   179,     5,    44,    85,    85,    32,   127,     0,     0,
     0,     0,     0,   104,     0,   105,     0,     0,     0,    97,
     0,     0,     0,     0,     0,   103,     0,   102,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
   144,     0,    30,     0,     0,     0,     0,    82,    52,    53,
     0,     0,     0,    39,    36,     0,     0,    43,    37,    38,
    40,    41,    42,     0,     0,     0,     0,     0,   117,     0,
    61,    52,    53,     0,     0,     0,    39,    36,     0,    48,
    43,    37,    38,    40,    41,    42,   194,     0,   182,    49,
     0,   147,   146,     0,     0,    50,    82,    52,    53,     0,
     0,     0,    48,     0,   191,     0,     0,   197,     0,    46,
    52,    53,    49,   147,   146,    39,    36,     0,    50,    43,
    37,    38,    40,    41,    42,     0,     0,     0,    48,     0,
     0,     0,     0,   147,   146,     8,     0,     9,    49,     0,
    10,    48,     0,   119,    50,     0,     0,     0,     0,     0,
     0,    49,    63,    64,    65,     0,     0,    50,    82,    52,
    53,    66,    67,    69,    70,    71,    72,    68,    63,    64,
    65,    82,    52,    53,     0,     0,    33,    66,    67,    69,
    70,    71,    72,    68,    63,    64,    65,     0,   154,   155,
    48,     0,    35,    66,    67,    69,    70,    71,    72,    68,
    49,     0,     0,    48,     0,     0,    50,    82,    52,    53,
     0,    60,     0,    49,    63,    64,    65,     0,     0,    50,
     0,     0,     0,    66,    67,    69,    70,    71,    72,    68,
     0,   175,   176,     0,     0,     0,    81,     0,     0,    48,
     0,   180,    99,   100,   101,     0,     0,     0,     0,    49,
     0,    24,   187,     0,     0,    50,   107,   108,   109,   110,
   111,   112,   113,   114,   115,   116,   118,     0,     0,   123,
     0,     0,     0,     0,     0,    31,     0,   128,   129,   130,
   131,   132,   133,   134,   135,   136,   137,   138,   139,   140,
    75,     0,     0,     0,     0,     0,     0,     0,   156,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,   118,   118,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,   120,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,   174,     0,
     0,   164,   165,   166,   167,   168,   169,     0,     0,     0,
     0,   173,     0,     0,     0,   118,   118,     0,     0,   186,
     0,     0,     0,     0,     0,   118,   192,     0,     0,     0,
     0,     0,     0,     0,   198,     0,   118,     0,     0,     0,
     0,   123,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,   161,   162,   163,
     0,     0,     0,     0,     0,     0,     0,     0,     0,   172,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,   177,     0,     0,     0,     0,     0,     0,     0,
   183,     0,     0,     0,     0,     0,   188,   189,     0,     0,
     0,     0,     0,     0,     0,     0,     0,   196 };
static YYCONST yytabelem yypact[]={

-10000000,-10000000,  -178,-10000000,    77,-10000000,  -196,-10000000,-10000000,-10000000,
-10000000,   110,-10000000,-10000000,  -209,-10000000,    24,   -37,   -34,    45,
-10000000,    24,   -46,-10000000,    22,-10000000,-10000000,   103,  -209,-10000000,
    16,-10000000,-10000000,-10000000,   -17,    97,   109,   108,-10000000,   106,
    68,    66,  -197,    84,-10000000,-10000000,    73,  -181,  -207,   120,
   120,   120,-10000000,-10000000,-10000000,  -155,-10000000,  -155,-10000000,-10000000,
-10000000,    50,-10000000,   120,   120,   120,   120,   120,   120,   120,
   120,   120,   120,     9,-10000000,-10000000,   120,-10000000,-10000000,    64,
-10000000,    67,    74,-10000000,    71,   120,   120,   120,   120,   120,
   120,   120,   120,   120,   120,   120,   120,-10000000,     0,-10000000,
-10000000,    51,   -62,    76,  -209,  -209,-10000000,  -245,  -231,  -224,
  -274,  -274,-10000000,  -264,  -264,-10000000,-10000000,    18,  -286,     9,
     9,   -40,    63,  -267,-10000000,-10000000,-10000000,    98,  -267,    35,
  -267,  -267,  -267,  -267,  -267,  -267,  -267,  -267,  -267,  -267,
  -267,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,   120,   120,
   120,   120,   120,   120,-10000000,    -2,  -228,-10000000,   120,-10000000,
-10000000,   -40,     9,     9,  -267,  -267,  -267,  -267,  -267,  -267,
-10000000,   100,     9,  -267,  -220,-10000000,  -268,-10000000,-10000000,    59,
  -240,-10000000,   -40,     9,-10000000,-10000000,-10000000,   -24,   120,   -40,
    57,-10000000,-10000000,-10000000,    93,-10000000,-10000000,   -40,-10000000 };
static YYCONST yytabelem yypgo[]={

     0,   130,   362,   167,   238,   166,   346,   132,   163,    64,
   162,    80,   161,    85,   159,   158,   157,   129,   104,   155,
   154,   153,   117,   421,   152,   151,   138 };
static YYCONST yytabelem yyr1[]={

     0,    16,    24,    24,    25,    25,    15,    15,    17,    17,
    18,    18,    18,    22,    22,    22,    10,    19,    20,    20,
    14,    14,    21,    21,    11,    23,     9,     8,     7,     7,
     5,     5,    26,    26,     6,     6,     6,     6,     6,     6,
     6,     6,     6,     6,     6,     6,     6,    12,    12,     4,
     4,     4,     4,     4,     4,     4,     4,     4,     4,     3,
     3,    13,    13,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     1,     1 };
static YYCONST yytabelem yyr2[]={

     0,     3,     1,     5,     5,     3,     1,     7,     5,     7,
     3,     7,     9,     3,     3,     3,     9,     9,     5,     3,
     5,     7,     5,     9,     1,     1,     1,     7,     1,     7,
     3,     5,     5,     7,     5,    13,    21,    17,    21,    29,
     5,     5,     7,     5,     7,     3,     3,     1,     3,     7,
     7,     7,     7,     7,     7,     9,     9,     5,     3,     3,
     7,     1,     3,     7,     7,     7,     7,     7,     7,     7,
     7,     7,     7,     7,     7,     7,     7,     7,     7,     7,
     7,     7,     7,     7,     5,     5,     5,     3,     7,     9,
     7,     3,     3,     3,     9 };
static YYCONST yytabelem yychk[]={

-10000000,   -16,   -24,   -25,   -17,   -10,   -22,   -19,   260,   262,
   265,   -20,   257,    59,    44,   -18,   257,    -7,   -14,    40,
   -18,   257,    91,   125,   -23,   123,    41,   -21,   -22,    93,
   258,   -23,    -5,    -6,   -26,    -2,   264,   268,   269,   263,
   270,   271,   272,   267,    -8,    59,   257,    -1,   289,   299,
   305,    40,   258,   259,   123,   -15,    41,    44,   -18,    93,
    -6,   257,    59,   287,   288,   289,   296,   297,   302,   298,
   299,   300,   301,    40,    40,   -23,    40,    59,    59,   257,
    59,    -2,   257,    58,    40,    91,   274,   275,   276,   277,
   278,   279,   280,   281,   282,   283,   284,    -1,   257,    -2,
    -2,    -2,    -7,   -17,   -22,   -22,    58,    -2,    -2,    -2,
    -2,    -2,    -2,    -2,    -2,    -2,    -2,    -4,    -2,   304,
   -23,   -11,   -13,    -2,    59,    59,    41,    -3,    -2,    -2,
    -2,    -2,    -2,    -2,    -2,    -2,    -2,    -2,    -2,    -2,
    -2,    41,   125,    59,   -18,    41,   286,   285,   290,   291,
   295,   293,   294,   292,    -4,    -4,    -6,    59,    44,    41,
    93,   -23,   -23,   -23,    -2,    -2,    -2,    -2,    -2,    -2,
    41,   268,   -23,    -2,    -6,    -4,    -4,   -23,    40,   -12,
    -4,   261,   -11,   -23,    59,    -9,    -6,    -4,   -23,   -23,
    41,   -13,    -6,    59,    -9,    41,   -23,   -11,    -6 };
static YYCONST yytabelem yydef[]={

     2,    -2,     1,     3,     0,     5,     0,    28,    13,    14,
    15,     0,    19,     4,     0,     8,    -2,    25,     0,     0,
     9,    10,     0,    25,     0,     6,    20,     0,     0,    11,
     0,    16,    29,    30,     0,     0,     0,     0,    25,     0,
     0,     0,     0,     0,    45,    46,    93,    87,     0,     0,
     0,     0,    91,    92,    28,    17,    21,     0,    22,    12,
    31,    93,    34,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,    25,    24,    61,    40,    41,     0,
    43,     0,    93,    32,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,    84,    93,    85,
    86,     0,    25,     0,     0,     0,    33,    74,    75,    76,
    77,    78,    79,    80,    81,    82,    83,     0,    58,     0,
     0,     0,     0,    62,    42,    44,    88,     0,    59,     0,
    63,    64,    65,    66,    67,    68,    69,    70,    71,    72,
    73,    90,    27,     7,    23,    25,    25,    25,     0,     0,
     0,     0,     0,     0,    57,     0,     0,    25,     0,    89,
    94,     0,     0,     0,    49,    50,    51,    52,    53,    54,
    25,     0,    47,    60,    35,    55,    56,    24,    25,     0,
    48,    26,     0,     0,    25,    25,    37,     0,    61,     0,
     0,    26,    36,    38,     0,    25,    24,     0,    39 };
typedef struct
#ifdef __cplusplus
	yytoktype
#endif
{
#ifdef __cplusplus
const
#endif
char *t_name; int t_val; } yytoktype;
#ifndef YYDEBUG
#	define YYDEBUG	0	/* don't allow debugging */
#endif

#if YYDEBUG

yytoktype yytoks[] =
{
	"ID",	257,
	"CON",	258,
	"STR",	259,
	"CHAR",	260,
	"ELSE",	261,
	"DOUBLE",	262,
	"FOR",	263,
	"IF",	264,
	"INT",	265,
	"RESERVED",	266,
	"RETURN",	267,
	"WHILE",	268,
	"DO",	269,
	"CONTINUE",	270,
	"BREAK",	271,
	"GOTO",	272,
	"LVAL",	273,
	"SET",	274,
	"SETOR",	275,
	"SETXOR",	276,
	"SETAND",	277,
	"SETLSH",	278,
	"SETRSH",	279,
	"SETADD",	280,
	"SETSUB",	281,
	"SETMUL",	282,
	"SETDIV",	283,
	"SETMOD",	284,
	"OR",	285,
	"AND",	286,
	"BITOR",	287,
	"BITXOR",	288,
	"BITAND",	289,
	"EQ",	290,
	"NE",	291,
	"GT",	292,
	"GE",	293,
	"LT",	294,
	"LE",	295,
	"LSH",	296,
	"RSH",	297,
	"ADD",	298,
	"SUB",	299,
	"MUL",	300,
	"DIV",	301,
	"MOD",	302,
	"UNARY",	303,
	"NOT",	304,
	"COM",	305,
	"-unknown-",	-1	/* ends search */
};

#ifdef __cplusplus
const
#endif
char * yyreds[] =
{
	"-no such reduction-",
	"prog : externs",
	"externs : /* empty */",
	"externs : externs extern",
	"extern : dcl ';'",
	"extern : func",
	"dcls : /* empty */",
	"dcls : dcls dcl ';'",
	"dcl : type dclr",
	"dcl : dcl ',' dclr",
	"dclr : ID",
	"dclr : ID '[' ']'",
	"dclr : ID '[' CON ']'",
	"type : CHAR",
	"type : DOUBLE",
	"type : INT",
	"func : fhead stmts '}' m",
	"fhead : fname fargs '{' dcls",
	"fname : type ID",
	"fname : ID",
	"fargs : '(' ')'",
	"fargs : '(' args ')'",
	"args : type dclr",
	"args : args ',' type dclr",
	"s : /* empty */",
	"m : /* empty */",
	"n : /* empty */",
	"block : '{' stmts '}'",
	"stmts : /* empty */",
	"stmts : stmts m lblstmt",
	"lblstmt : stmt",
	"lblstmt : labels stmt",
	"labels : ID ':'",
	"labels : labels ID ':'",
	"stmt : expr ';'",
	"stmt : IF '(' cexpr ')' m stmt",
	"stmt : IF '(' cexpr ')' m stmt ELSE n m stmt",
	"stmt : WHILE '(' m cexpr ')' m s stmt",
	"stmt : DO m s stmt WHILE '(' m cexpr ')' ';'",
	"stmt : FOR '(' expro ';' m cexpro ';' m expro n ')' m s stmt",
	"stmt : CONTINUE ';'",
	"stmt : BREAK ';'",
	"stmt : GOTO ID ';'",
	"stmt : RETURN ';'",
	"stmt : RETURN expr ';'",
	"stmt : block",
	"stmt : ';'",
	"cexpro : /* empty */",
	"cexpro : cexpr",
	"cexpr : expr EQ expr",
	"cexpr : expr NE expr",
	"cexpr : expr LE expr",
	"cexpr : expr GE expr",
	"cexpr : expr LT expr",
	"cexpr : expr GT expr",
	"cexpr : cexpr AND m cexpr",
	"cexpr : cexpr OR m cexpr",
	"cexpr : NOT cexpr",
	"cexpr : expr",
	"exprs : expr",
	"exprs : exprs ',' expr",
	"expro : /* empty */",
	"expro : expr",
	"expr : lval SET expr",
	"expr : lval SETOR expr",
	"expr : lval SETXOR expr",
	"expr : lval SETAND expr",
	"expr : lval SETLSH expr",
	"expr : lval SETRSH expr",
	"expr : lval SETADD expr",
	"expr : lval SETSUB expr",
	"expr : lval SETMUL expr",
	"expr : lval SETDIV expr",
	"expr : lval SETMOD expr",
	"expr : expr BITOR expr",
	"expr : expr BITXOR expr",
	"expr : expr BITAND expr",
	"expr : expr LSH expr",
	"expr : expr RSH expr",
	"expr : expr MOD expr",
	"expr : expr ADD expr",
	"expr : expr SUB expr",
	"expr : expr MUL expr",
	"expr : expr DIV expr",
	"expr : BITAND lval",
	"expr : SUB expr",
	"expr : COM expr",
	"expr : lval",
	"expr : ID '(' ')'",
	"expr : ID '(' exprs ')'",
	"expr : '(' expr ')'",
	"expr : CON",
	"expr : STR",
	"lval : ID",
	"lval : ID '[' expr ']'",
};
#endif /* YYDEBUG */
# line	1 "/usr/ccs/bin/yaccpar"
/*
 * Copyright (c) 1993 by Sun Microsystems, Inc.
 */

#pragma ident	"@(#)yaccpar	6.16	99/01/20 SMI"

/*
** Skeleton parser driver for yacc output
*/

/*
** yacc user known macros and defines
*/
#define YYERROR		goto yyerrlab
#define YYACCEPT	return(0)
#define YYABORT		return(1)
#define YYBACKUP( newtoken, newvalue )\
{\
	if ( yychar >= 0 || ( yyr2[ yytmp ] >> 1 ) != 1 )\
	{\
		yyerror( "syntax error - cannot backup" );\
		goto yyerrlab;\
	}\
	yychar = newtoken;\
	yystate = *yyps;\
	yylval = newvalue;\
	goto yynewstate;\
}
#define YYRECOVERING()	(!!yyerrflag)
#define YYNEW(type)	malloc(sizeof(type) * yynewmax)
#define YYCOPY(to, from, type) \
	(type *) memcpy(to, (char *) from, yymaxdepth * sizeof (type))
#define YYENLARGE( from, type) \
	(type *) realloc((char *) from, yynewmax * sizeof(type))
#ifndef YYDEBUG
#	define YYDEBUG	1	/* make debugging available */
#endif

/*
** user known globals
*/
int yydebug;			/* set to 1 to get debugging */

/*
** driver internal defines
*/
#define YYFLAG		(-10000000)

/*
** global variables used by the parser
*/
YYSTYPE *yypv;			/* top of value stack */
int *yyps;			/* top of state stack */

int yystate;			/* current state */
int yytmp;			/* extra var (lasts between blocks) */

int yynerrs;			/* number of errors */
int yyerrflag;			/* error recovery flag */
int yychar;			/* current input token number */



#ifdef YYNMBCHARS
#define YYLEX()		yycvtok(yylex())
/*
** yycvtok - return a token if i is a wchar_t value that exceeds 255.
**	If i<255, i itself is the token.  If i>255 but the neither 
**	of the 30th or 31st bit is on, i is already a token.
*/
#if defined(__STDC__) || defined(__cplusplus)
int yycvtok(int i)
#else
int yycvtok(i) int i;
#endif
{
	int first = 0;
	int last = YYNMBCHARS - 1;
	int mid;
	wchar_t j;

	if(i&0x60000000){/*Must convert to a token. */
		if( yymbchars[last].character < i ){
			return i;/*Giving up*/
		}
		while ((last>=first)&&(first>=0)) {/*Binary search loop*/
			mid = (first+last)/2;
			j = yymbchars[mid].character;
			if( j==i ){/*Found*/ 
				return yymbchars[mid].tvalue;
			}else if( j<i ){
				first = mid + 1;
			}else{
				last = mid -1;
			}
		}
		/*No entry in the table.*/
		return i;/* Giving up.*/
	}else{/* i is already a token. */
		return i;
	}
}
#else/*!YYNMBCHARS*/
#define YYLEX()		yylex()
#endif/*!YYNMBCHARS*/

/*
** yyparse - return 0 if worked, 1 if syntax error not recovered from
*/
#if defined(__STDC__) || defined(__cplusplus)
int yyparse(void)
#else
int yyparse()
#endif
{
	register YYSTYPE *yypvt = 0;	/* top of value stack for $vars */

#if defined(__cplusplus) || defined(lint)
/*
	hacks to please C++ and lint - goto's inside
	switch should never be executed
*/
	static int __yaccpar_lint_hack__ = 0;
	switch (__yaccpar_lint_hack__)
	{
		case 1: goto yyerrlab;
		case 2: goto yynewstate;
	}
#endif

	/*
	** Initialize externals - yyparse may be called more than once
	*/
	yypv = &yyv[-1];
	yyps = &yys[-1];
	yystate = 0;
	yytmp = 0;
	yynerrs = 0;
	yyerrflag = 0;
	yychar = -1;

#if YYMAXDEPTH <= 0
	if (yymaxdepth <= 0)
	{
		if ((yymaxdepth = YYEXPAND(0)) <= 0)
		{
			yyerror("yacc initialization error");
			YYABORT;
		}
	}
#endif

	{
		register YYSTYPE *yy_pv;	/* top of value stack */
		register int *yy_ps;		/* top of state stack */
		register int yy_state;		/* current state */
		register int  yy_n;		/* internal state number info */
	goto yystack;	/* moved from 6 lines above to here to please C++ */

		/*
		** get globals into registers.
		** branch to here only if YYBACKUP was called.
		*/
	yynewstate:
		yy_pv = yypv;
		yy_ps = yyps;
		yy_state = yystate;
		goto yy_newstate;

		/*
		** get globals into registers.
		** either we just started, or we just finished a reduction
		*/
	yystack:
		yy_pv = yypv;
		yy_ps = yyps;
		yy_state = yystate;

		/*
		** top of for (;;) loop while no reductions done
		*/
	yy_stack:
		/*
		** put a state and value onto the stacks
		*/
#if YYDEBUG
		/*
		** if debugging, look up token value in list of value vs.
		** name pairs.  0 and negative (-1) are special values.
		** Note: linear search is used since time is not a real
		** consideration while debugging.
		*/
		if ( yydebug )
		{
			register int yy_i;

			printf( "State %d, token ", yy_state );
			if ( yychar == 0 )
				printf( "end-of-file\n" );
			else if ( yychar < 0 )
				printf( "-none-\n" );
			else
			{
				for ( yy_i = 0; yytoks[yy_i].t_val >= 0;
					yy_i++ )
				{
					if ( yytoks[yy_i].t_val == yychar )
						break;
				}
				printf( "%s\n", yytoks[yy_i].t_name );
			}
		}
#endif /* YYDEBUG */
		if ( ++yy_ps >= &yys[ yymaxdepth ] )	/* room on stack? */
		{
			/*
			** reallocate and recover.  Note that pointers
			** have to be reset, or bad things will happen
			*/
			long yyps_index = (yy_ps - yys);
			long yypv_index = (yy_pv - yyv);
			long yypvt_index = (yypvt - yyv);
			int yynewmax;
#ifdef YYEXPAND
			yynewmax = YYEXPAND(yymaxdepth);
#else
			yynewmax = 2 * yymaxdepth;	/* double table size */
			if (yymaxdepth == YYMAXDEPTH)	/* first time growth */
			{
				char *newyys = (char *)YYNEW(int);
				char *newyyv = (char *)YYNEW(YYSTYPE);
				if (newyys != 0 && newyyv != 0)
				{
					yys = YYCOPY(newyys, yys, int);
					yyv = YYCOPY(newyyv, yyv, YYSTYPE);
				}
				else
					yynewmax = 0;	/* failed */
			}
			else				/* not first time */
			{
				yys = YYENLARGE(yys, int);
				yyv = YYENLARGE(yyv, YYSTYPE);
				if (yys == 0 || yyv == 0)
					yynewmax = 0;	/* failed */
			}
#endif
			if (yynewmax <= yymaxdepth)	/* tables not expanded */
			{
				yyerror( "yacc stack overflow" );
				YYABORT;
			}
			yymaxdepth = yynewmax;

			yy_ps = yys + yyps_index;
			yy_pv = yyv + yypv_index;
			yypvt = yyv + yypvt_index;
		}
		*yy_ps = yy_state;
		*++yy_pv = yyval;

		/*
		** we have a new state - find out what to do
		*/
	yy_newstate:
		if ( ( yy_n = yypact[ yy_state ] ) <= YYFLAG )
			goto yydefault;		/* simple state */
#if YYDEBUG
		/*
		** if debugging, need to mark whether new token grabbed
		*/
		yytmp = yychar < 0;
#endif
		if ( ( yychar < 0 ) && ( ( yychar = YYLEX() ) < 0 ) )
			yychar = 0;		/* reached EOF */
#if YYDEBUG
		if ( yydebug && yytmp )
		{
			register int yy_i;

			printf( "Received token " );
			if ( yychar == 0 )
				printf( "end-of-file\n" );
			else if ( yychar < 0 )
				printf( "-none-\n" );
			else
			{
				for ( yy_i = 0; yytoks[yy_i].t_val >= 0;
					yy_i++ )
				{
					if ( yytoks[yy_i].t_val == yychar )
						break;
				}
				printf( "%s\n", yytoks[yy_i].t_name );
			}
		}
#endif /* YYDEBUG */
		if ( ( ( yy_n += yychar ) < 0 ) || ( yy_n >= YYLAST ) )
			goto yydefault;
		if ( yychk[ yy_n = yyact[ yy_n ] ] == yychar )	/*valid shift*/
		{
			yychar = -1;
			yyval = yylval;
			yy_state = yy_n;
			if ( yyerrflag > 0 )
				yyerrflag--;
			goto yy_stack;
		}

	yydefault:
		if ( ( yy_n = yydef[ yy_state ] ) == -2 )
		{
#if YYDEBUG
			yytmp = yychar < 0;
#endif
			if ( ( yychar < 0 ) && ( ( yychar = YYLEX() ) < 0 ) )
				yychar = 0;		/* reached EOF */
#if YYDEBUG
			if ( yydebug && yytmp )
			{
				register int yy_i;

				printf( "Received token " );
				if ( yychar == 0 )
					printf( "end-of-file\n" );
				else if ( yychar < 0 )
					printf( "-none-\n" );
				else
				{
					for ( yy_i = 0;
						yytoks[yy_i].t_val >= 0;
						yy_i++ )
					{
						if ( yytoks[yy_i].t_val
							== yychar )
						{
							break;
						}
					}
					printf( "%s\n", yytoks[yy_i].t_name );
				}
			}
#endif /* YYDEBUG */
			/*
			** look through exception table
			*/
			{
				register YYCONST int *yyxi = yyexca;

				while ( ( *yyxi != -1 ) ||
					( yyxi[1] != yy_state ) )
				{
					yyxi += 2;
				}
				while ( ( *(yyxi += 2) >= 0 ) &&
					( *yyxi != yychar ) )
					;
				if ( ( yy_n = yyxi[1] ) < 0 )
					YYACCEPT;
			}
		}

		/*
		** check for syntax error
		*/
		if ( yy_n == 0 )	/* have an error */
		{
			/* no worry about speed here! */
			switch ( yyerrflag )
			{
			case 0:		/* new error */
				yyerror( "syntax error" );
				goto skip_init;
			yyerrlab:
				/*
				** get globals into registers.
				** we have a user generated syntax type error
				*/
				yy_pv = yypv;
				yy_ps = yyps;
				yy_state = yystate;
			skip_init:
				yynerrs++;
				/* FALLTHRU */
			case 1:
			case 2:		/* incompletely recovered error */
					/* try again... */
				yyerrflag = 3;
				/*
				** find state where "error" is a legal
				** shift action
				*/
				while ( yy_ps >= yys )
				{
					yy_n = yypact[ *yy_ps ] + YYERRCODE;
					if ( yy_n >= 0 && yy_n < YYLAST &&
						yychk[yyact[yy_n]] == YYERRCODE)					{
						/*
						** simulate shift of "error"
						*/
						yy_state = yyact[ yy_n ];
						goto yy_stack;
					}
					/*
					** current state has no shift on
					** "error", pop stack
					*/
#if YYDEBUG
#	define _POP_ "Error recovery pops state %d, uncovers state %d\n"
					if ( yydebug )
						printf( _POP_, *yy_ps,
							yy_ps[-1] );
#	undef _POP_
#endif
					yy_ps--;
					yy_pv--;
				}
				/*
				** there is no state on stack with "error" as
				** a valid shift.  give up.
				*/
				YYABORT;
			case 3:		/* no shift yet; eat a token */
#if YYDEBUG
				/*
				** if debugging, look up token in list of
				** pairs.  0 and negative shouldn't occur,
				** but since timing doesn't matter when
				** debugging, it doesn't hurt to leave the
				** tests here.
				*/
				if ( yydebug )
				{
					register int yy_i;

					printf( "Error recovery discards " );
					if ( yychar == 0 )
						printf( "token end-of-file\n" );
					else if ( yychar < 0 )
						printf( "token -none-\n" );
					else
					{
						for ( yy_i = 0;
							yytoks[yy_i].t_val >= 0;
							yy_i++ )
						{
							if ( yytoks[yy_i].t_val
								== yychar )
							{
								break;
							}
						}
						printf( "token %s\n",
							yytoks[yy_i].t_name );
					}
				}
#endif /* YYDEBUG */
				if ( yychar == 0 )	/* reached EOF. quit */
					YYABORT;
				yychar = -1;
				goto yy_newstate;
			}
		}/* end if ( yy_n == 0 ) */
		/*
		** reduction by production yy_n
		** put stack tops, etc. so things right after switch
		*/
#if YYDEBUG
		/*
		** if debugging, print the string that is the user's
		** specification of the reduction which is just about
		** to be done.
		*/
		if ( yydebug )
			printf( "Reduce by (%d) \"%s\"\n",
				yy_n, yyreds[ yy_n ] );
#endif
		yytmp = yy_n;			/* value to switch over */
		yypvt = yy_pv;			/* $vars top of value stack */
		/*
		** Look in goto table for next state
		** Sorry about using yy_state here as temporary
		** register variable, but why not, if it works...
		** If yyr2[ yy_n ] doesn't have the low order bit
		** set, then there is no action to be done for
		** this reduction.  So, no saving & unsaving of
		** registers done.  The only difference between the
		** code just after the if and the body of the if is
		** the goto yy_stack in the body.  This way the test
		** can be made before the choice of what to do is needed.
		*/
		{
			/* length of production doubled with extra bit */
			register int yy_len = yyr2[ yy_n ];

			if ( !( yy_len & 01 ) )
			{
				yy_len >>= 1;
				yyval = ( yy_pv -= yy_len )[1];	/* $$ = $1 */
				yy_state = yypgo[ yy_n = yyr1[ yy_n ] ] +
					*( yy_ps -= yy_len ) + 1;
				if ( yy_state >= YYLAST ||
					yychk[ yy_state =
					yyact[ yy_state ] ] != -yy_n )
				{
					yy_state = yyact[ yypgo[ yy_n ] ];
				}
				goto yy_stack;
			}
			yy_len >>= 1;
			yyval = ( yy_pv -= yy_len )[1];	/* $$ = $1 */
			yy_state = yypgo[ yy_n = yyr1[ yy_n ] ] +
				*( yy_ps -= yy_len ) + 1;
			if ( yy_state >= YYLAST ||
				yychk[ yy_state = yyact[ yy_state ] ] != -yy_n )
			{
				yy_state = yyact[ yypgo[ yy_n ] ];
			}
		}
					/* save until reenter driver code */
		yystate = yy_state;
		yyps = yy_ps;
		yypv = yy_pv;
	}
	/*
	** code supplied by user is placed in this switch
	*/
	switch( yytmp )
	{
		
case 1:
# line 36 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 2:
# line 39 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 3:
# line 40 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 4:
# line 43 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 5:
# line 44 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 6:
# line 47 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 7:
# line 48 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 8:
# line 51 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dcl(yypvt[-0].id_ptr, yypvt[-1].inttype, 0); } break;
case 9:
# line 52 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dcl(yypvt[-0].id_ptr, yypvt[-2].id_ptr->i_type&~T_ARRAY, 0); } break;
case 10:
# line 55 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dclr(yypvt[-0].str_ptr, 0, 1); } break;
case 11:
# line 56 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dclr(yypvt[-2].str_ptr, T_ARRAY, 1); } break;
case 12:
# line 57 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dclr(yypvt[-3].str_ptr, T_ARRAY, atoi(yypvt[-1].str_ptr)); } break;
case 13:
# line 60 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.inttype = T_INT; } break;
case 14:
# line 61 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.inttype = T_DOUBLE; } break;
case 15:
# line 62 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.inttype = T_INT; } break;
case 16:
# line 65 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = ftail(yypvt[-3].id_ptr, yypvt[-2].rec_ptr, yypvt[-0].inttype); } break;
case 17:
# line 68 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = fhead(yypvt[-3].id_ptr); } break;
case 18:
# line 71 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = fname(yypvt[-1].inttype, yypvt[-0].str_ptr); } break;
case 19:
# line 72 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = fname(T_INT, yypvt[-0].str_ptr); } break;
case 20:
# line 75 "/home/faculty/whalley/asg5/cgram.y"
{ enterblock(); } break;
case 21:
# line 76 "/home/faculty/whalley/asg5/cgram.y"
{ enterblock(); } break;
case 22:
# line 79 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dcl(yypvt[-0].id_ptr, yypvt[-1].inttype, PARAM); } break;
case 23:
# line 80 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.id_ptr = dcl(yypvt[-0].id_ptr, yypvt[-1].inttype, PARAM); } break;
case 24:
# line 83 "/home/faculty/whalley/asg5/cgram.y"
{ startloopscope(); } break;
case 25:
# line 86 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.inttype = m(); } break;
case 26:
# line 89 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = n(); } break;
case 27:
# line 92 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-1].rec_ptr; } break;
case 28:
# line 95 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = 0; } break;
case 29:
# line 96 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dostmts(yypvt[-2].rec_ptr, yypvt[-1].inttype, yypvt[-0].rec_ptr); } break;
case 30:
# line 99 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-0].rec_ptr; } break;
case 31:
# line 100 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-0].rec_ptr; } break;
case 32:
# line 103 "/home/faculty/whalley/asg5/cgram.y"
{ labeldcl(yypvt[-1].str_ptr); } break;
case 33:
# line 104 "/home/faculty/whalley/asg5/cgram.y"
{ labeldcl(yypvt[-1].str_ptr); } break;
case 34:
# line 108 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = 0; } break;
case 35:
# line 110 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = doif(yypvt[-3].rec_ptr, yypvt[-1].inttype, yypvt[-0].rec_ptr); } break;
case 36:
# line 112 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = doifelse(yypvt[-7].rec_ptr, yypvt[-5].inttype, yypvt[-4].rec_ptr, yypvt[-2].rec_ptr, yypvt[-1].inttype, yypvt[-0].rec_ptr); } break;
case 37:
# line 114 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dowhile(yypvt[-5].inttype, yypvt[-4].rec_ptr, yypvt[-2].inttype, yypvt[-0].rec_ptr); } break;
case 38:
# line 116 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dodo(yypvt[-8].inttype, yypvt[-6].rec_ptr, yypvt[-3].inttype, yypvt[-2].rec_ptr); } break;
case 39:
# line 118 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dofor(yypvt[-9].inttype, yypvt[-8].rec_ptr, yypvt[-6].inttype, yypvt[-4].rec_ptr, yypvt[-2].inttype, yypvt[-0].rec_ptr); } break;
case 40:
# line 120 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = docontinue(); } break;
case 41:
# line 122 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dobreak(); } break;
case 42:
# line 124 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = dogoto(yypvt[-1].str_ptr); } break;
case 43:
# line 126 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = doret((struct sem_rec *) NULL); } break;
case 44:
# line 128 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = doret(yypvt[-1].rec_ptr); } break;
case 45:
# line 130 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-0].rec_ptr; } break;
case 46:
# line 132 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = 0; } break;
case 47:
# line 135 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = node(0, 0, n(), 0); } break;
case 48:
# line 136 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 49:
# line 139 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel("==", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 50:
# line 140 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel("!=", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 51:
# line 141 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel("<=", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 52:
# line 142 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel(">=", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 53:
# line 143 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel("<",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 54:
# line 144 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = rel(">",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 55:
# line 145 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = ccand(yypvt[-3].rec_ptr, yypvt[-1].inttype, yypvt[-0].rec_ptr); } break;
case 56:
# line 146 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = ccor(yypvt[-3].rec_ptr, yypvt[-1].inttype, yypvt[-0].rec_ptr); } break;
case 57:
# line 147 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = ccnot(yypvt[-0].rec_ptr); } break;
case 58:
# line 148 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = ccexpr(yypvt[-0].rec_ptr); } break;
case 59:
# line 151 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-0].rec_ptr; } break;
case 60:
# line 152 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = exprs(yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 61:
# line 155 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 62:
# line 156 "/home/faculty/whalley/asg5/cgram.y"
{} break;
case 63:
# line 159 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("",   yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 64:
# line 160 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("|",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 65:
# line 161 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("^",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 66:
# line 162 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("&",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 67:
# line 163 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("<<", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 68:
# line 164 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set(">>", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 69:
# line 165 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("+",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 70:
# line 166 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("-",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 71:
# line 167 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("*",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 72:
# line 168 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("/",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 73:
# line 169 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = set("%",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 74:
# line 170 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb("|",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 75:
# line 171 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb("^",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 76:
# line 172 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb("&",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 77:
# line 173 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb("<<", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 78:
# line 174 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb(">>", yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 79:
# line 175 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = opb("%",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 80:
# line 176 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op2("+",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 81:
# line 177 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op2("-",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 82:
# line 178 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op2("*",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 83:
# line 179 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op2("/",  yypvt[-2].rec_ptr, yypvt[-0].rec_ptr); } break;
case 84:
# line 181 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-0].rec_ptr; } break;
case 85:
# line 182 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op1("-",      yypvt[-0].rec_ptr); } break;
case 86:
# line 183 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op1("~",      yypvt[-0].rec_ptr); } break;
case 87:
# line 184 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = op1("@",      yypvt[-0].rec_ptr); } break;
case 88:
# line 185 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = call(yypvt[-2].str_ptr, (struct sem_rec *) NULL); } break;
case 89:
# line 186 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = call(yypvt[-3].str_ptr, yypvt[-1].rec_ptr); } break;
case 90:
# line 187 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = yypvt[-1].rec_ptr; } break;
case 91:
# line 188 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = con(yypvt[-0].str_ptr); } break;
case 92:
# line 189 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = string(yypvt[-0].str_ptr); } break;
case 93:
# line 192 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = id(yypvt[-0].str_ptr); } break;
case 94:
# line 193 "/home/faculty/whalley/asg5/cgram.y"
{ yyval.rec_ptr = index(id(yypvt[-3].str_ptr), yypvt[-1].rec_ptr); } break;
# line	531 "/usr/ccs/bin/yaccpar"
	}
	goto yystack;		/* reset registers in driver code */
}

