#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
# define U(x) x
# define NLSTATE yyprevious=YYNEWLINE
# define BEGIN yybgin = yysvec + 1 +
# define INITIAL 0
# define YYLERR yysvec
# define YYSTATE (yyestate-yysvec-1)
# define YYOPTIM 1
# ifndef YYLMAX 
# define YYLMAX BUFSIZ
# endif 
#ifndef __cplusplus
# define output(c) (void)putc(c,yyout)
#else
# define lex_output(c) (void)putc(c,yyout)
#endif

#if defined(__cplusplus) || defined(__STDC__)

#if defined(__cplusplus) && defined(__EXTERN_C__)
extern "C" {
#endif
	int yyback(int *, int);
	int yyinput(void);
	int yylook(void);
	void yyoutput(int);
	int yyracc(int);
	int yyreject(void);
	void yyunput(int);
	int yylex(void);
#ifdef YYLEX_E
	void yywoutput(wchar_t);
	wchar_t yywinput(void);
#endif
#ifndef yyless
	int yyless(int);
#endif
#ifndef yywrap
	int yywrap(void);
#endif
#ifdef LEXDEBUG
	void allprint(char);
	void sprint(char *);
#endif
#if defined(__cplusplus) && defined(__EXTERN_C__)
}
#endif

#ifdef __cplusplus
extern "C" {
#endif
	void exit(int);
#ifdef __cplusplus
}
#endif

#endif
# define unput(c) {yytchar= (c);if(yytchar=='\n')yylineno--;*yysptr++=yytchar;}
# define yymore() (yymorfg=1)
#ifndef __cplusplus
# define input() (((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
#else
# define lex_input() (((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
#endif
#define ECHO fprintf(yyout, "%s",yytext)
# define REJECT { nstr = yyreject(); goto yyfussy;}
int yyleng;
#define YYISARRAY
char yytext[YYLMAX];
int yymorfg;
extern char *yysptr, yysbuf[];
int yytchar;
FILE *yyin = {stdin}, *yyout = {stdout};
extern int yylineno;
struct yysvf { 
	struct yywork *yystoff;
	struct yysvf *yyother;
	int *yystops;};
struct yysvf *yyestate;
extern struct yysvf yysvec[], *yybgin;

# line 3 "cpretty.l"
/****************************************
*										*
*	Yasser Atiya						*
*	COP5621								*
*	Asg 2 (lexer to make c pretty)		*
*										*
*****************************************/

	#include <stdio.h>
	#include <string.h>
	int CurrentType = 0;			//int for indicating most recently picked up token type (1 - Reserved, 2 - Comment, 3 - String, 4 - Character Literal, 5 - Number, 6 - Other, 7 - End state
	char previoustoken[YYLMAX];		//Character Array containing previous token, length of maximum lex token
	int linecomnum = 0;				//Line comment line number
	int justdelimited = 0;			//int indicating whether lexer should be warry of recent backslash

	int instring = 0;				//Ints using boolean style to indicate if we are in a comment, string, or literal to prevent different fonts within them
	int inliteral = 0;
	int inmcomment = 0;

