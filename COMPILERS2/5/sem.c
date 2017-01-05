//Yasser Atiya
//Assignment 5
//3/24/2016
//It compiles!

# include <stdlib.h>
# include <stdio.h>
# include "cc.h"
# include "semutil.h"
# include "sem.h"
# include "sym.h"

#define MAXLOCS 50
#define MAXARGS 50

extern char formaltypes[MAXARGS];
extern char localtypes[MAXLOCS];
extern int localwidths[MAXLOCS];
extern struct sem_rec **top;
extern int ntmp;
extern int formalnum;
extern int localnum;
extern int level;

/*
 * backpatch - backpatch list of triples starting at p with k
 */
void backpatch(struct sem_rec *p, int k)
{
   

   //Define and initialize iterator
   struct sem_rec* smrc = p;

   //Iterate through list
   while(smrc != ((struct sem_rec *) NULL))
   {
/*
            if(smrc)
      
      if(smrc->back.s_link)
            else
      */

      //Print triple
      if(smrc->s_place != 0)
      printf("%d.\tB%d=L%d\n",nexttrip(),smrc->s_place,k);

      //Move to next link
      smrc = smrc->back.s_link;
   }

   
}

/*
 * call - procedure invocation
 */
struct sem_rec *call(char *f, struct sem_rec *args)
{
   
   //Define and initialize iterator
   struct sem_rec* link = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Initialize semantic record to return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   struct id_entry* ide = lookup(f,0);
   if(!ide){
      ide = install(f,0);
   }

   ide = install(f,level);

//   smrc->s_mode = ide->i_type;
   ide->i_type = smrc->s_mode;

   smrc->s_mode = T_PROC;
   
   //Array for holding arguments
   struct sem_rec* arr[MAXARGS] = {0};

   //Ints for counting for loops
   int i,j,count = 0;

   //Check if we have no parameters
   if(args == ((struct sem_rec *) NULL))
   {
      //Print triple
      printf("%d.\tglobal %s\n",nexttrip(),f);
   }
   //Have parameters
   else
   {
      //Initialize iterator to end of list
      link = args;

      //Iterate backwards through array and add arguments to it
      for(i = MAXARGS-1; i >= 0; i--)
      {

         //If We have another link
         if(link != ((struct sem_rec *) NULL))
            {

               //Add link to arg to array
               arr[i] = link;

               //Iterate to next link
               link = link->back.s_link;   
            
            }
      
      }

      //Iterate through array forwards and print contents
      for(j = 0; j < MAXARGS; j++)
      {

         //Increment Iterator
         link = arr[j];

         //If we have valid chain , move to it
         if(link != ((struct sem_rec *) NULL))
         {
            //Increase argument count
            count++;

            //Print triple
            printf("%d.\targ",nexttrip());

            //Check type of argument, then print it
            if(link->s_mode == 4)
               printf("%c ",'f');
            else
               printf("%c ",'i');

            printf("%d\n", link->s_place);
         }
      }

      //Print triple for function name
      printf("%d.\tglobal %s\n",nexttrip(),f);

      //Print call triple
      printf("%d.\tf%c %d %d\n",nexttrip(),'i',ntmp-1,count);

   }

   smrc = node(currtrip(), T_PROC, args, (struct sem_rec*)NULL);

   
   return smrc;   
}

/*
 * ccand - logical and
 */
struct sem_rec *ccand(struct sem_rec *e1, int m, struct sem_rec *e2)
{
      

   //Initialize semantic record to return
   struct sem_rec* smrc = node(currtrip(),4,((struct sem_rec *) NULL),
      merge(e1->s_false,e2->s_false));
   smrc->back.s_true = e2->back.s_true;

   //Backpatch link
   if(e1 != (struct sem_rec*) NULL)
      backpatch(e1->back.s_true,m);      


   

   //Return newest statement
   return smrc;
}

/*
 * ccexpr - convert arithmetic expression to logical expression
 */
struct sem_rec *ccexpr(struct sem_rec *e)
{
   
   //Initialize new semantic record and define it
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));
   smrc->s_place = currtrip();
   smrc->s_mode = T_INT;

   
   //Make sure result is not 0
   return rel("!=", e, smrc);
}

