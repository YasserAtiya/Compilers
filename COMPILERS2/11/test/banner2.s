	.seg	"data"
	.seg	"data"
	.align	8
	.global	btab
btab:
	.ascii "\10\10\10\10\10\0\10\24\24\24\0\0\0\0\24\24\177\24\177\24"
	.ascii "\24\10\34(\34\12\34\10qRt\10\27%G\34\"\24\10\25\"\35\4"
	.ascii "\10\20\0\0\0\0\1\2\4\4\4\2\1@ \20\20\20 @I*\34\177\34*"
	.ascii "I\0\10\10>\10\10\0\0\0\0\0\0 @\0\0\0<\0\0\0\0\0\0\0\0"
	.ascii "\0 \1\2\4\10\20 @\34\"EIQ\"\34\30\10\10\10\10\10\34\34"
	.ascii "\"\2\4\10\20>\34\"\2\4\2\"\34\2\6\12\22?\2\2>  <\2\"\34"
	.ascii "\2\4\10\36!!\36?\1\2\4\10\20 \34\"\"\34\"\"\34\36!!\36"
	.ascii "\4\10\20\0\0\0\10\0\10\0\0\0\0\10\0\10\20\2\4\10\20\10"
	.ascii "\4\2\0\0<\0<\0\0 \20\10\4\10\20 \34\"\2\4\10\0\10>AO"
	.ascii "IO@>\34\"A\177AAA~AA~AA~\34\"@@@\"\34|BAAAB|~@@x@@~~"
	.ascii "@@x@@@\36!@@G!\36AAA\177AAA\34\10\10\10\10\10\34\2\2\2"
	.ascii "\2\2\"\34BDHPhDB@@@@@@~AcUIAAAAaQIECA>AAAAA>~AA~@@@>"
	.ascii "AAIEB=~AA~DBA>A@>\1A>\177\10\10\10\10\10\10AAAAAA>AA"
	.ascii "AA\"\24\10AAAIUcAA\"\24\10\24\"AA\"\24\10\10\10\10\177\2"
	.ascii "\4\10\20 \177\7\4\4\4\4\4\7@ \20\10\4\2\1p\20\20\20\20"
	.ascii "\20p\10\24\"A\0\0\0\0\0\0\0\0\0\177\20\10\4\0\0\0\0\0"
	.ascii ">\2>\"?\0  <\"\"|\0\0\36   \36\0\2\2\36\"\"\37\0\0\36!"
	.ascii "? \36\0\10\24\20"
	.ascii "8\20\20\0\0\34\"\"\36\2\14  >!!!\0\10\0\10\10\10\34\0"
	.ascii "\2\0\2\2\2\22\14 $(0($\0\30\10\10\10\10\34\0\0vIIII\0"
	.ascii "\0>!!!!\0\0\36!!!\36\0\0<\"\"<  \0\36\"\"\36\2\3\0,\""
	.ascii "   \0\0\36 \36\1\36\0\20<\20\20\22\14\0\0!!!!\35\0\0\""
	.ascii "\"\24\24\10\0\0AAII6\0\0\"\24\10\24\"\0\0\"\"\"\36\2\14"
	.ascii "\0>\4\10\20>\0\3\4\4\30\4\4\3\10\10\10\10\10\10\10`\20"
	.ascii "\20\14\20\20`0I\6\0\0\0\0\177\177\177\177\177\177\177\0"
	.ascii "\0\0"
	.seg	"text"
	.align	8
	.global	mkline
	.proc	1
! loops in function
!   loop: head = 14
!         blocks = 7 8 9 10 11 12 13 14
!   loop: head = 16
!         blocks = 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
!   loop: head = 19
!         blocks = 19
!   loop: head = 2
!         blocks = 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:%i2:%i3:
!  outs=%g2:%g4:%g7:%o3:%o4:%o5:
!
mkline:
! .1_rs = %g1
! .1_rl = %g2
! .1_bit = %g3
! .1_i = %g4
! .1_j = %g5
! .1_m = %g6
	save	%sp,(-88),%sp       ! sets=window  uses=%sp:     deads=
! .1_s = %g7
	mov	%i0,%g7             ! sets=%g7:    uses=%i0:     deads=%i0:
! .1_prch = %o3
	mov	%i1,%o3             ! sets=%o3:    uses=%i1:     deads=%i1:
! .1_line = %o4
	mov	%i2,%o4             ! sets=%o4:    uses=%i2:     deads=%i2:
! .1_space = %o5
	mov	%i3,%o5             ! sets=%o5:    uses=%i3:     deads=%i3:
