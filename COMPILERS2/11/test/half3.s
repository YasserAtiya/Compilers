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
!  doms: 1
!   ins=%i0:
!  outs=
!
half:
	!.1_d = %f4
	save	%sp,(-80),%sp       ! sets=window  uses=%sp:     deads=
	!.1_i = %g1
	mov	%i0,%g1             ! sets=%g1:    uses=%i0:     deads=%i0:
! source statement 6
	mov	%g1,%o0             ! sets=%o0:    uses=%g1:     deads=%g1:
	st	%o0,[%sp + -12]     ! sets=        uses=%o0:%sp: deads=%o0:
	ld	[%sp + -12],%f0     ! sets=%f0:    uses=%sp:     deads=
	fitod	%f0,%f0             ! sets=%f0:%f1:uses=%f0:     deads=%f0:
	fmovd	%f0,%f4             ! sets=%f4:%f5:uses=%f0:%f1: deads=%f0:%f1:
! source statement 7
	fmovd	%f4,%f0             ! sets=%f0:%f1:uses=%f4:%f5: deads=%f4:%f5:
	sethi	%hi(.L01),%o0       ! sets=%o0:    uses=         deads=
	ldd	[%o0 + %lo(.L01)],%f2! sets=%f2:%f3:uses=%o0:     deads=%o0:
	fdivd	%f0,%f2,%f0         ! sets=%f0:%f1:uses=%f0:%f1:%f2:%f3:deads=%f0:%f1:%f2:%f3:
	fmovd	%f0,%f4             ! sets=%f4:%f5:uses=%f0:%f1: deads=%f0:%f1:
! source statement 8
	fmovd	%f4,%f0             ! sets=%f0:%f1:uses=%f4:%f5: deads=%f4:%f5:
	ret	                    ! sets=        uses=%f0:%f1: deads=%f0:%f1:
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
!  doms: 1
!   ins=
!  outs=%l0:%l1:%f0:%f1:
!
main:
	!.2_n = %l1
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
! source statement 15
	mov	3,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
! source statement 16
	sethi	%hi(.L18),%l0       ! sets=%l0:    uses=         deads=
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	call	half,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms: 1 2
!   ins=%l0:%l1:%f0:%f1:
!  outs=
!
	add	%l0,%lo(.L18),%o0   ! sets=%o0:    uses=%l0:     deads=%l0:
	mov	%l1,%o1             ! sets=%o1:    uses=%l1:     deads=%l1:
	fmovs	%f0,%f0             ! sets=%f0:    uses=%f0:     deads=%f0:
	fmovs	%f1,%f1             ! sets=%f1:    uses=%f1:     deads=%f1:
	st	%f0,[%sp + 76]      ! sets=        uses=%sp:%f0: deads=%f0:
	st	%f1,[%sp + 80]      ! sets=        uses=%sp:%f1: deads=%f1:
	ld	[%sp + 76],%o2      ! sets=%o2:    uses=%sp:     deads=
	ld	[%sp + 80],%o3      ! sets=%o3:    uses=%sp:     deads=
	call	printf,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 3
! preds: 2
! succs:
!  doms: 1 2 3
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L18:
	.ascii "n = %d, n/2 = %f\12\0"
