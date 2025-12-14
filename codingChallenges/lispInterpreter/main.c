#include <stdio.h>
#include "absl/log/log.h"
#include "ast.h"
#include "lex.yy.h"
#include "parser.tab.h"
#include <iostream>

// extern int yylex();
extern int yyparse( void );
extern size_t lineNumber;

void yyerror( char const *message ) {
    printf( "Error: %s %ld\n", message, lineNumber );
}
void sayhello();

void execute(const mysemantictype& ast) {
		std::string r;
        const auto executeVisitor = [&r]( auto &&arg ) {
            using T = std::decay_t<decltype( arg )>;
            if constexpr ( std::is_same_v<T, int> ) {
                r = "";
            } else if constexpr ( std::is_same_v<T, NumberAtom> ) {
                //if (arg.m_isQuoted) r += "'";
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, Null> ) {
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, IdentifierAtom> ) {
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, SymbolAtom> ) {
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, StringAtom> ) {
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, Operator> ) {
                r += arg.toString();
            } else if constexpr ( std::is_same_v<T, mysemantictype::Sequence> ) {
		    //if (arg.m_isQuoted) r += "'";
		    //if (arg.m_isList) r+= "(";
                for ( const auto &a : arg ) {
                    r += a.toString();
                }
		    //if (arg.m_isList) r+= ")";
            } else {
                r += "plop";
            }
        };
	ast.execute( executeVisitor );
	std::cout <<"execute says "<<r <<std::endl;
}

int main( int argc, char *argv[] ) {
	bool fileOpened = true;
	if (argc > 1) {
		LOG(INFO) <<"input file is "<< argv[1];
		yyin = fopen(argv[1], "r");
	} else {
	    yyin = stdin;
	}
    int result_code = yyparse();
    if ( fileOpened ) fclose( yyin );
    extern YYSTYPE parseResult;
    std::cout << " address of parseResult is " << &parseResult << " and string representation is " << parseResult.toString() <<std::endl;
    sayhello();
    execute(parseResult);
    return result_code;
}
