#include <stdio.h>
#include "absl/log/log.h"
#include "ast.h"
#include "lex.yy.h"

// extern int yylex();
extern int yyparse( void );
extern size_t lineNumber;

void yyerror( char const *message ) {
    printf( "Error: %s %ld\n", message, lineNumber );
}
void sayhello();

int main( int argc, char *argv[] ) {
	if (argc > 1) {
		LOG(INFO) <<"input file is "<< argv[1];
	} else {
	    yyin = stdin;
	}
    int result_code = yyparse();
    extern YYSTYPE yyval;
    LOG( INFO ) << yylval.toString();
    sayhello();
    return result_code;
}