! source statement 122
	mov	%o5,%o0             ! sets=%o0:    uses=%o5:     deads=
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=%o0:
! source statement 123
	mov	%g0,%g4             ! sets=%g4:    uses=%g0:     deads=
!
! block 2
! preds: 1 20
! succs: 16
!  doms: 1 2
!   ins=%g2:%g4:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!
.L89:
! source statement 124
	mov	%g0,%g5             ! sets=%g5:    uses=%g0:     deads=
! source statement 125
	mov	%g7,%o0             ! sets=%o0:    uses=%g7:     deads=
	mov	%o0,%g1             ! sets=%g1:    uses=%o0:     deads=%o0:
	ba,a	.L92                ! sets=        uses=         deads=
!
! block 3
! preds: 17
! succs: 4 5
!  doms: 1 2 3 16 17
!   ins=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g7:%o3:%o4:%o5:
!
.L93:
! source statement 126
	mov	%g1,%o0             ! sets=%o0:    uses=%g1:     deads=%g1:
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	mov	%o1,%g1             ! sets=%g1:    uses=%o1:     deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	and	%o0,127,%o0         ! sets=%o0:    uses=%o0:     deads=%o0:
	sub	%o0,33,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g3             ! sets=%g3:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bge	.L94                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 6
!  doms: 1 2 3 4 16 17
!   ins=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o0:%o3:%o4:%o5:
!
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 5
! preds: 3
! succs: 6
!  doms: 1 2 3 5 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o0:%o3:%o4:%o5:
!
.L94:
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=%g3:
	smul	%o0,7,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(btab),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(btab),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	%g4,%o1             ! sets=%o1:    uses=%g4:     deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
!
! block 6
! preds: 4 5
! succs: 14
!  doms: 1 2 3 6 16 17
!   ins=%g1:%g2:%g4:%g5:%g7:%o0:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!
.L95:
	mov	%o0,%g3             ! sets=%g3:    uses=%o0:     deads=%o0:
! source statement 127
	mov	64,%o0              ! sets=%o0:    uses=         deads=
	mov	%o0,%g6             ! sets=%g6:    uses=%o0:     deads=%o0:
	ba,a	.L98                ! sets=        uses=         deads=
!
! block 7
! preds: 14
! succs: 8 12
!  doms: 1 2 3 6 7 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!
.L99:
! source statement 128
	mov	%g6,%o0             ! sets=%o0:    uses=%g6:     deads=
	mov	%g3,%o1             ! sets=%o1:    uses=%g3:     deads=
	andcc	%o0,%o1,%g0         ! sets=%g0:    uses=%o0:%o1: deads=%o0:%o1:
	be	.L100               ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 10
!  doms: 1 2 3 6 7 8 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!
	mov	%o3,%o0             ! sets=%o0:    uses=%o3:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L102               ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 13
!  doms: 1 2 3 6 7 8 9 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!
	mov	%o3,%o0             ! sets=%o0:    uses=%o3:     deads=
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 10
! preds: 8
! succs: 11
!  doms: 1 2 3 6 7 8 10 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!
.L102:
	mov	%g1,%o0             ! sets=%o0:    uses=%g1:     deads=
	ldsb	[%o0 + (-1)],%o0    ! sets=%o0:    uses=%o0:     deads=%o0:
!
! block 11
! preds: 10
! succs: 13
!  doms: 1 2 3 6 7 8 10 11 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!
.L103:
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 12
! preds: 7
! succs: 13
!  doms: 1 2 3 6 7 12 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!
.L100:
	mov	32,%o0              ! sets=%o0:    uses=         deads=
!
! block 13
! preds: 9 11 12
! succs: 14
!  doms: 1 2 3 6 7 13 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o0:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!
.L101:
	mov	%g2,%o1             ! sets=%o1:    uses=%g2:     deads=%g2:
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	mov	%o2,%g2             ! sets=%g2:    uses=%o2:     deads=%o2:
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 129
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=%g3:
	mov	%g6,%o1             ! sets=%o1:    uses=%g6:     deads=
	andn	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	%o0,%g3             ! sets=%g3:    uses=%o0:     deads=%o0:
! source statement 130
	mov	%g6,%o0             ! sets=%o0:    uses=%g6:     deads=%g6:
	sra	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g6             ! sets=%g6:    uses=%o0:     deads=%o0:
