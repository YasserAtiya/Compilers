cexpr: y.tab.c lex.yy.c
	gcc -g -o cexpr y.tab.c lex.yy.c -ly -ll

y.tab.c: cexpr.y
	yacc -d cexpr.y

lex.yy.c: scan.l
	lex scan.l

clean:
	rm cexpr y.tab.c lex.yy.c y.tab.h
