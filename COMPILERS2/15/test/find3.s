	.seg	"data"
	.seg	"data"
	.align	8
	.global	a
a:
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	0
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 4
!         blocks = 4 5

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=key:
!  outs=key:
!
main:
! .1_i = %l0
.1_key = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! source statement 7
	sethi	%hi(.L16),%o0       ! sets=%o0:    uses=         deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	add	%o0,%lo(.L16),%o0   ! sets=%o0:    uses=%o0:     deads=
!
! block 2
! preds: 1
! succs: 3
!  doms: 1 2
!   ins=key:
!  outs=key:
!
! source statement 8
	sethi	%hi(.L18),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L18),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	scanf,2             ! sets=scratch uses=%o0:%o1: deads=
	add	%fp,.1_key,%o1      ! sets=%o1:    uses=%fp:     deads=
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=key:
!  outs=%g2:%l0:key:
!
! source statement 9
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
	sethi	%hi(a),%g1          ! sets=%g1:    uses=         deads=
	add	%g1,%lo(a),%g2      ! sets=%g2:    uses=%g1:     deads=%g1:
!
! block 4
! preds: 3 5
! succs: 5 7
!  doms: 1 2 3 4
!   ins=%g2:%l0:key:
!  outs=%g2:%l0:key:
!
.L21:
! source statement 10
	sll	%l0,2,%o0           ! sets=%o0:    uses=%l0:     deads=
	ld	[%o0 + %g2],%o0     ! sets=%o0:    uses=%g2:%o0: deads=%o0:
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	be	.L20                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6 4
!  doms: 1 2 3 4 5
!   ins=%g2:%l0:key:
!  outs=%g2:%l0:key:
!
.L22:
! source statement 12
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
! source statement 12
	cmp	%o0,10              ! sets=        uses=%o0:     deads=%o0:
	bl	.L21                ! sets=        uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
!
! block 6
! preds: 5
! succs: 7
!  doms: 1 2 3 4 5 6
!   ins=%l0:key:
!  outs=%l0:key:
!
.L23:
!
! block 7
! preds: 4 6
! succs: 8 10
!  doms: 1 2 3 4 7
!   ins=%l0:key:
!  outs=%l0:key:
!
.L20:
! source statement 12
	cmp	%l0,10              ! sets=        uses=%l0:     deads=
	bne	.L24                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9
!  doms: 1 2 3 4 7 8
!   ins=key:
!  outs=
!
! source statement 13
	sethi	%hi(.L25),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L25),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=
!
! block 9
! preds: 8
! succs: 11
!  doms: 1 2 3 4 7 8 9
!   ins=
!  outs=
!
	ba,a	.L26                ! sets=        uses=         deads=
!
! block 10
! preds: 7
! succs: 11
!  doms: 1 2 3 4 7 10
!   ins=%l0:key:
!  outs=
!
.L24:
! source statement 15
	sethi	%hi(.L27),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L27),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=key:
	call	printf,3            ! sets=scratch uses=%o0:%o1:%o2:deads=
	mov	%l0,%o2             ! sets=%o2:    uses=%l0:     deads=
!
! block 11
! preds: 9 10
! succs:
!  doms: 1 2 3 4 7 11
!   ins=
!  outs=
!
.L26:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L27:
	.ascii "position of key %d is %d\12\0"
.L25:
	.ascii "key %d not found\12\0"
.L18:
	.ascii "%d\0"
.L16:
	.ascii "enter a key\12\0"
