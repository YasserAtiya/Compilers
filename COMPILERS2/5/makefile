test1.t: csem test.c
	csem < test.c > test.t
	/home/faculty/whalley/asg5/run.sh test.t 

test2.t: csem test2.c
	csem < test2.c > test2.t
	/home/faculty/whalley/asg5/run.sh test2.t 

test0.t: csem hello.c
	csem < hello.c > test0.t
	/home/faculty/whalley/asg5/run.sh test0.t 
	

csem: sem.c
	make -f /home/faculty/whalley/asg5/makefile

clean:
	rm csem *.o y.* *.t
