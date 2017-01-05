/****************************************
*										*
*	Yasser Atiya						*
*	COP5621								*
*	Asg 1 (Scanner for C Language)		*
*	g++ -g -o cscan cscan.cpp			*
*										*
*****************************************/


#include <iostream>
#include <stdio.h>
#include <fstream>
#include <string>
#include <vector>
#include <iomanip>
using namespace std;

//Struct for token
struct Token{

	Token()													//Default constructor
	{
		count = 1;
		isident = false;
		isstring = false;
		isnumber = false;
		ischarliteral = false;
	}

	int count;												//Number of token occurences
	string contents;										//Token physical representation
	bool isident, isstring, isnumber, ischarliteral;		//Bool identifying type of token
};

//Variables
string GlobalWord;											//Word being worked on
int line = 1;											//Line number

//Vectors and Iterators
vector<Token> Tokens;										//Vector containing captured tokens
vector<Token>::iterator itr;								//Iterator for access vector

//Prototypes
void Parse();												//Iterates through input, determines type
void Print();												//Prints all captured tokens and counts
void AddtoVector(Token t);									//Adds Token to vector or increments token count
bool isOneCharToken(char c);								//Checks if One character token
bool isTwoCharToken(char c, char c2);						//Checks if Two character token
bool isTwoorThreeCharToken(char c);							//Checks if token is possible three or two char token
bool isNumber(char c);										//Checks if token is number
bool isIdentifier(char c);									//Checks if token is identifier
bool isCharLiteral(char c);									//Checks if token is character literal
bool isString(char c);										//Checks if token is string
void SortVector();											//Sorts vector by most encountered token and length of contents
void IgnoreComment(char c);									//Checks for comment and ignores it


int main()													//Main
{
	Parse();												//Call parser
	Print();												//Print results of parser
}

void Parse()												//Picks up tokens one by one, checks type, adds to vector
{
	string word;											//Contents of current token
	char c;													//Current character

	while(!cin.eof())										//While we have not reached the end of the file
	{
		GlobalWord = "\0";
		Token* t = new Token();								//Creates token object we will populate
//		cout << "\nCreating new token.\n"; 

		cin.get(c);											//Acquire next character from stream

//			cout << c << " is the character we picked up.\n";

		if(c == '\n')										//Encountered newline, 
		{
			line++;												//Increment line count
//			cout << "Newline encountered. Now on line: " << line << endl;
			continue;											//Do not add to vector, continue to next loop iteration
		}
		else if(isspace(c))									//Encountered whitespace
		{
//			cout << c << " is white space.\n";
			continue;											//Do not add to vector, continue to next character
		}
		else if(isTwoCharToken(c,cin.peek()))				//Check if char aquired is part of two character token
		{
			word = c;											//Add both characters to word
			cin.get(c);
			word.push_back(c);
//			cout << word << " is two character token.\n";
		}		
		else if(isTwoorThreeCharToken(c))					//Check if char aquired is part of two or three character token
		{
			word = GlobalWord;									//Set word we grabbed to word gathered from function
//			cout << word << " is two or three character token.\n";
		}
		else if(isOneCharToken(c))							//Check if char is standalone token
		{
			word = c;											//Set word to grabbed token
//			cout << word << " is one character token.\n";
		}
		else if(isNumber(c))								//Check if char is number
		{
			word = GlobalWord;									//Set word to number token grabbed from function
			t->isnumber = true;									//Set boolean to identify type of token is number
//			cout << word << " is Number.\n";
		}
		else if(isIdentifier(c))							//Check if char is part of identifier
		{
			word = GlobalWord;									//Set word to token grabbed from function
			t->isident = true;									//Set boolean to identify token is identifier
//			cout << word << " is identifier.\n";
		}
		else if(isString(c))								//Check if char is Ditto
		{
			word = GlobalWord;									//Set word to token grabbed from function
			t->isstring = true;									//Set boolean to identify token as string
//			cout << word << " is string.\n";
		}
		else if(isCharLiteral(c))							//Check if char is '
		{
			word = GlobalWord;									//Set word to token grabbed from function
			t->ischarliteral = true;							//Set bool to identify token as character literal
//			cout << word << " is Character literal.\n";
		}
		else												//Ignore cases
		{
			if(c == '/')										//Possible comment
			{
//				cout << "Got a comment.\n";
				IgnoreComment(c);								//Check if comment and ignore
				continue;										//Do not add to vector, continue loop
			}
			else if(isspace(GlobalWord[0]))
				continue;
			else											//Character added does not fit any types, so ignore
			{
				cerr << "illegal character: " << c  << " on line " << line << endl;	//Print out error
				continue;										//Do not add to vector, grab next character
			}
		}

		t->contents = word;									//Set contents of token to grabbed characters

		AddtoVector(*t);									//Add populated token to vector	
		
	}
}