/*
 * ccnot - logical not
 */
struct sem_rec *ccnot(struct sem_rec *e)
{
   
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   if(e !=(struct sem_rec *) NULL)
   {
      smrc = node(e->s_place,e->s_mode,e->back.s_link,e->back.s_true);
      smrc->back.s_true = e->s_false;
   }
   else
      return (struct sem_rec*) NULL;

      
   return smrc;
}

/*
 * ccor - logical or
 */
struct sem_rec *ccor(struct sem_rec *e1, int m, struct sem_rec *e2)
{
   
      //Backpatch link
   if(e1 != (struct sem_rec*) NULL)
      backpatch(e1->s_false,m);      


   //Initialize semantic record to return
   struct sem_rec* smrc = node(currtrip(),4,
      ((struct sem_rec *) NULL),e2->s_false);
   smrc->back.s_true = merge(e2->back.s_true,e1->back.s_true);

   

   //Return newest statement
   return smrc;

}

/*
 * con - constant reference in an expression
 */
struct sem_rec *con(char *x)
{
      

   //Create and define constant semantic record
   struct sem_rec* smrc =   
   node(nexttrip(),T_INT,
      ((struct sem_rec *) NULL),((struct sem_rec *) NULL));

   //Null string
   if(x == NULL)
   {
            return ((struct sem_rec *) NULL);
   }

   //Print triple
   printf("%d.\tcon %s\n", currtrip(), x);

   
   //Return semantic record
   return smrc;
}

/*
 * dobreak - break statement
 */
struct sem_rec *dobreak()
{
   
   //Initialize semantic record to return
   struct sem_rec* smrc = n();
   
   return smrc;
}

/*  * docontinue - continue statement  */ 
struct sem_rec *docontinue() {

   //Initialize semantic record to return
   struct sem_rec* smrc = n();   
   return smrc;
}

/*
 * dodo - do statement
 * m1 - top of loop
 * s - Contents
 * m2 - triple before condition
 * e - conditional expression
 */
struct sem_rec *dodo(int m1, struct sem_rec *s, int m2, struct sem_rec *e)
{
      
   //Initialize semantic record to return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //If conditional expression is not null, backpatch it 
   if(e && e->back.s_true != (struct sem_rec *) NULL)
      backpatch(e->back.s_true,m1);

   //Define record
   smrc->s_place = nexttrip();
   smrc->s_mode = T_LBL;
   if(e && s && e->back.s_true && s->back.s_true)
      smrc->back.s_true = merge(e->back.s_true,s->back.s_true);
   if(e && s && e->s_false && s->s_false)
      smrc->s_false = merge(e->s_false,smrc->s_false);
   
   //Save record
   save_rec(smrc);

   
   n();

   //Return record
   return smrc;
}

/*
 * dofor - for statement
 * m1 - first label(before exit condition)
 * e2 - for exit condition
 * m2 - 2nd label(before increment
 * n - from n, the unconditional jump 
 * s - statements in loop
 */
struct sem_rec *dofor(int m1, struct sem_rec *e2, int m2, struct sem_rec *n,
                      int m3, struct sem_rec *s)
{
   
   //Create semantic record
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Backpatch semantic records if they are not null
   if(e2 && e2->back.s_true != (struct sem_rec *) NULL)
      backpatch(e2->back.s_true,m3);
   if(n != (struct sem_rec *) NULL)
      backpatch(n,m1);

   //Print triple
   printf("%d.\tbr L%d\n",nexttrip(), m2);

   //Populate semantic record
   smrc->s_mode = T_LBL;
   smrc->s_place = currtrip();
   smrc->s_false = e2->s_false;
   
   //Return record
   return smrc;
}

/*
 * dogoto - goto statement
 */
struct sem_rec *dogoto(char *id)
{
      
   //Initialize semantic record we will return
   struct sem_rec* smrc = n();

   struct id_entry* ide = lookup(id,0);


   
   return smrc;
}

/*
 * doif - one-arm if statement
 * e is cexpr, m is triple number that follows, s is statement
 */
