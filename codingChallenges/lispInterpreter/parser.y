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

extern size_t lineNumber;
#define MYLOG 	LOG(INFO) << "line " << lineNumber << ": "
%}
 
/* Declarations of terminals */
%token  PLUS MINUS TIMES FORWARDSLASH SEMICOLON COMMA PERIOD EQUAL NOTEQUAL LESSTHAN GREATERTHAN LEQ GEQ IDENT NUMBER UNKNOWN STRINGATOM SYMBOLATOM BEGINEXPRESSION ENDEXPRESSION
%start program
 
%%
/* Grammar rules */

program: sexpression
       {
       MYLOG << " " << $1.toString();
       MYLOG << " " << $$.toString();
       }
       ;
sexpression:
       expression
       {
       MYLOG << " expression ( " << $1.toString() << " )";
       $$ = $1;
       }
       | atom
       {
       MYLOG << "atom " << $1.toString();
       $$ = $1;
       }
       ;

expression:
    BEGINEXPRESSION members ENDEXPRESSION
    {
        $$ = $2;
       MYLOG << " ( " << $2.toString() << " )";
    }
    ;

members:
       /* empty */
       {
	mysemantictype emptySemanticType;
	emptySemanticType.setNull();
	//MYLOG << "emptySemanticType is " << emptySemanticType.toString();
	$$ = emptySemanticType;
       }
       | members sexpression
       {
       MYLOG << "members is '" << $1.toString() << "' sexpression is '" << $2.toString() << '\'';
       std::vector< mysemantictype > s;
       s.push_back($1);
       s.push_back($2);
       $$.setSequence( s );
       }
       ;

atom: STRINGATOM 
    {
	//LOG(INFO) << $1.toString();
	//LOG(INFO) << "string style atom " << yylval.m_id();
	//$$ = StringAtom($1);
    }
    | IDENT 
    {
	//LOG(INFO) << $1.toString();
        //$$ = IdentifierAtom($1);
    }
    | SYMBOLATOM
    {
	//LOG(INFO) << $1.toString();
    	//$$ = SymbolAtom($1);
    }
    | PLUS | MINUS
    {
	//LOG(INFO) << $1.toString();
	//$$ = Operator($1);
    }
    | NUMBER
    {
	//LOG(INFO) << $1.toString();
	$$ = $1;
    }
    ;
