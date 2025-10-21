%top{
  /* This goes at the top of the generated file */
#include "y.tab.h"
  #include "parser.tab.h"
}
%{
#include "parser.tab.h"

/* union YYSTYPE yylval; */
/* extern union YYSTYPE yylval; */
size_t lineNumber = 1;
%}

digit         [0-9]
letter        [a-zA-Z]
doublequote   ["]
colon   [:]
lparen   [(]
rparen   [)]
identifier {letter}({letter}|{digit}|-)*
number {digit}+
stringatom {doublequote}[^"]*{doublequote}
symbolatom {colon}{identifier}

%%
{identifier} {
	yylval.m_id( strdup(yytext) );
	//printf("%ld: found id %s\n", lineNumber, yylval.id);
	return IDENT;
	}
{stringatom} {
	yylval.m_id( strdup(yytext) );
	//printf("%ld: found STRINGATOM %s\n", lineNumber, yylval.id);
	return STRINGATOM;
	}
{symbolatom} {
	yylval.setStringAtom( yytext );
	//printf("found SYMBOLATOM %s\n", yylval.id);
	return SYMBOLATOM;
	}
{lparen} {
	//printf("%ld: found BEGINEXPRESSION %s\n", lineNumber, yytext);
	return BEGINEXPRESSION;
	}
{rparen} {
	//printf("%ld: found ENDEXPRESSION %s\n", lineNumber, yytext);
	return ENDEXPRESSION;
	}
{number} {
	yylval.m_num( atoi(yytext) );
	//printf("%ld: found number %d\n", lineNumber, yylval.num);
	return NUMBER;
	}
[+] {
	//printf("%ld: found PLUS\n", lineNumber);
	yylval.setOperator("+");
	return PLUS;
	}
[-] {
	//printf("%ld: found MINUS\n", lineNumber);
	yylval.setOperator("-");
	return MINUS;
	}
[\n] {
	++lineNumber;
	}
[ \t\r] {
	//printf("/* skip whitespace */\n");
	}
.                    { printf("Unknown character [%c]\n",yytext[0]);
                       return UNKNOWN;    }
%%

int yywrap(void){return 1;}
