#include <stdio.h>
#include "foo.h"


//extern int yylex();
extern int yyparse (void);
extern size_t lineNumber;

void yyerror(char const *message) {
	printf("Error: %s %ld\n", message, lineNumber);
}
void sayhello();

int main(int argc, char* argv[])
{
	yyin = stdin;
	int result_code = yyparse();
	sayhello();
	return result_code;
}
