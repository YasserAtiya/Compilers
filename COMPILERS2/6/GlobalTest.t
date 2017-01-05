1.	alloc m 48
2.	func main
	label L3
3.	con 3
4.	global m
5.	[]f 4 3
6.	con 9
7.	cvf 6
8.	=f 5 7
	label L9
9.	str "Element %d of m = %f\n"
10.	con 3
11.	con 3
12.	global m
13.	[]f 12 11
14.	@f 13
15.	argi 9
16.	argi 10
17.	argf 14
18.	global printf
19.	fi 18 3
	label L20
20.	fend
