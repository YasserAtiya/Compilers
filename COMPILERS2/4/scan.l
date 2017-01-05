%{
#include "y.tab.h"
%}

DUMP  "dump"
CLEAR "clear"
%%
[0-9]+		{ 
            //Pick up digits, return flag for number
            sscanf(yytext, "%d", &yylval.num);
      		  return NUM; 
          }

{DUMP}";"       {
                    //Return token indicating dump
                    return DUMP;
                }

{CLEAR}";"      {
                  //Return token indicating clear
                  return CLEAR;
                }

[a-z]           { 
                  //Pick up1and return single lowercase letters
                  sscanf(yytext, "%c", &yylval.alpha);
                  return ALPHA; 
                }

"+="            return PLSE;

"-="            return MINE;

"*="            return TIME;

"/="            return DIVE;

"%="            return MODE;

"<<="           return LSHE;

">>="           return RSHE;

"&="            return ANDE;

"^="            return XORE;

"|="            return ORE;

"<<"            return LSHF;

">>"            return RSHF;

" "		          {}

.		{ return yytext[0]; }
