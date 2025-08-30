

lex.yy.c foo.h: lexer.l
	flex --header-file=foo.h lexer.l

lexer: lex.yy.c
	gcc -g -O0 -o lexer  lex.yy.c  -ll

test: lexer
	cat test1.lsp| ./lexer > output.actual
	diff test1.lsp.expected output.actual


