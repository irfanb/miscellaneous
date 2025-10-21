%{
  /* This is the prologue section. This code goes
  on the top of the parser implementation file. */
  #include <stdio.h>
  extern int yyerror(char *message);
  extern int yylex(void);
#include "y.tab.h"
%}
 
/* Declarations of terminals */
%token  PLUS MINUS TIMES FORWARDSLASH SEMICOLON COMMA PERIOD EQUAL NOTEQUAL LESSTHAN GREATERTHAN LEQ GEQ IDENT NUMBER UNKNOWN STRINGATOM SYMBOLATOM BEGINEXPRESSION ENDEXPRESSION
 
%%
/* Grammar rules */

sexpression:
	   expression
	   { printf("expression\n"); }
	   | atom
	   { printf("atom\n"); }
	   ;

expression: BEGINEXPRESSION ENDEXPRESSION
	  { printf("empty list"); }
	  | BEGINEXPRESSION members ENDEXPRESSION
	  { printf("non empty list"); }
	  ;

members: sexpression | sexpression members;

atom: STRINGATOM | IDENT | SYMBOLATOM | NUMBER | PLUS | MINUS
	{printf("atom\n");}
	;
