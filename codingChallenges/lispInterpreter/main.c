#include <stdio.h>
//#include "foo.h"
#include "lex.yy.h"
#include "y.tab.h"
#include <iostream>
#include "absl/log/log.h"


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
  extern YYSTYPE yyval;
  LOG(INFO) << yylval.toString();
	sayhello();
	return result_code;
}
