1.	alloc m 48
2.	func main
3.	formal 8
4.	localloc 4
	label L5
5.	str "Began func\n"
6.	argi 5
7.	global printf
8.	fi 7 1
	label L9
9.	local 0
10.	con 0
11.	=i 9 10
	label L12
12.	local 0
13.	@i 12
14.	con 6
15.	<i 13 14
16.	bt 15 B16
17.	br B17
	label L18
18.	local 0
19.	con 1
20.	@i 18
21.	+i 20 19
22.	=i 18 21
23.	br B23
	label L24
24.	local 0
25.	@i 24
26.	global m
27.	[]f 26 25
28.	local 0
29.	@i 28
30.	cvf 29
31.	=f 27 30
32.	B16=L24
33.	B23=L12
34.	br L18
	label L35
35.	str "Passed first loop\n"
36.	argi 35
37.	global printf
38.	fi 37 1
39.	B17=L35
	label L40
40.	con 3
41.	global m
42.	[]f 41 40
43.	con 9
44.	cvf 43
45.	=f 42 44
	label L46
46.	str "Element %d of m = %f\n"
47.	con 3
48.	con 3
49.	global m
50.	[]f 49 48
51.	@f 50
52.	argi 46
53.	argi 47
54.	argf 51
55.	global printf
56.	fi 55 3
	label L57
57.	str "Element %d of m = %f\n"
58.	con 3
59.	param 0
60.	@f 59
61.	argi 57
62.	argi 58
63.	argf 60
64.	global printf
65.	fi 64 3
	label L66
66.	param 0
67.	@f 66
68.	con 0
69.	cvf 68
70.	==f 67 69
71.	bt 70 B71
72.	br B72
	label L73
73.	con 0
74.	reti 73
75.	B71=L73
	label L76
76.	param 0
77.	con 777
78.	cvf 77
79.	=f 76 78
80.	B72=L76
	label L81
81.	str "Beginning second loop\n"
82.	argi 81
83.	global printf
84.	fi 83 1
	label L85
85.	local 0
86.	con 0
87.	=i 85 86
	label L88
88.	local 0
89.	@i 88
90.	con 6
91.	<i 89 90
92.	bt 91 B92
93.	br B93
	label L94
94.	local 0
95.	con 1
96.	@i 94
97.	+i 96 95
98.	=i 94 97
99.	br B99
	label L100
100.	local 0
101.	@i 100
102.	global m
103.	[]f 102 101
104.	con 888
105.	cvf 104
106.	=f 103 105
	label L107
107.	str "Element %d of m = %f\n"
108.	local 0
109.	@i 108
110.	local 0
111.	@i 110
112.	global m
113.	[]f 112 111
114.	@f 113
115.	argi 107
116.	argi 109
117.	argf 114
118.	global printf
119.	fi 118 3
120.	B92=L100
121.	B99=L88
122.	br L94
	label L123
123.	con 1
124.	reti 123
125.	B93=L123
	label L126
126.	fend