# define YYNEWLINE 10
int yylex(){
int nstr; extern int yyprevious;
#ifdef __cplusplus
/* to avoid CC and lint complaining yyfussy not being used ...*/
static int __lex_hack = 0;
if (__lex_hack) goto yyfussy;
#endif
while((nstr = yylook()) >= 0)
yyfussy: switch(nstr){
case 0:
if(yywrap()) return(0); break;
case 1:

# line 39 "cpretty.l"
	{	/*Detect reserved word not a beginning of another word(such as char, not putchar)*/
								int len = strlen(previoustoken);					//Length of last token(used to keep track of last character mostly)
								if(CurrentType == 0){								//If just started lexing
					 		        printf(".fp 5 CBI\n.ft CR\n.nf\n");				//Print defaults
									printf("\\f(CB%s",yytext);						//Print groff code and last token
									CurrentType = 1;								//Specify we just found a reserved word
									strcpy(previoustoken,yytext);					//Replace old previous token with current
								}
								else if(CurrentType != 1 && isalpha(previoustoken[len-1]))		//If we are part of another word
								{
									printf("%s",yytext);							//Simply print token
									strcat(previoustoken, yytext);					//Add token to previous token
								}
								else if(CurrentType != 1 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum){	//If we found a lone reserved word and need to indicate new font to groff
									printf("\\f(CB%s",yytext);						//Print token and groff command
									CurrentType = 1;								//Set most recent type so as not to print command again
									strcpy(previoustoken,yytext);					//Replace last token 
								}
								else{												//If we already have groff command down for reserved words, etc.
									printf("%s",yytext);							//Print token
									strcat(previoustoken, yytext);					//Add to previous token
								}	
								justdelimited = 0;									//Indicate last character was not delimiter
							}
break;
case 2:

# line 64 "cpretty.l"
 		{		/*Detect pattern beginning of traditional C comment section*/
									if(CurrentType == 0){							//Just started lexing
							            printf(".fp 5 CBI\n.ft CR\n.nf\n");
										printf("\\f(CI%s",yytext);
										CurrentType = 2;
										strcpy(previoustoken,yytext);
										inmcomment = 1;								//Set in comment boolean to true
									}
									else if(CurrentType != 2 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum){	//If we found the beginning of a multiline comment section outside of another section
										printf("\\f(CI%s",yytext);					//PRint token and groff command
										CurrentType = 2;							//Set most recent type
										strcpy(previoustoken,yytext);				
										inmcomment = 1;								//Set in comment bool
									}
									else{
										printf("%s",yytext);						//Print token
										strcat(previoustoken, yytext);
									}	
									justdelimited = 0;								//Indicate last token was not backslash
								}
break;
case 3:

# line 85 "cpretty.l"
 		{		/*Detect pattern ending traditional C comment section*/
								printf("%s",yytext);								//Print token
								strcat(previoustoken, yytext);						//Add to previous token
								inmcomment = 0;										//Indicate out of comment section
								CurrentType = 7;									//Indicate we have just finished a section
								justdelimited = 0;									//Indicate last token was not backslash
							}
break;
case 4:

# line 93 "cpretty.l"
  		{
							if(CurrentType == 0){									//Just started lexing
					            printf(".fp 5 CBI\n.ft CR\n.nf\n");
								printf("\\f(CI%s",yytext);
								CurrentType = 2;
								strcpy(previoustoken,yytext);
								linecomnum = yylineno;								//Set line comment number to current number to indicate where comment is
							}
							else if(CurrentType != 2 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum){	//Indicate we are not in another section
								printf("\\f(CI%s",yytext);
								CurrentType = 2;
								strcpy(previoustoken,yytext);
								linecomnum = yylineno;
							}
							else{													//In other section, just print token
								printf("%s",yytext);
								strcat(previoustoken, yytext);
							}
							justdelimited = 0;									//Indicate last token was not backslash
						}
break;
case 5:

# line 114 "cpretty.l"
	  		{		/*Detected ditto*/
							if(CurrentType == 0){									//Just began lexing
					            printf(".fp 5 CBI\n.ft CR\n.nf\n");
								printf("\\fB%s",yytext);
								CurrentType = 3;
								strcpy(previoustoken,yytext);
								instring = 1;										//Set bool to indicate inside string
							}
							else if(CurrentType != 3 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum){	//String is not inside other section, need groff command
								printf("\\fB%s",yytext);
								CurrentType = 3;
								strcpy(previoustoken,yytext);
								instring = 1;
							}
							else if(instring == 1)									//Second ditto found, ending string section
							{
								printf("%s",yytext);								//Print ditto
								strcat(previoustoken, yytext);						//Add ditto to token
								instring = 0;										//Set string bool to false
								CurrentType = 7;									//Set type to finished section
							}
							else{													//In other section, just print token
								printf("%s",yytext);
								strcat(previoustoken, yytext);
							}	

							justdelimited = 0;
						}
break;
case 6:

# line 143 "cpretty.l"
	{		/*Found literal containing other quote, special case that is tricky to handle otherwise*/
						printf("\\fI%s", yytext);									//Issue groff command
						CurrentType = 7;											//Set type to done
						justdelimited = 0;
					}
break;
case 7:

# line 149 "cpretty.l"
		{		/*Found quote indicating character literal section*/
						if(CurrentType == 0){										//Just began parsing
						        printf(".fp 5 CBI\n.ft CR\n.nf\n");
							printf("\\fI%s",yytext);
							CurrentType = 4;
							strcpy(previoustoken,yytext);
							inliteral = 1;											//Indicate we have entered a literal
						}
						else if(CurrentType != 4 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum && justdelimited != 1){		//Literal independent of other sections, in need of groff command
							printf("\\fI%s",yytext);
							CurrentType = 4;
							strcpy(previoustoken,yytext);
							inliteral = 1;
						}
						else if(inliteral == 1)										//Inside of literal, closing area
						{
							printf("%s",yytext);									//Print token
							strcat(previoustoken, yytext);							//Add to previous token
							inliteral = 0;											//Set bool for inside character literal to false
							CurrentType = 7;										//Set type to just finished section
						}
						else{
							printf("%s",yytext);
							strcat(previoustoken, yytext);
						}	
							justdelimited = 0;
					}
break;
case 8:

# line 177 "cpretty.l"
		{	/*Found any number of consecutive digits*/
						if(CurrentType == 0){										//Just began lexing
				            printf(".fp 5 CBI\n.ft CR\n.nf\n");
							printf("\\f5%s",yytext);
							CurrentType = 5;
							strcpy(previoustoken,yytext);
						}
						else if(CurrentType != 5 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum){	//Number is not part of other section and needs groff command
							printf("\\f5%s",yytext);
							CurrentType = 5;
							strcpy(previoustoken,yytext);
						}
						else{														//Number does not need groff command
							printf("%s",yytext);
							strcat(previoustoken, yytext);
						}	
							justdelimited = 0;
					}
break;
case 9:

# line 196 "cpretty.l"
{	/*Two consecutive backslashes, can trip up lexer*/
							printf("%s",yytext);									//Print token
							justdelimited = 1;										//Indicate lexer last token was delimiter
						}
break;
case 10:

# line 202 "cpretty.l"
		{	/*Detected pattern of delimited character such as newline*/

						if(CurrentType == 0){										//Just began lexing
				            printf(".fp 5 CBI\n.ft CR\n.nf\n");
							printf("\\f(CR%s",yytext);
							CurrentType = 6;
							strcpy(previoustoken,yytext);
						}
							printf("\\%s",yytext);									//Print extra backslash for groff reasons
							strcat(previoustoken, yytext);							//Add to previous token	
							justdelimited = 1;										//Indicate last character was delimited
					}
break;
case 11:

# line 215 "cpretty.l"
				{	/*Detected any default character not matching other patterns*/
						if(CurrentType == 0){										//Just began lexing
				            printf(".fp 5 CBI\n.ft CR\n.nf\n");
							printf("\\f(CR%s",yytext);
							CurrentType = 6;
							strcpy(previoustoken,yytext);
						}
						else if(CurrentType != 6 && inmcomment != 1 && inliteral != 1 && instring != 1 && yylineno != linecomnum)	//Not part of other section, need groff command
						{
							printf("\\f(CR%s",yytext);
							CurrentType = 6;
							strcpy(previoustoken,yytext);
						}
						else{														//Part of other section
							printf("%s",yytext);
							strcat(previoustoken, yytext);
						}	
							justdelimited = 0;										//Indicate token is not a delimiter
					}
break;
case -1:
break;
default:
(void)fprintf(yyout,"bad switch yylook %d",nstr);
} return(0); }
/* end of yylex */

