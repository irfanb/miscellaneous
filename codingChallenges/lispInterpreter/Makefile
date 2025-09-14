

lex.yy.c foo.h: lexer.l
	flex --header-file=foo.h lexer.l

lexer: lex.yy.c main.c
	gcc -g -O0 -o lexer  lex.yy.c main.c -ll

test: lexer
	cat test1.lsp| ./lexer > output1.actual
	diff test1.lsp.expected output1.actual
	cat test2.lsp| ./lexer > output2.actual
	diff test2.lsp.expected output2.actual
	cat test3.lsp| ./lexer > output3.actual
	diff test3.lsp.expected output3.actual


