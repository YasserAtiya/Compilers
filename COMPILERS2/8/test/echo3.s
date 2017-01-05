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

!
! block 1
! preds:
! succs: 2 5
!  doms:
!   ins=
!  outs=
!
main:
.1_i = -4
.1_nflg = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.1_argc = 68
	st	%i0,[%fp + .1_argc] ! sets=argc:   uses=%i0:%fp: deads=
.1_argv = 72
	st	%i1,[%fp + .1_argv] ! sets=argv:   uses=%i1:%fp: deads=
! source statement 10
	st	%g0,[%fp + .1_nflg] ! sets=nflg:   uses=%g0:%fp: deads=
! source statement 11
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	ble	.L88                ! sets=        uses=         deads=
	nop
!
! block 2
! preds: 1
! succs: 3 5
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,45              ! sets=        uses=%o0:     deads=
	bne	.L88                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%o0 + 1],%o0       ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,110             ! sets=        uses=%o0:     deads=
	bne	.L88                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms:
!   ins=
!  outs=
!
! source statement 12
	ld	[%fp + .1_nflg],%o0 ! sets=%o0:    uses=%fp:nflg:deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_nflg] ! sets=nflg:   uses=%o0:%fp: deads=
! source statement 13
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_argc] ! sets=argc:   uses=%o0:%fp: deads=
! source statement 14
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_argv] ! sets=argv:   uses=%o0:%fp: deads=
!
! block 5
! preds: 1 2 3 4
! succs: 14
!  doms:
!   ins=
!  outs=
!
.L88:
! source statement 16
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
	ba,a	.L91                ! sets=        uses=         deads=
!
! block 6
! preds: 14
! succs: 7
!  doms:
!   ins=
!  outs=
!
.L92:
! source statement 17
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=
	sethi	%hi(_iob),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(_iob),%o2   ! sets=%o2:    uses=%o2:     deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	add	%o2,16,%o1          ! sets=%o1:    uses=%o2:     deads=
	call	fputs,2             ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 7
! preds: 6
! succs: 8 13
!  doms:
!   ins=
!  outs=
!
! source statement 18
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=
	bge	.L93                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 11
!  doms:
!   ins=
!  outs=
!
! source statement 19
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=
	add	%o0,16,%o0          ! sets=%o0:    uses=%o0:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=
	bge	.L94                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms:
!   ins=
!  outs=
!
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	add	%o1,16,%o1          ! sets=%o1:    uses=%o1:     deads=
	call	_flsbuf,2           ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 10
! preds: 9
! succs: 12
!  doms:
!   ins=
!  outs=
!
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 11
! preds: 8
! succs: 12
!  doms:
!   ins=
!  outs=
!
.L94:
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=
	add	%o1,20,%o1          ! sets=%o1:    uses=%o1:     deads=
	ld	[%o1],%o2           ! sets=%o2:    uses=%o1:     deads=
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	st	%o3,[%o1]           ! sets=        uses=%o1:%o3: deads=
	stb	%o0,[%o2]           ! sets=        uses=%o0:%o2: deads=
	and	%o0,255,%o0         ! sets=%o0:    uses=%o0:     deads=
!
! block 12
! preds: 10 11
! succs: 13
!  doms:
!   ins=
!  outs=
!
.L95:
!
! block 13
! preds: 7 12
! succs: 14
!  doms:
!   ins=
!  outs=
!
.L93:
! source statement 20
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
!
! block 14
! preds: 5 13
! succs: 15 6
!  doms:
!   ins=
!  outs=
!
.L91:
! source statement 20
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=
	bl	.L92                ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16 21
!  doms:
!   ins=
!  outs=
!
.L96:
! source statement 21
	ld	[%fp + .1_nflg],%o0 ! sets=%o0:    uses=%fp:nflg:deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bne	.L97                ! sets=        uses=         deads=
	nop
!
! block 16
! preds: 15
! succs: 17 19
!  doms:
!   ins=
!  outs=
!
! source statement 22
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=
	add	%o0,16,%o0          ! sets=%o0:    uses=%o0:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=
	bge	.L98                ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18
!  doms:
!   ins=
!  outs=
!
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	add	%o1,16,%o1          ! sets=%o1:    uses=%o1:     deads=
	call	_flsbuf,2           ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 18
! preds: 17
! succs: 20
!  doms:
!   ins=
!  outs=
!
	ba,a	.L99                ! sets=        uses=         deads=
!
! block 19
! preds: 16
! succs: 20
!  doms:
!   ins=
!  outs=
!
.L98:
	mov	10,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(_iob),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(_iob),%o1   ! sets=%o1:    uses=%o1:     deads=
	add	%o1,20,%o1          ! sets=%o1:    uses=%o1:     deads=
	ld	[%o1],%o2           ! sets=%o2:    uses=%o1:     deads=
	add	%o2,1,%o3           ! sets=%o3:    uses=%o2:     deads=
	st	%o3,[%o1]           ! sets=        uses=%o1:%o3: deads=
	stb	%o0,[%o2]           ! sets=        uses=%o0:%o2: deads=
	and	%o0,255,%o0         ! sets=%o0:    uses=%o0:     deads=
!
! block 20
! preds: 18 19
! succs: 21
!  doms:
!   ins=
!  outs=
!
.L99:
!
! block 21
! preds: 15 20
! succs: 22
!  doms:
!   ins=
!  outs=
!
.L97:
! source statement 23
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=
	nop
!
! block 22
! preds: 21
! succs:
!  doms:
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L12:
	.ascii "@(#)echo.c\11"
	.ascii "4.1 (Berkeley) 10/1/80\0"
