	.seg	"data"
	.seg	"data"
	.common	up,64,4
	.common	down,64,4
	.common	rows,36,4
	.common	x,36,4
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2
!   loop: head = 4
!         blocks = 4

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=
!  outs=%g2:%g4:%l0:
!
main:
! .1_i = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! source statement 9
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
	sethi	%hi(down),%g1       ! sets=%g1:    uses=         deads=
	add	%g1,%lo(down),%g2   ! sets=%g2:    uses=%g1:     deads=%g1:
	sethi	%hi(up),%g3         ! sets=%g3:    uses=         deads=
	add	%g3,%lo(up),%g4     ! sets=%g4:    uses=%g3:     deads=%g3:
!
! block 2
! preds: 1 2
! succs: 3 2
!  doms: 1 2
!   ins=%g2:%g4:%l0:
!  outs=%g2:%g4:%l0:
!
.L20:
! source statement 10
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%g0,[%o1 + %g2]     ! sets=        uses=%g0:%g2:%o1:deads=%o1:
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%g0,[%o1 + %g4]     ! sets=        uses=%g0:%g4:%o1:deads=%o1:
! source statement 10
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
! source statement 10
	cmp	%o0,16              ! sets=        uses=%o0:     deads=%o0:
	bl	.L20                ! sets=        uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=
!  outs=%g2:%g4:%l0:
!
.L21:
! source statement 11
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
	sethi	%hi(x),%g1          ! sets=%g1:    uses=         deads=
	add	%g1,%lo(x),%g2      ! sets=%g2:    uses=%g1:     deads=%g1:
	sethi	%hi(rows),%g3       ! sets=%g3:    uses=         deads=
	add	%g3,%lo(rows),%g4   ! sets=%g4:    uses=%g3:     deads=%g3:
!
! block 4
! preds: 3 4
! succs: 5 4
!  doms: 1 2 3 4
!   ins=%g2:%g4:%l0:
!  outs=%g2:%g4:%l0:
!
.L24:
! source statement 12
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%g0,[%o1 + %g2]     ! sets=        uses=%g0:%g2:%o1:deads=%o1:
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%g0,[%o1 + %g4]     ! sets=        uses=%g0:%g4:%o1:deads=%o1:
! source statement 12
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
! source statement 12
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	bl	.L24                ! sets=        uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
!
! block 5
! preds: 4
! succs: 6
!  doms: 1 2 3 4 5
!   ins=
!  outs=
!
.L25:
! source statement 13
	call	queens,1            ! sets=scratch uses=%o0:     deads=
	mov	1,%o0               ! sets=%o0:    uses=         deads=
!
! block 6
! preds: 5
! succs:
!  doms: 1 2 3 4 5 6
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	queens
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2 3 4 5 6 7 8 9 10

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
queens:
! .2_r = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! .2_c = %l1
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=
! source statement 21
	mov	1,%l0               ! sets=%l0:    uses=         deads=
	sethi	%hi(x),%g1          ! sets=%g1:    uses=         deads=
	sethi	%hi(up),%g2         ! sets=%g2:    uses=         deads=
	sethi	%hi(down),%g3       ! sets=%g3:    uses=         deads=
	add	%i0,1,%g5           ! sets=%g5:    uses=%i0:     deads=
	sethi	%hi(rows),%g7       ! sets=%g7:    uses=         deads=
	add	%g1,%lo(x),%o3      ! sets=%o3:    uses=%g1:     deads=
	add	%g2,%lo(up),%o4     ! sets=%o4:    uses=%g2:     deads=%g2:
	add	%g3,%lo(down),%o5   ! sets=%o5:    uses=%g3:     deads=%g3:
	mov	%o5,%l2             ! sets=%l2:    uses=%o5:     deads=
	add	%g7,%lo(rows),%l4   ! sets=%l4:    uses=%g7:     deads=%g7:
	mov	%o4,%l6             ! sets=%l6:    uses=%o4:     deads=
	mov	%o4,%l7             ! sets=%l7:    uses=%o4:     deads=
	mov	%l4,%i2             ! sets=%i2:    uses=%l4:     deads=
	mov	%l4,%i3             ! sets=%i3:    uses=%l4:     deads=
	sll	%i0,2,%i4           ! sets=%i4:    uses=%i0:     deads=%i0:
	mov	%g1,%i5             ! sets=%i5:    uses=%g1:     deads=%g1:
!
! block 2
! preds: 1 10
! succs: 3 10
!  doms: 1 2
!   ins=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
.L31:
! source statement 22
	sll	%l0,2,%o0           ! sets=%o0:    uses=%l0:     deads=
	ld	[%o0 + %l4],%o0     ! sets=%o0:    uses=%o0:%l4: deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 10
!  doms: 1 2 3
!   ins=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
	sub	%l0,%l1,%o0         ! sets=%o0:    uses=%l0:%l1: deads=
	add	%o0,8,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0 + %o4],%o0     ! sets=%o0:    uses=%o0:%o4: deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5 10
