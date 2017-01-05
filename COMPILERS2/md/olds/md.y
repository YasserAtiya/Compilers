/*
 * This machine description describes the MIPS
 *
 * It contains 0 shift/reduce and 0 reduce/reduce conflicts
 */
%{

/************************************************************************/
/*                                                                      */
/* Copyright (c) 1987, 1988, 1989, 1990, 1991, 1992 -                   */
/*     The Rector and Visitors of the University of Virginia            */
/*                                                                      */
/* This code may not be distributed further without permission          */
/*      from the University of Virginia.                                */
/* This code is distributed WITHOUT ANY WARRANTY.  No claims are        */
/*      made as to whether it serves any particular purpose or even     */
/*      works at all.                                                   */
/*                                                                      */
/************************************************************************/

#include "recdef.h"
#include "addrdef.h"
#include "instdef.h"
#include "vpo.h"

void makereg(char *reg, int rt, int rnum); 
static char myreg[20]; 
static char* build_myreg()
{
	makereg(myreg,RTREG,0);
	return myreg;
}

struct sem_rec *binopi(), *record(), *brecord(), *rrecord();
struct addr_entry *addr(), *memref(), *displacement(), *initexpr(), *addexpr();
struct addr_entry *same();
void cvtfi(), cvtif();
void bb(), bc(), binst(), cmpset(), cvt(), fcmp(), neg(), not();
void jal(), jmp(), l(), li(), mfc(), mfu(), mov(), mtc(), retrn();
void samemem(), s(), nop(), mtof(), mtoi(), divide(), divideu(), mflo();
void mfhi(),high(),low(),brk(),multi();

extern int yylength;
%}

%union {
   char *str_ptr;
   struct sem_rec *rec_ptr;
   struct addr_entry *addr_ptr;
   };

/*
 * The GLOBAL token always represents a global identifier
 */
%token <str_ptr> GLOBAL

/*
 * The LOCAL token always represents a local identifier
 */
%token <str_ptr> LOCAL

/*
 * The LBL token always represents a label
 */
%token <str_ptr> LBL

/*
 * The CON token always represents an integer constant above 10.
 * The single character constants ('0'..'9') represent themselves.
 */
%token <str_ptr> CON

/*
 * The FCON token always represents an floating point constant
 */
%token <str_ptr> FCON

/*
 * The following upper-case letter constants are defined by the RTL standard
 *
 *     FC - represents the floating-point register set by compare instructions
 *     PC - represents the program counter
 *     RT - represents the return label
 *     ST - represents a call instruction
 */
%token FC PC RT ST

/*
 * Two upper-case letter tokens always represent the same actual two letters
 */
%token CV MY MU ML MT SL TT WY LO HI BK IL

/*
 * The REGx tokens always represent register encodings of type x (hexadecimal)
 */
%token REG0 REG1 REG2 REG3 REG4

/*
 * The xMEM tokens always represent the "x[" memory reference sequence
 */
%token BMEM DMEM FMEM RMEM WMEM MMEM

%left '='
%left '+' '-'
%left '|' '&' '^'
%left '"' '{' '}'
%left '*' '/' '\\' '%' '#'
%nonassoc '~' ','

%type <rec_ptr> bb, bcf, bct, binst, cmpset, cvt, fcmp, cvtfi, cvtif, cvtil
%type <rec_ptr> jal, jmp, l, li, mfc, mfu, mfl, mov, mtc, neg, not
%type <rec_ptr> rhs, s, samemem, mtof, mtoi, divide, divideu, mflo
%type <rec_ptr> mfhi,hilo, high,low, brk, multi,multu,mfireg

%type <addr_ptr> src, mem, dst, dst0, memaddr, addr,  expr, simpexpr, hreg
%type <addr_ptr> regexp, label, con, immed, reg, ireg
%type <str_ptr> rel frel
%%

