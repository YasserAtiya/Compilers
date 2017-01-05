//g++ -std=c++11 -g -o cparse cparse.cpp


#include <iomanip>
#include <iostream>
#include "stdio.h"
#include <string>
#include <list>
#include <iterator>
using namespace std;

const string ARROW = "->";
const string CURSOR = "@";

//Item/Production struct
struct Item
{
  Item()
  {
    lhs = "";
    rhs = "";
    cursorindex = -1;
    gotochar = "";
    hasgoto = false;
    gotonum = 0;
  }
  Item(string l, string r, int ci)
  {
    lhs = l;
    rhs = r;
    cursorindex = ci;
    gotochar = "";
    hasgoto = false;
    gotonum = 0;
  }
  string lhs;
  string rhs;
  int cursorindex;
  string gotochar;
  int gotonum;
  bool hasgoto;
};

struct Set
{
  list<Item> Items;
  int number;
};

Set Grammar;

void GetGrammar();
void AugmentGrammar();
void ComputeCollection();
void DivideLine(Item* i, string line);
void ComputeI0();
void Print();
void IterateItems();
bool CreateNewSet(char, list<Set>::iterator, list<Item>::iterator&);
int RemoveRedundancy();


list<Set> Sets;

int main()
{
  GetGrammar();
  AugmentGrammar();
  ComputeCollection();
  Print();
}

void ComputeCollection()
{
  ComputeI0();
  IterateItems();

}

void IterateItems()
{
  list<Set>::iterator setitr;
  list<Item>::iterator itemitr;

  setitr = Sets.begin();
  itemitr = setitr->Items.begin();

  do
  {
    for(itemitr = setitr->Items.begin(); itemitr != setitr->Items.end(); itemitr++)
    {
      if(itemitr->cursorindex !=  itemitr->rhs.size())
      {
        char aftercursor = itemitr->rhs[itemitr->cursorindex+1];
       if(CreateNewSet(aftercursor,setitr,itemitr))
          break;
        else
         itemitr--;

      }
    }
      setitr++;
  }
  while(setitr != Sets.end());
}

bool CreateNewSet(char ac, list<Set>::iterator si, list<Item>::iterator& ii)
{
  list<Item>::iterator holder = ii;
  Set s;
  s.number = Sets.size();
  //cout << "\nIn CreateNewSet, producing I" << s.number << "\n";
  bool needincrement = false;
  //Advance cursor on sets with same ac character

  while(1)
  {
    Item i = Item(ii->lhs,ii->rhs,ii->cursorindex);//DO I MOVE THIS
    //cout << "Current Item: " << ii->lhs << ARROW << ii->rhs << endl;
    //cout << "Cursor Index: " << ii->cursorindex << endl;
    //cout << "Rhs size: " << ii->rhs.size() << endl;
    //cout << "Set size: " << si->Items.size() << endl;

    //if cursor is at end of rhs
    if(ii->cursorindex == ii->rhs.size()-1)
      {
        //cout << "Reached end of rhs\n";
        //if current item is not end of set increment, else leave loop
        if(next(ii,1) != si->Items.end())
          ii++;
        else 
        {
          //cout << "Incremented sets and broke\n";
          needincrement = true;
          break;
        }
        continue;
      }
    //If character in front of cursor is same as parameter
    else if(i.rhs[i.cursorindex+1] == ac)
    {
      //Advance cursor
      //cout << "Old rhs: " << i.rhs << endl;
      i.rhs[i.cursorindex] = i.rhs[i.cursorindex+1];
      i.rhs[i.cursorindex+1] = '@';
      //cout << "New rhs: " << i.rhs << endl;


      i.cursorindex+=1;; 
      //cout << "Advanced cursor\n";

    }
    //Different character following cursor, break
    else 
        {
          if(ii == si->Items.end())
            needincrement = true;
          break;
        }
    //Add item to new set
    s.Items.push_back(i);
    //Advance iterator if not at end of loop
    if(next(ii,1) != si->Items.end())
      ii++;
    else 
        {
          ////cout << "In that else function\n";
          needincrement = true;
          break;
        }
  }
  bool failed = false;
  //cout << "Past loop!\n";
  ac = holder->rhs[holder->cursorindex+2];
  //If nonterminal take closure
  if(ac >= 65 && ac <= 90)
  {
    list<Item>::iterator itr;
    itr= Sets.begin()->Items.begin();
    itr++;

    while(itr->lhs[0] != ac)
    {
      //cout << "Skippin production: " << itr->lhs << ARROW << itr->rhs << endl;
      itr++;
    }

    //Cycle through grammar and identify lhs with same character as ac
    for(; itr !=Sets.begin()->Items.end();itr++)
    {
      if(itr == Sets.begin()->Items.end())
        break;
      //cout << " Taking closure.\n\n";
      //cout << "ac: " << ac << endl;
      //cout << "Current production: " << itr->lhs << ARROW << itr->rhs << endl;
      //if production matches nonterminal following cursor
      if(itr->lhs[0] == ac)
      {
        //Add to set
        //cout << "Adding to set\n";
        s.Items.push_back(*itr);      
        failed = true;
      //Advance iterator
      }
      else
      {
        if(itr !=Sets.begin()->Items.end() && itr->lhs[0] == prev(itr,1)->rhs[1]) 
        {
          //cout << "Adding to set ";
          //cout << "Current production: " << itr->lhs << ARROW << itr->rhs << endl;
          //cout << "Grabbing new ac\n";
          s.Items.push_back(*itr);                
          if(prev(itr,1)->cursorindex != prev(itr,1)->rhs.size()-1 && (prev(itr,1)->rhs[prev(itr,1)->cursorindex+1] >= 65 && prev(itr,1)->rhs[prev(itr,1)->cursorindex+1] <= 90))
            ac = prev(itr,1)->rhs[prev(itr,1)->cursorindex+1];
          //Oherwise exit loop
          else 
            break;
          failed = false;

        }
      }

    }

  }
  //Take first letter of rhs, if nonterminal, repeat

  

  //Check set against others for redundancy, if there is, delete it, return 

    //Add to set

    //Take first letter of rhs, if nonterminal, repeat
  




  Sets.push_back(s);
  //Check set against others for redundancy, if there is, delete it, return
  if(holder->cursorindex == holder->rhs.size()-1)
    holder->hasgoto = false;
  else
    holder->hasgoto = true;

  holder->gotonum = RemoveRedundancy();
  if(holder->gotonum == -1)
    holder->gotonum = s.number;
    
  holder->gotochar = holder->rhs[holder->cursorindex+1];

  return needincrement;
}

