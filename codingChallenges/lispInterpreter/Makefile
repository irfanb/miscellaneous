# added abseil with sudo apt install libabsl-dev
ABSL_LINK_FLAGS=`pkg-config absl_log --libs-only-l`

sayhello.o: sayhello.cpp
	g++ -std=c++23 -g -O0 -c $< -ll

lex.yy.c foo.h: lexer.l
	flex --header-file=foo.h lexer.l

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

parser.tab.o: parser.tab.c parser.tab.h
	gcc -g -O0 -c $< -ll

main.o: main.c
	gcc -g -O0 -c $< -ll

lex.yy.o: lex.yy.c parser.tab.h
	gcc -g -O0 -c $< -ll

parser: main.o lex.yy.o parser.tab.o sayhello.o
	gcc -g -o parser main.o lex.yy.o parser.tab.o sayhello.o $(ABSL_LINK_FLAGS) -lstdc++

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