void AddtoVector(Token t)									//Takes token and adds to vector or increments that tokens count
{
	cout << t.contents << endl;
	for(itr = Tokens.begin(); itr != Tokens.end(); itr++)		//Loop through tokens
	{

//		cout << "Compared word: " << itr->contents << " \nNew word: " << t.contents << endl;
		if(t.contents == itr->contents)								//Match found
		{
			if(itr->isident || itr->isnumber || itr->ischarliteral || itr->isstring)	//Is not a special type of token
				break;													//Do not increment count

			itr->count++;											//Increase count of token encounters
//			cout << "Word " << itr->contents << " repeated" << endl;
//			cout << t.contents << endl;								//Print character
			return;													//Do not add to vector		
		}
	}
	
//	cout << "Word add successful: " << t.contents << endl;
	Tokens.push_back(t);										//Add new token to vector

}

void Print()												//Print all gathered tokens and count of tokens
{
	Token t1,t2,t3,t4;											//Create tokens for the different types of tokens: Number, string, Identifier, Character literal
	t1.contents = "number";
	t2.contents = "string";
	t3.contents = "ident";
	t4.contents = "char";

	t1.count = t2.count = t3.count = t4.count = 0;				//Set counts for these different types of tokens to 0

	for(itr = Tokens.begin(); itr != Tokens.end(); itr++)		//Print out all gathered tokens, and increment number of types
	{
//		cout << itr->contents << endl;								//Print out token content

		if(itr->isnumber)											//Found type of token, increment its type 
		{
			t1.count++;
		}
		else if(itr->isident)
		{
			t3.count++;
		}
		else if(itr->ischarliteral)
		{
			t4.count++;
		}
		else if(itr->isstring)
		{
			t2.count++;
		}

		if(itr->ischarliteral || itr->isstring || itr-> isident || itr->isnumber)	//Token is of type we are counting, we don't need individual count
		{
//			cout << itr->contents << " erased.\n";
			Tokens.erase(itr);															//Erase individual token, vector will auto adjust
			itr--;																		//Back up iterator to get new token
		}
	}

	if(t4.count != 0)																//Type of token is present, add it to vector
		Tokens.insert(Tokens.begin(),t4);
	if(t3.count != 0)
		Tokens.insert(Tokens.begin(),t3);
	if(t2.count != 0)
		Tokens.insert(Tokens.begin(),t2);
	if(t1.count != 0)
		Tokens.insert(Tokens.begin(),t1);



	cout << "\n" << setw(13) << "token" << setw(16) << "count\n";					//Print header
	cout  << "---------------------" << setw(8) << "-----\n";					

	
	SortVector();																	//Sort vector to descending order of token count 	
	
	for(itr = Tokens.begin(); itr != Tokens.end(); itr++)							//Print out tokens in sorted order
	{
		cout << setw(21) << itr->contents  << setw(7) << itr->count << endl;
	}

}

bool isOneCharToken(char c)											//See if grabbed character is one of the one character tokens
{
	switch(c)															//Compare grabbed token to list of accepted one char tokens			
	{
		case '(':
		case ')':
		case '*':
		case '+':
		case '-':
		case '=':
		case ',':
		case '.':
		case '!':
		case ':':
		case ';':
		case '?':
		case '[':
		case ']':
		case '{':
		case '}':
		case '~':
		case '<':
		case '>':
		case '&':
		case '%':
		case '|':
			return true;
		default:
			return false;
	}
}

bool isTwoCharToken(char c, char c2)						//See if grabbed character and peeked character are part of a character token
{
	if(c == '&' && c2 == '&')									//Compare two to accepted two character tokens				
	{
		return true;
	}
	else if(c == '|' && c2 == '|')
	{
		return true;
	}
	else if(c == '+' && c2 == '+')
	{
		return true;
	}
	else if(c == '-' && c2 == '-')
	{
		return true;
	}
	else if(c == '-' && c2 == '>')
	{
		return true;
	}
	else 
	{
		return false;
	}

}

