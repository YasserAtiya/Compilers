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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=
!  outs=
!
mkline:
.1_rs = -4
.1_rl = -8
.1_bit = -12
.1_i = -16
.1_j = -20
.1_m = -24
	save	%sp,(-88),%sp       ! sets=window  uses=%sp:     deads=
.1_s = 68
	st	%i0,[%fp + .1_s]    ! sets=s:      uses=%i0:%fp: deads=
.1_prch = 75
	stb	%i1,[%fp + .1_prch] ! sets=prch:   uses=%i1:%fp: deads=
.1_line = 76
	st	%i2,[%fp + .1_line] ! sets=line:   uses=%i2:%fp: deads=
.1_space = 80
	st	%i3,[%fp + .1_space]! sets=space:  uses=%i3:%fp: deads=
! source statement 122
	ld	[%fp + .1_space],%o0! sets=%o0:    uses=%fp:space:deads=
	st	%o0,[%fp + .1_rl]   ! sets=rl:     uses=%o0:%fp: deads=
! source statement 123
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 2
! preds: 1 23
! succs: 16
!  doms:
!   ins=
!  outs=
!
.L89:
! source statement 124
	st	%g0,[%fp + .1_j]    ! sets=j:      uses=%g0:%fp: deads=
! source statement 125
	ld	[%fp + .1_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=
	st	%o0,[%fp + .1_rs]   ! sets=rs:     uses=%o0:%fp: deads=
	ba,a	.L92                ! sets=        uses=         deads=
!
! block 3
! preds: 18
! succs: 4 5
!  doms:
!   ins=
!  outs=
!
.L93:
! source statement 126
	ld	[%fp + .1_rs],%o0   ! sets=%o0:    uses=%fp:rs:  deads=
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .1_rs]   ! sets=rs:     uses=%o1:%fp: deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	and	%o0,127,%o0         ! sets=%o0:    uses=%o0:     deads=
	sub	%o0,33,%o0          ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_bit]  ! sets=bit:    uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bge	.L94                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 6
!  doms:
!   ins=
!  outs=
!
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 5
! preds: 3
! succs: 6
!  doms:
!   ins=
!  outs=
!
.L94:
	ld	[%fp + .1_bit],%o0  ! sets=%o0:    uses=%fp:bit: deads=
	smul	%o0,7,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(btab),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(btab),%o1   ! sets=%o1:    uses=%o1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
!
! block 6
! preds: 4 5
! succs: 14
!  doms:
!   ins=
!  outs=
!
.L95:
	st	%o0,[%fp + .1_bit]  ! sets=bit:    uses=%o0:%fp: deads=
! source statement 127
	mov	64,%o0              ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .1_m]    ! sets=m:      uses=%o0:%fp: deads=
	ba,a	.L98                ! sets=        uses=         deads=
!
! block 7
! preds: 14
! succs: 8 12
!  doms:
!   ins=
!  outs=
!
.L99:
! source statement 128
	ld	[%fp + .1_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	ld	[%fp + .1_bit],%o1  ! sets=%o1:    uses=%fp:bit: deads=
	andcc	%o0,%o1,%g0         ! sets=%g0:    uses=%o0:%o1: deads=
	be	.L100               ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 10
!  doms:
!   ins=
!  outs=
!
	ldsb	[%fp + .1_prch],%o0 ! sets=%o0:    uses=%fp:prch:deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	be	.L102               ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 13
!  doms:
!   ins=
!  outs=
!
	ldsb	[%fp + .1_prch],%o0 ! sets=%o0:    uses=%fp:prch:deads=
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 10
! preds: 8
! succs: 11
!  doms:
!   ins=
!  outs=
!
.L102:
	ld	[%fp + .1_rs],%o0   ! sets=%o0:    uses=%fp:rs:  deads=
	ldsb	[%o0 + (-1)],%o0    ! sets=%o0:    uses=%o0:     deads=
!
! block 11
! preds: 10
! succs: 13
!  doms:
!   ins=
!  outs=
!
.L103:
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 12
! preds: 7
! succs: 13
!  doms:
!   ins=
!  outs=
!
.L100:
	mov	32,%o0              ! sets=%o0:    uses=         deads=
!
! block 13
! preds: 9 11 12
! succs: 14
!  doms:
!   ins=
!  outs=
!
.L101:
	ld	[%fp + .1_rl],%o1   ! sets=%o1:    uses=%fp:rl:  deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%fp + .1_rl]   ! sets=rl:     uses=%o2:%fp: deads=
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=
! source statement 129
	ld	[%fp + .1_bit],%o0  ! sets=%o0:    uses=%fp:bit: deads=
	ld	[%fp + .1_m],%o1    ! sets=%o1:    uses=%fp:m:   deads=
	andn	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	st	%o0,[%fp + .1_bit]  ! sets=bit:    uses=%o0:%fp: deads=
