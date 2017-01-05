cgen: cgen.cpp
	g++ -std=c++11 -g cgen.cpp -o cgen
	/home/faculty/whalley/cop5621exec/csem < GlobalTest.c > GlobalTest.t
	./cgen < GlobalTest.t > GlobalTest.s
	gcc -g GlobalTest.s
	./a.out
