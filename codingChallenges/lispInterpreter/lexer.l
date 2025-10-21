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
	yylval.id = strdup(yytext);
	printf("found id %s\n", yylval.id);
	return IDENT;
	}
{stringatom} {
	yylval.id = strdup(yytext);
	printf("found STRINGATOM %s\n", yylval.id);
	return STRINGATOM;
	}
{symbolatom} {
	yylval.id = strdup(yytext);
	printf("found SYMBOLATOM %s\n", yylval.id);
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
	yylval.num = atoi(yytext);
	printf("%ld: found number %d\n", lineNumber, yylval.num);
	return NUMBER;
	}
[+] {
	printf("%ld: found PLUS\n", lineNumber);
	return PLUS;
	}
[-] {
	printf("%ld: found MINUS\n", lineNumber);
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