! source statement 130
	ld	[%fp + .1_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	sra	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_m]    ! sets=m:      uses=%o0:%fp: deads=
!
! block 14
! preds: 6 13
! succs: 15 7
!  doms:
!   ins=
!  outs=
!
.L98:
! source statement 130
	ld	[%fp + .1_bit],%o0  ! sets=%o0:    uses=%fp:bit: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bne	.L99                ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16
!  doms:
!   ins=
!  outs=
!
! source statement 131
	mov	9,%o0               ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_rl],%o1   ! sets=%o1:    uses=%fp:rl:  deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%fp + .1_rl]   ! sets=rl:     uses=%o2:%fp: deads=
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=
! source statement 132
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_j]    ! sets=j:      uses=%o0:%fp: deads=
!
! block 16
! preds: 2 15
! succs: 17 19
!  doms:
!   ins=
!  outs=
!
.L92:
! source statement 132
	ld	[%fp + .1_rs],%o0   ! sets=%o0:    uses=%fp:rs:  deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	be	.L104               ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18 19
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	ld	[%fp + .1_line],%o1 ! sets=%o1:    uses=%fp:line:deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=
	bge	.L104               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 3
!  doms:
!   ins=
!  outs=
!
	ba,a	.L93                ! sets=        uses=         deads=
!
! block 19
! preds: 16 17
! succs: 20
!  doms:
!   ins=
!  outs=
!
.L104:
!
! block 20
! preds: 19 21
! succs: 21 22
!  doms:
!   ins=
!  outs=
!
.L105:
! source statement 133
	ld	[%fp + .1_rl],%o0   ! sets=%o0:    uses=%fp:rl:  deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_rl]   ! sets=rl:     uses=%o0:%fp: deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,9               ! sets=        uses=%o0:     deads=
	bne	.L106               ! sets=        uses=         deads=
	nop
!
! block 21
! preds: 20
! succs: 20
!  doms:
!   ins=
!  outs=
!
	ba,a	.L105               ! sets=        uses=         deads=
!
! block 22
! preds: 20
! succs: 23 24
!  doms:
!   ins=
!  outs=
!
.L106:
! source statement 135
	ld	[%fp + .1_rl],%o0   ! sets=%o0:    uses=%fp:rl:  deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_rl]   ! sets=rl:     uses=%o0:%fp: deads=
! source statement 136
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_rl],%o1   ! sets=%o1:    uses=%fp:rl:  deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%fp + .1_rl]   ! sets=rl:     uses=%o2:%fp: deads=
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=
! source statement 137
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
! source statement 137
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,7               ! sets=        uses=%o0:     deads=
	bge	.L107               ! sets=        uses=         deads=
	nop
!
! block 23
! preds: 22
! succs: 2
!  doms:
!   ins=
!  outs=
!
	ba,a	.L89                ! sets=        uses=         deads=
!
! block 24
! preds: 22
! succs:
!  doms:
!   ins=
!  outs=
!
.L107:
! source statement 138
	ld	[%fp + .1_rl],%o0   ! sets=%o0:    uses=%fp:rl:  deads=
	stb	%g0,[%o0]           ! sets=        uses=%g0:%o0: deads=
! source statement 139
	ld	[%fp + .1_space],%i0! sets=%i0:    uses=%fp:space:deads=
	ret	                    ! sets=        uses=%i0:     deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.common	.L111,256,8
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=
!  outs=
!
main:
.2_prch = -1
.2_space = -8
.2_line = -12
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.2_argc = 68
	st	%i0,[%fp + .2_argc] ! sets=argc:   uses=%i0:%fp: deads=
.2_argv = 72
	st	%i1,[%fp + .2_argv] ! sets=argv:   uses=%i1:%fp: deads=
! source statement 151
	mov	42,%o0              ! sets=%o0:    uses=         deads=
	stb	%o0,[%fp + .2_prch] ! sets=prch:   uses=%o0:%fp: deads=