!  doms: 1 2 3 4
!   ins=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
	add	%l0,%l1,%o0         ! sets=%o0:    uses=%l0:%l1: deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0 + %o5],%o0     ! sets=%o0:    uses=%o0:%o5: deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6 8
!  doms: 1 2 3 4 5
!   ins=%g5:%o3:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
! source statement 23
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	add	%l0,%l1,%o1         ! sets=%o1:    uses=%l0:%l1: deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o0,[%o1 + %l2]     ! sets=        uses=%o0:%o1:%l2:deads=%o1:
	sub	%l0,%l1,%o1         ! sets=%o1:    uses=%l0:%l1: deads=
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o0,[%o1 + %l7]     ! sets=        uses=%o0:%o1:%l7:deads=%o1:
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%o0,[%o1 + %i3]     ! sets=        uses=%o0:%o1:%i3:deads=%o0:%o1:
! source statement 24
	add	%i5,%lo(x),%o2      ! sets=%o2:    uses=%i5:     deads=
! source statement 25
	cmp	%l1,8               ! sets=        uses=%l1:     deads=
	bne	.L33                ! sets=        uses=         deads=
	st	%l0,[%i4 + %o2]     ! sets=        uses=%o2:%l0:%i4:deads=
!
! block 6
! preds: 5
! succs: 7
!  doms: 1 2 3 4 5 6
!   ins=%o3:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%g6:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
! source statement 26
	call	print,1             ! sets=scratch uses=%o0:     deads=
	mov	%o3,%o0             ! sets=%o0:    uses=%o3:     deads=
!
! block 7
! preds: 6
! succs: 9
!  doms: 1 2 3 4 5 6 7
!   ins=%g5:%g6:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%g6:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
	ba,a	.L35                ! sets=        uses=         deads=
!
! block 8
! preds: 5
! succs: 9
!  doms: 1 2 3 4 5 8
!   ins=%g5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%g6:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
.L33:
! source statement 28
	call	queens,1            ! sets=scratch uses=%o0:     deads=
	mov	%g5,%o0             ! sets=%o0:    uses=%g5:     deads=
!
! block 9
! preds: 7 8
! succs: 10
!  doms: 1 2 3 4 5 9
!   ins=%g5:%g6:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
.L35:
! source statement 29
	add	%l0,%l1,%o1         ! sets=%o1:    uses=%l0:%l1: deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%g6,%lo(down),%o2   ! sets=%o2:    uses=%g6:     deads=%g6:
	st	%g0,[%o1 + %o2]     ! sets=        uses=%g0:%o1:%o2:deads=%o1:%o2:
	sub	%l0,%l1,%o1         ! sets=%o1:    uses=%l0:%l1: deads=
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%g0,[%o1 + %l6]     ! sets=        uses=%g0:%o1:%l6:deads=%o1:
	sll	%l0,2,%o1           ! sets=%o1:    uses=%l0:     deads=
	st	%g0,[%o1 + %i2]     ! sets=        uses=%g0:%o1:%i2:deads=%o1:
!
! block 10
! preds: 2 3 4 9
! succs: 11 2
!  doms: 1 2 10
!   ins=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!  outs=%g5:%o3:%o4:%o5:%l0:%l1:%l2:%l4:%l6:%l7:%i2:%i3:%i4:%i5:
!
.L32:
! source statement 31
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
! source statement 31
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L31                ! sets=        uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
!
! block 11
! preds: 10
! succs:
!  doms: 1 2 10 11
!   ins=
!  outs=
!
.L36:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	print
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2 3

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=%g2:%l0:%l1:
!
print:
! .3_k = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! .3_x = %l1
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=%i0:
! source statement 38
	mov	1,%l0               ! sets=%l0:    uses=         deads=
	sethi	%hi(.L43),%g1       ! sets=%g1:    uses=         deads=
	add	%g1,%lo(.L43),%g2   ! sets=%g2:    uses=%g1:     deads=%g1:
!
! block 2
! preds: 1 3
! succs: 3
!  doms: 1 2
!   ins=%g2:%l0:%l1:
!  outs=%g2:%l0:%l1:
!
.L41:
! source statement 39
	sll	%l0,2,%o2           ! sets=%o2:    uses=%l0:     deads=
	mov	%g2,%o0             ! sets=%o0:    uses=%g2:     deads=%g2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	ld	[%l1 + %o2],%o1     ! sets=%o1:    uses=%o2:%l1: deads=
!
! block 3
! preds: 2
! succs: 4 2
!  doms: 1 2 3
!   ins=%g2:%l0:%l1:
!  outs=%g2:%l0:%l1:
!
! source statement 39
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
! source statement 39
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L41                ! sets=        uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
!
! block 4
! preds: 3
! succs: 5
!  doms: 1 2 3 4
!   ins=
!  outs=
!
.L44:
! source statement 40
	sethi	%hi(.L45),%o0       ! sets=%o0:    uses=         deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	add	%o0,%lo(.L45),%o0   ! sets=%o0:    uses=%o0:     deads=
!
! block 5
! preds: 4
! succs:
!  doms: 1 2 3 4 5
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L45:
	.ascii "\12\0"
.L43:
	.ascii " %d\0"
