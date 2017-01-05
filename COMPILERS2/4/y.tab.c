
# line 3 "cexpr.y"
/*
 * Yasser Atiya
 * make
 * 2/23/2016
 * Assignment 4 (Calculator cexpr)
 */

#include <stdio.h>
#include "limits.h"
//Array of variables
int arr[26] = {0};

//Counter
int i = 0;

//Result of optional operations
int result = 0;

//Booleans

//For using variable
int gotvar = 0;

//To indicate ability to print
int print = 1;

//To assign variable
int assign = 1;

# line 33 "cexpr.y"
typedef union
#ifdef __cplusplus
	YYSTYPE
#endif
  {
  int num;
  char alpha;
  } YYSTYPE;
# define NUM 257
# define ALPHA 258
# define DUMP 259
# define CLEAR 260
# define PLSE 261
# define MINE 262
# define TIME 263
# define DIVE 264
# define MODE 265
# define LSHE 266
# define RSHE 267
# define ANDE 268
# define XORE 269
# define ORE 270
# define RSHF 271
# define LSHF 272

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

# line 390 "cexpr.y"



main()
{
   if (yyparse())
      printf("\nInvalid expression.\n");
   else
      printf("\nCalculator off.\n");
}

yyerror(s)
char *s;
{
   fprintf(stderr, "%s\n", s);
}
static YYCONST yytabelem yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
-1, 54,
	59, 42,
	41, 42,
	-2, 37,
	};
# define YYNPROD 46
# define YYLAST 281
static YYCONST yytabelem yyact[]={

    23,    14,    36,    29,     2,    21,    19,    29,    25,     7,
    22,    23,    14,     1,    29,    57,    21,    19,    26,    32,
     8,    22,    23,    14,    31,    29,    24,    21,    19,    33,
    32,     3,    22,    23,    14,    48,    29,    50,    21,    19,
    56,    32,    55,    22,    30,    23,    14,    20,    29,    28,
    21,    19,    18,    25,    31,    22,    15,    12,    13,    51,
    11,    52,    53,    35,     0,     3,     0,     0,    12,     0,
     0,     0,    31,    31,    31,    47,     0,    49,     0,    12,
     0,     0,    54,     0,     0,     0,     0,    10,     0,    27,
    12,     0,     0,     0,     0,     0,     0,     0,    10,     0,
    27,     0,    12,     0,     0,     0,     0,     0,     0,    10,
     0,    27,     0,     0,     0,     0,     0,     0,     0,     0,
    10,     0,    27,     0,     0,     0,     0,     0,     0,     0,
     0,     0,    10,     0,    27,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,    37,    38,    39,    40,    41,    42,    43,    44,
    45,    46,     0,     0,     0,     0,     0,     0,     0,     0,
     9,     6,     4,     5,     9,    34,     0,     0,     0,     0,
     0,     9,    34,     0,    17,    16,     0,     0,     0,     0,
     0,     0,     9,    34,     0,    17,    16,     0,     0,     0,
     0,     0,     0,     9,    34,     0,    17,    16,     0,     0,
     0,     0,     0,     0,     0,     9,    34,    17,    16,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,    17,
    16 };
static YYCONST yytabelem yypact[]={

-10000000,   -37,-10000000,   -15,-10000000,-10000000,   -59,-10000000,-10000000,-10000000,
-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,
-10000000,-10000000,-10000000,-10000000,-10000000,   -33,-10000000,   -33,-10000000,     8,
-10000000,     8,     8,    -4,-10000000,   -37,-10000000,-10000000,-10000000,-10000000,
-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,-10000000,
-10000000,   -26,    -4,    -4,-10000000,-10000000,-10000000,-10000000 };
static YYCONST yytabelem yypgo[]={

     0,    29,    63,    20,    60,    58,    56,    52,    47,    26,
    18,    49,     9,     4,    13 };
static YYCONST yytabelem yyr1[]={

     0,    14,    14,    13,    13,    13,    13,     1,     1,     1,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     3,     3,     4,     4,     5,     5,     6,     6,     6,
     7,     7,     7,     8,     8,     8,     8,     9,     9,     9,
    10,    10,    10,    11,    12,    12 };
static YYCONST yytabelem yyr2[]={

     0,     0,     5,     5,     3,     3,     7,     3,     7,     3,
     3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
     3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
     3,     7,     3,     3,     3,     3,     3,     5,     5,     3,
     5,     5,     3,     7,     3,     3 };
static YYCONST yytabelem yychk[]={

-10000000,   -14,   -13,    -1,   259,   260,   258,   -12,    -3,   257,
   124,    -4,    94,    -5,    38,    -6,   272,   271,    -7,    43,
    -8,    42,    47,    37,    -9,    45,   -10,   126,   -11,    40,
    59,    -3,    45,    -1,   258,    -2,    61,   261,   262,   263,
   264,   265,   266,   267,   268,   269,   270,   -11,   -12,   -11,
   -12,    -1,    -1,    -1,   -11,   -12,   -13,    41 };