struct sem_rec *doif(struct sem_rec *e, int m, struct sem_rec *s)
{
   
   //Initialize semantic record we will return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Define semantic record

      if(e && s && e->s_false && s->back.s_link)
   //Define backpatching link
   smrc->s_false = merge(e->s_false,s->back.s_link);
   else if(e && e->s_false)
      smrc->s_false = e->s_false;
   else if(s && s->back.s_link)
      smrc->s_false = s->back.s_link;


      //Define attributes
   smrc->s_place = m;
   smrc->s_mode = T_LBL;

      //Backpatch truelist
   backpatch(e->back.s_true,m);

      if(e && s && e->s_false && s->back.s_link)
      s->back.s_link = e->s_false;

   //Save record
   save_rec(smrc);

   
   //Return record
   return smrc;
}

/*
 * doifelse - if then else statement
 */
struct sem_rec *doifelse(struct sem_rec *e, int m1, struct sem_rec *s1,
                         struct sem_rec *n, int m2, struct sem_rec *s2)
{
      

   //Initialize semantic record we will return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   

   //Define semantic record

   if(s2)
      if(s1)
         smrc->back.s_link = merge(s2->back.s_link,s1->back.s_link);
   else
      if(s1)
         smrc->back.s_link = s1->back.s_link;

   
   //Define attributes
   smrc->s_place = currtrip();
   smrc->s_mode = T_PROC;

   //Update truelist triple number


   //Backpatch 
   backpatch(e->back.s_true,m1);

   //Backpatch else
   backpatch(e->s_false, m2);

   //Save record
   smrc = node(smrc->s_place,smrc->s_mode,
      merge(smrc->back.s_link,n->back.s_link),smrc->s_false);

   

   //Return record
   return smrc;
}

/*
 * doret - return statement
 */
struct sem_rec *doret(struct sem_rec *e)
{
   

   //char representing type presentation
   char c;

   //Determine type presentation
   if(e->s_mode == 4)
      c = 'f';
   else
      c = 'i';

   

   //Initialize semantic record
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));


   //Print record
   printf("%d.\tret%c %d\n", nexttrip(), c, e->s_place);
   
   //Update semantic record
   smrc->s_place = currtrip();
   smrc->s_mode = e->s_mode;

   //Save record
   save_rec(smrc);

   

   //Return record
   return smrc;
}

/*
 * dostmts - statement list
 */
struct sem_rec *dostmts(struct sem_rec *sl, int m, struct sem_rec *s)
{
   

   //Initialize semantic record to return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));


   //If statement list is not null
   if(sl != (struct sem_rec *) NULL)
   {

      //Assign link to statement lis for iteration
      smrc = sl;

      //Set statement list link as next statement
      smrc->back.s_link = s;

   }
   //Otherwise, create new statement list
   else
   {

      //Make statemtent list new statement
      sl = s;

   }

   //Backpatch link
   backpatch(smrc->s_false,m);

   
   //Return newest statement
   return s;

}

/*
 * dowhile - while statement
 */
struct sem_rec *dowhile(int m1, struct sem_rec *e, int m2, struct sem_rec *s)
{
      
   //Initialize semantic record to return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //If conditional expression is not null, backpatch it 
   if(e && e->back.s_true != (struct sem_rec *) NULL)
      backpatch(e->back.s_true,m2);

   if(e && e->back.s_link != (struct sem_rec *) NULL)
      backpatch(e->back.s_link,m1);

   //Define record
   smrc->s_place = nexttrip();
   smrc->s_mode = T_LBL;
   if(e && s)
      smrc->back.s_true = merge(e->back.s_true,s->back.s_true);
   if(e && smrc->s_false)
      smrc->s_false = merge(e->s_false,smrc->s_false);
   
   //Save record
   smrc  = node(smrc->s_place,smrc->s_mode,smrc->back.s_link,smrc->s_false);

   //Print triple
   printf("%d.\tbr L%d\n",smrc->s_place,m2);

   
   //Return record
   return smrc;
}

/*
 * endloopscope - end the scope for a loop
 */
void endloopscope(struct sem_rec *p)
{
      
   leaveblock();
}

/*
 * exprs - form a list of expressions
 */