!
! block 14
! preds: 6 13
! succs: 15 7
!  doms: 1 2 3 6 14 16 17
!   ins=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g3:%g4:%g5:%g6:%g7:%o3:%o4:%o5:
!
.L98:
! source statement 130
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L99                ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16
!  doms: 1 2 3 6 14 15 16 17
!   ins=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!
! source statement 131
	mov	9,%o0               ! sets=%o0:    uses=         deads=
	mov	%g2,%o1             ! sets=%o1:    uses=%g2:     deads=%g2:
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	mov	%o2,%g2             ! sets=%g2:    uses=%o2:     deads=%o2:
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 132
	mov	%g5,%o0             ! sets=%o0:    uses=%g5:     deads=%g5:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g5             ! sets=%g5:    uses=%o0:     deads=%o0:
!
! block 16
! preds: 2 15
! succs: 17 18
!  doms: 1 2 16
!   ins=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!
.L92:
! source statement 132
	mov	%g1,%o0             ! sets=%o0:    uses=%g1:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L104               ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18 3
!  doms: 1 2 16 17
!   ins=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!  outs=%g1:%g2:%g4:%g5:%g7:%o3:%o4:%o5:
!
	mov	%g5,%o0             ! sets=%o0:    uses=%g5:     deads=
	mov	%o4,%o1             ! sets=%o1:    uses=%o4:     deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L93                ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 16 17
! succs: 19
!  doms: 1 2 16 18
!   ins=%g2:%g4:%g7:%o3:%o4:%o5:
!  outs=%g2:%g4:%g7:%o3:%o4:%o5:
!
.L104:
!
! block 19
! preds: 18 19
! succs: 20 19
!  doms: 1 2 16 18 19
!   ins=%g2:%g4:%g7:%o3:%o4:%o5:
!  outs=%g2:%g4:%g7:%o3:%o4:%o5:
!
.L105:
! source statement 133
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	be	.L105               ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21 2
!  doms: 1 2 16 18 19 20
!   ins=%g2:%g4:%g7:%o3:%o4:%o5:
!  outs=%g2:%g4:%g7:%o3:%o4:%o5:
!
.L106:
! source statement 135
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=%o0:
! source statement 136
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	mov	%g2,%o1             ! sets=%o1:    uses=%g2:     deads=%g2:
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	mov	%o2,%g2             ! sets=%g2:    uses=%o2:     deads=%o2:
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 137
	mov	%g4,%o0             ! sets=%o0:    uses=%g4:     deads=%g4:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g4             ! sets=%g4:    uses=%o0:     deads=%o0:
! source statement 137
	mov	%g4,%o0             ! sets=%o0:    uses=%g4:     deads=
	cmp	%o0,7               ! sets=        uses=%o0:     deads=%o0:
	bl	.L89                ! sets=        uses=         deads=
	nop
!
! block 21
! preds: 20
! succs:
!  doms: 1 2 16 18 19 20 21
!   ins=%g2:%o5:
!  outs=
!
.L107:
! source statement 138
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	stb	%g0,[%o0]           ! sets=        uses=%g0:%o0: deads=%o0:
! source statement 139
	mov	%o5,%i0             ! sets=%i0:    uses=%o5:     deads=%o5:
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.common	.L111,256,8
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2 3 4 5 6 7 8 9 10 11
!   loop: head = 15
!         blocks = 15 16 17
!   loop: head = 20
!         blocks = 20 21 22 23 24

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:
!  outs=%l1:%l3:%l4:%l5:
!
main:
! .2_prch = %l1
! .2_space = %l2
! .2_line = %l3
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! .2_argc = %l4
	mov	%i0,%l4             ! sets=%l4:    uses=%i0:     deads=%i0:
! .2_argv = %l5
	mov	%i1,%l5             ! sets=%l5:    uses=%i1:     deads=%i1:
! source statement 151
	mov	42,%o0              ! sets=%o0:    uses=         deads=
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
! source statement 152
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	mov	%o0,%l3             ! sets=%l3:    uses=%o0:     deads=%o0:
!
! block 2
! preds: 1 4 7 11
! succs: 3 12
!  doms: 1 2
!   ins=%l1:%l3:%l4:%l5:
!  outs=%l1:%l3:%l4:%l5:
!
.L113:
! source statement 153
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=%l5:
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l5             ! sets=%l5:    uses=%o0:     deads=
	ld	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,45              ! sets=        uses=%o0:     deads=%o0:
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 8
!  doms: 1 2 3
!   ins=%l1:%l3:%l4:%l5:
!  outs=%o0:%l1:%l3:%l4:%l5:
!
! source statement 154
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=%l4:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l4             ! sets=%l4:    uses=%o0:     deads=%o0:
! source statement 155
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	ldsb	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=%o1:
	ba,a	.L116               ! sets=        uses=         deads=
