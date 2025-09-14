#include <stdio.h>
#include "foo.h"


extern int yylex();

int main(int argc, char* argv[])
{
	yyin = stdin;
	while (yylex() != 0);
	return 0;
}
