%{
  /* This is the prologue section. This code goes
  on the top of the parser implementation file. */
  #include <stdio.h>
  extern int yyerror(const char *message);
  extern int yylex(void);
#include <iostream>
#include "ast.h"

#include "absl/log/log.h"
#include "absl/log/check.h"

extern size_t lineNumber;
#define MYLOG 	LOG(INFO) << "line " << lineNumber << ": "
YYSTYPE parseResult;
%}
 
/* Declarations of terminals */
%token  PLUS MINUS TIMES FORWARDSLASH SEMICOLON COMMA PERIOD EQUAL NOTEQUAL LESSTHAN GREATERTHAN LEQ GEQ IDENT NUMBER UNKNOWN STRINGATOM SYMBOLATOM BEGINEXPRESSION ENDEXPRESSION SINGLEQUOTE
%start exprs
 
%%
/* Grammar rules */

exprs: /* empty */
     {
       //MYLOG << "found an empty thingy";
     /*
       mysemantictype s;
       s.setNull();
	     $$ = s;
	     */
	     mysemantictype mst;
       mst.setEmptySequence();
       $$ = mst;
       //MYLOG << "$$ is " << $$.toString();
     }
     | exprs expr
       {
       /*
       MYLOG << "exprs is " << $1.toString()
       << "expr is " << $2.toString();
       */
       auto j = $1.getSequence();
       j.push_back($2);
       $$.setSequence( j );
       //$$.setStringAtom( "plop" );
       //MYLOG << "$$ is " << $$.toString();
//LOG( INFO ) << " address of yylval is " << &yylval << " and string representation is " << yylval.toString();
//LOG( INFO ) << " address of $$ is " << &$$ << " and string representation is " << $$.toString();
parseResult = $$;
       }
       ;
list: BEGINEXPRESSION exprs ENDEXPRESSION
    {
    /*
       MYLOG << "$1 " << $1.toString()
       <<  "$2 " << "(" << $2.toString() << ")"
       <<  "$3 " << $3.toString()
       ;
*/
       $$.setList( $2.getSequence() );
       //MYLOG << "$$ is " << $$.toString();
       }
    ;

expr: atom
    {
      $$ = $1;
    }
    | SINGLEQUOTE list
    {
      $$ = $2;
      }
    | list
    {
      $$ = $1;
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
