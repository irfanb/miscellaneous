%{
  /* This is the prologue section. This code goes
  on the top of the parser implementation file. */
  #include <stdio.h>
  extern int yyerror(const char *message);
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
	   { /*printf("atom\n"); */ }
	   ;

expression: BEGINEXPRESSION ENDEXPRESSION
	  { /*printf("empty list"); */
	  $$.m_sequence = std::vector<member>();
	  }
	  | BEGINEXPRESSION members ENDEXPRESSION
	  { /*printf("non empty list"); */
	  $$.m_sequence = $2.m_sequence;
	  }
	  ;

members: sexpression
       {
       $$.m_sequence = $1.m_sequence;
       }
       | sexpression members
       {
       $$.m_sequence.push_back($2.m_member);
       }
       ;

atom: STRINGATOM | IDENT | SYMBOLATOM 
	{printf("string style atom %s\n", yylval.m_id); }
	| PLUS | MINUS
	{printf("operator atom\n"); }
    | NUMBER
	{printf("number atom %ld\n", yylval.m_num); }
	;
