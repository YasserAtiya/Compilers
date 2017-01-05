1.	func main
2.	localloc 4
	label L3
3.	local 0
4.	con 0
5.	=i 3 4
	label L6
6.	str "i is %d\n"
7.	local 0
8.	@i 7
9.	argi 6
10.	argi 8
11.	global printf
12.	fi 11 2
	label L13
13.	local 0
14.	con 1
15.	@i 13
16.	+i 15 14
17.	=i 13 16
18.	con 5
19.	<i 17 18
20.	bt 19 B20
21.	br B21
22.	B20=L6
	label L23
23.	B21=L23
24.	fend
