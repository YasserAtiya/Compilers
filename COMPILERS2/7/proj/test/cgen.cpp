
#include <vector>
#include <iostream>
#include <iomanip>
#include <string>
#include <stdlib.h>
#include <stdio.h>
using namespace std;

//Constant for maximum size of a line
#define MAXLINESIZE 100

//Enumeration for different types of  triples
enum TripleType
{

  LSS_THN,
  LSS_EQL,
  GRT_THN,
  GRT_EQL,
  CMP_EQL,
  NOT_EQL,
  NEGATION,
  COMPLIENT,
  C_BRANCH,
  U_BRANCH,
  ASSIGN,
  ADD,
  MINUS,
  MULTIPLICATION,
  DIVISION,
  MODULUS,
  AND,
  OR,
  XOR,
  LSHIFT,
  RSHIFT,
  LABEL,
  DECGLOBAL,
  USEGLOBAL,
  OP,
  CALL,
  USELOCAL,
  PARAM,
  CON,
  STR,
  FORMAL,
  ALLOC,
  LOCALLOC,
  FUNC,
  FEND,
  BRANCH_ASSIGN,
  INDEX,
  CONVERT,
  DEREF,
  RET,
  ARG

};

//Scope enum for functions
enum Scope
{
  UNUSED,
  LOCAL,
  GLOBAL
};

//Struct for objects representing registers
struct Register
{
  //Associated triple
  int triplenum;

  //char fp or int
  char cl;

  //i, o, f, g, etc.
  char type;

  //Grouped with type to provide name (g0,i1..)
  int number;

  //Flag represents if occupied
  bool empty;

  //Default constructor 
  Register()
  {
    triplenum = 0;
    empty = true;
    number = -1;
    type = 0;
  }

};

//Struct for objects representing variables
struct Variable
{

  //Double or int
  string type;

  //Most recent usage for reference
  int mostrecenttriple;

  //Stored in register
  Register* reg;

  //Name in code
  string name;

  //Current value
  double value;
  
  //Stored location in memory
  int memory_location;

  //Scope
  Scope scope;
  
  //Constructor
  Variable()
  {
    mostrecenttriple = 0;
    type = name = "";
    reg = NULL;
    memory_location = -1;
    value = 0;
    scope = UNUSED;    
  }

};


//Struct representing triple objects
struct Triple
{
  //Triple number
  int num;

  //f or i
  char valtype;

  //Associated variable if applicable
  Variable v;

  //Associated register if applicable
  Register* r;

  //Varying Arguments for triple instruction, vary with type of instruction
  string fields[3];

  //Full triple
  string line;

  //Enumerated type of triple
  TripleType type;  

  //Triples referenced in triple, max of 2
  Triple* ref1;
  Triple* ref2;

  //Constructor
  Triple()
  {
    r = NULL;
    ref1 = NULL;
    ref2 = NULL;
    valtype = 'i';
    num = 0;
  }
};

//Struct for objects representing windows
struct Window
{
  //Size allocated for window
  int size;

  //Corresponding registers
  Register iregisters[32];
  Register fregisters[32];  

  //Constructor initializes size and registers
  Window()
  {
    int i;

    //Default size of activation record
    size = 104;

    //Assign names and numbers to registers
    for(i = 0; i<32;i++)
    {
      fregisters[i].type = 'f';
      fregisters[i].number = i;
      fregisters[i].cl = 'f';

    }

    for(i = 1; i<8;i++)
    {
      iregisters[i].type = 'g';
      iregisters[i].number = i;
      iregisters[i].cl = 'i';
    }
    for(i = i; i<14;i++)
    {
      iregisters[i].type = 'o';
      iregisters[i].number = i%8;
      iregisters[i].cl = 'i';
    }
    for(i = 16; i<24;i++)
    {
      iregisters[i].type = 'l';
      iregisters[i].number = i%16;
      iregisters[i].cl = 'i';
    }
    for(i = i; i<30;i++)
    {
      iregisters[i].type = 'i';
      iregisters[i].number = i%24;
      iregisters[i].cl = 'i';
    }
  }
};

//Struct indicating label
struct Label
{
  //Label number/name
  int number;

  //Personal set of registers
  Window w;

  Label()
  {
    number = 0;
  }
};

//Struct indicating function object
struct Function
{
  //Number of locals and paramaters
  int numlocals;
  int numformals;

  //Size of window based on number of locals
  int windowsize; 

  //Number of labeks within function
  int numlabels;

  //Offset between size of window and allocated space
  int offset;

  int distance;

  //Local variables and parameters within function
  vector<Variable> variables;
  vector<Variable> parameters;

  //Name of function
  string name;

  //Labels within function
  vector<Label> Labels;

  //Iterator keeps track of current label
  vector<Label>::iterator litr;                

  //Contructor
  Function()
  {

    //Establishes 1 indexed vector
    Label l;
    Labels.push_back(l);
    litr = Labels.begin();

    //Initialize to 0
    numformals = 0;
    distance = 0;
    numlabels = 0;
    numlocals = 0;
    offset = 0;
    name = "";

    //Standard activation size
    windowsize = 104;
  }
};


//Objects representing branch
struct Branch
{

  //Branch number
  int number;

  //Attacked label number
  int labelnum;

  //Conditional or unconditional branch
  char type;

  //Initalize it all to NULL
  Branch()
  {
    type = ' ';
    number = 0;
    labelnum = 0;
  }
};