struct sem_rec *exprs(struct sem_rec *l, struct sem_rec *e)
{

   
   //Create list
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Populate list 
   if(e == (struct sem_rec *) NULL)
   {
            return ((struct sem_rec *) NULL);
   }

   //Link list to newest expression
   e->back.s_link = l;

   
   //Return new expression definition
   return e;
   

}

/*
 * fhead - beginning of function body
 */
struct id_entry *fhead(struct id_entry *p)
{
   
   //Int for count
   int i = 0;

   //Error/Trace printing   
   

   //Indicate id is defined
   p->i_defined = 1;

   //Get and print arguments
   for(i = 0; i < formalnum; i++)
   {

      //Print triple
      printf("%d.\tformal ",nexttrip());
      
      //Determine type
      if(formaltypes[i] == 105)
         printf("%d\n",tsize(T_INT));
      else if(formaltypes[i] == 102)
         printf("%d\n",tsize(T_DOUBLE));
   
   }

   //Get and print variables
   for(i = 0; i < localnum; i++)
   {
      
      //Print triple
      printf("%d.\tlocalloc ", nexttrip());

      //Determine type
      if(localtypes[i] == 105)
         printf("%d\n",tsize(T_INT)*localwidths[i]);
      else if(localtypes[i] == 102)
         printf("%d\n",tsize(T_DOUBLE)*localwidths[i]);
   
   }

   
   //Return mdified entry
   return p;

}

/*
 * fname - function declaration
 * Passed in type, name of function
 */
struct id_entry *fname(int t, char *id)
{
   //Error/Trace printing   
      

   //Add to id table
   struct id_entry* ide = install(id, level);

   //Populate id entry for function name
   ide->i_name = id;
   ide->i_type = t;
   ide->i_blevel = level;
   ide->i_scope = GLOBAL;
   ide->i_defined = 0;


   //Increment scope
   enterblock();

   //Print label using supplied number and id
   printf("%d.\tfunc %s\n", nexttrip(), id);

      //return entry
   return ide;

}

/*
 * ftail - end of function body
 */
struct sem_rec *ftail(struct id_entry *p, struct sem_rec *s, int m)
{

   //Print error
   
   //Indicate end of function
   printf("%d.\tfend\n",nexttrip());

   //If there are no statements
   if(s == (struct sem_rec *) NULL)
      return ((struct sem_rec *) NULL);

   //Create return value record
   struct sem_rec* smrc = node(m,T_INT,s,(struct sem_rec *) NULL);

   //Decrement block level
   leaveblock();

   //Save record
   save_rec(smrc);  

   
   //Return record
   return smrc;

}

/*
 * id - variable reference
 */
struct sem_rec *id(char *x)
{

   
   //Create record for return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));
 
   //Search id entries for x
   struct id_entry* entry = lookup(x,0);

   //If entry is not found, make one
   if(entry == (struct id_entry*) NULL)
   {
         entry = install(x,0);
   }

   //Set record type to entry type
   smrc->s_mode = entry->i_type;

   //Print variable reference triple
   if(entry->i_blevel == 4)
      printf("%d.\tlocal %d\n", nexttrip(), entry->i_offset);
   else if(entry->i_blevel == 3)
      printf("%d.\tparam %d\n", nexttrip(), entry->i_offset);
   else
      printf("%d.\tglobal %s\n", nexttrip(), x);

   //Set record triple number
   smrc->s_place = currtrip();


   //Save semantic Record
   smrc = node(smrc->s_place,smrc->s_mode,NULL,smrc->s_false);

   
   //Return record
   return smrc;

}

/*
 * index - subscript
 */
struct sem_rec *index(struct sem_rec *x, struct sem_rec *i)
{
   
   //Create record to return
   struct sem_rec* smrc = (struct sem_rec*) alloc(sizeof(struct sem_rec));

   //Character indicating type
   char c;

   //Decide type
   if(x->s_mode == 0)
      smrc->s_mode = T_INT;
   else
      smrc->s_mode = T_DOUBLE;

   //Choose character to print based on type
  if(smrc->s_mode == 4)
      c = 'f';
   else
      c = 'i';

