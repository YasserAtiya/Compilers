test: cpretty
	cpretty < test0.c > test0.tr
	groff -me test0.tr > test0.ps
	ps2pdf test0.ps	
	cpretty < test1.c > test1.tr
	groff -me test1.tr > test1.ps
	ps2pdf test1.ps
	cpretty < test2.c > test2.tr
	groff -me test2.tr > test2.ps
	ps2pdf test2.ps
	cpretty < test3.c > test3.tr
	groff -me test3.tr > test3.ps
	ps2pdf test3.ps
	cpretty < test4.c > test4.tr
	groff -me test4.tr > test4.ps
	ps2pdf test4.ps
	cpretty < test5.c > test5.tr
	groff -me test5.tr > test5.ps
	ps2pdf test5.ps
	cpretty < test6.c > test6.tr
	groff -me test6.tr > test6.ps
	ps2pdf test6.ps
	cpretty < test7.c > test7.tr
	groff -me test7.tr > test7.ps
	ps2pdf test7.ps
	cpretty < test8.c > test8.tr
	groff -me test8.tr > test8.ps
	ps2pdf test8.ps
	cpretty < test9.c > test9.tr
	groff -me test9.tr > test9.ps
	ps2pdf test9.ps
	cpretty < test10.c > test10.tr
	groff -me test10.tr > test10.ps
	ps2pdf test10.ps
	cpretty < test11.c > test11.tr
	groff -me test11.tr > test11.ps
	ps2pdf test11.ps
	cpretty < test12.c > test12.tr
	groff -me test12.tr > test12.ps
	ps2pdf test12.ps
	cpretty < echo.c > test13.tr
	groff -me test13.tr > test13.ps
	ps2pdf test13.ps
	cpretty < reserved > test14.tr
	groff -me test14.tr > test14.ps
	ps2pdf test14.ps
cpretty: lex.yy.c
	gcc -lfl -g -o cpretty lex.yy.c 
lex.yy.c: cpretty.l
	lex cpretty.l


clean: 
	rm lex.yy.c cpretty
