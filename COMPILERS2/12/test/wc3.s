	.seg	"data"
	.seg	"data"
	.align	8
sccsid:
	.word	.L12
	.common	linect,4,4
	.common	wordct,4,4
	.common	charct,4,4
	.common	pagect,4,4
	.common	tlinect,4,4
	.common	twordct,4,4
	.common	tcharct,4,4
	.common	tpagect,4,4
	.align	8
	.global	wd
wd:
	.word	.L94
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 23
!         blocks = 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
!   loop: head = 2
!         blocks = 2 3 4 5 6 7 8 9 10 11 12 13 14 15
!   loop: head = 17
!         blocks = 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:
!  outs=%l4:%l5:
!
main:
	!.1_i = %l0
	!.1_token = %l1
	!.1_fp = %l2
	!.1_c = %l3
	save	%sp,(-112),%sp      ! sets=window  uses=%sp:     deads=
	!.1_argc = %l4
	mov	%i0,%l4             ! sets=%l4:    uses=%i0:     deads=%i0:
	!.1_argv = %l5
	mov	%i1,%l5             ! sets=%l5:    uses=%i1:     deads=%i1:
!
! block 2
! preds: 1 15
! succs: 3 16
!  doms: 1 2
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L98:
! source statement 16
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L99                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 16
!  doms: 1 2 3
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,45              ! sets=        uses=%o0:     deads=%o0:
	bne	.L99                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 11
!  doms: 1 2 3 4
!   ins=%l4:%l5:
!  outs=%o0:%l4:%l5:
!
! source statement 17
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0 + 1],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 5
! preds: 12
! succs: 6
!  doms: 1 2 3 4 5 11 12
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L102:
!
! block 6
! preds: 5 13
! succs: 7
!  doms: 1 2 3 4 6 11 12
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L103:
!
! block 7
! preds: 6 11
! succs: 15
!  doms: 1 2 3 4 7 11
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L104:
! source statement 19
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wd),%o1         ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wd)] ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 8
! preds: 14
! succs: 9
!  doms: 1 2 3 4 8 11 12 13 14
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L105:
! source statement 23
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(.L107),%o1      ! sets=%o1:    uses=         deads=
	add	%o0,32,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o1,%lo(.L107),%o1  ! sets=%o1:    uses=%o1:     deads=%o1:
	call	fprintf,2           ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms: 1 2 3 4 8 9 11 12 13 14
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
! source statement 24
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 10
! preds: 9
! succs: 15
!  doms: 1 2 3 4 8 9 10 11 12 13 14
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 11
! preds: 4
! succs: 12 7
!  doms: 1 2 3 4 11
!   ins=%o0:%l4:%l5:
!  outs=%o0:%l4:%l5:
!
.L101:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L104               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13 5
!  doms: 1 2 3 4 11 12
!   ins=%o0:%l4:%l5:
!  outs=%o0:%l4:%l5:
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L102               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 14 6
!  doms: 1 2 3 4 11 12 13
!   ins=%o0:%l4:%l5:
!  outs=%l4:%l5:
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=%o0:
	be	.L103               ! sets=        uses=         deads=
	nop
!
! block 14
! preds: 13
! succs: 8
!  doms: 1 2 3 4 11 12 13 14
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
	ba,a	.L105               ! sets=        uses=         deads=
!
! block 15
! preds: 7 10
! succs: 2
!  doms: 1 2 3 4 11 15
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
.L100:
! source statement 26
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=%l4:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l4             ! sets=%l4:    uses=%o0:     deads=%o0:
! source statement 27
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=%l5:
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l5             ! sets=%l5:    uses=%o0:     deads=%o0:
	ba,a	.L98                ! sets=        uses=         deads=
!
! block 16
! preds: 2 3
! succs: 17
!  doms: 1 2 16
!   ins=%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L99:
! source statement 30
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 31
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
!
! block 17
! preds: 16 48
! succs: 18 22
!  doms: 1 2 16 17
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L111:
! source statement 33
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L113               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 19
!  doms: 1 2 16 17 18
!   ins=%l0:%l4:%l5:
!  outs=%o0:%l0:%l4:%l5:
!
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(.L112),%o2      ! sets=%o2:    uses=         deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	add	%o2,%lo(.L112),%o1  ! sets=%o1:    uses=%o2:     deads=%o2:
	call	fopen,2             ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 19