# line 235 "cpretty.l"

int yyvstop[] = {
0,

11,
0, 

5,
11,
0, 

7,
11,
0, 

11,
0, 

11,
0, 

8,
11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

11,
0, 

3,
0, 

2,
0, 

4,
0, 

8,
0, 

10,
0, 

9,
0, 

-1,
0, 

-1,
0, 

1,
0, 

6,
0, 
0};
# define YYTYPE unsigned char
struct yywork { YYTYPE verify, advance; } yycrank[] = {
0,0,	0,0,	1,3,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	1,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	1,4,	
0,0,	0,0,	0,0,	2,0,	
1,5,	25,56,	56,82,	1,6,	
0,0,	0,0,	7,27,	0,0,	
1,7,	1,8,	6,26,	7,28,	
8,29,	8,29,	8,29,	8,29,	
8,29,	8,29,	8,29,	8,29,	
8,29,	8,29,	0,0,	2,4,	
0,0,	0,0,	1,3,	0,0,	
2,5,	0,0,	0,0,	2,6,	
0,0,	0,0,	0,0,	0,0,	
2,7,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	1,9,	5,25,	0,0,	
0,0,	0,0,	1,10,	1,11,	
1,12,	1,13,	1,14,	1,15,	
1,16,	19,47,	1,17,	24,55,	
33,58,	1,18,	35,60,	15,41,	
16,43,	14,39,	15,42,	1,19,	
1,20,	1,21,	1,22,	1,23,	
1,24,	2,9,	9,30,	10,32,	
11,33,	14,40,	2,10,	2,11,	
2,12,	2,13,	2,14,	2,15,	
2,16,	17,44,	2,17,	12,34,	
18,46,	2,18,	21,52,	22,53,	
13,37,	17,45,	12,35,	2,19,	
2,20,	2,21,	2,22,	2,23,	
2,24,	12,36,	13,38,	23,54,	
32,57,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	34,59,	
9,31,	36,61,	37,62,	39,65,	
40,66,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	9,30,	
9,30,	9,30,	9,30,	20,48,	
20,49,	38,63,	41,67,	42,44,	
43,68,	45,44,	46,69,	47,70,	
48,72,	49,73,	38,63,	20,50,	
50,74,	51,76,	20,51,	52,77,	
53,78,	54,80,	55,81,	57,44,	
47,71,	58,83,	59,44,	61,84,	
62,85,	64,86,	53,79,	66,87,	
67,88,	50,75,	69,44,	70,89,	
71,90,	72,91,	73,92,	74,93,	
75,94,	76,95,	77,96,	78,97,	
79,98,	80,44,	81,99,	83,44,	
84,100,	85,101,	86,102,	87,103,	
38,63,	89,104,	90,105,	92,106,	
93,107,	94,108,	95,109,	96,110,	
97,44,	98,111,	100,112,	101,113,	
104,114,	106,44,	107,44,	109,44,	
110,115,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	111,116,	
112,117,	114,118,	116,119,	0,0,	
0,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,0,	38,0,	38,0,	
38,0,	38,64,	38,0,	38,0,	
38,0,	38,0,	38,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	44,0,	44,0,	44,0,	
44,0,	0,0,	0,0,	0,0,	
0,0};
struct yysvf yysvec[] = {
0,	0,	0,
yycrank+-1,	0,		0,	
yycrank+-29,	yysvec+1,	0,	
yycrank+0,	0,		yyvstop+1,
yycrank+0,	0,		yyvstop+3,
yycrank+2,	0,		yyvstop+6,
yycrank+3,	0,		yyvstop+9,
yycrank+4,	0,		yyvstop+11,
yycrank+4,	0,		yyvstop+13,
yycrank+88,	0,		yyvstop+16,
yycrank+6,	0,		yyvstop+18,
yycrank+10,	0,		yyvstop+20,
yycrank+38,	0,		yyvstop+22,
yycrank+39,	0,		yyvstop+24,
yycrank+5,	0,		yyvstop+26,
yycrank+3,	0,		yyvstop+28,
yycrank+1,	0,		yyvstop+30,
yycrank+31,	0,		yyvstop+32,
yycrank+25,	0,		yyvstop+34,
yycrank+4,	0,		yyvstop+36,
yycrank+107,	0,		yyvstop+38,
yycrank+17,	0,		yyvstop+40,
yycrank+29,	0,		yyvstop+42,
yycrank+40,	0,		yyvstop+44,
yycrank+3,	0,		yyvstop+46,
yycrank+2,	0,		0,	
yycrank+0,	0,		yyvstop+48,
yycrank+0,	0,		yyvstop+50,
yycrank+0,	0,		yyvstop+52,
yycrank+0,	yysvec+8,	yyvstop+54,
yycrank+0,	0,		yyvstop+56,
yycrank+0,	0,		yyvstop+58,
yycrank+36,	0,		0,	
yycrank+7,	0,		0,	
yycrank+64,	0,		0,	
yycrank+13,	0,		0,	
yycrank+71,	0,		0,	
yycrank+80,	0,		0,	
yycrank+-212,	0,		yyvstop+60,
yycrank+68,	0,		0,	
yycrank+68,	0,		0,	
yycrank+103,	0,		0,	
yycrank+101,	0,		0,	
yycrank+100,	0,		0,	
yycrank+-270,	yysvec+38,	yyvstop+62,
yycrank+101,	0,		0,	
yycrank+108,	0,		0,	
yycrank+116,	0,		0,	
yycrank+109,	0,		0,	
yycrank+99,	0,		0,	
yycrank+127,	0,		0,	
yycrank+120,	0,		0,	
yycrank+115,	0,		0,	
yycrank+123,	0,		0,	
yycrank+124,	0,		0,	
yycrank+125,	0,		0,	
yycrank+3,	0,		0,	
yycrank+120,	0,		0,	
yycrank+136,	0,		0,	
yycrank+133,	0,		0,	
yycrank+0,	yysvec+42,	0,	
yycrank+119,	0,		0,	
yycrank+139,	0,		0,	
yycrank+0,	0,		yyvstop+64,
yycrank+139,	0,		0,	
yycrank+0,	yysvec+59,	0,	
yycrank+138,	0,		0,	
yycrank+143,	0,		0,	
yycrank+0,	yysvec+57,	0,	
yycrank+139,	0,		0,	
yycrank+138,	0,		0,	
yycrank+127,	0,		0,	
yycrank+131,	0,		0,	
yycrank+145,	0,		0,	
yycrank+131,	0,		0,	
yycrank+131,	0,		0,	
yycrank+133,	0,		0,	
yycrank+149,	0,		0,	
yycrank+140,	0,		0,	
yycrank+147,	0,		0,	
yycrank+153,	0,		0,	
yycrank+146,	0,		0,	
yycrank+0,	0,		yyvstop+66,
yycrank+148,	0,		0,	
yycrank+151,	0,		0,	
yycrank+140,	0,		0,	
yycrank+150,	0,		0,	
yycrank+145,	0,		0,	
yycrank+0,	yysvec+45,	0,	
yycrank+146,	0,		0,	
yycrank+148,	0,		0,	
yycrank+0,	yysvec+45,	0,	
yycrank+152,	0,		0,	
yycrank+159,	0,		0,	
yycrank+166,	0,		0,	
yycrank+167,	0,		0,	
yycrank+167,	0,		0,	
yycrank+158,	0,		0,	
yycrank+166,	0,		0,	
yycrank+0,	yysvec+59,	0,	
yycrank+160,	0,		0,	
yycrank+163,	0,		0,	
yycrank+0,	yysvec+59,	0,	
yycrank+0,	yysvec+97,	0,	
yycrank+156,	0,		0,	
yycrank+0,	yysvec+97,	0,	
yycrank+171,	0,		0,	
yycrank+175,	0,		0,	
yycrank+0,	yysvec+45,	0,	
yycrank+171,	0,		0,	
yycrank+175,	0,		0,	
yycrank+193,	0,		0,	
yycrank+187,	0,		0,	
yycrank+0,	yysvec+45,	0,	
yycrank+204,	0,		0,	
yycrank+0,	yysvec+106,	0,	
yycrank+205,	0,		0,	
yycrank+0,	yysvec+59,	0,	
yycrank+0,	yysvec+42,	0,	
yycrank+0,	yysvec+80,	0,	
0,	0,	0};
struct yywork *yytop = yycrank+392;
struct yysvf *yybgin = yysvec+1;
char yymatch[] = {
  0,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,  10,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
 48,  48,  48,  48,  48,  48,  48,  48, 
 48,  48,   1,   1,   1,   1,   1,   1, 
  1,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,   1,   1,   1,   1,   1, 
  1,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,  65,  65,  65,  65,  65, 
 65,  65,  65,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
0};
char yyextra[] = {
0,1,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0};
/*	Copyright (c) 1989 AT&T	*/
/*	  All Rights Reserved  	*/

