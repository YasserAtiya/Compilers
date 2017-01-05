CC = gcc
DIR = /home/faculty/whalley/cop6622proj/lib
DIROBJ = /home/faculty/whalley/cop6622proj/obj
DIROBJJ = /home/majors/yatiya/Compilers/13/obj
CFLAGS = -g -I$(DIR) -I. -c -Wall
LFLAGS = -g
OBJECTS = $(DIROBJ)/chains.o $(DIROBJ)/copyprop.o cse.o $(DIROBJ)/deadasgs.o fillslots.o flow.o io.o $(DIROBJ)/livedeadvars.o $(DIROBJ)/loops.o misc.o motion.o opt.o peephole.o $(DIROBJ)/regalloc.o $(DIROBJ)/reverse.o $(DIROBJ)/unreachable.o vars.o vect.o


opt: $(OBJECTS)
	$(CC) $(LFLAGS) -o opt $(OBJECTS)

chains.o: chains.c $(DIR)/misc.h $(DIR)/opt.h opts.h $(DIR)/vect.h
	$(CC) $(CFLAGS) chains.c

copyprop.o: copyprop.c $(DIR)/misc.h $(DIR)/opt.h $(DIR)/vars.h
	$(CC) $(CFLAGS) copyprop.c

deadasgs.o: deadasgs.c $(DIR)/opt.h $(DIR)/vars.h analysis.h opts.h
	$(CC) $(CFLAGS) deadasgs.c

fillslots.o: fillslots.c $(DIR)/opt.h opts.h $(DIR)/misc.h
	$(CC) $(CFLAGS) fillslots.c

flow.o: $(DIR)/flow.c $(DIR)/flow.h $(DIR)/opt.h
	$(CC) $(CFLAGS) $(DIR)/flow.c

io.o: $(DIR)/io.c $(DIR)/io.h analysis.h $(DIR)/misc.h $(DIR)/opt.h $(DIR)/vars.h
	$(CC) $(CFLAGS) $(DIR)/io.c

livedeadvars.o: livedeadvars.c analysis.h $(DIR)/misc.h $(DIR)/opt.h $(DIR)/vars.h opts.h
	$(CC) $(CFLAGS) livedeadvars.c

cse.o: cse.c $(DIR)/vars.h $(DIR)/misc.h $(DIR)/opt.h
	$(CC) $(CFLAGS) cse.c

loops.o: loops.c analysis.h $(DIR)/misc.h $(DIR)/opt.h
	$(CC) $(CFLAGS) loops.c

misc.o: $(DIR)/misc.c $(DIR)/misc.h $(DIR)/opt.h $(DIR)/vars.h
	$(CC) $(CFLAGS) $(DIR)/misc.c

motion.o: motion.c $(DIR)/opt.h opts.h $(DIR)/misc.h $(DIR)/vars.h
	$(CC) $(CFLAGS) motion.c

opt.o: $(DIR)/opt.c $(DIR)/opt.h
	$(CC) $(CFLAGS) $(DIR)/opt.c

peephole.o: peephole.c $(DIR)/misc.h $(DIR)/vars.h $(DIR)/opt.h
	$(CC) $(CFLAGS) peephole.c

regalloc.o: regalloc.c $(DIR)/opt.h opts.h $(DIR)/misc.h $(DIR)/vars.h
	$(CC) $(CFLAGS) regalloc.c
	cp regalloc.o ../obj/

reverse.o: reverse.c $(DIR)/opt.h opts.h $(DIR)/misc.h
	$(CC) $(CFLAGS) reverse.c

vars.o: $(DIR)/vars.c $(DIR)/vars.h $(DIR)/opt.h
	$(CC) $(CFLAGS) $(DIR)/vars.c

vect.o: $(DIR)/vect.c $(DIR)/vect.h $(DIR)/opt.h
	$(CC) $(CFLAGS) $(DIR)/vect.c

do:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU  < ../test/banner.s > ../test/banner3.s 2> ../test/bannererror.txt
	opt -BCDOMERU < ../test/banner.s > ../test/banner3.s
	gcc  ../test/banner.s
	a.out 2016
	gcc -ggdb ../test/banner3.s
	a.out 2016
test1:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt  -BCDOMERU < ../test/cal.s > ../test/cal3.s 2> ../test/calerror.txt
	opt -BCDOMERU  < ../test/cal.s > ../test/cal3.s
	gcc ../test/cal.s
	a.out 8 2016
	gcc ../test/cal3.s
	a.out 8 2016
test2:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/echo.s > ../test/echo3.s
	gcc ../test/echo.s
	a.out 8 2016
	gcc ../test/echo3.s
	a.out 8 2016
test3:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/find.s > ../test/find3.s
	gcc ../test/find.s
	a.out word < o
	gcc ../test/find3.s
	a.out word < o
test4:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/half.s > ../test/half3.s
	gcc ../test/half.s
	a.out
	gcc ../test/half3.s
	a.out
test5:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/queens.s > ../test/queens3.s 2> ../test/queenserror.txt
	opt -BCDOMERU < ../test/queens.s > ../test/queens3.s
	gcc ../test/queens.s
	a.out
	gcc ../test/queens3.s
	a.out
test6:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/square.s > ../test/square3.s
	gcc ../test/square.s
	a.out
	gcc ../test/square3.s
	a.out
test7:
	make -f /home/faculty/whalley/cop6622proj/proj/Makefile
	opt -BCDOMERU < ../test/wc.s > ../test/wc3.s
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
test:
	opt < ../test/wc.s > ../test/wc3.s
	gcc ../test/wc3.s
	a.out < ../test/wc.s

clean:
	gcc ../test/banner3.s
	a.out 23456
	rm opt ../test/*3.s