! preds: 18
! succs: 20 22
!  doms: 1 2 16 17 18 19
!   ins=%o0:%l0:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L113               ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21
!  doms: 1 2 16 17 18 19 20
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
! source statement 34
	mov	%l5,%o0             ! sets=%o0:    uses=%l5:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	call	perror,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 21
! preds: 20
! succs: 48
!  doms: 1 2 16 17 18 19 20 21
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
	ba,a	.L110               ! sets=        uses=         deads=
!
! block 22
! preds: 17 19
! succs: 23
!  doms: 1 2 16 17 22
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L113:
! source statement 37
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(linect)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 38
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(wordct)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 39
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(charct)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 40
	mov	%g0,%l1             ! sets=%l1:    uses=%g0:     deads=
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 23
! preds: 22 40
! succs: 24 26
!  doms: 1 2 16 17 22 23
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L117:
! source statement 42
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=%o1:
	bge	.L118               ! sets=        uses=         deads=
	nop
!
! block 24
! preds: 23
! succs: 25
!  doms: 1 2 16 17 22 23 24
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%o0:%l0:%l1:%l2:%l4:%l5:
!
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	call	_filbuf,1           ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 25
! preds: 24
! succs: 27
!  doms: 1 2 16 17 22 23 24 25
!   ins=%o0:%l0:%l1:%l2:%l4:%l5:
!  outs=%o0:%l0:%l1:%l2:%l4:%l5:
!
	ba,a	.L119               ! sets=        uses=         deads=
!
! block 26
! preds: 23
! succs: 27
!  doms: 1 2 16 17 22 23 26
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%o0:%l0:%l1:%l2:%l4:%l5:
!
.L118:
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%o0]           ! sets=        uses=%o0:%o2: deads=%o0:%o2:
	ldub	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=%o1:
!
! block 27
! preds: 25 26
! succs: 28 41
!  doms: 1 2 16 17 22 23 27
!   ins=%o0:%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:
!
.L119:
	mov	%o0,%l3             ! sets=%l3:    uses=%o0:     deads=%o0:
! source statement 43
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	cmp	%o0,(-1)            ! sets=        uses=%o0:     deads=%o0:
	be	.L115               ! sets=        uses=         deads=
	nop
