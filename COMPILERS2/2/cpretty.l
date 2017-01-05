%{
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

%}

DelimitedBackslash ("\\\\")		
Delimited "\\"([A-Za-z]|"\"")		
Reserved ("auto"|"break"|"case"|"char"|"continue"|"default"|"do"|"double"|"else"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"while")
MultiLineCommentBegin  "/*"			
MultiLineCommentEnd "*/"
LineComment "//"
String "\""
QuoteLiteral "'\\''"
Literal ("'")
Number [0-9]+

%p 10000
%a 10000

%%

{Reserved}/[^a-zA-Z]		{	/*Detect reserved word not a beginning of another word(such as char, not putchar)*/
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

{MultiLineCommentBegin}  		{		/*Detect pattern beginning of traditional C comment section*/
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

{MultiLineCommentEnd}  		{		/*Detect pattern ending traditional C comment section*/
								printf("%s",yytext);								//Print token
								strcat(previoustoken, yytext);						//Add to previous token
								inmcomment = 0;										//Indicate out of comment section
								CurrentType = 7;									//Indicate we have just finished a section
								justdelimited = 0;									//Indicate last token was not backslash
							}

{LineComment}	  		{
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

{String}		  		{		/*Detected ditto*/
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

{QuoteLiteral}		{		/*Found literal containing other quote, special case that is tricky to handle otherwise*/
						printf("\\fI%s", yytext);									//Issue groff command
						CurrentType = 7;											//Set type to done
						justdelimited = 0;
					}

{Literal}			{		/*Found quote indicating character literal section*/
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

{Number}			{	/*Found any number of consecutive digits*/
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

{DelimitedBackslash}	{	/*Two consecutive backslashes, can trip up lexer*/
							printf("%s",yytext);									//Print token
							justdelimited = 1;										//Indicate lexer last token was delimiter
						}


{Delimited}			{	/*Detected pattern of delimited character such as newline*/

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

.					{	/*Detected any default character not matching other patterns*/
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
%%

