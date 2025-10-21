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
sexpressionlist: sexpressionlist sexpression | sexpression
	{printf("sexpressionlist\n");}
	       ;

sexpression: BEGINEXPRESSION sexpressionelementlist ENDEXPRESSION
	{printf("sexpression\n");}
	;

sexpressionelementlist: sexpressionelementlist sexpressionelement | sexpressionelement
	{printf("sexpressionelementlist\n");}
		      ;

sexpressionelement: STRINGATOM | IDENT | SYMBOLATOM | NUMBER | PLUS | MINUS
	{printf("sexpressionelement\n");}
	;