! source statement 152
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .2_line] ! sets=line:   uses=%o0:%fp: deads=
!
! block 2
! preds: 1 4 7 11
! succs: 3 12
!  doms:
!   ins=
!  outs=
!
.L113:
! source statement 153
	ld	[%fp + .2_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .2_argv] ! sets=argv:   uses=%o0:%fp: deads=
	ld	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,45              ! sets=        uses=%o0:     deads=
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 8
!  doms:
!   ins=
!  outs=
!
! source statement 154
	ld	[%fp + .2_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .2_argc] ! sets=argc:   uses=%o0:%fp: deads=
! source statement 155
	ld	[%fp + .2_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	ldsb	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=
	ba,a	.L116               ! sets=        uses=         deads=
!
! block 4
! preds: 8
! succs: 2
!  doms:
!   ins=
!  outs=
!
.L117:
! source statement 158
	ld	[%fp + .2_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	ldsb	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=
	stb	%o0,[%fp + .2_prch] ! sets=prch:   uses=%o0:%fp: deads=
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 5
! preds: 9
! succs: 6
!  doms:
!   ins=
!  outs=
!
.L118:
!
! block 6
! preds: 5 10
! succs: 7
!  doms:
!   ins=
!  outs=
!
.L119:
! source statement 163
	ld	[%fp + .2_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	mov	%o1,%o0             ! sets=%o0:    uses=%o1:     deads=
	call	myatoi,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 7
! preds: 6
! succs: 2
!  doms:
!   ins=
!  outs=
!
	sra	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .2_line] ! sets=line:   uses=%o0:%fp: deads=
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 8
! preds: 3
! succs: 9 4
!  doms:
!   ins=
!  outs=
!
.L116:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L117               ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10 5
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L118               ! sets=        uses=         deads=
	nop
!
! block 10
! preds: 9
! succs: 11 6
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=
	be	.L119               ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 2
!  doms:
!   ins=
!  outs=
!
.L115:
	ba,a	.L113               ! sets=        uses=         deads=
!
! block 12
! preds: 2
! succs: 13
!  doms:
!   ins=
!  outs=
!
.L114:
! source statement 167
	ld	[%fp + .2_line],%o0 ! sets=%o0:    uses=%fp:line:deads=
	sll	%o0,6,%o0           ! sets=%o0:    uses=%o0:     deads=
	call	malloc,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 13
! preds: 12
! succs: 14
!  doms:
!   ins=
!  outs=
!
	st	%o0,[%fp + .2_space]! sets=space:  uses=%o0:%fp: deads=
! source statement 168
	sethi	%hi(.L121),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L121),%o0  ! sets=%o0:    uses=%o0:     deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 14
! preds: 13
! succs: 15 19
!  doms:
!   ins=
!  outs=
!
! source statement 169
	ld	[%fp + .2_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .2_argc] ! sets=argc:   uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	be	.L122               ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14 17
! succs: 16
!  doms:
!   ins=
!  outs=
!
.L125:
! source statement 171
	sethi	%hi(.L126),%l0      ! sets=%l0:    uses=         deads=
	ld	[%fp + .2_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	add	%o0,4,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .2_argv] ! sets=argv:   uses=%o1:%fp: deads=
	ld	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%fp + .2_prch],%o1 ! sets=%o1:    uses=%fp:prch:deads=
	ld	[%fp + .2_line],%o2 ! sets=%o2:    uses=%fp:line:deads=
	ld	[%fp + .2_space],%o3! sets=%o3:    uses=%fp:space:deads=
	call	mkline,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=
	nop
!
! block 16
! preds: 15
! succs: 17
!  doms:
!   ins=
!  outs=
!
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=
	add	%l0,%lo(.L126),%o0  ! sets=%o0:    uses=%l0:     deads=
	mov	%o1,%o1             ! sets=%o1:    uses=%o1:     deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 17
! preds: 16
! succs: 18 15
!  doms:
!   ins=
!  outs=
!
! source statement 172
	ld	[%fp + .2_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .2_argc] ! sets=argc:   uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bne	.L125               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 26
!  doms:
!   ins=
!  outs=
!
	ba,a	.L127               ! sets=        uses=         deads=