bool isTwoorThreeCharToken(char c)										//See if character is a part of optional two or three character token
{
	switch(c)																//See if first token is part of an accepted two character token
	{
		case '|':
		case '^':
		case '&':
		case '+':
		case '-':
		case '%':
		case '*':
		case '/':
		case '=':
		case '!':															//Check rest
		{
			if(cin.peek() == '=')
			{
				GlobalWord = c;
				cin.get(c);
				GlobalWord.push_back(c);
				return true;
			}

			break;
		}	
		case '>':															//See if arrow is followed by other arrow
		case '<':
		{
			GlobalWord = c;

			if(cin.peek() == c)
			{
				cin.get(c);
				GlobalWord.push_back(c);											

				if(cin.peek() == '=')											//Check for optional = character
				{
					cin.get(c);
					GlobalWord.push_back(c);
				}

				return true;
			}
			else if(cin.peek() == '=')										//Check if just <= or >=
			{
				cin.get(c);
				GlobalWord.push_back(c);

				return true;
			}

		}

	}

	return false;
}

bool isNumber(char c)												//See if character is number, pick up all subsequent number characters till whitespace
{
	if(isdigit(c))														//Check first character
	{
		GlobalWord = c;														//We have a number, add it to the token we're making
		c = cin.peek();														//Store next character but do not grab it
		while(isdigit(c) && c != cin.eof())									//While we keep getting numbers
		{
			cin.get(c);															//Grab the next character
			GlobalWord.push_back(c);											//Add it
			c = cin.peek();														//See what the next character is
		}
		return true;
	}
	else 
		return false;
}

bool isIdentifier(char c)											//See if character is start of an identifier
{
	
	if(isalpha(c) || c == '_')											//We have a character or _, we need the rest of the identifier
	{
		GlobalWord = c;													//Add c to token we are making
		c = cin.peek();													//Store next character but don't grab it
		while((isalnum(c) | c == '_') && c != cin.eof())				//While we keep getting alphanumeric characters (or whitespaces)
		{
			cin.get(c);														//Pick up the next character
			GlobalWord.push_back(c);										//Add it to the word
			c = cin.peek();													//See what the next characte
		}
		return true;
	}
	else
		return false;
		
}

bool isCharLiteral(char c)											//Determines if character is part of character literal
{
	if(c == '\'')														//See if character passed in is openning quote
	{
		GlobalWord = c;													//Add character to word we're producing

		if(cin.peek() == '\'')											//Check for empty literal
		{
			cin.get(c);														//Get next character
			cerr <<	"character has zero length on line " << line << endl;	//Print error message
			GlobalWord = " ";
			return false;
		}

		do																//Take everything until next quote
		{
			cin.get(c);														//Get next character
			GlobalWord.push_back(c);										//Add character to word
//			cout << "c is: " << c << " Peek is: " << (char)cin.peek() << endl;

			if(cin.peek() == '\n')											//Ensure that character literal closes before new line
			{
				cin.get(c);																//Get newline
				cerr << "missing ' for " << GlobalWord << " on line " << line << endl;	//Print error message
				line++;																	//Increment line number
				GlobalWord = " ";														//Reset global token contents
				return false;															//Indicate false token
			}
			if(cin.peek() == '\\' && c == '\\')								//Encountering \\ in char literal 
			{
				cin.get(c);			
																			//Get next character
				if(cin.peek() == '\'')										//Encountered end of literal
				{
					GlobalWord.push_back(c);										//Add character to word
					break;
				}
				else
					cin.putback(c);											//We have made a mistake, put last character back
			}
			if(cin.peek() == '\''){											//Encountering delimited '
				if(c == '\\')
					continue;
//				cout << "Next character is '. breaking \n";
				break;
			}
			if(cin.peek() == cin.eof()){									//Encountering end of file
//				cout << "Next character is eof. breaking \n";
				break;
			}
		}
		while(true);

		cin.get(c);															//Get end quote
		GlobalWord.push_back(c);											//Add it to to token

		if(GlobalWord.length() > 4 || GlobalWord[1] != '\\' && GlobalWord.length() > 3)				//Checks length of character literal
		{
			cerr <<	"character constant " << GlobalWord << " too long on line " << line << endl;	//Print error message
			GlobalWord = " ";
			return false;
		}

		return true;
	}
	else 
		return false;

}

