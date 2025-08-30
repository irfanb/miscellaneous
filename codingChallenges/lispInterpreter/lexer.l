%{
#include "y.tab.h"
#define PLUS 1
#define MINUS 2
#define TIMES 3
#define FORWARDSLASH 4
#define SEMICOLON 7
#define COMMA 8
#define PERIOD 9
#define EQUAL 10
#define NOTEQUAL 11
#define LESSTHAN 12
#define GREATERTHAN 13
#define LEQ 14
#define GEQ 15
#define IDENT 16
#define NUMBER 17
#define UNKNOWN 18
#define STRINGATOM 19
#define SYMBOLATOM 20
#define EXPRESSION 21

union YYSTYPE yylval;
%}

digit         [0-9]
letter        [a-zA-Z]
doublequote   ["]
colon   [:]
lparen   [(]
rparen   [)]
identifier {letter}({letter}|{digit})*
number {digit}+

%%
"+"                  { return PLUS;       }
"-"                  { return MINUS;      }
"*"                  { return TIMES;      }
"/"                  { return FORWARDSLASH;      }
";"                  { return SEMICOLON;  }
","                  { return COMMA;      }
"."                  { return PERIOD;     }
"="                  { return EQUAL;        }
"<>"                 { return NOTEQUAL;        }
"<"                  { return LESSTHAN;        }
">"                  { return GREATERTHAN;        }
"<="                 { return LEQ;        }
">="                 { return GEQ;        }
{identifier} {
                       yylval.id = strdup(yytext);
		       printf("found id %s\n", yylval.id);
                       return IDENT;      }
{doublequote}[^"]*{doublequote} {
                       yylval.id = strdup(yytext);
		       printf("found STRINGATOM %s\n", yylval.id);
                       return STRINGATOM;      }
{colon}{identifier} {
                       yylval.id = strdup(yytext);
		       printf("found SYMBOLATOM %s\n", yylval.id);
                       return SYMBOLATOM;      }
{lparen}({identifier}|{number})*{rparen} {
		       printf("found EXPRESSION %s\n", yytext);
		       return EXPRESSION;
		       }
{number} {
                       yylval.num = atoi(yytext);
		       printf("found number %d\n", yylval.num);
                       return NUMBER;
		       }
[ \t\n\r]            /* skip whitespace */
.                    { printf("Unknown character [%c]\n",yytext[0]);
                       return UNKNOWN;    }
%%

int yywrap(void){return 1;}