inst 	:	bb				{ bb($1); }
	|	bcf				{ bc($1, 'f'); }
	|	bct				{ bc($1, 't'); }
	|	binst 				{ binst($1); }
	|	cmpset				{ cmpset($1); }
	|	cvt				{ cvt($1); }
	|	cvtfi				{ cvtfi($1); }
	|	cvtil				{ cvtil($1); }  
	|	cvtif				{ cvtif($1); }
        |       divide                          { divide($1); }
        |       divideu                         { divideu($1); }

	|	fcmp				{ fcmp($1); }
	|	jal				{ jal($1); }
	|	l				{ l($1); }
	|	li				{ li($1); }
	|	mfc				{ mfc($1); }
	|	mfu mfl				{ mfu($1, $2); }
	|	mfl mfu				{ mfu($2, $1); }
	|	mov				{ mov($1); }
	|	mtc				{ mtc($1); }
        |       mfhi                    { mfhi($1); }
        |       mfireg                    { mfireg($1); }
        |       mflo                    { mflo($1); }

	|	neg 				{ neg($1); }
	|	not 				{ not($1); }
	|	jmp				{ jmp($1); }
 	|	ret				{ retrn(); }
	|	samemem				{ samemem($1); }
	|	s				{ s($1); }
        |       mtof                            { mtof($1); }
        |       mtoi                            { mtoi($1); }
	|	nop				{ nop(); }
        |       high                            { high($1); }
        |       low                             { low($1); }
        |       hilo                             { highlow($1); }
        |       brk                             { brk($1); }
        |       multi                           { multi($1); }
        |       multu                           { multu($1); }
	;

bb	:	PC '=' dst0 rel dst0 ',' label ';'
					{ $$ = rrecord($4, $3, $5, $7); };
bcf	:	PC '=' FC ':' '0' ',' label ';'	{ $$ = record($7, AN, AN); };
bct	:	PC '=' FC ':' '1' ',' label ';'	{ $$ = record($7, AN, AN); };
nop	:	FC '=' FC ';' 
	|	';';
binst	:	dst '=' rhs ';'			{ $$ = binopi($1, $3); };
cmpset	:	dst '=' dst rel src ';'		{ $$ = rrecord($4, $1, $3, $5); };
cvt	:	dst '=' CV '[' dst ']' ';'	{ $$ = record($1, $5, AN);};
cvtfi	:	dst '=' TT '[' dst ']' ';'	{ $$ = record($1, $5, AN);};
cvtif	:	dst '=' WY '[' dst ']' ';'	{ $$ = record($1, $5, AN);};

divide :        LO '=' reg '/' reg ';'          { $$ = record($3, $5, AN); }
        |       HI '=' reg '/' reg ';'                  { $$ = record($3, $5, AN); };
divideu :       LO '=' reg '\\' reg ';'         { $$ = record($3, $5, AN); }
        |       HI '=' reg '\\' reg ';'                 { $$ = record($3, $5, AN); };

high    :       dst '=' HI'['GLOBAL']'';'        { $$ = record($1, addr(ANY, GIDENT, AE $5, AN, AN), AN); }
	|       dst '=' HI'['immed']'';'         { $$ = record($1, $5, AN); };

low     :       dst '=' dst'|'LO'['GLOBAL']'';'  { $$ = record($1, $3, addr(ANY, GIDENT, AE $7, AN, AN)); }
        |       dst '=' dst'|'LO'['immed']'';'   { $$ = record($1, $3, $7); };

hilo	: 	dst '=' HI '[' GLOBAL ']' '|' LO '[' GLOBAL ']' ';' { $$ = record($1, addr(ANY, GIDENT, AE $5, AN, AN), AN); }
	| 	dst '=' HI '[' immed ']' '|' LO '[' immed ']' ';' { $$ = record($1, $5, AN); }
        ;


brk     :       BK ';'                          { $$ = record(AN,AN,AN); };

multi   :       LO '=' reg '*' reg ';'          { $$ = record($3, $5, AN);  };

/* Only accept if the arguments match.  Instead of creating a new type with 6 parameters,
   the comparison is done here. */ 