//Object struct representing global variables
struct Global
{
  //Name of variable
  string name;

  //Function or array or int or double
  string type;

  //If array, size of elements
  int index;

  //Total size of variable
  int size;

  //Current register
  int reg;

  //Constructor 
  Global()
  {
    name = type = "";
    size = index = 0;
  }

};

Register GlobalRegisters[7];

//Number of current label
int currentlabel = 0;

//Current function
Function f;

//Initialize current scope
Scope currentscope = GLOBAL;

//Vectors of all accumulated branches, functions, triples, and global variables
vector<Function> Functions;
vector<Branch> Branches;
vector<Triple> Triples;
vector<Global> Globals;

//Iterators to access vectors anywhere
vector<Triple>::iterator itr;                
vector<Function>::iterator fitr;                

//Two functions involved with geneating code

//Reads in input and parses it, creating triple objects, populating vector
Triple CreateTriple(string line);

//Converts created triple objects into assembly based on type and fields
void ConvertTriple(Triple t);

//Locate pasttriple using number
Triple* LocateTriple(int num);

//Locate triple register using register information
Register* LocateTriple(int num, char type);

//Find next available register, type indicates floating point, local, or global
Register* FindLRegister();
Register* FindGRegister();
Register* FindFRegister();
void InitializeGlobalRegisters();

//Print instructions to move from integer variable to float
void InttoFloat(Register* i, Register* f);
void FloattoInt(Register* f, Register* i);

//FUNCTIONS HANDLING DIFFERENT TYPES OF TRIPLES

//Funtion declaration
void fhead(Triple t);
//Declaration of local variable
void localloc(Triple t);
//Declaration of label
void label(Triple t);
//End of function
void fend(Triple t);
//Use of local varliable
void local(Triple& t);
//Use of constant value
void con(Triple& t);
//Assignment of one register/value to another
void assign(Triple t);
//Conversion from one type to another
void convert(Triple& t);
//Arithmetic addition
void add(Triple& t);
//Subtraction
void msub(Triple& t);
//String handling
void str(Triple& t);
//Variable dreference
void deref(Triple& t);
//Passing argument into function and calling it
void arg(Triple& t);
//Handle global identifiers and calling agrgumentless functions
void global(Triple& t);
//Division
void div(Triple& t);
//Declaration of formal
void formal(Triple& t);
//Use of parameter
void param(Triple& t);
//Multiplication
void mult(Triple& t);
//Modulus
void mod(Triple& t);
//COmplement
void comp(Triple& t);
//Negation
void neg(Triple& t);
//Bitwise left shift
void lshft(Triple& t);
//Bitwise right shift
void rshft(Triple& t);
//Bitwise OR
void bor(Triple& t);
//Bitwise XOR
void bxor(Triple& t);
//Bitwise AND
void band(Triple& t);
//Bitwise complement
void bcomp(Triple& t);
//Unconditional branch
void ubranch(Triple& t);
//Conditional branch
void cbranch(Triple& t);
//Global array declaration
void alloc(Triple& t);
//Index into array
void index(Triple& t);


int main()
{
  //Current working triple
  Triple current;
  //Current line
  string line;

  //Initialize Global registers for use
  InitializeGlobalRegisters();

  //While we have input, get lines, create triples
  while(!cin.eof())
  {
    getline(cin,line);
    current = CreateTriple(line);
  }

  //In convert triple we find the appropriate assembly instruction
  //to convert the triple to.
  //We then call a function of that name to print the instruction
  //and then take the necessaru actions
  fitr = Functions.begin();
  for(itr = Triples.begin();itr != Triples.end(); itr++)
  { 
    ConvertTriple(*itr);
  }

}

//Switch like statement to determine type of current triple and call
//the appropriate function.
void ConvertTriple(Triple t)
{

    if(t.type == FUNC)
    {
      fhead(t);
    }
    else if(t.type == LOCALLOC)
    {
      localloc(t);
    }
    else if(t.type == LABEL)
    {
      label(t);
    }
    else if(t.type == FEND)
    {
      fend(t);
    }
    else if(t.type == USELOCAL)
    {
      local(t);
    }
    else if(t.type == CON)
    {
      con(t);
    }
    else if(t.type == ASSIGN)
    {
      assign(t);
    }
    else if(t.type == CONVERT)
    {
      convert(t);
    }
    else if(t.type == ADD)
    {
      add(t);
    }
   else if(t.type == STR)
    {
      str(t);
    }
   else if(t.type == DEREF)
    {
      deref(t);
    }
   else if(t.type == ARG)
    {
      arg(t);
    }
   else if(t.type == DECGLOBAL)
    {
      global(t);
    }
   else if(t.type == DIVISION)
    {
      div(t);
    }
   else if(t.type == FORMAL)
    {
      formal(t);
    }
   else if(t.type == PARAM)
    {
      param(t);
    }
   else if(t.type == MULTIPLICATION)
    {
      mult(t);
    }
    else if(t.type == NEGATION)
      {
        neg(t);
      }
    else if(t.type == COMPLIENT)
      {
        comp(t);
      }
    else if(t.type == LSHIFT)
      {
        lshft(t);
      }
    else if(t.type == RSHIFT)
      {
        rshft(t);
      }
    else if(t.type == OR)
      {
        bor(t);
      }
    else if(t.type == XOR)
      {
        bxor(t);
      }
    else if(t.type == AND)
      {
        band(t);
      }
    else if(t.type == U_BRANCH)
      {
        ubranch(t);
      }
    else if(t.type == LSS_THN || t.type == GRT_THN || t.type == GRT_EQL 
          || t.type == LSS_EQL || t.type == NOT_EQL || t.type == CMP_EQL)
    {
      cbranch(t);
    }
    else if(t.type == ALLOC)
    {
      alloc(t);
    }
    else if(t.type == INDEX)
    {
      index(t);
    }
    else if(t.type == MINUS)
    {
      msub(t);
    }

}


