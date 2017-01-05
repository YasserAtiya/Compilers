do:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt < ../test/banner.s > ../test/banner3.s
	gcc ../test/banner.s
	a.out 2016
	gcc ../test/banner3.s
	a.out 2016

test1:
	opt < ../test/cal.s > ../test/cal3.s
	gcc ../test/cal.s
	a.out 8 2016
	gcc ../test/cal3.s
	a.out 8 2016

test2:
	opt < ../test/echo.s > ../test/echo3.s
	gcc ../test/echo.s
	a.out 8 2016
	gcc ../test/echo3.s
	a.out 8 2016

test3:
	opt < ../test/find.s > ../test/find3.s
	gcc ../test/find.s
	a.out word < o
	gcc ../test/find3.s
	a.out word < o

test4:
	opt < ../test/half.s > ../test/half3.s
	gcc ../test/half.s
	a.out 
	gcc ../test/half3.s
	a.out 

test5:
	opt < ../test/queens.s > ../test/queens3.s
	gcc ../test/queens.s
	a.out 
	gcc ../test/queens3.s
	a.out 

test6:
	opt < ../test/square.s > ../test/square3.s
	gcc ../test/square.s
	a.out 
	gcc ../test/square3.s
	a.out 

test7:
	opt < ../test/wc.s > ../test/wc3.s
	gcc ../test/wc.s
	a.out < ../test/wc.s
	gcc ../test/wc3.s
	a.out < ../test/wc.s 

clean:
	gcc ../test/banner3.s
	a.out 2016
	rm opt ../test/*3.s
