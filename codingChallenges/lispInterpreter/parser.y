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
       {
       $$ = $1;
       //LOG(INFO) << "( " << $$.toString() << " )";
       }
       | atom
       {
       //LOG(INFO) << "atom " << $1.toString();
       $$ = $1;
       }
       ;

expression:
    BEGINEXPRESSION ENDEXPRESSION
    {
        //$$.m_sequence( std::vector<mysemantictype>() );
    mysemantictype emptySemanticType;
    emptySemanticType.setEmptySequence();
        //LOG(INFO) << "emptySemanticType is " << emptySemanticType.toString();
        $$ = emptySemanticType;
    }
    |
    BEGINEXPRESSION members ENDEXPRESSION
    {
        //LOG(INFO) << "members is " << $1.toString();
        $$ = $1;
    }
    ;

members: sexpression
       {
       //LOG(INFO) << "sexpression is " << $1.toString();
       $$ = $1;
       }
       | sexpression members
       {
       //LOG(INFO) << "sexpression is " << $1.toString() << " members is " << $2.toString();
       //const auto jkl = $2.getSequence();
       std::vector< mysemantictype > s;
       s.push_back($1);
       s.push_back($2);
       $$.setSequence( s );
       }
       ;

atom: STRINGATOM 
    {
	LOG(INFO) << $1.toString();
	//LOG(INFO) << "string style atom " << yylval.m_id();
	//$$ = StringAtom($1);
    }
    | IDENT 
    {
	LOG(INFO) << $1.toString();
        //$$ = IdentifierAtom($1);
    }
    | SYMBOLATOM
    {
	LOG(INFO) << $1.toString();
    	//$$ = SymbolAtom($1);
    }
    | PLUS | MINUS
    {
	LOG(INFO) << $1.toString();
	//$$ = Operator($1);
    }
    | NUMBER
    {
	LOG(INFO) << $1.toString();
    }
    ;