//Handle Array indexing
void index(Triple& t)
{
  //Iterator of global variable vector
  vector<Global>::iterator gitr;

  Register* arr = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* ind = LocateTriple(stoi(t.fields[2],NULL),'i');

  //REquired shift left
  int sl;

  //Set register associated with global's latest triple reference
  arr->triplenum = t.num;

  //Iterate through global variables
  for(gitr = Globals.begin(); gitr != Globals.end(); gitr++)
  {
    //Grab the one referenced in the triple
    if(arr->number == gitr->reg)
    {
      //Exit loop
      break;
    }
  }

  //Determine shift number
  if(t.fields[0] == "f")
    {
      sl = 3;
      //Perform shift
      printf("\tsll\t%%%c%d,%d,%%%c%d\n",ind->type,ind->number
        ,sl,ind->type,ind->number);

    //  //Print load command
      printf("\tld\t[%%%c%d+%%%c%d],%%%c%d\n",arr->type,arr->number,
        ind->type,ind->number,arr->type,arr->number);
    }
  else
    {
      sl = 2;
      //Perform shift
      printf("\tsll\t%%%c%d,%d,%%%c%d\n",ind->type,ind->number,
        sl,ind->type,ind->number);

    //  //Print load command
      printf("\tld\t[%%%c%d+%%%c%d],%%%c%d\n",arr->type,arr->number,
        ind->type,ind->number,arr->type,arr->number);
    }

}

//Allocate global array
void alloc(Triple& t)
{
  //Iterator of global variable vextor
  vector<Global>::iterator gitr;

  //Iterate through global variables
  for(gitr = Globals.begin(); gitr != Globals.end(); gitr++)
  {
    //Grab referenced global
    if(t.fields[0] == gitr->name)
    {
      //Set its size and element size based on triple
      gitr->size = stoi(t.fields[1],NULL);
      gitr->index = 8;
      break;
    }
  }

  //Allign to 8th byte
  printf("\t.common\t%s,%s,%d\n",t.fields[0].c_str(),t.fields[1].c_str(),8);
}