multu   :       ireg '=' reg '*' reg '"' con ';' ireg '=' reg '*' reg ';'      { $$ = record(icompare($3, $11) ? $3 : 0, icompare($5,$13) ? $5 : 0, $7);  };


fcmp	:	FC '=' dst frel src ';'		{ $$ = rrecord($4, $3, $5, AN); };
jal	:	ST '=' addr ';'  		{ $$ = record($3, AN, AN); }
	|	ST '=' addr ';' dst '=' addr ';'  { $$ = record(same($3,$7)?$3:NULL, $5, AN); }
	|	ST '=' HI '[' addr ']' '|' LO '[' addr ']' ';'  		{ $$ = record(same($5, $10)?$5:NULL, AN, AN); }
	|	ST '=' HI '[' addr ']' '|' LO '[' addr ']' ';' 
		dst '=' HI '[' addr ']' '|' LO '[' addr ']' ';' 
                { $$ = record((same($5,$10) && same($17,$22) && same($10,$17))?$5:NULL, $13, AN); }
 	|	ST '=' HI '[' addr ']' '|' LO '[' addr ']' ';' 
		dst '=' dst ';' 
                { $$ = record((same($5,$10))?$5:NULL, $13, AN); }
	;



jmp	:	PC '=' expr ';'			{ $$ = record($3, AN, AN); }
	|	PC '=' reg ';'			{ $$ = record($3, AN, AN); };
l	:	dst '=' mem ';'			{ $$ = record($1, $3, AN); }
	|	dst '=' mem '&' con ';'		{ $$ = record($1, $3, $5); }
	|	dst '=' '(' mem '{' con ')' '}' con ';'
				{ $$ = record($1, $4, same($6, $9)); };
li	:	dst '=' simpexpr ';'		{ $$ = record($1, $3, AN); };
mfc	:	dst '=' MY '[' dst  ']' ';'	{ $$ = record($1, $5, AN); };
mfu	:	dst '=' MU '[' dst  ']' ';'	{ $$ = record($1, $5, AN); };
mfl	:	dst '=' ML '[' dst  ']' ';'	{ $$ = record($1, $5, AN); };
mov	:	dst '=' dst ';'			{ $$ = record($1, $3, AN); };
mtc	:	dst '=' MT '[' dst  ']' ';'	{ $$ = record($1, $5, AN); };

hreg	: 	REG3 { $$ = addr(LONG, HREGISTER, AE $<str_ptr>1, AN, AN); };
cvtil	: 	dst '=' IL '[' dst ',' dst ']' ';' { $$ = record($1, $5, $7); };


mfhi    :       dst '=' HI ';'                  { $$ = record($1, AN, AN); };
mflo    :       dst '=' LO ';'                  { $$ = record($1, AN, AN); };
mfireg    :       dst '=' ireg ';'                  { $$ = record($1, $3, AN); };

neg	:	dst '=' '-' dst ';'		{ $$ = record($1, $4, AN); };
not	:	dst '=' '~' dst ';'		{ $$ = record($1, $4, AN); };
ret	:	PC '=' RT ';'
s	:	mem '=' dst0 ';'		{ $$ = record($1, $3, AN); };
samemem	:	mem '=' mem ';'			{ $$ = record($1, $3, AN); };
mtof    :       dst '=' WY '[' MT '[' dst ']' ']' ';'      { $$ = record($1, $7, AN); };
mtoi    :       dst '=' MY '[' TT '[' dst ']' ']' ';'      { $$ = record($1, $7, AN); };  
rhs	:	dst '+' src		{ $$ = brecord(ADDI, $1, $3); }
	|	dst '-' src		{ $$ = brecord(SUBI, $1, $3); }
	|	dst '^' src		{ $$ = brecord(XORI, $1, $3); }
	|	dst '&' src		{ $$ = brecord(ANDI, $1, $3); }
	|	dst '|' src		{ $$ = brecord(ORI, $1, $3); }
	|	dst '*' src		{ $$ = brecord(MULI, $1, $3); }
	|	dst '/' src		{ $$ = brecord(DIVI, $1, $3); }
	|	dst '\\' src		{ $$ = brecord(DIVUI, $1, $3); }
	|	dst '%' src		{ $$ = brecord(REMI, $1, $3); }
	|	dst '#' src		{ $$ = brecord(REMUI, $1, $3); }
	|	dst '{' src		{ $$ = brecord(SLLI, $1, $3); }
	|	dst '}' src		{ $$ = brecord(SRAI, $1, $3); }
	|	dst '"' src		{ $$ = brecord(SRLI, $1, $3); }
	|	'(' rhs ')' 		{ $$ = $2; }
	;

