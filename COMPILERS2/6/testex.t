1.	func main
2.	localloc 8
3.	localloc 4
	label L4
4.	local 1
5.	con 10
6.	=i 4 5
	label L7
7.	local 0
8.	con 15
9.	cvf 8
10.	=f 7 9
	label L11
11.	str "i is %d\n"
12.	local 1
13.	@i 12
14.	argi 11
15.	argi 13
16.	global printf
17.	fi 16 2
	label L18
18.	str "x is %f\n"
19.	local 0
20.	@f 19
21.	argi 18
22.	argf 20
23.	global printf
24.	fi 23 2
	label L25
25.	local 1
26.	con 3
27.	@i 25
28.	+i 27 26
29.	=i 25 28
	label L30
30.	local 0
31.	con 3
32.	@f 30
33.	cvf 31
34.	/f 32 33
35.	=f 30 34
	label L36
36.	local 1
37.	@i 36
38.	local 0
39.	@f 38
40.	argi 37
41.	argf 39
42.	global foo
43.	fi 42 2
	label L44
44.	fend
45.	func foo
46.	formal 4
47.	formal 8
	label L48
48.	str "j is %d\n"
49.	param 0
50.	@i 49
51.	argi 48
52.	argi 50
53.	global printf
54.	fi 53 2
	label L55
55.	str "z is %f\n"
56.	param 1
57.	@f 56
58.	argi 55
59.	argf 57
60.	global printf
61.	fi 60 2
	label L62
62.	fend