//Handle conditional branch
void cbranch(Triple& t)
{
  //Locate registers that referenced triples are found in
  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  //Create iterator for vector of branches
  vector<Branch>::iterator bitr;

  //Label number
  int lab;

  //Type of condition
  string cmptype = "";


  //Print comparison instruction
  if(r1 && r1->type == 'f')
    printf("\tfcmpd\t%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,r2->number);
  else
    printf("\tcmp\t%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,r2->number);

  //Move to next instruction
  itr++;

  //Search for branch to use based on new triple
  for(bitr = Branches.begin();bitr != Branches.end(); bitr++)
  {
    if(bitr->number == stoi(itr->fields[1],NULL))
     {
        lab = bitr->labelnum;
     }
  }

  //Use new triple type to determine type of comparison to do
  switch(t.type)
  {
    case CMP_EQL:
      cmptype = "e";
    break;
  
    case NOT_EQL:
      cmptype = "ne";
    break;
  
    case LSS_EQL:
      cmptype = "le";
    break;
  
    case GRT_EQL:
      cmptype = "ge";
    break;

    case LSS_THN:
      cmptype = "l";
    break;
  
    case GRT_THN:
      cmptype = "g";
    break;
  }  
 
  //Print type of branch and destination
  printf("\tb%s\tL%d\n",cmptype.c_str(), lab);

  //Print branch noop
  printf("\tnop\n");

}

//Handle unconditional branches
void ubranch(Triple& t)
{
    //Variable for branch item
    Branch* b;

    //Iterator for vector of branches
    vector<Branch>::iterator bitr;

    //Target label
    int lab;

    //Search through branches to find appropriate one
    for(bitr = Branches.begin();bitr != Branches.end(); bitr++)
    {
      if(bitr->number == stoi(t.fields[0],NULL))
       {
          //Takes its destination
          lab = bitr->labelnum;
          break;
       }
    }

   //Print instruction to branch to label destination and noop to fill gap
   printf("\tb\tL%d\n",lab);
   printf("\tnop\n");
}

//Bitwise and handling
void band(Triple& t)
{
  //Locate registers of referenced triples in current triple
  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  //Print instruction anding said triples
  printf("\tand\t%%%c%d,%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,
    r2->number,r1->type,r1->number);

  //Update destinations most recent triple number
  r2->triplenum = t.num;
}

//Bitwise or, basically same as band
void bor(Triple& t)
{

  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  printf("\tor\t%%%c%d,%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,
    r2->number,r1->type,r1->number);

  r2->triplenum = t.num;

}

//Bitwise xor, basically same as band and bor
void bxor(Triple& t)
{
  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  printf("\txor\t%%%c%d,%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,
    r2->number,r1->type,r1->number);

  r2->triplenum = t.num;
}

//Bitwise rightshift, basically same as other bitwise operations
void rshft(Triple& t)
{
  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  printf("\tsrl\t%%%c%d,%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,
    r2->number,r1->type,r1->number);

  r2->triplenum = t.num;
}

//Bitwise left shift, basically same as other bitwise operations
void lshft(Triple& t)
{
  Register* r1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  Register* r2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  printf("\tsll\t%%%c%d,%%%c%d,%%%c%d\n",r1->type,r1->number,r2->type,
    r2->number,r1->type,r1->number);

  r2->triplenum = t.num;
}

//Print instruction performing one's complement, bitwise unary operator
void comp(Triple& t)
{
  Register* dest = LocateTriple(stoi(t.fields[1],NULL),'i');

  printf("\tnot\t%%%c%d\n",dest->type,dest->number);

  dest->triplenum = t.num;
}

//Print instruction performing two's complement, also similar
void neg(Triple& t)
{
  Register* dest = LocateTriple(stoi(t.fields[1],NULL),'i');

  printf("\tneg\t%%%c%d\n",dest->type,dest->number);

  dest->triplenum = t.num;
}

//Handle multiplication
void mult(Triple& t)
{
  //Used registers(names are out of order)
  Register* dest;
  Register* src1;
  Register* src2;

  //FInd registers of referenced triples
  dest = LocateTriple(stoi(t.fields[1],NULL),'i');
  src1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  src2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  //Update destination's most recently used triple number
  dest->triplenum = t.num;

  //Print d instuctions for float
  if(t.fields[0] == "f")
    printf("\tfmuld\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);
  else
  //Print s instruction for int
    printf("\tsmul\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);

  //Update registers last used triple int
  src1->triplenum = t.num;
}

//Handling parameter usage
void param(Triple& t)
{
  //Find free register
  Register* r =  FindLRegister();

  //Print instruction putting parameter in register
  printf("\tadd\t%%fp,%d,%%%c%d\n",(68+(stoi(t.fields[0],NULL)*4)),
        r->type,r->number);

  //Update triple number of register
  r->triplenum = t.num;
}

//Handle parameter declaration
void formal(Triple& t)
{

  //Take parameter from in memory and put it in a register
  printf("\tst\t%%i%d,[%%fp + %d]\n",f.numformals,(68+(f.numformals*4)));

  //Increment processed parameters
  f.numformals++;

  //Handle dloats with different instruction
  if(t.fields[0] == "8")
  {
    printf("\tst\t%%i%d,[%%fp + %d]\n",f.numformals,(68+(f.numformals*4)));
    f.numformals++;
  }
}


//Handling divide
void div(Triple& t)
{
  //Used registers(names are out of order)
  Register* dest;
  Register* src1;
  Register* src2;

  //FInd registers of referenced triples
  dest = LocateTriple(stoi(t.fields[1],NULL),'i');
  src1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  src2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  //Update destination's triple number


  //Use d instructions for floats and s for ints
  if(t.fields[0] == "f")
    printf("\tfdivd\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);
  else
    printf("\tsdiv\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);

  //Update destination's triple number
  src1->triplenum = t.num;
}

//Handle use of global variable
void global(Triple& t)
{

  //Registers for placing variable
  Register* rfunc,*r2;

  //Iterator for globals
  vector<Global>::iterator gitr;
  Global g;

  //Find global we are looking for
  for(gitr = Globals.begin(); gitr != Globals.end(); gitr++)
  {
    if(t.fields[0] == gitr->name)
    {
      g = *gitr;
      break;
    }
  }

  //Handle functions differently than arrays
  if(g.type != "function")
    {
      rfunc = FindGRegister();

      g.reg = rfunc->number;

      rfunc->triplenum = t.num;


      //Print instruction to put top half of array  in register
      printf("\tsethi\t%%hi(%s),%%%c%d\n",
        t.fields[0].c_str(),rfunc->type,rfunc->number);

      printf("\tor\t%%%c%d,%%lo(%s),%%%c%d\n",
        rfunc->type,rfunc->number,t.fields[0].c_str(),
        rfunc->type,rfunc->number);
      return;
    }
  else
    rfunc = FindLRegister();

  //Print instruction to put top half of function name  in register
  printf("\tsethi\t%%hi(%s),%%%c%d\n",
    t.fields[0].c_str(),rfunc->type,rfunc->number);

  //Or bottom half into register
  printf("\tor\t%%%c%d,%%lo(%s),%%%c%d\n",
    rfunc->type,rfunc->number,t.fields[0].c_str(),
    rfunc->type,rfunc->number);

  //Update register number
  rfunc->triplenum = t.num;

  //Call function
  printf("\tcall\t%%%c%d,%d\n",rfunc->type,rfunc->number,0);

  printf("\tnop\n");
}

//Handle args and function call
//Like above function but with argument handling
void arg(Triple& t)
{
  vector<Triple> Args;
  vector<Register> Regs;
  Triple* cur = &t;
  Triple* tfunc;
  Triple* tcall;
  Register* curreg = (LocateTriple(stoi((cur->fields[1]),NULL),cur->valtype));
  Register* rfunc = FindLRegister();
  vector<Register>::iterator regitr;
  int i = 0;


  //Get all arguments
  do
  {  
    Args.push_back(*cur);
    curreg = (LocateTriple(stoi((cur->fields[1]),NULL),cur->valtype));
    Regs.push_back(*curreg);
  
    itr++;
    cur = &(*itr);
  }
  while(cur->type == ARG);
  


  //Now we have function name
  tfunc = &(*itr);
  itr++;
  

  //Get call
  tcall = &(*itr);

  //Print instruction to put top half of function name  in register
  printf("\tsethi\t%%hi(%s),%%%c%d\n",
    tfunc->fields[0].c_str(),rfunc->type,rfunc->number);

  printf("\tor\t%%%c%d,%%lo(%s),%%%c%d\n",
    rfunc->type,rfunc->number,tfunc->fields[0].c_str(),
    rfunc->type,rfunc->number);


  regitr = Regs.begin();
  for(vector<Triple>::iterator Argitr = Args.begin(); Argitr != Args.end();
      Argitr++)
  {
    if(regitr->type == 'f')
    { 
      //Store top half of float in temporary space
      printf("\tstd\t%%%c%d,[%%sp + 96]\n",regitr->type,regitr->number);

      printf("\tld\t[%%sp + 96],%%o%d\n",i);
      i++;

      printf("\tld\t[%%sp + 100],%%o%d\n",i);

    } 
    else
    {
      printf("\tmov\t%%%c%d,%%o%d\n",regitr->type,regitr->number,i);   
    }
    if(regitr != Regs.end())
      regitr++;
    i++;
  }

  printf("\tcall\t%%%c%d,%d\n",rfunc->type,rfunc->number,i);

  printf("\tnop\n");

}


//Handle dreference command
void deref(Triple& t)
{
  //Variable we are dereferencing
  Variable *v;

  //First, get register of triple we need
  Register* r = LocateTriple(stoi(t.fields[1],NULL),'i'); 
  Register* r2;
  //Find new register based on type
  if(t.fields[0] == "f")
    r2 = FindFRegister();
  else
    r2 = FindLRegister();

  //Print load into new register
  if(r->cl == r2->cl)
    printf("\tld\t[%%%c%d],%%%c%d\n",r->type,r->number,r2->type,r2->number);
  else if(r->type == 'i' && r2->type == 'f')
    InttoFloat(r,r2);
  else if(r->type == 'f' && r2->type == 'i')
    FloattoInt(r,r2);
  else if(r->type == 'g' && r2->type == 'f')
    InttoFloat(r,r2);
  else if(r->type == 'f' && r2->type == 'g')
    FloattoInt(r,r2);

  r2->triplenum = t.num;
  t.r = r2;

}

//Handle string declaration
void str(Triple& t)
{
  Register* r = FindLRegister();

  //Change to data section
  printf("\t.seg\t\"data\"\n");

  //Declare new label
  printf("LS%d:\n", currentlabel);

  //Declare null terminated string
  printf("\t.asciz\t\"%s\"\n\n",t.fields[0].c_str());

  //Change to data section
  printf("\t.seg\t\"text\"\n");

  //Save string away
  printf("\tsethi\t%%hi(LS%d),%%%c%d\n",currentlabel,r->type,r->number);
  printf("\tor\t%%%c%d,%%lo(LS%d),%%%c%d\n",r->type,r->number,currentlabel,
        r->type,r->number);

  r->triplenum = t.num;

}

//Arithmetic subtraction, similar to other arithmetic functions
void msub(Triple& t)
{
  Register* dest;
  Register* src1;
  Register* src2;

  dest = LocateTriple(stoi(t.fields[1],NULL),'i');
  src1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  src2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  src1->triplenum = t.num;

  if(t.fields[0] == "i")
      printf("\tsub\t%%%c%d,%%%c%d,%%%c%d\n",
            dest->type,dest->number,
            src2->type,src2->number,src1->type,src1->number);
  else
      printf("\tfsubd\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);
}

//Arithmetic add, similar to other arithmetic functions
void add(Triple& t)
{
  Register* dest;
  Register* src1;
  Register* src2;

  dest = LocateTriple(stoi(t.fields[1],NULL),'i');
  src1 = LocateTriple(stoi(t.fields[1],NULL),'i');
  src2 = LocateTriple(stoi(t.fields[2],NULL),'i');

  src1->triplenum = t.num;

  if(t.fields[0] == "i")
      printf("\tadd\t%%%c%d,%%%c%d,%%%c%d\n",
            dest->type,dest->number,
            src2->type,src2->number,src1->type,src1->number);
  else
      printf("\tfaddd\t%%%c%d,%%%c%d,%%%c%d\n",
        dest->type,dest->number,
        src2->type,src2->number,src1->type,src1->number);

}

//Handle cv commands
void convert(Triple& t)
{
  //Find where temporary space is
  int ts = 96;
  char vt;
  int num;
  Register* r;
  Register* r2;
  int dist = 96;

  //Works with + 100 and + 104

  //Convert string to number
  num = stoi(t.fields[1],NULL);


  //Convert
  if(t.fields[0] == "f")
  {
//    dist = f.windowsize-8

    vt = 'i';
    //Find register holding triple needed
    r = LocateTriple(num,vt);      

    //Print instruction putting register in memory space
    printf("\tst\t%%%c%d,[%%sp + %d]\n",r->type,r->number,dist);
    
    //Find free float register
    r2 = FindFRegister();
    r2->triplenum = t.num;   
    
    //Load into register from memory space
//    printf("\tld\t[%%sp + %d],%%%c%d\n",(104-),r2->type,r2->number);
    printf("\tld\t[%%sp + %d],%%%c%d\n",(dist),r2->type,r2->number);
    
    //Convert
    printf("\tfitod\t%%%c%d,%%%c%d\n",r2->type,r2->number,r2->type,r2->number);

  }
  else 
  {
    vt = 'f';
    //Find register holding triple needed
    r = LocateTriple(num,vt);
      
    //Print instruction putting register in memory space
    printf("\tst\t%%%c%d,[%%sp + %d]\n",r->type,r->number,dist);
    
    //Find free float register
    r2 = FindLRegister();
    r2->triplenum = t.num;   
    //Load into register from memory space
    //printf("\tldd\t[%%sp + 96],%%%c%d\n",r2->type,r2->number);
    printf("\tld\t[%%sp + %d],%%%c%d\n",dist,r2->type,r2->number);
    
    //Convert
    printf("\tfdtoi\t%%%c%d,%%%c%d\n",r->type,r->number,r->type,r->number);


  }  
  
}

//Handle assignment commands
void assign(Triple t)
{
  Register* dest;
  Register* src;
  Triple t1;
  Triple t2;

  //Find registers that the triples are in
  dest = LocateTriple(stoi(t.fields[1],NULL),'i');
  src = LocateTriple(stoi(t.fields[2],NULL),'i');

  if(src->type == 'i' && dest->type == 'f')
  {
    InttoFloat(src,dest);
  }
  else if(src->type == 'f' && dest->type == 'i')
  {
    FloattoInt(src,dest);
  }
  else if(src->type == 'g' && dest->type == 'f')
    InttoFloat(src,dest);
  else if(src->type == 'f' && dest->type == 'g')
    FloattoInt(src,dest);
  else if(src->type == 'o' && dest->type == 'f')
    InttoFloat(src,dest);
  else if(src->type == 'f' && dest->type == 'o')
    FloattoInt(src,dest);
  else
  {
      printf("\tst\t%%%c%d,[%%%c%d]\n",src->type,src->number
    ,dest->type,dest->number);

  }

  src->triplenum = t.num;

}

//Pick up constant
void con(Triple& t)
{
  //Find available reggister
  t.r  = FindLRegister();
  t.r->triplenum = t.num;
 
  //MOve constant into register
  printf("\tmov\t%s,%%%c%d\n",t.fields[0].c_str(),t.r->type,t.r->number);
}

//Handle local, similar to handle formals
void local(Triple& t)
{
    Variable* v;
    Register* r;
    int loc = stoi(t.fields[0],NULL);
    v = &t.v;


    t.r = FindLRegister();
    v->mostrecenttriple = t.num;
    v->reg = t.r;
    v->reg->triplenum = t.num;

    printf("\tadd\t%%sp,%d,%%%c%d\n",v->memory_location,t.r->type,t.r->number);

}

//Moving into new label
void label(Triple t)
{
  //Iterate label list
  f.litr++;

  //Print label header
  printf("L%s:\n",t.fields[0].c_str());
  currentlabel = stoi(t.fields[0],NULL);

}

//Begin new function
void fhead(Triple t)
{
  
  //Switch to text segment
  printf("\t.seg\t\"text\"\n");

  //Declare global
  printf("\t.global %s\n",t.fields[0].c_str());

  //Begin function
  printf("%s:\n",t.fields[0].c_str());

  fitr->offset = fitr->windowsize%8;

  //Print new allocated size
  printf("\tsave\t%%sp,(-%d),%%sp\n",fitr->windowsize+fitr->offset);

  f.litr = f.Labels.begin();
}

//Dummy function
void localloc(Triple t)
{

}

//ENd of function
void fend(Triple t)
{

  //Perform return
  printf("\tret\n");

  //Perform context switch
  printf("\trestore\n");

  fitr++;
}

//Parse lines of triples, assign extracted strings 
//as fields in triple, set type of triple
Triple CreateTriple(string line)
{
  //Current working triple
  Triple t;
  //Strings we are extracting
  char field1[MAXLINESIZE],field2[MAXLINESIZE],field3[MAXLINESIZE];
  //Current line
  const char* arr = line.c_str();
  //Assign triple line
  t.line = line;
  int n1, n2;

  //Parse for branch assignment
  if(sscanf(arr,"%d.\tB%d=L%d", &t.num,&n1,&n2) == 3)
  {

    t.fields[0] = to_string(n1);
    t.fields[1] = to_string(n2);
    Branch* b;
    vector<Branch>::iterator bitr;

    for(bitr = Branches.begin();bitr != Branches.end(); bitr++)
    {
      if(bitr->number == n1)
       {
          bitr->labelnum = n2;
          break;
       }
    }

    t.type = BRANCH_ASSIGN;
    Triples.push_back(t);
  }
  //Global array declaration
  else if(sscanf(arr,"%d.\talloc %s %s", &t.num, field1,field2) == 3)
  {
    
    Global g;
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.type = ALLOC;

    g.type = "array";
    g.name = field1;
 //   g.size = stoi(t.fields[1],NULL);
    Globals.push_back(g);

    Triples.push_back(t);
  }
  //Global fucntion declaration
  else if(sscanf(arr,"%d.\tfunc %s\n", &t.num, field1) == 2)
  {
    
    
    f.name = field1;
    
    t.fields[0] = field1;
    t.type = FUNC;
    Triples.push_back(t);
    

  }
  //Global identifier declaration
  else if(sscanf(arr,"%d.\tglobal %s\n", &t.num, field1) == 2)
  {
    
    
    Global g;
    g.type = "function";
    g.name = field1;
    Globals.push_back(g);
    t.fields[0] = field1;
    t.type = DECGLOBAL;

    Triples.push_back(t);
  }
  //String declaration
  else if(sscanf(arr,"%d.\tstr \"%[^\"]\"\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    t.valtype = 'i';
    t.type = STR;
    Triples.push_back(t);
  }
  //Argument declaration
  else if(sscanf(arr,"%d.\targ%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.valtype = 'i';
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.type = ARG;
    Triples.push_back(t);
  }
  //Formal declaration
  else if(sscanf(arr,"%d.\tformal %s\n", &t.num, field1) == 2)
  {
    Variable v;
    
    t.fields[0] = field1;
    t.type = FORMAL;
    
    if(t.fields[0] == "8")
    {
        v.type = "double";
        t.valtype = 'd';
    }
    else
    {
        v.type = "int";
        t.valtype = 'i';
    }

    f.parameters.push_back(v);
    Triples.push_back(t);
  }
  //Argument passing and call declaration
  else if(sscanf(arr,"%d.\tf%1s %s %s\n", &t.num, field1, field2,field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;

    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    
    t.type = CALL;
    Triples.push_back(t); 
  }
  //Constant
  else if(sscanf(arr,"%d.\tcon %s\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    t.type = CON;
    t.valtype = 'i';
    Triples.push_back(t);
  }
  //Conversion declaration
  else if(sscanf(arr,"%d.\tcv%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.type = CONVERT;

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;

    t.valtype = t.fields[0][0];

    Triples.push_back(t);
  }
  //Unconditional branch
  else if(sscanf(arr,"%d.\tbr B%s\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    Branch b;

    b.type = 'U';
    b.number = stoi(t.fields[0],NULL);

    Branches.push_back(b);

    t.type = U_BRANCH;
    Triples.push_back(t);
  }
    //Label branch
  else if(sscanf(arr,"%d.\tbr L%s\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    Branch b;

    b.type = 'L';
    b.number = stoi(t.fields[0],NULL);
    b.labelnum = b.number;

    Branches.push_back(b);

    t.type = U_BRANCH;
    Triples.push_back(t);
  }

  //Conditional branch
  else if(sscanf(arr,"%d.\tbt %s B%s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    Branch b;

    b.type = 'C';
    b.number = stoi(t.fields[1],NULL);

    Branches.push_back(b);
    t.type = C_BRANCH;
    Triples.push_back(t);
    }
  //Value return
  else if(sscanf(arr,"%d.\tret%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.type = RET;
    Triples.push_back(t);
  }
  //Declaration of local variable
  else if(sscanf(arr,"%d.\tlocalloc %s\n", &t.num, field1) == 2)
  {
    
    Variable v;
    v.memory_location = f.windowsize;
    t.fields[0] = field1;
    t.type = LOCALLOC;
    if(t.fields[0] == "8")
    {
        f.windowsize+=8;
        v.type = "double";
        t.valtype = 'd';
    }
    else
    {
        f.windowsize+=4;
        v.type = "int";
        t.valtype = 'i';
    }
    f.variables.push_back(v);
    f.numlocals++;
    Triples.push_back(t);
  }
  //Use of local variable
  else if(sscanf(arr,"%d.\tlocal %s\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    t.v = f.variables[stoi(t.fields[0],NULL)];
    t.type = USELOCAL;
    Triples.push_back(t);
  }
  //Use of parameter variable
  else if(sscanf(arr,"%d.\tparam %s\n", &t.num, field1) == 2)
  {
    
    t.fields[0] = field1;
    t.type = PARAM;
    Triples.push_back(t);
  }
  //Index array
  else if(sscanf(arr,"%d.\t[]%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;

    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;

    t.type = INDEX;
    Triples.push_back(t);
  }
  //Dereference
  else if(sscanf(arr,"%d.\t@%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;

    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;

    t.type = DEREF;
    Triples.push_back(t);
  }
  //Complenent
  else if(sscanf(arr,"%d.\t~%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.type = COMPLIENT;
    Triples.push_back(t);
  }
  //Addition
  else if(sscanf(arr,"%d.\t+%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = ADD;
    Triples.push_back(t);
  }
  //Subtraction
  else if(sscanf(arr,"%d.\t-%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = MINUS;
    Triples.push_back(t);
    }
   //Minus
  else if(sscanf(arr,"%d.\t-%1s %s\n", &t.num, field1, field2) == 3)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.type = NEGATION;
    Triples.push_back(t);
  }
  //Multiplication
  else if(sscanf(arr,"%d.\t*%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = MULTIPLICATION;
    Triples.push_back(t);
  }
  //NDivision
  else if(sscanf(arr,"%d.\t/%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = DIVISION;
    Triples.push_back(t);
  }
  //Modulus
  else if(sscanf(arr,"%d.\t%%%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = MODULUS;
    Triples.push_back(t);
  }
  //Bitwise and
  else if(sscanf(arr,"%d.\t&%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = AND;
    Triples.push_back(t);
  }
  //Bitwise or
  else if(sscanf(arr,"%d.\t|%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = OR;
    Triples.push_back(t);
  }
  //Bitwise xor
  else if(sscanf(arr,"%d.\t^%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = XOR;
    Triples.push_back(t);
  }
  //Bitwise lshift
  else if(sscanf(arr,"%d.\t<<%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = LSHIFT;
    Triples.push_back(t);
  }
  //Bitwise rshift
  else if(sscanf(arr,"%d.\t>>%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));;
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));;
    t.type = RSHIFT;
    Triples.push_back(t);
  }
  //Comparators
  else if(sscanf(arr,"%d.\t==%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
  
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = CMP_EQL;
    Triples.push_back(t);
  }
  else if(sscanf(arr,"%d.\t<=%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = LSS_EQL;
    Triples.push_back(t);
  }
  else if(sscanf(arr,"%d.\t>=%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = GRT_EQL;
    Triples.push_back(t);
  }
  else if(sscanf(arr,"%d.\t!=%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = NOT_EQL;
    Triples.push_back(t);
  }
  else if(sscanf(arr,"%d.\t<%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = LSS_THN;
    Triples.push_back(t);
  }
  else if(sscanf(arr,"%d.\t>%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
    
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];

    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));

    t.type = GRT_THN;
    Triples.push_back(t);
  }
  //Assignment
  else if(sscanf(arr,"%d.\t=%1s %s %s\n", &t.num, field1, field2, field3) == 4)
  {
  
    t.fields[0] = field1;
    t.fields[1] = field2;
    t.fields[2] = field3;
    t.valtype = t.fields[0][0];
    t.ref1 = LocateTriple((stoi(t.fields[1],NULL)));
    t.ref2 = LocateTriple((stoi(t.fields[2],NULL)));
    t.type = ASSIGN;
    Triples.push_back(t);
  }
  //Label declaration
  else if(sscanf(arr,"\tlabel L%s\n", field1) == 1)
  {
    Label l;
    t.fields[0] = field1;
    t.type = LABEL;
    l.number = stoi(t.fields[0],NULL);
    f.numlabels++;
    f.Labels.push_back(l);
    Triples.push_back(t);
  }
  //ENd of function
  else if(sscanf(arr,"%d.\tfend\n", &t.num) == 1)
  {
    //cout << "Line: " << t.line << "\nis a fend\n";

    Function f2;
    
    t.type = FEND;
    Functions.push_back(f);
    f = f2;
    Triples.push_back(t);
  }
  else
  {
    
  }

  
  //Return created triple
  return t;
}

//FInd global register that is free
Register* FindGRegister()
{
  Register* lru = &(GlobalRegisters[0]);

  //Search for empty register
  for(int i = 0; i < 7; i++)
  {
    if(GlobalRegisters[i].empty == 1){    
      GlobalRegisters[i].empty = 0;
      return &(GlobalRegisters[i]);
    }
  }

  //If not available, use lru
  for(int i = 0; i < 7; i++)
  {
    if(GlobalRegisters[i].triplenum < lru->triplenum){    
        lru = &(GlobalRegisters[i]);
    }
  }

  return lru;


}

//Same as above but with local
Register* FindLRegister()
{
  //for(int i = 16; i < 24; i++)
 //   cout << "Register " << f.litr->w.iregisters[i].type << f.litr->w.iregisters[i].number << " contains value: " << f.litr->w.iregisters[i].triplenum << endl;
  for(int i = 16; i < 24; i++)
  {
    if(f.litr->w.iregisters[i].empty == 1){    
      f.litr->w.iregisters[i].empty = 0;
      return &(f.litr->w.iregisters[i]);
    }
  }
}

//Same as above but with fp
Register* FindFRegister()
{
  for(int i = 0; i < 32; i++)
  {
    if(f.litr->w.fregisters[i].empty == 1 && i%2 == 0){    
      f.litr->w.fregisters[i].empty = 0;
      return &(f.litr->w.fregisters[i]);
    }
  }
  cout << "DID NOT FOIND REG\n";
}

//Define global variables
void InitializeGlobalRegisters()
{
  int i;
    for(i = 0; i<=7;i++)
    {
      GlobalRegisters[i].type = 'g';
      GlobalRegisters[i].number = i+1;
    }

}

  //Find registers that the triples are in
Register* LocateTriple(int num, char type)
{
    for(int i = 0; i<32; i++)
    {
  
      if(f.litr->w.iregisters[i].triplenum == num)
        return &(f.litr->w.iregisters[i]);
      if(f.litr->w.fregisters[i].triplenum == num)
        return &(f.litr->w.fregisters[i]);
    }

    for(int i = 0; i<7;i++)
    {
      if(GlobalRegisters[i].triplenum == num)
        return &(GlobalRegisters[i]);
    }

}

//Locate triples themselves
Triple* LocateTriple(int num)
{
  int i = 1;
  vector<Triple>::iterator itr2;
  for(itr2 = Triples.begin();itr2 != Triples.end();itr2++)
  {
    if(itr2->num == num)
      return &(*itr2);
  }
}

void InttoFloat(Register* i, Register* f)
{
  printf("\tst\t%%%c%d,[%%sp + 96]\n",i->type,i->number);
  printf("\tldd\t[%%sp + 96],%%%c%d\n", f->type,f->number);
  printf("\tfitod\t%%%c%d,%%%c%d\n", f->type,f->number,f->type,f->number);

}

void FloattoInt(Register* f, Register* i)
{
  printf("\tst\t%%%c%d,[%%sp + 96]\n",f->type,f->number);
  printf("\tld\t[%%sp + 96],%%%c%d\n", i->type,i->number);
  printf("\tfdtoi\t%%%c%d,%%%c%d\n", f->type,f->number,f->type,f->number);


}