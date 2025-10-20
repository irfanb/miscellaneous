

lex.yy.c foo.h: lexer.l
	flex --header-file=foo.h lexer.l

lexer: lex.yy.c main.c
	gcc -g -O0 -o lexer  lex.yy.c main.c -ll

lex.yy.cc lex.yy.h: lexer.l
	flex --c++ --header-file=lex.yy.h lexer.l

lexercpp: lex.yy.cc main.cpp lex.yy.h
	g++ -g -O0 -o lexercpp  lex.yy.cc main.cpp -ll

test: lexer
	cat test1.lsp| ./lexer > output1.actual
	diff test1.lsp.expected output1.actual
	cat test2.lsp| ./lexer > output2.actual
	diff test2.lsp.expected output2.actual
	cat test3.lsp| ./lexer > output3.actual
	diff test3.lsp.expected output3.actual
	cat test4.lsp| ./lexer > output4.actual
	diff test4.lsp.expected output4.actual
	cat test5.lsp| ./lexer > output5.actual
	diff test5.lsp.expected output5.actual