int RemoveRedundancy()
{
  Set suspect = Sets.back();
  list<Set>::iterator setitr;
  list<Item>::iterator itemitr,suspectitr;

  int match = 0;
  bool identical = false;

  if(suspect.Items.size() == 0)
  {
    Sets.pop_back();
    return 0;
  }

  //Loop through list of sets
  for(setitr = Sets.begin(); setitr != prev(Sets.end(),1); setitr++)
  {
    suspectitr = suspect.Items.begin();
    identical = true;
    if(setitr->Items.size() == 0)
      setitr = Sets.erase(setitr);
    //Loop through list of items in set
    for(itemitr = setitr->Items.begin(); itemitr != setitr->Items.end(); itemitr++)
    {
      if(setitr->Items.size() != suspect.Items.size() || suspectitr->lhs != itemitr->lhs || suspectitr->rhs != itemitr->rhs)
        {
          identical = false;
          break;
        }
        suspectitr++;
    }
    if(identical)
    {
      if(match != suspect.number)
        Sets.pop_back();
      return match;
    }      
    match++;
  }  

  return -1;
}


void ComputeI0()
{
  list<Item>::iterator itr;
  list<Item>::iterator Gritr;
  Set i0;
  Item *i;

  itr = i0.Items.begin();
  i0.number = 0;
  for(Gritr = Grammar.Items.begin(); Gritr != Grammar.Items.end(); Gritr++)
  {
    i = new Item();
    i->lhs = Gritr->lhs;
    i->rhs = Gritr->rhs;
    i->cursorindex = 0;
    i->rhs.insert(0,"@");
    //cout << "i rhs is: " << i->rhs << endl;
    i0.Items.push_back(*i);
    itr++;
  }
  Sets.push_back(i0);
}

void Print()
{
  cout << "Sets of LR(0) Items\n-------------------";
  list<Set>::iterator setitr;
  list<Item>::iterator itemitr;


  //Loop through list of sets
  for(setitr = Sets.begin(); setitr != Sets.end(); setitr++)
  {
    cout << "\nI" << setitr->number  <<":\n";
    //Loop through list of items in set
    for(itemitr = setitr->Items.begin(); itemitr != setitr->Items.end(); itemitr++)
    {
      if(itemitr->hasgoto)
        printf("   %s%s%-17s goto(%c)=I%d\n",itemitr->lhs.c_str(), ARROW.c_str(),itemitr->rhs.c_str(), itemitr->gotochar[0], itemitr->gotonum);
      else
        printf("   %s%s%-17s\n",itemitr->lhs.c_str(), ARROW.c_str(), itemitr->rhs.c_str());
    }
  }
  cout << "\n";
}

//Augment and Print grammar input
void AugmentGrammar()
{
  list<Item>::iterator itr;
  Grammar.Items.front().lhs = "'";
  cout << "Augmented Grammar\n";
  cout << "-----------------\n";
  for(itr = Grammar.Items.begin(); itr != Grammar.Items.end(); itr++)
  {
    cout << itr->lhs << ARROW << itr->rhs << endl;
  }
  cout << "\n";
}

void GetGrammar()
{
  string line;
  int count = 0;
  Item *i;
  while(getline(cin,line))
  {
    i = new Item();
    if(count != 0)
      DivideLine(i, line);
    else
      i->rhs = line;
    Grammar.Items.push_back(*i);
    count++;
  }
}

void DivideLine(Item* i, string line)
{
  char c; 
  char arr2[20];

  i->lhs = line[0];
  i->rhs = line.substr(3);

  return;

}