/*	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T	*/
/*	The copyright notice above does not evidence any   	*/
/*	actual or intended publication of such source code.	*/

#pragma ident	"@(#)ncform	6.12	97/12/08 SMI"

int yylineno =1;
# define YYU(x) x
# define NLSTATE yyprevious=YYNEWLINE
struct yysvf *yylstate [YYLMAX], **yylsp, **yyolsp;
char yysbuf[YYLMAX];
char *yysptr = yysbuf;
int *yyfnd;
extern struct yysvf *yyestate;
int yyprevious = YYNEWLINE;
#if defined(__cplusplus) || defined(__STDC__)
int yylook(void)
#else
yylook()
#endif
{
	register struct yysvf *yystate, **lsp;
	register struct yywork *yyt;
	struct yysvf *yyz;
	int yych, yyfirst;
	struct yywork *yyr;
# ifdef LEXDEBUG
	int debug;
# endif
	char *yylastch;
	/* start off machines */
# ifdef LEXDEBUG
	debug = 0;
# endif
	yyfirst=1;
	if (!yymorfg)
		yylastch = yytext;
	else {
		yymorfg=0;
		yylastch = yytext+yyleng;
		}
	for(;;){
		lsp = yylstate;
		yyestate = yystate = yybgin;
		if (yyprevious==YYNEWLINE) yystate++;
		for (;;){
# ifdef LEXDEBUG
			if(debug)fprintf(yyout,"state %d\n",yystate-yysvec-1);
# endif
			yyt = yystate->yystoff;
			if(yyt == yycrank && !yyfirst){  /* may not be any transitions */
				yyz = yystate->yyother;
				if(yyz == 0)break;
				if(yyz->yystoff == yycrank)break;
				}
#ifndef __cplusplus
			*yylastch++ = yych = input();
#else
			*yylastch++ = yych = lex_input();
#endif
#ifdef YYISARRAY
			if(yylastch > &yytext[YYLMAX]) {
				fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
				exit(1);
			}
#else
			if (yylastch >= &yytext[ yytextsz ]) {
				int	x = yylastch - yytext;

				yytextsz += YYTEXTSZINC;
				if (yytext == yy_tbuf) {
				    yytext = (char *) malloc(yytextsz);
				    memcpy(yytext, yy_tbuf, sizeof (yy_tbuf));
				}
				else
				    yytext = (char *) realloc(yytext, yytextsz);
				if (!yytext) {
				    fprintf(yyout,
					"Cannot realloc yytext\n");
				    exit(1);
				}
				yylastch = yytext + x;
			}
#endif
			yyfirst=0;
		tryagain:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"char ");
				allprint(yych);
				putchar('\n');
				}
# endif
			yyr = yyt;
			if ( (uintptr_t)yyt > (uintptr_t)yycrank){
				yyt = yyr + yych;
				if (yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				}
# ifdef YYOPTIM
			else if((uintptr_t)yyt < (uintptr_t)yycrank) {	/* r < yycrank */
				yyt = yyr = yycrank+(yycrank-yyt);
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"compressed state\n");
# endif
				yyt = yyt + yych;
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				yyt = yyr + YYU(yymatch[yych]);
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"try fall back character ");
					allprint(YYU(yymatch[yych]));
					putchar('\n');
					}
