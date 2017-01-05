	.seg	"data"
	.seg	"data"
	.align	8
sccsid:
	.word	.L12
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 14
!         blocks = 6 7 8 9 10 11 12 13 14

!
! block 1
! preds:
! succs: 2 5
!  doms: 1
!   ins=%i0:%i1:
!  outs=nflg:argc:argv:
!
main:
.1_i = -4
.1_nflg = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.1_argc = 68
	st	%i0,[%fp + .1_argc] ! sets=argc:   uses=%i0:%fp: deads=%i0:
.1_argv = 72
	st	%i1,[%fp + .1_argv] ! sets=argv:   uses=%i1:%fp: deads=%i1:
! source statement 10
	st	%g0,[%fp + .1_nflg] ! sets=nflg:   uses=%g0:%fp: deads=
! source statement 11
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L88                ! sets=        uses=         deads=
	nop
!
! block 2
! preds: 1
! succs: 3 5
!  doms: 1 2
!   ins=nflg:argc:argv:
!  outs=nflg:argc:argv:
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,45              ! sets=        uses=%o0:     deads=%o0:
	bne	.L88                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms: 1 2 3
!   ins=nflg:argc:argv:
!  outs=nflg:argc:argv:
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0 + 1],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,110             ! sets=        uses=%o0:     deads=%o0:
	bne	.L88                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms: 1 2 3 4
!   ins=nflg:argc:argv:
!  outs=nflg:argc:argv:
!
! source statement 12
	ld	[%fp + .1_nflg],%o0 ! sets=%o0:    uses=%fp:nflg:deads=nflg:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_nflg] ! sets=nflg:   uses=%o0:%fp: deads=%o0:
! source statement 13
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=argc:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_argc] ! sets=argc:   uses=%o0:%fp: deads=%o0:
! source statement 14
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=argv:
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_argv] ! sets=argv:   uses=%o0:%fp: deads=%o0:
!
! block 5
! preds: 1 2 3 4
! succs: 14
!  doms: 1 5
!   ins=nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L88:
! source statement 16
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
	ba,a	.L91                ! sets=        uses=         deads=
!
! block 6
! preds: 14
! succs: 7
!  doms: 1 5 6 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L92:
! source statement 17
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(_iob),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(_iob),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	add	%o2,16,%o1          ! sets=%o1:    uses=%o2:     deads=%o2:
	call	fputs,2             ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 7
! preds: 6
! succs: 8 13
!  doms: 1 5 6 7 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
! source statement 18
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bge	.L93                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 11
!  doms: 1 5 6 7 8 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
! source statement 19
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,16,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=%o1:
	bge	.L94                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms: 1 5 6 7 8 9 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	add	%o1,16,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	call	_flsbuf,2           ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 10
! preds: 9
! succs: 12
!  doms: 1 5 6 7 8 9 10 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 11
! preds: 8
! succs: 12
!  doms: 1 5 6 7 8 11 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L94:
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o1,20,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o1],%o2           ! sets=%o2:    uses=%o1:     deads=
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	st	%o3,[%o1]           ! sets=        uses=%o1:%o3: deads=%o1:%o3:
	stb	%o0,[%o2]           ! sets=        uses=%o0:%o2: deads=%o2:
	and	%o0,255,%o0         ! sets=%o0:    uses=%o0:     deads=%o0:
!
! block 12
! preds: 10 11
! succs: 13
!  doms: 1 5 6 7 8 12 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L95:
!
! block 13
! preds: 7 12
! succs: 14
!  doms: 1 5 6 7 13 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L93:
! source statement 20
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
!
! block 14
! preds: 5 13
! succs: 15 6
!  doms: 1 5 14
!   ins=i:nflg:argc:argv:
!  outs=i:nflg:argc:argv:
!
.L91:
! source statement 20
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L92                ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16 21
!  doms: 1 5 14 15
!   ins=nflg:
!  outs=
!
.L96:
! source statement 21
	ld	[%fp + .1_nflg],%o0 ! sets=%o0:    uses=%fp:nflg:deads=nflg:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L97                ! sets=        uses=         deads=
	nop
!
! block 16
! preds: 15
! succs: 17 19
!  doms: 1 5 14 15 16
!   ins=
!  outs=
!
! source statement 22
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,16,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=%o1:
	bge	.L98                ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18
!  doms: 1 5 14 15 16 17
!   ins=
!  outs=
!
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	add	%o1,16,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	call	_flsbuf,2           ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 18
! preds: 17
! succs: 20
!  doms: 1 5 14 15 16 17 18
!   ins=
!  outs=
!
	ba,a	.L99                ! sets=        uses=         deads=
!
! block 19
! preds: 16
! succs: 20
!  doms: 1 5 14 15 16 19
!   ins=
!  outs=
!
.L98:
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o1,20,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o1],%o2           ! sets=%o2:    uses=%o1:     deads=
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	st	%o3,[%o1]           ! sets=        uses=%o1:%o3: deads=%o1:%o3:
	stb	%o0,[%o2]           ! sets=        uses=%o0:%o2: deads=%o2:
	and	%o0,255,%o0         ! sets=%o0:    uses=%o0:     deads=%o0:
!
! block 20
! preds: 18 19
! succs: 21
!  doms: 1 5 14 15 16 20
!   ins=
!  outs=
!
.L99:
!
! block 21
! preds: 15 20
! succs: 22
!  doms: 1 5 14 15 21
!   ins=
!  outs=
!
.L97:
! source statement 23
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 22
! preds: 21
! succs:
!  doms: 1 5 14 15 21 22
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L12:
	.ascii "@(#)echo.c\11"
	.ascii "4.1 (Berkeley) 10/1/80\0"