   //Print triple
   printf("%d.\t[]%c %d %d\n",nexttrip(), c, x->s_place,i->s_place);

   //Define record triple number
   smrc->s_place = currtrip();

   //Save record
   save_rec(smrc);   

   
   //Return record
   return smrc;
}

/*
 * labeldcl - process a label declaration
 */
void labeldcl(char *id)
{
   
   m();

   struct id_entry* ide = install(id,0);

   ide->i_type = T_LBL;

}

/*
 * m - generate label and return next triple number
 */
int m()
{

      
   //Create semantic record for label
   struct sem_rec* smrc = (struct sem_rec*) alloc(sizeof(struct sem_rec));
   
   //Define record
   smrc->s_mode = T_LBL;
   smrc->s_place = ntmp;
   
   //Save record
   save_rec(smrc);

   //Print triple
   printf("\tlabel L%d\n", currtrip());
   
   
   //Return following triple
   return (currtrip());

}

/*
 * n - generate goto and return backpatch pointer
 */
struct sem_rec *n()
{
   
   
   //Create record to return
   struct sem_rec* smrc = (struct sem_rec*) alloc(sizeof(struct sem_rec));

   //Print triple number
   printf("%d.\tbr B%d\n",nexttrip(), currtrip());

   //Define record
   smrc->s_place = currtrip();
   smrc->s_mode = T_PROC;
   save_rec(smrc);

   
   //Return record
   return smrc;
}

/*
 * op1 - unary operators
 */
struct sem_rec *op1(char *op, struct sem_rec *x)
{
   
   
   //Create record to return
   struct sem_rec* smrc = (struct sem_rec*) alloc(sizeof(struct sem_rec));
   
   //Char indicating type
   char c;

   //Type definitions
   if(x->s_mode == T_DOUBLE)
   {
      c = 'f';
   } 
   else
      c = 'i';

   //if x is not null
   if(x != (struct sem_rec*) NULL)
   {

      //Based on what switch is print it, its type, and triple
      switch(*op)
      {
         case '~':
            printf("%d.\t~", nexttrip());

            printf("%c ", c);   

            //Print triple number
            printf("%d\n",x->s_place);
          
            break;

         case '-':
            printf("%d.\t-", nexttrip());

            printf("%c ", c);   

            //Print triple number
            printf("%d\n",x->s_place);
          
            break;

         case '@':
            printf("%d.\t@", nexttrip());

            printf("%c ", c);   

            //Print triple number
            printf("%d\n",x->s_place);
          
            break;
      }

      //Define record
      smrc->s_place = currtrip();
      smrc->s_mode = x->s_mode;   
   
   }
   else
      //Return null
      return ((struct sem_rec *) NULL);

      
   save_rec(smrc);

   //Return record
   return smrc;
}

/*
 * op2 - arithmetic operators
 */
struct sem_rec *op2(char *op, struct sem_rec *x, struct sem_rec *y)
{
   
      char c;


   //Create record to return
   struct sem_rec* smrc = node(currtrip(),1,
   ((struct sem_rec *) NULL),((struct sem_rec *) NULL));


   //If either argument is null, abort
   if(x == (struct sem_rec *) NULL || y == (struct sem_rec *) NULL)
      return ((struct sem_rec *) NULL);   

   //Determine type
   if(x->s_mode == 0 && y->s_mode == 0)
   {
      c = 'i';
      smrc->s_mode = 1;
   }
   else
   {
     c = 'f';
      smrc->s_mode = 3;
   }

   //Print triple
   printf("%d.\t%s%c %d %d\n", nexttrip(), op, c, 
      x->s_place, y->s_place);

   smrc = node(currtrip(),smrc->s_mode,((struct sem_rec *) NULL),
      ((struct sem_rec *) NULL));

   
   //Return record
   return smrc;
}

/*
 * opb - bitwise operators
 */
struct sem_rec *opb(char *op, struct sem_rec *x, struct sem_rec *y)
{
      char c;

   //Create record to return
   struct sem_rec* smrc = node(currtrip(),T_INT,
      ((struct sem_rec *) NULL),((struct sem_rec *) NULL));