!
! block 4
! preds: 8
! succs: 2
!  doms: 1 2 3 4 8
!   ins=%l3:%l4:%l5:
!  outs=%l1:%l3:%l4:%l5:
!
.L117:
! source statement 158
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	ldsb	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=%o1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 5
! preds: 9
! succs: 6
!  doms: 1 2 3 5 8 9
!   ins=%l1:%l4:%l5:
!  outs=%l1:%l4:%l5:
!
.L118:
!
! block 6
! preds: 5 10
! succs: 7
!  doms: 1 2 3 6 8 9
!   ins=%l1:%l4:%l5:
!  outs=%o0:%l1:%l4:%l5:
!
.L119:
! source statement 163
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	mov	%o1,%o0             ! sets=%o0:    uses=%o1:     deads=%o1:
	call	myatoi,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 7
! preds: 6
! succs: 2
!  doms: 1 2 3 6 7 8 9
!   ins=%o0:%l1:%l4:%l5:
!  outs=%l1:%l3:%l4:%l5:
!
	sra	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l3             ! sets=%l3:    uses=%o0:     deads=%o0:
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 8
! preds: 3
! succs: 9 4
!  doms: 1 2 3 8
!   ins=%o0:%l1:%l3:%l4:%l5:
!  outs=%o0:%l1:%l3:%l4:%l5:
!
.L116:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L117               ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10 5
!  doms: 1 2 3 8 9
!   ins=%o0:%l1:%l3:%l4:%l5:
!  outs=%o0:%l1:%l3:%l4:%l5:
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L118               ! sets=        uses=         deads=
	nop
!
! block 10
! preds: 9
! succs: 11 6
!  doms: 1 2 3 8 9 10
!   ins=%o0:%l1:%l3:%l4:%l5:
!  outs=%l1:%l3:%l4:%l5:
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=%o0:
	be	.L119               ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 2
!  doms: 1 2 3 8 9 10 11
!   ins=%l1:%l3:%l4:%l5:
!  outs=%l1:%l3:%l4:%l5:
!
.L115:
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 12
! preds: 2
! succs: 13
!  doms: 1 2 12
!   ins=%l1:%l3:%l4:%l5:
!  outs=%o0:%l1:%l3:%l4:%l5:
!
.L114:
! source statement 167
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	sll	%o0,6,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	call	malloc,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 13
! preds: 12
! succs: 14
!  doms: 1 2 12 13
!   ins=%o0:%l1:%l3:%l4:%l5:
!  outs=%l1:%l2:%l3:%l4:%l5:
!
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
! source statement 168
	sethi	%hi(.L121),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L121),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 14
! preds: 13
! succs: 15 19
!  doms: 1 2 12 13 14
!   ins=%l1:%l2:%l3:%l4:%l5:
!  outs=%l1:%l2:%l3:%l4:%l5:
!
! source statement 169
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=%l4:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l4             ! sets=%l4:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L122               ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14 17
! succs: 16
!  doms: 1 2 12 13 14 15
!   ins=%l1:%l2:%l3:%l4:%l5:
!  outs=%o0:%l0:%l1:%l2:%l3:%l4:%l5:
!
.L125:
! source statement 171
	sethi	%hi(.L126),%l0      ! sets=%l0:    uses=         deads=
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=%l5:
	add	%o0,4,%o1           ! sets=%o1:    uses=%o0:     deads=
	mov	%o1,%l5             ! sets=%l5:    uses=%o1:     deads=%o1:
	ld	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	mov	%l3,%o2             ! sets=%o2:    uses=%l3:     deads=
	mov	%l2,%o3             ! sets=%o3:    uses=%l2:     deads=
	call	mkline,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 16
! preds: 15
! succs: 17
!  doms: 1 2 12 13 14 15 16
!   ins=%o0:%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l1:%l2:%l3:%l4:%l5:
!
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=%o0:
	add	%l0,%lo(.L126),%o0  ! sets=%o0:    uses=%l0:     deads=%l0:
	mov	%o1,%o1             ! sets=%o1:    uses=%o1:     deads=%o1:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 17
! preds: 16
! succs: 18 15
!  doms: 1 2 12 13 14 15 16 17
!   ins=%l1:%l2:%l3:%l4:%l5:
!  outs=%l1:%l2:%l3:%l4:%l5:
!
! source statement 172
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=%l4:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l4             ! sets=%l4:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L125               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 26
!  doms: 1 2 12 13 14 15 16 17 18
!   ins=
!  outs=
!
	ba,a	.L127               ! sets=        uses=         deads=