bool isString(char c)														//Check if encountered character is beginning of string
{

	if(c == '"')																//The character is a ditto
	{
//	cout << "\n Identified string beginning. \n";
//	cout << "C is: " << (char)c << " Peek is: " << (char)cin.peek() << endl;

		GlobalWord = c;															//Add character to current token

		if(cin.peek() == '\n')
		{
			cerr << "missing \" for " << GlobalWord << " on line " << line << endl;	//Print error message for unfinished string		
//			line++;
			GlobalWord = " ";														//Reset global token contents
			return false;
		}
		else if(cin.peek() == '"')
		{
			cin.get(c);																//Grab final ditto
			GlobalWord.push_back(c);												//Add to string token
			return true;	
		}


		do 																		//Until next ditto grab characters
		{

			cin.get(c);																//Grab next token
			GlobalWord.push_back(c);												//Add character to new token

//			cout << "C is: " << c << " Peek is: " << (char)cin.peek() << endl;

			if(cin.peek() == '\n')
			{
				cerr << "missing \" for " << GlobalWord << " on line " << line << endl;	//Print error message for unfinished string		
//				line++;
				GlobalWord = " ";														//Reset global token contents
				return false;
			}
			if(cin.peek() == '"' && c != '\\'){										//Next character is a ditto and current is a delimiter
//				cout << "Next character is \". breaking \n";
				break;																//End loop
			}
			else if(cin.peek() == cin.eof()){										//About to reach end of file
//				cout << "Next character is eof. breaking \n ";
				break;																//End loop
			}
		}
		while(true);

		cin.get(c);																//Grab final ditto
		GlobalWord.push_back(c);												//Add to string token
		
		return true;	
	}
	else 
		return false;
}

void SortVector()															//Arrange vector by count in descending order
{
	bool sorted = false;														//Flag indicating if whether the vector has been sorted
	while(!sorted)																//While not sorted
	{
		sorted = true;																//Indicated sorted until learning otherwise
		for(itr = Tokens.begin(); itr != Tokens.end(); itr++)						//Move through vector
		{
//			cout << "Tokens compared: " << itr->contents << ", " << (itr+1)->contents << endl;
			if(itr != Tokens.end()-1 && (itr->count < (itr+1)->count || (itr->contents.length() < (itr+1)->contents.length() && itr->count == (itr+1)->count) || (itr->contents > (itr+1)->contents && itr->count == (itr+1)->count && itr->contents.length() == (itr+1)->contents.length())))		//Compare counts and lengths of token names
			{
				sorted = false;															//Indicate vector is unsorted
//				cout << "Tokens swapped: " << itr->contents << ", " << (itr+1)->contents << endl;
				int holder;																//Holder int for swap
				holder = itr->count;													//Swap count
				itr->count = (itr+1)->count;
				(itr+1)->count = holder;
				itr->contents.swap((itr+1)->contents);									//Swap contents
			}

		}
	}
}

void IgnoreComment(char c)									//Checks if character is beginning of comment, if so picks it all up to be ignored
{
	int nlcount = 0;
	string s;
	s = c;														//Add character to comment

//	cout << "Next character is: " << (char)cin.peek() << endl;
	if(cin.peek() == '/')										//There is another /, indicating a line comment
	{
		getline(cin,s);												//Grab the entire line
//		cout << "Got line comment: " << s;
	}	
	else if(cin.peek() == '*')									//There is a * coming up, indicating a multiline comment
	{
//		cout << "Got multiline comment: ";
		do 															//Grab every characterunti next */
		{
			cin.get(c);													//Grab next character
			if(c == '\n'){
				line++;
				nlcount++;
			}
//			cout << (char)c;											
			if(c == '*' && cin.peek() == '/')								//Found */
				break;															//Exit loop
			if(cin.peek() == cin.eof() || nlcount > 10000)					//Reached end of file without closing comment, unclosed comment
			{
				cerr << "unclosed comment\n";
				return;
			}
		}
		while(true);

		cin.get(c);													//Grab final /

	}
}
