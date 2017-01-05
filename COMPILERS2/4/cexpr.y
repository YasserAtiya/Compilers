
%{
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
%}

%union  {
  int num;
  char alpha;
  }

%token <num> NUM

%token <alpha> ALPHA

%token <dump> DUMP

%token <clear> CLEAR

%token <num> PLSE

%token <num> MINE

%token <num> TIME

%token <num> DIVE

%token <num> MODE

%token <num> LSHE

%token <num> RSHE

%token <num> ANDE

%token <num> XORE

%token <num> ORE

%token <num> RSHF

%token <num> LSHF


%type <num> expr


%type <num> level10

%type <num> level9

%type <num> level8

%type <num> level7

%type <num> level6

%type <num> level5

%type <num> level4

%type <num> level3

%type <num> level2

%type <num> level1

%type <num> value

%type <num> command

%%

commands:
  | commands command    { 
                            //Prints result of command if no exception met 
                            if(print && $2 < INT_MAX)
                               printf("%d", $2);
                            else if($2 > INT_MAX && print)
                               printf("overflow");
                            
                            //Reset printing flag
                            print = 1;
                        }
  ;

command : expr ';'      {$$ = $1;}
  | DUMP           {
                      //Loop and print all variables
                      i = 0; 
                      for(i = 0; i<25; i++)
                      { 
                         printf("%c: %d\n", (i+97),arr[i]);
                      }
                       printf("%c: %d", (i+97),arr[i]);

                       //Set flag
                       print = 0;
                    }

  | CLEAR           {
                        //Reset all variables to 0
                        i =0; 
                        for(i = 0; i<26; i++)
                        { 
                            arr[i] = 0;
                        }

                        //Set flag
                        print = 0;
                    }
  | ALPHA level10 command  { 
                            //Switch case for assignment operator
                            switch($2)
                            {
                              //based on operator number
                              case 0:
                                  //Detect overflow, and assign if necessary
                                  if($3 < INT_MAX && assign)
                                     $$ = arr[$1-97] = $3;
                                  //Print error message
                                  else
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 1:
                                  if($3+arr[$1-97] < INT_MAX && assign)
                                    $$ = arr[$1-97] += $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 2:
                                  if(arr[$1-97]-$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] -= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 3:
                                  if(arr[$1-97]*$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] *= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              //Detect and print incase of divide by zero
                              case 4:
                                  if($3 == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                     }
                                  else if(arr[$1-97]/$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  else
                                    {
                                      if(assign)
                                        $$ = arr[$1-97] /= $3;
                                    }

                                  break;
                              case 5:
                                  if($3 == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                     }
                                  else if(arr[$1-97]%$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }

                                  else
                                    {
                                      if(assign)
                                          $$ = arr[$1-97] %= $3;
                                    }
                                  break;
                              case 6:
                                  if(arr[$1-97]<<$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] <<= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 7:
                                  if(arr[$1-97]>>$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] >>= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 8:
                                  if(arr[$1-97]&$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] &= $3;
                                   else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 9:
                                  if(arr[$1-97]^$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] ^= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;
                              case 10:
                                  if(arr[$1-97]|$3 < INT_MAX && assign)
                                    $$ = arr[$1-97] |= $3;
                                  else if (arr[$1-97]|$3 > INT_MAX)
                                     {
                                       printf("overflow");
                                       print = 0;
                                     }
                                  break;

                            }
                        }
  ;


expr  : value       {
                        if(gotvar)
                        {
                          $$ = arr[$1-97];
                          gotvar = 0;
                        }   
                        else
                          $$ = $1;
                    }
  | expr level9 expr   {
                            switch($2)
                          {
                              case 1:
                                  $$ = $1 | $3;
                                  break;
                              case 2:
                                  $$ = $1 ^ $3;
                                  break;
                              case 3:
                                  $$ = $1 & $3;
                                  break;
                              case 4:
                                  $$ = $1 << $3;
                                  break;
                              case 5:
                                  $$ = $1 >> $3;
                                  break;
                              case 6:
                                  $$ = $1 + $3;
                                  break;
                              case 7:
                                  $$ = result;
                                  break;
                              case 8:
                                  $$ = $1 * $3;
                                  break;
                              case 9:
                                  if($3 == 0)
                                     {
                                       printf("dividebyzero");
                                       print = 0;
                                       assign = 0;
                                     }
                                  else
                                    $$ = $1 / $3;
                                  break;
                              case 10:
                                  $$ = $1 % $3;
                                  break;
                            }

                  } 
 | level9 {if($1 == 7)
              $$ = result;
           else
              $$=$1;}
 ;

level10 : '='     {$$ = 0;}
  | PLSE          {$$ = 1;}
  | MINE          {$$ = 2;}
  | TIME          {$$ = 3;}
  | DIVE          {$$ = 4;}
  | MODE          {$$ = 5;}
  | LSHE          {$$ = 6;}
  | RSHE          {$$ = 7;}
  | ANDE          {$$ = 8;}
  | XORE          {$$ = 9;}
  | ORE           {$$ = 10;}
  ;


level9 : '|'      {$$ = 1;}
  | level8        {$$ = $1;}
  ;

level8 :  '^'     {$$ = 2; } 
  | level7        {$$ = $1;}
  ;

level7 :  '&'     {$$ = 3;}
  | level6        {$$ = $1;}
  ;

level6 :  LSHF    {$$ = 4; }
  | RSHF          {$$ = 5;}
  | level5        {$$ = $1;}
  ;

level5 :  '+'      {$$ = 6;}
  | expr '-' expr  {$$ = 7; result=$1 - $3;}
  | level4         {$$ = $1;}
  ;

level4 :  '*'    { $$ = 8; }
  | '/'          { $$ = 9; }
  | '%'          { $$ = 10; }
  | level3        {$$ = $1;}
  ;

level3 : '-' level1  {
                        $$ = -$2;
                     }
  | '-' value       {$$ = -$2;}
  | level2         {$$ = $1;}
  ;

level2 : '~' level1  {
                        $$ = ~$2;
                     }
  | '~' value       {$$ = ~$2;} 
  | level1         {$$ = $1;}
  ;

level1 :  '(' expr ')' {$$ = $2;}
  ;

value : NUM      {$$ = $1;}
  | ALPHA    {$$ = $1; gotvar = 1;}
  ;

%%


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