!
! block 19
! preds: 14
! succs: 20
!  doms: 1 2 12 13 14 19
!   ins=%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
.L122:
!
! block 20
! preds: 19 24
! succs: 21
!  doms: 1 2 12 13 14 19 20
!   ins=%l1:%l2:%l3:
!  outs=%o0:%l1:%l2:%l3:
!
.L128:
! source statement 176
	sethi	%hi(.L111),%o0      ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o2       ! sets=%o2:    uses=         deads=
	add	%o0,%lo(.L111),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	256,%o1             ! sets=%o1:    uses=         deads=
	add	%o2,%lo(_iob),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	call	fgets,3             ! sets=scratch uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
	nop
!
! block 21
! preds: 20
! succs: 22 25
!  doms: 1 2 12 13 14 19 20 21
!   ins=%o0:%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L129               ! sets=        uses=         deads=
	nop
!
! block 22
! preds: 21
! succs: 23
!  doms: 1 2 12 13 14 19 20 21 22
!   ins=%l1:%l2:%l3:
!  outs=%o0:%l0:%l1:%l2:%l3:
!
! source statement 177
	sethi	%hi(.L130),%l0      ! sets=%l0:    uses=         deads=
	sethi	%hi(.L111),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L111),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	mov	%l3,%o2             ! sets=%o2:    uses=%l3:     deads=
	mov	%l2,%o3             ! sets=%o3:    uses=%l2:     deads=
	call	mkline,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 23
! preds: 22
! succs: 24
!  doms: 1 2 12 13 14 19 20 21 22 23
!   ins=%o0:%l0:%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=%o0:
	add	%l0,%lo(.L130),%o0  ! sets=%o0:    uses=%l0:     deads=%l0:
	mov	%o1,%o1             ! sets=%o1:    uses=%o1:     deads=%o1:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 24
! preds: 23
! succs: 20
!  doms: 1 2 12 13 14 19 20 21 22 23 24
!   ins=%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
	ba,a	.L128               ! sets=        uses=         deads=
!
! block 25
! preds: 21
! succs: 26
!  doms: 1 2 12 13 14 19 20 21 25
!   ins=
!  outs=
!
.L129:
!
! block 26
! preds: 18 25
! succs:
!  doms: 1 2 12 13 14 26
!   ins=
!  outs=
!
.L127:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L130:
	.ascii "\12%s\0"
.L126:
	.ascii "\12%s\0"
.L121:
	.ascii "\12\0"
	.seg	"text"
	.align	8
	.global	myatoi
	.proc	1
! loops in function
!   loop: head = 2
!         blocks = 2 3 4

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=%g1:%g2:%g3:
!
myatoi:
! .3_i = %g1
! .3_retval = %g2
	save	%sp,(-72),%sp       ! sets=window  uses=%sp:     deads=
! .3_str = %g3
	mov	%i0,%g3             ! sets=%g3:    uses=%i0:     deads=%i0:
! source statement 184
	mov	%g0,%g1             ! sets=%g1:    uses=%g0:     deads=
! source statement 185
	mov	%g0,%g2             ! sets=%g2:    uses=%g0:     deads=
!
! block 2
! preds: 1 4
! succs: 3 5
!  doms: 1 2
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g2:%g3:
!
.L133:
! source statement 187
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=
	mov	%g1,%o1             ! sets=%o1:    uses=%g1:     deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,48              ! sets=        uses=%o0:     deads=%o0:
	bl	.L134               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms: 1 2 3
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g2:%g3:
!
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=
	mov	%g1,%o1             ! sets=%o1:    uses=%g1:     deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,57              ! sets=        uses=%o0:     deads=%o0:
	bg	.L134               ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 2
!  doms: 1 2 3 4
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g2:%g3:
!
! source statement 188
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	smul	%o0,10,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=%o0:
! source statement 189
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	mov	%g3,%o1             ! sets=%o1:    uses=%g3:     deads=
	mov	%g1,%o2             ! sets=%o2:    uses=%g1:     deads=%g1:
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	mov	%o3,%g1             ! sets=%g1:    uses=%o3:     deads=%o3:
	ldsb	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	sub	%o1,48,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=%o0:
	ba,a	.L133               ! sets=        uses=         deads=
!
! block 5
! preds: 2 3
! succs:
!  doms: 1 2 5
!   ins=%g2:
!  outs=
!
.L134:
! source statement 191
	mov	%g2,%i0             ! sets=%i0:    uses=%g2:     deads=%g2:
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