# endif
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transition */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					if(lsp > &yylstate[YYLMAX]) {
						fprintf(yyout,"Input string too long, limit %d\n",YYLMAX);
						exit(1);
					}
					goto contin;
					}
				}
			if ((yystate = yystate->yyother) && (yyt= yystate->yystoff) != yycrank){
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"fall back to state %d\n",yystate-yysvec-1);
# endif
				goto tryagain;
				}
# endif
			else
				{unput(*--yylastch);break;}
		contin:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"state %d char ",yystate-yysvec-1);
				allprint(yych);
				putchar('\n');
				}
# endif
			;
			}
# ifdef LEXDEBUG
		if(debug){
			fprintf(yyout,"stopped at %d with ",*(lsp-1)-yysvec-1);
			allprint(yych);
			putchar('\n');
			}
# endif
		while (lsp-- > yylstate){
			*yylastch-- = 0;
			if (*lsp != 0 && (yyfnd= (*lsp)->yystops) && *yyfnd > 0){
				yyolsp = lsp;
				if(yyextra[*yyfnd]){		/* must backup */
					while(yyback((*lsp)->yystops,-*yyfnd) != 1 && lsp > yylstate){
						lsp--;
						unput(*yylastch--);
						}
					}
				yyprevious = YYU(*yylastch);
				yylsp = lsp;
				yyleng = yylastch-yytext+1;
				yytext[yyleng] = 0;
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"\nmatch ");
					sprint(yytext);
					fprintf(yyout," action %d\n",*yyfnd);
					}
