do:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCEFMPRUO < ../test/banner.s > ../test/banner2.s
	opt < ../test/banner.s > ../test/banner3.s
	opt < ../test/banner.s > ../test/banner3.s 2> ../test/bannererror.txt
	gcc ../test/banner.s
	a.out 2016
	a.out 2016 > bannerbefore.txt
	gcc ../test/banner3.s
	a.out 2016
	a.out 2016 > bannerafter.txt 

test1:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/cal.s > ../test/cal3.s
	gcc ../test/cal.s
	a.out 8 2016
	gcc ../test/cal3.s
	a.out 8 2016

test2:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/echo.s > ../test/echo3.s
	gcc ../test/echo.s
	a.out 8 2016
	gcc ../test/echo3.s
	a.out 8 2016

test3:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/find.s > ../test/find3.s
	gcc ../test/find.s
	a.out word < o
	gcc ../test/find3.s
	a.out word < o

test4:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/half.s > ../test/half3.s
	gcc ../test/half.s
	a.out
	gcc ../test/half3.s
	a.out

test5:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/queens.s > ../test/queens3.s
	gcc ../test/queens.s
	a.out
	gcc ../test/queens3.s
	a.out

test6:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/square.s > ../test/square3.s
	gcc ../test/square.s
	a.out
	gcc ../test/square3.s
	a.out

test7:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/wc.s > ../test/wc3.s
	gcc ../test/wc.s
	a.out < ../test/wc.s
	gcc ../test/wc3.s
	a.out < ../test/wc.s

diffs:
	diff ../test/banner3.s ../test/banner2.s
	diff ../test/cal3.s ../test/cal2.s
	diff ../test/echo3.s ../test/echo2.s
	diff ../test/find3.s ../test/find2.s
	diff ../test/half3.s ../test/half2.s
	diff ../test/queens3.s ../test/queens2.s
	diff ../test/square3.s ../test/square2.s
	diff ../test/wc3.s ../test/wc2.s

tests:
	opt < ../test/banner.s > ../test/banner3.s
	opt < ../test/cal.s > ../test/cal3.s
	opt < ../test/echo.s > ../test/echo3.s
	opt < ../test/find.s > ../test/find3.s
	opt < ../test/half.s > ../test/half3.s
	opt < ../test/queens.s > ../test/queens3.s
	opt < ../test/square.s > ../test/square3.s
	opt < ../test/wc.s > ../test/wc3.s


clean:
	gcc ../test/banner3.s
	a.out 2016
	rm opt ../test/*3.s
