	.seg	"data"
	.seg	"data"
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
.1_x = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! source statement 5
	sethi	%hi(.L01),%o0       ! sets=%o0:    uses=         deads=
	ldd	[%o0 + %lo(.L01)],%f0! sets=%f0:%f1:uses=%o0:     deads=%o0:
	std	%f0,[%fp + .1_x]    ! sets=x:      uses=%fp:%f0:%f1:deads=%f0:%f1:
! source statement 6
	sethi	%hi(.L15),%o0       ! sets=%o0:    uses=         deads=
	ldd	[%fp + .1_x],%f0    ! sets=%f0:%f1:uses=%fp:x:   deads=
	ldd	[%fp + .1_x],%f2    ! sets=%f2:%f3:uses=%fp:x:   deads=
	add	%o0,%lo(.L15),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ldd	[%fp + .1_x],%f4    ! sets=%f4:%f5:uses=%fp:x:   deads=x:
	std	%f4,[%sp + 72]      ! sets=        uses=%sp:%f4:%f5:deads=%f4:%f5:
	ld	[%sp + 72],%o1      ! sets=%o1:    uses=%sp:     deads=
	ld	[%sp + 76],%o2      ! sets=%o2:    uses=%sp:     deads=
	fmuld	%f0,%f2,%f0         ! sets=%f0:%f1:uses=%f0:%f1:%f2:%f3:deads=%f0:%f1:%f2:%f3:
	std	%f0,[%sp + 80]      ! sets=        uses=%sp:%f0:%f1:deads=%f0:%f1:
	ld	[%sp + 80],%o3      ! sets=%o3:    uses=%sp:     deads=
	ld	[%sp + 84],%o4      ! sets=%o4:    uses=%sp:     deads=
	call	printf,5            ! sets=scratch uses=%o0:%o1:%o2:%o3:%o4:deads=%o0:%o1:%o2:%o3:%o4:
	nop
!
! block 2
! preds: 1
! succs:
!  doms:
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.align	8
.L01:	.double	0r3.00000000000000000000000000000000e+00
.L15:
	.ascii "x = %f, x**2 = %f\12\0"