   //If either argument is null, abort
   if(x == (struct sem_rec *) NULL || y == (struct sem_rec *) NULL)
      return ((struct sem_rec *) NULL);   

   //Determine type
   if(x->s_mode == 0 && y->s_mode == 0)
   {
      c = 'i';
      smrc->s_mode = 1;
   }
   else
   {
     c = 'f';
      smrc->s_mode = 3;
   }

   //Print triple
   printf("%d.\t%s%c %d %d\n", nexttrip(), op, c, 
      x->s_place, y->s_place);

   
   //Return record
   return smrc;
}

/*
 * rel - relational operators
 */
struct sem_rec *rel(char *op, struct sem_rec *x, struct sem_rec *y)
{

   
   char c;

   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));
   struct sem_rec* tru = (struct sem_rec*)alloc(sizeof(struct sem_rec));
   struct sem_rec* fals = (struct sem_rec*)alloc(sizeof(struct sem_rec));


   //Change for type coersion
   if(x->s_mode == 4 || y->s_mode == 4)
   {
      smrc->s_mode = T_DOUBLE;
      c = 'f';
   }
   else 
   {
      smrc->s_mode = T_INT;
      c = 'i';
   }

   if((x->s_mode != 4 && y->s_mode == 4)){
         printf("%d.\tcv%c %d\n",nexttrip(),'f',x->s_place);
         x->s_place++;
      }
   else if((x->s_mode == 4 && y->s_mode != 4)){
         printf("%d.\tcv%c %d\n",nexttrip(),'f',y->s_place);
         y->s_place++;
      }

   printf("%d.\t%s%c %d %d\n",nexttrip(),op,c,x->s_place,y->s_place);

   printf("%d.\tbt %d B%d\n",nexttrip(),currtrip()-1, currtrip());


   tru->s_place = currtrip();

   
  smrc = n();

   smrc->back.s_true = tru;
   smrc->s_false = fals;
   fals->s_place = currtrip();
   save_rec(smrc);
   save_rec(fals);
   save_rec(tru);


   
   return smrc;
}

/*
 * set - assignment operators
 */
struct sem_rec *set(char *op, struct sem_rec *x, struct sem_rec *y)
{

      
   //Char indicating type
   char c;

   //Initialize record for return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Initialize x replacement
   struct sem_rec* x2 = x;

   //If operation is anything other than normal =
   if(*op != NULL)
   {

      //Dereference rhs
      x2 = op1("@",x); 

      //Print triple for binary operator     
      if(x2->s_mode == T_INT && y->s_mode == T_INT)
         printf("%d.\t%si %d %d\n", 
            nexttrip(), op, currtrip()-1, currtrip()-2);
      else
         printf("%d.\t%sf %d %d\n", 
            nexttrip(), op, currtrip()-1, currtrip()-2);

   }

   //If either argument is null, return
   if(x == (struct sem_rec *) NULL || y == (struct sem_rec *) NULL)
   {
                  return ((struct sem_rec *) NULL);
   }
   //Type determination
   if(x->s_mode == T_INT && y->s_mode == T_INT)
   {
      c = 'i';
   }
   else
   {
      c = 'f';
   }

   //Print triple
   printf("%d.\t=%c %d %d\n",nexttrip(),c,x->s_place, currtrip()-1);

   //Define triple
   smrc->s_place = currtrip();
 
   //Save record
   save_rec(smrc);

   
   //Return record
   return smrc;
}

/*
 * startloopscope - start the scope for a loop
 */
void startloopscope()
{
         enterblock();
}

/*
 * string - generate code for a string
 */
struct sem_rec *string(char *s)
{

   
   //Print triple
   printf("%d.\tstr %s\n", nexttrip(), s);

   //Create record to return
   struct sem_rec* smrc = (struct sem_rec*)alloc(sizeof(struct sem_rec));

   //Populate string semantic record
   smrc->s_place = currtrip();
   smrc->s_mode = T_STR;

   //Save record
   smrc = node(smrc->s_place,smrc->s_mode,(struct sem_rec*) NULL,
      (struct sem_rec*) NULL);

   
   //Return record
   return smrc;

}
 
