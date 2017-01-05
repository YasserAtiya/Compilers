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
!  outs=%l0:
!
main:
	!.1_i = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! source statement 9
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
!
! block 2
! preds: 1 2
! succs: 3 2
!  doms: 1 2
!   ins=%l0:
!  outs=%l0:
!
.L20:
! source statement 10
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 10
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 10
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	cmp	%o0,16              ! sets=        uses=%o0:     deads=%o0:
	bl	.L20                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=
!  outs=%l0:
!
.L21:
! source statement 11
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
!
! block 4
! preds: 3 4
! succs: 5 4
!  doms: 1 2 3 4
!   ins=%l0:
!  outs=%l0:
!
.L24:
! source statement 12
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(x),%o2          ! sets=%o2:    uses=         deads=
	add	%o2,%lo(x),%o2      ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 12
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 12
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	bl	.L24                ! sets=        uses=         deads=
	nop
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
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	call	queens,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
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
!  outs=%l0:%l1:
!
queens:
	!.2_r = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
	!.2_c = %l1
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=%i0:
! source statement 21
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
!
! block 2
! preds: 1 10
! succs: 3 10
!  doms: 1 2
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
.L31:
! source statement 22
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(rows),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(rows),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 10
!  doms: 1 2 3
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	sub	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	add	%o0,8,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(up),%o1         ! sets=%o1:    uses=         deads=
	add	%o1,%lo(up),%o1     ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5 10
!  doms: 1 2 3 4
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(down),%o1       ! sets=%o1:    uses=         deads=
	add	%o1,%lo(down),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L32                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6 8
!  doms: 1 2 3 4 5
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
! source statement 23
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	mov	%l1,%o2             ! sets=%o2:    uses=%l1:     deads=
	add	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	mov	%l1,%o2             ! sets=%o2:    uses=%l1:     deads=
	sub	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 24
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(x),%o2          ! sets=%o2:    uses=         deads=
	add	%o2,%lo(x),%o2      ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 25
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	bne	.L33                ! sets=        uses=         deads=
	nop
!
! block 6
! preds: 5
! succs: 7
!  doms: 1 2 3 4 5 6
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
! source statement 26
	sethi	%hi(x),%o0          ! sets=%o0:    uses=         deads=
	add	%o0,%lo(x),%o0      ! sets=%o0:    uses=%o0:     deads=%o0:
	call	print,1             ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 7
! preds: 6
! succs: 9
!  doms: 1 2 3 4 5 6 7
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
	ba,a	.L35                ! sets=        uses=         deads=
!
! block 8
! preds: 5
! succs: 9
!  doms: 1 2 3 4 5 8
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
.L33:
! source statement 28
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	call	queens,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 7 8
! succs: 10
!  doms: 1 2 3 4 5 9
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
.L35:
! source statement 29
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	mov	%l1,%o2             ! sets=%o2:    uses=%l1:     deads=
	add	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	mov	%l1,%o2             ! sets=%o2:    uses=%l1:     deads=
	sub	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
!
! block 10
! preds: 2 3 4 9
! succs: 11 2
!  doms: 1 2 10
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
.L32:
! source statement 31
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 31
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L31                ! sets=        uses=         deads=
	nop
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
!  outs=%l0:%l1:
!
print:
	!.3_k = %l0
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
	!.3_x = %l1
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=%i0:
! source statement 38
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
!
! block 2
! preds: 1 3
! succs: 3
!  doms: 1 2
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
.L41:
! source statement 39
	sethi	%hi(.L43),%o0       ! sets=%o0:    uses=         deads=
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=
	mov	%l0,%o2             ! sets=%o2:    uses=%l0:     deads=
	sll	%o2,2,%o2           ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L43),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 3
! preds: 2
! succs: 4 2
!  doms: 1 2 3
!   ins=%l0:%l1:
!  outs=%l0:%l1:
!
! source statement 39
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 39
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L41                ! sets=        uses=         deads=
	nop
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
	add	%o0,%lo(.L45),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
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
