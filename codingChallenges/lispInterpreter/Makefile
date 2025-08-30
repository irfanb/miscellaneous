.PHONY: lexer


lex.yy.c foo.h: lexer.l
	flex --header-file=foo.h lexer.l

lexer lex.yy.o: lex.yy.c
	gcc -g -O0 -o lexer  lex.yy.c  -ll

