%{
  /* This is the prologue section. This code goes
  on the top of the parser implementation file. */
  #include <stdio.h>
  extern int yyerror(const char *message);
  extern int yylex(void);
#include <iostream>
#include "y.tab.h"

#include "absl/log/log.h"
#include "absl/log/check.h"

%}
 
/* Declarations of terminals */
%token  PLUS MINUS TIMES FORWARDSLASH SEMICOLON COMMA PERIOD EQUAL NOTEQUAL LESSTHAN GREATERTHAN LEQ GEQ IDENT NUMBER UNKNOWN STRINGATOM SYMBOLATOM BEGINEXPRESSION ENDEXPRESSION
 
%%
/* Grammar rules */

sexpression:
	   expression
	   { LOG(INFO) << "expression " << $1.toString(); }
	   | atom
	   { LOG(INFO) << "atom " << $1.toString(); }
	   ;

expression: BEGINEXPRESSION ENDEXPRESSION
	  { /*printf("empty list"); */
	  $$.m_sequence( std::vector<member>() );
	  }
	  | BEGINEXPRESSION members ENDEXPRESSION
	  { /*printf("non empty list"); */
       LOG(INFO) << "members is " << $1.toString();
	  }
	  ;

members: sexpression
       {
       LOG(INFO) << "sexpression is " << $1.toString();
       }
       | sexpression members
       {
	LOG(INFO) 
       << "sexpression is " << $1.toString() << " members is " << $2.toString();
       }
       ;

atom: STRINGATOM | IDENT | SYMBOLATOM 
	{LOG(INFO) << "string style atom " << yylval.m_id(); }
	| PLUS | MINUS
	{LOG(INFO) << "operator atom"; }
    | NUMBER
	{printf("number atom %ld\n", yylval.m_num()); }
	;
