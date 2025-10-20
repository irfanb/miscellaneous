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
#define EXPRESSIONELEMENT 22
#define ENDEXPRESSION 23

union YYSTYPE yylval;
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
%s BEGINEXPRESSION

%%
"+"                  {
printf("found PLUS\n");
return PLUS;       }
"-"                  {
printf("found MINUS\n");
return MINUS;      }
"*"                  {
printf("found TIMES\n");
return TIMES;      }
"/"                  {
printf("found FORWARDSLASH\n");
return FORWARDSLASH;      }
";"                  {
printf("found SEMICOLON\n");
return SEMICOLON;  }
","                  {
printf("found COMMA\n");
return COMMA;      }
"."                  {
printf("found PERIOD\n");
return PERIOD;     }
"="                  {
printf("found EQUAL\n");
return EQUAL;        }
"<>"                 {
printf("found NOTEQUAL\n");
return NOTEQUAL;        }
"<"                  {
printf("found LESSTHAN\n");
return LESSTHAN;        }
">"                  {
printf("found GREATERTHAN\n");
return GREATERTHAN;        }
"<="                 {
printf("found LEQ\n");
return LEQ;        }
">="                 {
printf("found GEQ\n");
return GEQ;        }
{identifier} {
                       yylval.id = strdup(yytext);
		       printf("found id %s\n", yylval.id);
                       return IDENT;      }
{stringatom} {
                       yylval.id = strdup(yytext);
		       printf("found STRINGATOM %s\n", yylval.id);
                       return STRINGATOM;      }
{symbolatom} {
                       yylval.id = strdup(yytext);
		       printf("found SYMBOLATOM %s\n", yylval.id);
                       return SYMBOLATOM;      }
{lparen} {
		       printf("found BEGINEXPRESSION %s\n", yytext);
			BEGIN(BEGINEXPRESSION);
			}
<BEGINEXPRESSION>{rparen} {
		       printf("found ENDEXPRESSION %s\n", yytext);
		       return ENDEXPRESSION;
		       }
<BEGINEXPRESSION>{identifier} {
		       printf("found EXPRESSIONELEMENT %s\n", yytext);
		       return EXPRESSIONELEMENT;
		       }
<BEGINEXPRESSION>{number} {
		       printf("found EXPRESSIONELEMENT %s\n", yytext);
		       return EXPRESSIONELEMENT;
		       }
<BEGINEXPRESSION>{symbolatom} {
		       printf("found EXPRESSIONELEMENT %s\n", yytext);
		       return EXPRESSIONELEMENT;
		       }
{number} {
                       yylval.num = atoi(yytext);
		       printf("found number %d\n", yylval.num);
                       return NUMBER;
		       }
[\n] {
++lineNumber;
}
[ \t\r]            /* skip whitespace */
.                    { printf("Unknown character [%c]\n",yytext[0]);
                       return UNKNOWN;    }
%%

int yywrap(void){return 1;}