# endif
				return(*yyfnd++);
				}
			unput(*yylastch);
			}
		if (yytext[0] == 0  /* && feof(yyin) */)
			{
			yysptr=yysbuf;
			return(0);
			}
#ifndef __cplusplus
		yyprevious = yytext[0] = input();
		if (yyprevious>0)
			output(yyprevious);
#else
		yyprevious = yytext[0] = lex_input();
		if (yyprevious>0)
			lex_output(yyprevious);
#endif
		yylastch=yytext;
# ifdef LEXDEBUG
		if(debug)putchar('\n');
# endif
		}
	}
#if defined(__cplusplus) || defined(__STDC__)
int yyback(int *p, int m)
#else
yyback(p, m)
	int *p;
#endif
{
	if (p==0) return(0);
	while (*p) {
		if (*p++ == m)
			return(1);
	}
	return(0);
}
	/* the following are only used in the lex library */
#if defined(__cplusplus) || defined(__STDC__)
int yyinput(void)
#else
yyinput()
#endif
{
#ifndef __cplusplus
	return(input());
#else
	return(lex_input());
#endif
	}
#if defined(__cplusplus) || defined(__STDC__)
void yyoutput(int c)
#else
yyoutput(c)
  int c; 
#endif
{
#ifndef __cplusplus
	output(c);
#else
	lex_output(c);
#endif
	}
#if defined(__cplusplus) || defined(__STDC__)
void yyunput(int c)
#else
yyunput(c)
   int c; 
#endif
{
	unput(c);
	}