!
! block 28
! preds: 27
! succs: 29 33
!  doms: 1 2 16 17 22 23 27 28
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:
!
.L120:
! source statement 45
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(charct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(charct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 46
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	ble	.L121               ! sets=        uses=         deads=
	nop
!
! block 29
! preds: 28
! succs: 30 33
!  doms: 1 2 16 17 22 23 27 28 29
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:
!
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	cmp	%o0,127             ! sets=        uses=%o0:     deads=%o0:
	bge	.L121               ! sets=        uses=         deads=
	nop
!
! block 30
! preds: 29
! succs: 31 39
!  doms: 1 2 16 17 22 23 27 28 29 30
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
! source statement 47
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 31
! preds: 30
! succs: 32
!  doms: 1 2 16 17 22 23 27 28 29 30 31
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
! source statement 48
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(wordct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wordct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 49
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=%l1:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
!
! block 32
! preds: 31
! succs: 39
!  doms: 1 2 16 17 22 23 27 28 29 30 31 32
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L122:
	ba,a	.L114               ! sets=        uses=         deads=
!
! block 33
! preds: 28 29
! succs: 34 35
!  doms: 1 2 16 17 22 23 27 28 33
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:
!
.L121:
! source statement 53
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	cmp	%o0,10              ! sets=        uses=%o0:     deads=%o0:
	bne	.L123               ! sets=        uses=         deads=
	nop
!
! block 34
! preds: 33
! succs: 38
!  doms: 1 2 16 17 22 23 27 28 33 34
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
! source statement 54
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(linect)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(linect)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L124               ! sets=        uses=         deads=
!
! block 35
! preds: 33
! succs: 36 37
!  doms: 1 2 16 17 22 23 27 28 33 35
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:
!
.L123:
! source statement 56
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	be	.L125               ! sets=        uses=         deads=
	nop
!
! block 36
! preds: 35
! succs: 37 39
!  doms: 1 2 16 17 22 23 27 28 33 35 36
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=%l3:
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 37
! preds: 35 36
! succs: 38
!  doms: 1 2 16 17 22 23 27 28 33 35 37
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L125:
!
! block 38
! preds: 34 37
! succs: 39
!  doms: 1 2 16 17 22 23 27 28 33 38
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L124:
! source statement 58
	mov	%g0,%l1             ! sets=%l1:    uses=%g0:     deads=
!
! block 39
! preds: 30 32 36 38
! succs: 40
!  doms: 1 2 16 17 22 23 27 28 39
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L114:
!
! block 40
! preds: 39
! succs: 23
!  doms: 1 2 16 17 22 23 27 28 39 40
!   ins=%l0:%l1:%l2:%l4:%l5:
!  outs=%l0:%l1:%l2:%l4:%l5:
!
.L116:
! source statement 59
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 41
! preds: 27
! succs: 42
!  doms: 1 2 16 17 22 23 27 41
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L115:
! source statement 61
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	sethi	%hi(wordct),%o2     ! sets=%o2:    uses=         deads=
	sethi	%hi(linect),%o3     ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o2 + %lo(wordct)],%o2! sets=%o2:    uses=%o2:     deads=%o2:
	ld	[%o3 + %lo(linect)],%o3! sets=%o3:    uses=%o3:     deads=%o3:
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 42
! preds: 41
! succs: 43 45
!  doms: 1 2 16 17 22 23 27 41 42
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
! source statement 62
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L127               ! sets=        uses=         deads=
	nop
!
! block 43
! preds: 42
! succs: 44
!  doms: 1 2 16 17 22 23 27 41 42 43
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
! source statement 63
	sethi	%hi(.L128),%o0      ! sets=%o0:    uses=         deads=
	mov	%l5,%o1             ! sets=%o1:    uses=%l5:     deads=
	mov	%l0,%o2             ! sets=%o2:    uses=%l0:     deads=
	sll	%o2,2,%o2           ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L128),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 44
! preds: 43
! succs: 46
!  doms: 1 2 16 17 22 23 27 41 42 43 44
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
	ba,a	.L129               ! sets=        uses=         deads=
!
! block 45
! preds: 42
! succs: 46
!  doms: 1 2 16 17 22 23 27 41 42 45
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L127:
! source statement 65
	sethi	%hi(.L130),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L130),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 46