src	:	dst
	|	immed
	;

dst0	:	dst	
	|	'0'	{ $$ = addr(ANY, RREGISTER, AE build_myreg() ,AN,AN); }
	;

dst	:	REG0	{ $$ =addr(LONG, RREGISTER, AE $<str_ptr>1, AN, AN); }
	|	REG1	{ $$ =addr(FLOAT, FREGISTER, AE $<str_ptr>1, AN, AN); }
	|	REG2	{ $$ =addr(DOUBLE, DREGISTER, AE $<str_ptr>1, AN, AN); }
	|	REG3	{ $$ =addr(LONG, HREGISTER, AE $<str_ptr>1, AN, AN); }
	;

immed	:	expr		{ $$ = addr(ANY, IMMED, $1, AN, AN); }
	;

mem	:	BMEM memaddr ']'	{ $$ = memref(BYTE, $2); }	
        |	WMEM memaddr ']'	{ $$ = memref(WORD, $2); }
	|	RMEM memaddr ']'	{ $$ = memref(LONG, $2); }
	|	FMEM memaddr ']'	{ $$ = memref(FLOAT, $2); }
	|	DMEM memaddr ']'	{ $$ = memref(DOUBLE, $2); }
	;

memaddr	:	/*expr		{ $$ = addr(ANY, ABSOLUTE, $1, AN, AN); }
        |*/	reg		{ $$ = addr(ANY, REGDFR, $1, AN, AN); }
        |	regexp		{ $$ = displacement($1); }
        ;

addr	:	expr		{ $$ = addr(ANY, ABSOLUTE, $1, AN, AN); }
        |	reg		{ $$ = addr(ANY, REGDFR, $1, AN, AN); }
        |	regexp		{ $$ = displacement($1); }
        ;

regexp	:	reg '+' expr		{ $$ = initexpr($1, 0, $3); }
	|	reg '-' expr		{ $$ = initexpr($1, 1, $3); }
	|	expr '+' reg		{ $$ = initexpr($3, 0, $1); }
	|	regexp '+' expr		{ $$ = addexpr($1, ADDI, $3); }
	|	regexp '-' expr		{ $$ = addexpr($1, SUBI, $3); }
	|	'(' regexp ')'		{ $$ = $2; }
	;

reg	:	REG0	{ $$ = addr(LONG, RREGISTER, AE $<str_ptr>1, AN, AN); };

ireg	:	REG4	{ $$ = addr(LONG, RREGISTER, AE $<str_ptr>1, AN, AN); };

simpexpr:       expr '+' expr   { $$ = addr(ANY, EXPR, AE ADDI, $1, $3); }
        |       expr '-' expr   { $$ = addr(ANY, EXPR, AE SUBI, $1, $3); }
	|	'-' expr %prec '~'
				{ $$ = addr($2->type, EXPR, AE NEGI, $2, AN); }
	|	'~' expr	{ $$ = addr(ANY, EXPR, AE NOTI, $2, AN); }
        |       LOCAL           { $$ = addr(ANY, LIDENT, AE $1, AN, AN); }
        |       GLOBAL          { $$ = addr(ANY, GIDENT, AE $1, AN, AN); }
        |       SL '[' con ']'  { $$ = addr(ANY, SPILLOC, $3, AN, AN); }
        |       con		
        |       FCON    	{ $$ = addr(FPANY, FCONST, AE $1, AE yylength, AN); }
        |       label		
        |       '(' expr ')'    { $$ = $2; }
        ;

