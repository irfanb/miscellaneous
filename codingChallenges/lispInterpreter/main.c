#include <stdio.h>
#include "absl/log/log.h"
#include "ast.h"
#include "lex.yy.h"
#include "parser.tab.h"

// extern int yylex();
extern int yyparse( void );
extern size_t lineNumber;

void yyerror( char const *message ) {
    printf( "Error: %s %ld\n", message, lineNumber );
}
void sayhello();

int main( int argc, char *argv[] ) {
	bool fileOpened = true;
	if (argc > 1) {
		LOG(INFO) <<"input file is "<< argv[1];
		yyin = fopen(argv[1], "r");
	} else {
	    yyin = stdin;
	}
    int result_code = yyparse();
    extern YYSTYPE yyval;
    LOG( INFO ) << yylval.toString();
    sayhello();
    if ( fileOpened ) fclose( yyin );
    return result_code;
}
