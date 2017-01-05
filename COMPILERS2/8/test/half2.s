	.seg	"data"
	.seg	"data"
	.seg	"text"
	.align	8
	.global	half
	.proc	7
! loops in function

!
! block 1
! preds:
! succs:
!  doms:
!   ins=
!  outs=
!
half:
.1_d = -8
	save	%sp,(-80),%sp       ! sets=window  uses=%sp:     deads=
.1_i = 68
	st	%i0,[%fp + .1_i]    ! sets=i:      uses=%i0:%fp: deads=
! source statement 6
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	st	%o0,[%sp + -12]     ! sets=        uses=%o0:%sp: deads=
	ld	[%sp + -12],%f0     ! sets=%f0:    uses=%sp:     deads=
	fitod	%f0,%f0             ! sets=%f0:%f1:uses=%f0:     deads=
	std	%f0,[%fp + .1_d]    ! sets=d:      uses=%fp:%f0:%f1:deads=
! source statement 7
	ldd	[%fp + .1_d],%f0    ! sets=%f0:%f1:uses=%fp:d:   deads=
	sethi	%hi(.L01),%o0       ! sets=%o0:    uses=         deads=
	ldd	[%o0 + %lo(.L01)],%f2! sets=%f2:%f3:uses=%o0:     deads=
	fdivd	%f0,%f2,%f0         ! sets=%f0:%f1:uses=%f0:%f1:%f2:%f3:deads=
	std	%f0,[%fp + .1_d]    ! sets=d:      uses=%fp:%f0:%f1:deads=
! source statement 8
	ldd	[%fp + .1_d],%f0    ! sets=%f0:%f1:uses=%fp:d:   deads=
	ret	                    ! sets=        uses=%f0:%f1: deads=
	restore	                    ! sets=window  uses=         deads=
!
! block 2
! preds:
! succs:
!  doms:
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=%f0:%f1: deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.align	8
.L01:	.double	0r2.00000000000000000000000000000000e+00
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
.2_n = -4
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! source statement 15
	mov	3,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .2_n]    ! sets=n:      uses=%o0:%fp: deads=
! source statement 16
	sethi	%hi(.L18),%l0       ! sets=%l0:    uses=         deads=
	ld	[%fp + .2_n],%o0    ! sets=%o0:    uses=%fp:n:   deads=
	call	half,1              ! sets=scratch uses=%o0:     deads=
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms:
!   ins=
!  outs=
!
	add	%l0,%lo(.L18),%o0   ! sets=%o0:    uses=%l0:     deads=
	ld	[%fp + .2_n],%o1    ! sets=%o1:    uses=%fp:n:   deads=
	fmovs	%f0,%f0             ! sets=%f0:    uses=%f0:     deads=
	fmovs	%f1,%f1             ! sets=%f1:    uses=%f1:     deads=
	st	%f0,[%sp + 76]      ! sets=        uses=%sp:%f0: deads=
	st	%f1,[%sp + 80]      ! sets=        uses=%sp:%f1: deads=
	ld	[%sp + 76],%o2      ! sets=%o2:    uses=%sp:     deads=
	ld	[%sp + 80],%o3      ! sets=%o3:    uses=%sp:     deads=
	call	printf,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=
	nop
!
! block 3
! preds: 2
! succs:
!  doms:
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L18:
	.ascii "n = %d, n/2 = %f\12\0"
