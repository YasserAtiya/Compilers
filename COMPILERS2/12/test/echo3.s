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
!  outs=%l1:%l2:%l3:
!
main:
	!.1_i = %l0
	!.1_nflg = %l1
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
	!.1_argc = %l2
	mov	%i0,%l2             ! sets=%l2:    uses=%i0:     deads=%i0:
	!.1_argv = %l3
	mov	%i1,%l3             ! sets=%l3:    uses=%i1:     deads=%i1:
! source statement 10
	mov	%g0,%l1             ! sets=%l1:    uses=%g0:     deads=
! source statement 11
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L88                ! sets=        uses=         deads=
	nop
!
! block 2
! preds: 1
! succs: 3 5
!  doms: 1 2
!   ins=%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
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
!   ins=%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
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
!   ins=%l1:%l2:%l3:
!  outs=%l1:%l2:%l3:
!
! source statement 12
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=%l1:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
! source statement 13
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=%l2:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
! source statement 14
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=%l3:
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l3             ! sets=%l3:    uses=%o0:     deads=%o0:
!
! block 5
! preds: 1 2 3 4
! succs: 14
!  doms: 1 5
!   ins=%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L88:
! source statement 16
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
	ba,a	.L91                ! sets=        uses=         deads=
!
! block 6
! preds: 14
! succs: 7
!  doms: 1 5 6 14
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L92:
! source statement 17
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
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
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
! source statement 18
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	%l2,%o1             ! sets=%o1:    uses=%l2:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bge	.L93                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 11
!  doms: 1 5 6 7 8 14
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
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
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
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
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 11
! preds: 8
! succs: 12
!  doms: 1 5 6 7 8 11 14
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
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
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L95:
!
! block 13
! preds: 7 12
! succs: 14
!  doms: 1 5 6 7 13 14
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L93:
! source statement 20
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
!
! block 14
! preds: 5 13
! succs: 15 6
!  doms: 1 5 14
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L91:
! source statement 20
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	%l2,%o1             ! sets=%o1:    uses=%l2:     deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L92                ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16 21
!  doms: 1 5 14 15
!   ins=%l1:
!  outs=
!
.L96:
! source statement 21
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=%l1:
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
