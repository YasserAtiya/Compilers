1.	func main
2.	formal 8
3.	localloc 8
	label L4
4.	local 0
5.	con 0
6.	cvf 5
7.	=f 4 6
	label L8
8.	local 0
9.	@f 8
10.	argf 9
11.	global foo
12.	fi 11 1
	label L13
13.	fend
14.	func foo
15.	formal 8
	label L16
16.	str "Printing %d\n"
17.	param 0
18.	@f 17
19.	argi 16
20.	argf 18
21.	global printf
22.	fi 21 2
	label L23
23.	param 0
24.	@f 23
25.	cvi 24
26.	reti 25
	label L27
27.	fend
