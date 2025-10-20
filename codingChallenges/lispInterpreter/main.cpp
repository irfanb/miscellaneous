#include <stdio.h>
#define yywrap_ALREADY_DEFINED 1
#include "lex.yy.h"


//extern int yylex();

int main(int argc, char* argv[])
{
	yyFlexLexer myLexer;

	//yyin = stdin;
	while (myLexer.yylex() != 0);
	return 0;
}