static YYCONST yytabelem yydef[]={

     1,    -2,     2,     0,     4,     5,    45,     7,     9,    44,
    21,    22,    23,    24,    25,    26,    27,    28,    29,    30,
    32,    33,    34,    35,    36,     0,    39,     0,    42,     0,
     3,     0,     0,     0,    45,     0,    10,    11,    12,    13,
    14,    15,    16,    17,    18,    19,    20,    37,    38,    40,
    41,     0,     8,    31,    -2,     7,     6,    43 };
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
	"NUM",	257,
	"ALPHA",	258,
	"DUMP",	259,
	"CLEAR",	260,
	"PLSE",	261,
	"MINE",	262,
	"TIME",	263,
	"DIVE",	264,
	"MODE",	265,
	"LSHE",	266,
	"RSHE",	267,
	"ANDE",	268,
	"XORE",	269,
	"ORE",	270,
	"RSHF",	271,
	"LSHF",	272,
	"-unknown-",	-1	/* ends search */
};

#ifdef __cplusplus
const
#endif
char * yyreds[] =
{
	"-no such reduction-",
	"commands : /* empty */",
	"commands : commands command",
	"command : expr ';'",
	"command : DUMP",
	"command : CLEAR",
	"command : ALPHA level10 command",
	"expr : value",
	"expr : expr level9 expr",
	"expr : level9",
	"level10 : '='",
	"level10 : PLSE",
	"level10 : MINE",
	"level10 : TIME",
	"level10 : DIVE",
	"level10 : MODE",
	"level10 : LSHE",
	"level10 : RSHE",
	"level10 : ANDE",
	"level10 : XORE",
	"level10 : ORE",
	"level9 : '|'",
	"level9 : level8",
	"level8 : '^'",
	"level8 : level7",
	"level7 : '&'",
	"level7 : level6",
	"level6 : LSHF",
	"level6 : RSHF",
	"level6 : level5",
	"level5 : '+'",
	"level5 : expr '-' expr",
	"level5 : level4",
	"level4 : '*'",
	"level4 : '/'",
	"level4 : '%'",
	"level4 : level3",
	"level3 : '-' level1",
	"level3 : '-' value",
	"level3 : level2",
	"level2 : '~' level1",
	"level2 : '~' value",
	"level2 : level1",
	"level1 : '(' expr ')'",
	"value : NUM",
	"value : ALPHA",
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
		
case 2:
# line 101 "cexpr.y"
{ 
                            //Prints result of command if no exception met 
                            if(print && yypvt[-0].num < INT_MAX)
                               printf("%d", yypvt[-0].num);
                            else if(yypvt[-0].num > INT_MAX && print)
                               printf("overflow");
                            
                            //Reset printing flag
                            print = 1;
                        } break;
case 3:
# line 113 "cexpr.y"
{yyval.num = yypvt[-1].num;} break;
case 4:
# line 114 "cexpr.y"
{
                      //Loop and print all variables
                      i = 0; 
                      for(i = 0; i<25; i++)
                      { 
                         printf("%c: %d\n", (i+97),arr[i]);
                      }
                       printf("%c: %d", (i+97),arr[i]);

                       //Set flag
                       print = 0;
                    } break;
case 5:
# line 127 "cexpr.y"
{
                        //Reset all variables to 0
                        i =0; 
                        for(i = 0; i<26; i++)
                        { 
                            arr[i] = 0;
                        }

                        //Set flag
                        print = 0;
                    } break;
case 6:
# line 138 "cexpr.y"
{ 
                            //Switch case for assignment operator
                            switch(yypvt[-1].num)
                            {
                              //based on operator number
                              case 0:
                                  //Detect overflow, and assign if necessary
                                  if(yypvt[-0].num < INT_MAX && assign)
                                     yyval.num = arr[yypvt[-2].alpha-97] = yypvt[-0].num;
                                  //Print error message
                                  else
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 1:
                                  if(yypvt[-0].num+arr[yypvt[-2].alpha-97] < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] += yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 2:
                                  if(arr[yypvt[-2].alpha-97]-yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] -= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 3:
                                  if(arr[yypvt[-2].alpha-97]*yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] *= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              //Detect and print incase of divide by zero
                              case 4:
                                  if(yypvt[-0].num == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                     }
                                  else if(arr[yypvt[-2].alpha-97]/yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  else
                                    {
                                      if(assign)
                                        yyval.num = arr[yypvt[-2].alpha-97] /= yypvt[-0].num;
                                    }

                                  break;
                              case 5:
                                  if(yypvt[-0].num == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                     }
                                  else if(arr[yypvt[-2].alpha-97]%yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }

                                  else
                                    {
                                      if(assign)
                                          yyval.num = arr[yypvt[-2].alpha-97] %= yypvt[-0].num;
                                    }
                                  break;
                              case 6:
                                  if(arr[yypvt[-2].alpha-97]<<yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] <<= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 7:
                                  if(arr[yypvt[-2].alpha-97]>>yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] >>= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 8:
                                  if(arr[yypvt[-2].alpha-97]&yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] &= yypvt[-0].num;
                                   else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 9:
                                  if(arr[yypvt[-2].alpha-97]^yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] ^= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 10:
                                  if(arr[yypvt[-2].alpha-97]|yypvt[-0].num < INT_MAX && assign)
                                    yyval.num = arr[yypvt[-2].alpha-97] |= yypvt[-0].num;
                                  else if (arr[yypvt[-2].alpha-97]|yypvt[-0].num > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;

                            }
                        } break;
case 7:
# line 269 "cexpr.y"
{
                        if(gotvar)
                        {
                          yyval.num = arr[yypvt[-0].num-97];
                          gotvar = 0;
                        }   
                        else
                          yyval.num = yypvt[-0].num;
                    } break;
case 8:
# line 278 "cexpr.y"
{
                            switch(yypvt[-1].num)
                          {
                              case 1:
                                  yyval.num = yypvt[-2].num | yypvt[-0].num;
                                  break;
                              case 2:
                                  yyval.num = yypvt[-2].num ^ yypvt[-0].num;
                                  break;
                              case 3:
                                  yyval.num = yypvt[-2].num & yypvt[-0].num;
                                  break;
                              case 4:
                                  yyval.num = yypvt[-2].num << yypvt[-0].num;
                                  break;
                              case 5:
                                  yyval.num = yypvt[-2].num >> yypvt[-0].num;
                                  break;
                              case 6:
                                  yyval.num = yypvt[-2].num + yypvt[-0].num;
                                  break;
                              case 7:
                                  yyval.num = result;
                                  break;
                              case 8:
                                  yyval.num = yypvt[-2].num * yypvt[-0].num;
                                  break;
                              case 9:
                                  if(yypvt[-0].num == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                       assign = 0;
                                     }
                                  else
                                    yyval.num = yypvt[-2].num / yypvt[-0].num;
                                  break;
                              case 10:
                                  yyval.num = yypvt[-2].num % yypvt[-0].num;
                                  break;
                            }

                  } break;
case 9:
# line 321 "cexpr.y"
{if(yypvt[-0].num == 7)
              yyval.num = result;
           else
              yyval.num=yypvt[-0].num;} break;
case 10:
# line 327 "cexpr.y"
{yyval.num = 0;} break;
case 11:
# line 328 "cexpr.y"
{yyval.num = 1;} break;
case 12:
# line 329 "cexpr.y"
{yyval.num = 2;} break;
case 13:
# line 330 "cexpr.y"
{yyval.num = 3;} break;
case 14:
# line 331 "cexpr.y"
{yyval.num = 4;} break;
case 15:
# line 332 "cexpr.y"
{yyval.num = 5;} break;
case 16:
# line 333 "cexpr.y"
{yyval.num = 6;} break;
case 17:
# line 334 "cexpr.y"
{yyval.num = 7;} break;
case 18:
# line 335 "cexpr.y"
{yyval.num = 8;} break;
case 19:
# line 336 "cexpr.y"
{yyval.num = 9;} break;
case 20:
# line 337 "cexpr.y"
{yyval.num = 10;} break;
case 21:
# line 341 "cexpr.y"
{yyval.num = 1;} break;
case 22:
# line 342 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 23:
# line 345 "cexpr.y"
{yyval.num = 2; } break;
case 24:
# line 346 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 25:
# line 349 "cexpr.y"
{yyval.num = 3;} break;
case 26:
# line 350 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 27:
# line 353 "cexpr.y"
{yyval.num = 4; } break;
case 28:
# line 354 "cexpr.y"
{yyval.num = 5;} break;
case 29:
# line 355 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 30:
# line 358 "cexpr.y"
{yyval.num = 6;} break;
case 31:
# line 359 "cexpr.y"
{yyval.num = 7; result=yypvt[-2].num - yypvt[-0].num;} break;
case 32:
# line 360 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 33:
# line 363 "cexpr.y"
{ yyval.num = 8; } break;
case 34:
# line 364 "cexpr.y"
{ yyval.num = 9; } break;
case 35:
# line 365 "cexpr.y"
{ yyval.num = 10; } break;
case 36:
# line 366 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 37:
# line 369 "cexpr.y"
{
                        yyval.num = -yypvt[-0].num;
                     } break;
case 38:
# line 372 "cexpr.y"
{yyval.num = -yypvt[-0].num;} break;
case 39:
# line 373 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 40:
# line 376 "cexpr.y"
{
                        yyval.num = ~yypvt[-0].num;
                     } break;
case 41:
# line 379 "cexpr.y"
{yyval.num = ~yypvt[-0].num;} break;
case 42:
# line 380 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 43:
# line 383 "cexpr.y"
{yyval.num = yypvt[-1].num;} break;
case 44:
# line 386 "cexpr.y"
{yyval.num = yypvt[-0].num;} break;
case 45:
# line 387 "cexpr.y"
{yyval.num = yypvt[-0].alpha; gotvar = 1;} break;
# line	531 "/usr/ccs/bin/yaccpar"
	}
	goto yystack;		/* reset registers in driver code */
}