!
! block 19
! preds: 14
! succs: 20
!  doms:
!   ins=
!  outs=
!
.L122:
!
! block 20
! preds: 19 24
! succs: 21
!  doms:
!   ins=
!  outs=
!
.L128:
! source statement 176
	sethi	%hi(.L111),%o0      ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o2       ! sets=%o2:    uses=         deads=
	add	%o0,%lo(.L111),%o0  ! sets=%o0:    uses=%o0:     deads=
	mov	256,%o1             ! sets=%o1:    uses=         deads=
	add	%o2,%lo(_iob),%o2   ! sets=%o2:    uses=%o2:     deads=
	call	fgets,3             ! sets=scratch uses=%o0:%o1:%o2:deads=
	nop
!
! block 21
! preds: 20
! succs: 22 25
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	be	.L129               ! sets=        uses=         deads=
	nop
!
! block 22
! preds: 21
! succs: 23
!  doms:
!   ins=
!  outs=
!
! source statement 177
	sethi	%hi(.L130),%l0      ! sets=%l0:    uses=         deads=
	sethi	%hi(.L111),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L111),%o0  ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%fp + .2_prch],%o1 ! sets=%o1:    uses=%fp:prch:deads=
	ld	[%fp + .2_line],%o2 ! sets=%o2:    uses=%fp:line:deads=
	ld	[%fp + .2_space],%o3! sets=%o3:    uses=%fp:space:deads=
	call	mkline,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=
	nop
!
! block 23
! preds: 22
! succs: 24
!  doms:
!   ins=
!  outs=
!
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=
	add	%l0,%lo(.L130),%o0  ! sets=%o0:    uses=%l0:     deads=
	mov	%o1,%o1             ! sets=%o1:    uses=%o1:     deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 24
! preds: 23
! succs: 20
!  doms:
!   ins=
!  outs=
!
	ba,a	.L128               ! sets=        uses=         deads=
!
! block 25
! preds: 21
! succs: 26
!  doms:
!   ins=
!  outs=
!
.L129:
!
! block 26
! preds: 18 25
! succs:
!  doms:
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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=
!  outs=
!
myatoi:
.3_i = -4
.3_retval = -8
	save	%sp,(-72),%sp       ! sets=window  uses=%sp:     deads=
.3_str = 68
	st	%i0,[%fp + .3_str]  ! sets=str:    uses=%i0:%fp: deads=
! source statement 184
	st	%g0,[%fp + .3_i]    ! sets=i:      uses=%g0:%fp: deads=
! source statement 185
	st	%g0,[%fp + .3_retval]! sets=retval: uses=%g0:%fp: deads=
!
! block 2
! preds: 1 4
! succs: 3 5
!  doms:
!   ins=
!  outs=
!
.L133:
! source statement 187
	ld	[%fp + .3_str],%o0  ! sets=%o0:    uses=%fp:str: deads=
	ld	[%fp + .3_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	cmp	%o0,48              ! sets=        uses=%o0:     deads=
	bl	.L134               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .3_str],%o0  ! sets=%o0:    uses=%fp:str: deads=
	ld	[%fp + .3_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	cmp	%o0,57              ! sets=        uses=%o0:     deads=
	bg	.L134               ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 2
!  doms:
!   ins=
!  outs=
!
! source statement 188
	ld	[%fp + .3_retval],%o0! sets=%o0:    uses=%fp:retval:deads=
	smul	%o0,10,%o0          ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .3_retval]! sets=retval: uses=%o0:%fp: deads=
! source statement 189
	ld	[%fp + .3_retval],%o0! sets=%o0:    uses=%fp:retval:deads=
	ld	[%fp + .3_str],%o1  ! sets=%o1:    uses=%fp:str: deads=
	ld	[%fp + .3_i],%o2    ! sets=%o2:    uses=%fp:i:   deads=
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	st	%o3,[%fp + .3_i]    ! sets=i:      uses=%o3:%fp: deads=
	ldsb	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=
	sub	%o1,48,%o1          ! sets=%o1:    uses=%o1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	st	%o0,[%fp + .3_retval]! sets=retval: uses=%o0:%fp: deads=
	ba,a	.L133               ! sets=        uses=         deads=
!
! block 5
! preds: 2 3
! succs:
!  doms:
!   ins=
!  outs=
!
.L134:
! source statement 191
	ld	[%fp + .3_retval],%i0! sets=%i0:    uses=%fp:retval:deads=
	ret	                    ! sets=        uses=%i0:     deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
