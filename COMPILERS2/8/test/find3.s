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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=
!  outs=
!
main:
.1_i = -4
.1_key = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! source statement 7
	sethi	%hi(.L16),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L16),%o0   ! sets=%o0:    uses=%o0:     deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms:
!   ins=
!  outs=
!
! source statement 8
	sethi	%hi(.L18),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L18),%o0   ! sets=%o0:    uses=%o0:     deads=
	add	%fp,.1_key,%o1      ! sets=%o1:    uses=%fp:     deads=
	call	scanf,2             ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms:
!   ins=
!  outs=
!
! source statement 9
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 4
! preds: 3 5
! succs: 5 7
!  doms:
!   ins=
!  outs=
!
.L21:
! source statement 10
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	sll	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(a),%o1          ! sets=%o1:    uses=         deads=
	add	%o1,%lo(a),%o1      ! sets=%o1:    uses=%o1:     deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=
	be	.L20                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6 4
!  doms:
!   ins=
!  outs=
!
.L22:
! source statement 12
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
! source statement 12
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,10              ! sets=        uses=%o0:     deads=
	bl	.L21                ! sets=        uses=         deads=
	nop
!
! block 6
! preds: 5
! succs: 7
!  doms:
!   ins=
!  outs=
!
.L23:
!
! block 7
! preds: 4 6
! succs: 8 10
!  doms:
!   ins=
!  outs=
!
.L20:
! source statement 12
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,10              ! sets=        uses=%o0:     deads=
	bne	.L24                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9
!  doms:
!   ins=
!  outs=
!
! source statement 13
	sethi	%hi(.L25),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L25),%o0   ! sets=%o0:    uses=%o0:     deads=
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 9
! preds: 8
! succs: 11
!  doms:
!   ins=
!  outs=
!
	ba,a	.L26                ! sets=        uses=         deads=
!
! block 10
! preds: 7
! succs: 11
!  doms:
!   ins=
!  outs=
!
.L24:
! source statement 15
	sethi	%hi(.L27),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L27),%o0   ! sets=%o0:    uses=%o0:     deads=
	ld	[%fp + .1_key],%o1  ! sets=%o1:    uses=%fp:key: deads=
	ld	[%fp + .1_i],%o2    ! sets=%o2:    uses=%fp:i:   deads=
	call	printf,3            ! sets=scratch uses=%o0:%o1:%o2:deads=
	nop
!
! block 11
! preds: 9 10
! succs:
!  doms:
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