! preds: 44 45
! succs: 47
!  doms: 1 2 16 17 22 23 27 41 42 46
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L129:
! source statement 66
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	call	fclose,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 47
! preds: 46
! succs: 48
!  doms: 1 2 16 17 22 23 27 41 42 46 47
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
! source statement 67
	sethi	%hi(tlinect),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tlinect)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(linect)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(tlinect),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tlinect)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 68
	sethi	%hi(twordct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(twordct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(wordct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(twordct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(twordct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 69
	sethi	%hi(tcharct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tcharct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tcharct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
!
! block 48
! preds: 21 47
! succs: 49 17
!  doms: 1 2 16 17 48
!   ins=%l0:%l2:%l4:%l5:
!  outs=%l0:%l2:%l4:%l5:
!
.L110:
! source statement 70
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
	mov	%l4,%o1             ! sets=%o1:    uses=%l4:     deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L111               ! sets=        uses=         deads=
	nop
!
! block 49
! preds: 48
! succs: 50 52
!  doms: 1 2 16 17 48 49
!   ins=%l4:
!  outs=
!
.L131:
! source statement 71
	mov	%l4,%o0             ! sets=%o0:    uses=%l4:     deads=%l4:
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	ble	.L132               ! sets=        uses=         deads=
	nop
!
! block 50
! preds: 49
! succs: 51
!  doms: 1 2 16 17 48 49 50
!   ins=
!  outs=
!
! source statement 72
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	sethi	%hi(twordct),%o2    ! sets=%o2:    uses=         deads=
	sethi	%hi(tlinect),%o3    ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %lo(tcharct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o2 + %lo(twordct)],%o2! sets=%o2:    uses=%o2:     deads=%o2:
	ld	[%o3 + %lo(tlinect)],%o3! sets=%o3:    uses=%o3:     deads=%o3:
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 51
! preds: 50
! succs: 52
!  doms: 1 2 16 17 48 49 50 51
!   ins=
!  outs=
!
! source statement 73
	sethi	%hi(.L133),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L133),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 52
! preds: 49 51
! succs: 53
!  doms: 1 2 16 17 48 49 52
!   ins=
!  outs=
!
.L132:
! source statement 75
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 53
! preds: 52
! succs:
!  doms: 1 2 16 17 48 49 52 53
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L133:
	.ascii " total\12\0"
.L130:
	.ascii "\12\0"
.L128:
	.ascii " %s\12\0"
.L112:
	.ascii "r\0"
.L107:
	.ascii "Usage: wc [-lwc] [files]\12\0"
.L94:
	.ascii "lwc\0"
.L12:
	.ascii "@(#)wc.c\11"
	.ascii "4.6 (Berkeley) 6/1/83\0"
	.seg	"text"
	.align	8
	.global	wcp
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2 3 4 5 6 7 8 9 10 11 12 13

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:%i2:%i3:
!  outs=%l0:%l1:%l2:%l3:
!
wcp:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
	!.2_wd = %l0
	mov	%i0,%l0             ! sets=%l0:    uses=%i0:     deads=%i0:
	!.2_charct = %l1
	mov	%i1,%l1             ! sets=%l1:    uses=%i1:     deads=%i1:
	!.2_wordct = %l2
	mov	%i2,%l2             ! sets=%l2:    uses=%i2:     deads=%i2:
	!.2_linect = %l3
	mov	%i3,%l3             ! sets=%l3:    uses=%i3:     deads=%i3:
!
! block 2
! preds: 1 5 7 9 13
! succs: 3 14
!  doms: 1 2
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L136:
! source statement 82
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L137               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 10
!  doms: 1 2 3
!   ins=%l0:%l1:%l2:%l3:
!  outs=%o0:%l0:%l1:%l2:%l3:
!
! source statement 82
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	mov	%o1,%l0             ! sets=%l0:    uses=%o1:     deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L139               ! sets=        uses=         deads=
!
! block 4
! preds: 11
! succs: 5
!  doms: 1 2 3 4 10 11
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L140:
! source statement 84
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 5
! preds: 4
! succs: 2
!  doms: 1 2 3 4 5 10 11
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 6
! preds: 12
! succs: 7
!  doms: 1 2 3 6 10 11 12
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L142:
! source statement 88
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 7
! preds: 6
! succs: 2
!  doms: 1 2 3 6 7 10 11 12
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 8
! preds: 10
! succs: 9
!  doms: 1 2 3 8 10
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L143:
! source statement 92
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 8
! succs: 2
!  doms: 1 2 3 8 9 10
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 10
! preds: 3
! succs: 11 8
!  doms: 1 2 3 10
!   ins=%o0:%l0:%l1:%l2:%l3:
!  outs=%o0:%l0:%l1:%l2:%l3:
!
.L139:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L143               ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 12 4
!  doms: 1 2 3 10 11
!   ins=%o0:%l0:%l1:%l2:%l3:
!  outs=%o0:%l0:%l1:%l2:%l3:
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L140               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13 6
!  doms: 1 2 3 10 11 12
!   ins=%o0:%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=%o0:
	be	.L142               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 2
!  doms: 1 2 3 10 11 12 13
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L138:
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 14
! preds: 2
! succs:
!  doms: 1 2 14
!   ins=
!  outs=
!
.L137:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	ipr
	.proc	0
! loops in function

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=
!
ipr:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
	!.3_num = %l0
	mov	%i0,%l0             ! sets=%l0:    uses=%i0:     deads=%i0:
! source statement 101
	sethi	%hi(.L146),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L146),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=%l0:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 2
! preds: 1
! succs:
!  doms: 1 2
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L146:
	.ascii " %7ld\0"