expr	:	expr '+' expr	{ $$ = addr(ANY, EXPR, AE ADDI, $1, $3); }
	|	expr '-' expr	{ $$ = addr(ANY, EXPR, AE SUBI, $1, $3); }
/*	|	expr '*' expr	{ $$ = addr(ANY, EXPR, AE MULI, $1, $3); }
	|	expr '/' expr	{ $$ = addr(ANY, EXPR, AE DIVI, $1, $3); }
	|	expr '%' expr	{ $$ = addr(ANY, EXPR, AE REMI, $1, $3); } */
	|	expr '{' expr	{ $$ = addr(ANY, EXPR, AE SLLI, $1, $3); }
	|	expr '"' expr	{ $$ = addr(ANY, EXPR, AE SRLI, $1, $3); }
	|	expr '^' expr	{ $$ = addr(ANY, EXPR, AE XORI, $1, $3); }
	|	expr '&' expr	{ $$ = addr(ANY, EXPR, AE ANDI, $1, $3); }
	|	expr '|' expr	{ $$ = addr(ANY, EXPR, AE ORI, $1, $3); }
	|	'-' expr %prec '~'
				{ $$ = addr($2->type, EXPR, AE NEGI, $2, AN); }
/*	|	'~' expr	{ $$ = addr(ANY, EXPR, AE NOTI, $2, AN); } */
	|	LOCAL		{ $$ = addr(ANY, LIDENT, AE $1, AN, AN); }
	|	GLOBAL		{ $$ = addr(ANY, GIDENT, AE $1, AN, AN); }
	|	SL '[' con ']'	{ $$ = addr(ANY, SPILLOC, $3, AN, AN); }
	|	con
	|	FCON	{ $$ = addr(FPANY, FCONST, AE $1, AE yylength, AN); }
	|	label
	|	'(' expr ')' 	{ $$ = $2; }
	;

label	:	LBL	{ $$ = addr(LONG, LABEL, AE $1, AE yylength, AN); }
	;

con	:	CON	{ $$ = addr(ANY, ICONST, AE $1, AE yylength, AN); }
	|	'0'	{ $$ = addr(ANY, ICONST, AE "0", AE 1, AN); }
	|	'1'	{ $$ = addr(ANY, ICONST, AE "1", AE 1, AN); }
	|	'2'	{ $$ = addr(ANY, ICONST, AE "2", AE 1, AN); }
	|	'3'	{ $$ = addr(ANY, ICONST, AE "3", AE 1, AN); }
	|	'4'	{ $$ = addr(ANY, ICONST, AE "4", AE 1, AN); }
	|	'5'	{ $$ = addr(ANY, ICONST, AE "5", AE 1, AN); }
	|	'6'	{ $$ = addr(ANY, ICONST, AE "6", AE 1, AN); }
	|	'7'	{ $$ = addr(ANY, ICONST, AE "7", AE 1, AN); }
	|	'8'	{ $$ = addr(ANY, ICONST, AE "8", AE 1, AN); }
	|	'9'	{ $$ = addr(ANY, ICONST, AE "9", AE 1, AN); }
	;

rel	:	':'	{ $$ = "eq"; }
	|	'!'	{ $$ = "ne"; }
	|	'`'	{ $$ = "ge"; }
	|	'\''	{ $$ = "le"; }
	|	'<'	{ $$ = "lt"; }
	|	'>'	{ $$ = "gt"; }
	|	'g'	{ $$ = "geu"; }
	|	's'	{ $$ = "leu"; }
	|	'l'	{ $$ = "ltu"; }
	|	'h'	{ $$ = "gtu"; }
	;

frel	:	':'		{ $$ = "eq"; }
	|	'\''		{ $$ = "le"; }
	|	'<'		{ $$ = "lt"; }
	;
%%
#include <stdio.h>

yyerror(char* str)
{
	fprintf(stderr, "parse error: %s\n", str);
}




