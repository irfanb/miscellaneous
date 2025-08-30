%{
#include "y.tab.h"
#define PLUS 1
#define MINUS 2
#define TIMES 3
#define FORWARDSLASH 4
#define LPAREN 5
#define RPAREN 6
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



union YYSTYPE yylval;
%}

digit         [0-9]
letter        [a-zA-Z]

%%
"+"                  { return PLUS;       }
"-"                  { return MINUS;      }
"*"                  { return TIMES;      }
"/"                  { return FORWARDSLASH;      }
"("                  { return LPAREN;     }
")"                  { return RPAREN;     }
";"                  { return SEMICOLON;  }
","                  { return COMMA;      }
"."                  { return PERIOD;     }
"="                  { return EQUAL;        }
"<>"                 { return NOTEQUAL;        }
"<"                  { return LESSTHAN;        }
">"                  { return GREATERTHAN;        }
"<="                 { return LEQ;        }
">="                 { return GEQ;        }
{letter}({letter}|{digit})* {
                       yylval.id = strdup(yytext);
		       printf("found id %s", yylval.id);
                       return IDENT;      }
{digit}+             { yylval.num = atoi(yytext);
		       printf("found number %d", yylval.num);
                       return NUMBER;     }
[ \t\n\r]            /* skip whitespace */
.                    { printf("Unknown character [%c]\n",yytext[0]);
                       return UNKNOWN;    }
%%

int yywrap(void){return 1;}
