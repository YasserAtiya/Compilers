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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=
!  outs=i:
!
main:
.1_i = -4
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! source statement 9
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 2
! preds: 1 2
! succs: 3 2
!  doms:
!   ins=i:
!  outs=i:
!
.L20:
! source statement 10
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 10
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 10
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,16              ! sets=        uses=%o0:     deads=%o0:
	bl	.L20                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms:
!   ins=
!  outs=i:
!
.L21:
! source statement 11
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 4
! preds: 3 4
! succs: 5 4
!  doms:
!   ins=i:
!  outs=i:
!
.L24:
! source statement 12
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(x),%o2          ! sets=%o2:    uses=         deads=
	add	%o2,%lo(x),%o2      ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 12
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 12
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	bl	.L24                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6
!  doms:
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
!  doms:
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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=%i0:
!  outs=r:c:
!
queens:
.2_r = -4
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.2_c = 68
	st	%i0,[%fp + .2_c]    ! sets=c:      uses=%i0:%fp: deads=%i0:
! source statement 21
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .2_r]    ! sets=r:      uses=%o0:%fp: deads=%o0:
!
! block 2
! preds: 1 10
! succs: 3 10
!  doms:
!   ins=r:c:
!  outs=r:c:
!
.L31:
! source statement 22
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=
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
!  doms:
!   ins=r:c:
!  outs=r:c:
!
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o1    ! sets=%o1:    uses=%fp:c:   deads=
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
!  doms:
!   ins=r:c:
!  outs=r:c:
!
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o1    ! sets=%o1:    uses=%fp:c:   deads=
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
!  doms:
!   ins=r:c:
!  outs=r:c:
!
! source statement 23
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o2    ! sets=%o2:    uses=%fp:c:   deads=
	add	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o2    ! sets=%o2:    uses=%fp:c:   deads=
	sub	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 24
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o1    ! sets=%o1:    uses=%fp:c:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(x),%o2          ! sets=%o2:    uses=         deads=
	add	%o2,%lo(x),%o2      ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
! source statement 25
	ld	[%fp + .2_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	bne	.L33                ! sets=        uses=         deads=
	nop
!
! block 6
! preds: 5
! succs: 7
!  doms:
!   ins=r:c:
!  outs=r:c:
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
!  doms:
!   ins=r:c:
!  outs=r:c:
!
	ba,a	.L35                ! sets=        uses=         deads=
!
! block 8
! preds: 5
! succs: 9
!  doms:
!   ins=r:c:
!  outs=r:c:
!
.L33:
! source statement 28
	ld	[%fp + .2_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	call	queens,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 7 8
! succs: 10
!  doms:
!   ins=r:c:
!  outs=r:c:
!
.L35:
! source statement 29
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o2    ! sets=%o2:    uses=%fp:c:   deads=
	add	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(down),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(down),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	ld	[%fp + .2_c],%o2    ! sets=%o2:    uses=%fp:c:   deads=
	sub	%o1,%o2,%o1         ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	add	%o1,8,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(up),%o2         ! sets=%o2:    uses=         deads=
	add	%o2,%lo(up),%o2     ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o1:%o2:
	ld	[%fp + .2_r],%o1    ! sets=%o1:    uses=%fp:r:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(rows),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(rows),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	st	%o0,[%o1 + %o2]     ! sets=        uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
!
! block 10
! preds: 2 3 4 9
! succs: 11 2
!  doms:
!   ins=r:c:
!  outs=r:c:
!
.L32:
! source statement 31
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=r:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .2_r]    ! sets=r:      uses=%o0:%fp: deads=%o0:
! source statement 31
	ld	[%fp + .2_r],%o0    ! sets=%o0:    uses=%fp:r:   deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L31                ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs:
!  doms:
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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=%i0:
!  outs=k:x:
!
print:
.3_k = -4
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.3_x = 68
	st	%i0,[%fp + .3_x]    ! sets=x:      uses=%i0:%fp: deads=%i0:
! source statement 38
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .3_k]    ! sets=k:      uses=%o0:%fp: deads=%o0:
!
! block 2
! preds: 1 3
! succs: 3
!  doms:
!   ins=k:x:
!  outs=k:x:
!
.L41:
! source statement 39
	sethi	%hi(.L43),%o0       ! sets=%o0:    uses=         deads=
	ld	[%fp + .3_x],%o1    ! sets=%o1:    uses=%fp:x:   deads=
	ld	[%fp + .3_k],%o2    ! sets=%o2:    uses=%fp:k:   deads=
	sll	%o2,2,%o2           ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L43),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 3
! preds: 2
! succs: 4 2
!  doms:
!   ins=k:x:
!  outs=k:x:
!
! source statement 39
	ld	[%fp + .3_k],%o0    ! sets=%o0:    uses=%fp:k:   deads=k:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .3_k]    ! sets=k:      uses=%o0:%fp: deads=%o0:
! source statement 39
	ld	[%fp + .3_k],%o0    ! sets=%o0:    uses=%fp:k:   deads=
	cmp	%o0,8               ! sets=        uses=%o0:     deads=%o0:
	ble	.L41                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms:
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
!  doms:
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
