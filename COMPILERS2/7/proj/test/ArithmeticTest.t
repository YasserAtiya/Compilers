1.	func main
2.	formal 4
3.	localloc 4
	label L4
4.	local 0
5.	con 5
6.	=i 4 5
	label L7
7.	str "b=1\n a: %d\nb: %d\n"
8.	param 0
9.	@i 8
10.	local 0
11.	@i 10
12.	argi 7
13.	argi 9
14.	argi 11
15.	global printf
16.	fi 15 3
	label L17
17.	param 0
18.	local 0
19.	@i 18
20.	=i 17 19
	label L21
21.	str "a=nb\na: %d\nb: %d\n"
22.	param 0
23.	@i 22
24.	local 0
25.	@i 24
26.	argi 21
27.	argi 23
28.	argi 25
29.	global printf
30.	fi 29 3
	label L31
31.	param 0
32.	param 0
33.	@i 32
34.	local 0
35.	@i 34
36.	+i 33 35
37.	=i 31 36
	label L38
38.	str "a+b\na: %d\nb: %d\n"
39.	param 0
40.	@i 39
41.	local 0
42.	@i 41
43.	argi 38
44.	argi 40
45.	argi 42
46.	global printf
47.	fi 46 3
	label L48
48.	param 0
49.	param 0
50.	@i 49
51.	local 0
52.	@i 51
53.	-i 50 52
54.	=i 48 53
	label L55
55.	str "a-b\na: %d\nb: %d\n"
56.	param 0
57.	@i 56
58.	local 0
59.	@i 58
60.	argi 55
61.	argi 57
62.	argi 59
63.	global printf
64.	fi 63 3
	label L65
65.	param 0
66.	param 0
67.	@i 66
68.	local 0
69.	@i 68
70.	*i 67 69
71.	=i 65 70
	label L72
72.	str "a*b\na: %d\nb: %d\n"
73.	param 0
74.	@i 73
75.	local 0
76.	@i 75
77.	argi 72
78.	argi 74
79.	argi 76
80.	global printf
81.	fi 80 3
	label L82
82.	param 0
83.	param 0
84.	@i 83
85.	con 2
86.	/i 84 85
87.	=i 82 86
	label L88
88.	str "a\\2\na: %d\nb: %d\n"
89.	param 0
90.	@i 89
91.	local 0
92.	@i 91
93.	argi 88
94.	argi 90
95.	argi 92
96.	global printf
97.	fi 96 3
	label L98
98.	param 0
99.	param 0
100.	@i 99
101.	local 0
102.	@i 101
103.	|i 100 102
104.	=i 98 103
	label L105
105.	str "a|b\na: %d\nb: %d\n"
106.	param 0
107.	@i 106
108.	local 0
109.	@i 108
110.	argi 105
111.	argi 107
112.	argi 109
113.	global printf
114.	fi 113 3
	label L115
115.	param 0
116.	param 0
117.	@i 116
118.	local 0
119.	@i 118
120.	&i 117 119
121.	=i 115 120
	label L122
122.	str "a&b\na: %d\nb: %d\n"
123.	param 0
124.	@i 123
125.	local 0
126.	@i 125
127.	argi 122
128.	argi 124
129.	argi 126
130.	global printf
131.	fi 130 3
	label L132
132.	param 0
133.	param 0
134.	@i 133
135.	local 0
136.	@i 135
137.	^i 134 136
138.	=i 132 137
	label L139
139.	str "a^b\na: %d\nb: %d\n"
140.	param 0
141.	@i 140
142.	local 0
143.	@i 142
144.	argi 139
145.	argi 141
146.	argi 143
147.	global printf
148.	fi 147 3
	label L149
149.	param 0
150.	param 0
151.	@i 150
152.	local 0
153.	@i 152
154.	<<i 151 153
155.	=i 149 154
	label L156
156.	str "a<<b\na: %d\nb: %d\n"
157.	param 0
158.	@i 157
159.	local 0
160.	@i 159
161.	argi 156
162.	argi 158
163.	argi 160
164.	global printf
165.	fi 164 3
	label L166
166.	param 0
167.	param 0
168.	@i 167
169.	local 0
170.	@i 169
171.	>>i 168 170
172.	=i 166 171
	label L173
173.	str "a>>b\na: %d\nb: %d\n"
174.	param 0
175.	@i 174
176.	local 0
177.	@i 176
178.	argi 173
179.	argi 175
180.	argi 177
181.	global printf
182.	fi 181 3
	label L183
183.	fend
