	.seg	"data"
	.seg	"data"
	.align	8
	.global	dayw
dayw:
	.ascii " S  M Tu  W Th  F  S\0\0\0\0"
	.align	8
	.global	smon
smon:
	.word	.L13
	.word	.L14
	.word	.L15
	.word	.L16
	.word	.L17
	.word	.L18
	.word	.L19
	.word	.L20
	.word	.L21
	.word	.L22
	.word	.L23
	.word	.L24
	.common	string,432,4
	.seg	"text"
	.align	8
	.global	main
	.proc	0
! loops in function
!   loop: head = 26
!         blocks = 26
!   loop: head = 35
!         blocks = 35 36
!   loop: head = 15
!         blocks = 15 16
!   loop: head = 25
!         blocks = 25 26 27 28 29 30 31 32 33 34 35 36 37

!
! block 1
! preds:
! succs: 2 4
!  doms: 1
!   ins=%i0:%i1:
!  outs=%l4:%l5:
!
main:
! .1_y = %l0
! .1_i = %l1
! .1_j = %l2
! .1_m = %l3
	save	%sp,(-112),%sp      ! sets=window  uses=%sp:     deads=
! .1_argc = %l4
	mov	%i0,%l4             ! sets=%l4:    uses=%i0:     deads=
! .1_argv = %l5
	mov	%i1,%l5             ! sets=%l5:    uses=%i1:     deads=%i1:
! source statement 17
	cmp	%i0,2               ! sets=        uses=%i0:     deads=%i0:
	bge	.L29                ! sets=        uses=         deads=
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms: 1 2
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
! source statement 18
	sethi	%hi(.L31),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L31),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=%l4:%l5:
!  outs=%l4:%l5:
!
! source statement 19
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 4
! preds: 1 3
! succs: 5 18
!  doms: 1 4
!   ins=%l4:%l5:
!  outs=%l5:
!
.L29:
! source statement 21
	cmp	%l4,2               ! sets=        uses=%l4:     deads=%l4:
	be	.L34                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6
!  doms: 1 4 5
!   ins=%l5:
!  outs=%o0:%l5:
!
.L33:
! source statement 28
	ld	[%l5 + 4],%o0       ! sets=%o0:    uses=%l5:     deads=
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 6
! preds: 5
! succs: 7 40
!  doms: 1 4 5 6
!   ins=%o0:%l5:
!  outs=%l3:%l5:
!
	mov	%o0,%l3             ! sets=%l3:    uses=%o0:     deads=
! source statement 29
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 7
! preds: 6
! succs: 8 40
!  doms: 1 4 5 6 7
!   ins=%l3:%l5:
!  outs=%l3:%l5:
!
.L37:
	cmp	%l3,12              ! sets=        uses=%l3:     deads=
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9
!  doms: 1 4 5 6 7 8
!   ins=%l3:%l5:
!  outs=%o0:%l3:%l5:
!
.L36:
! source statement 31
	ld	[%l5 + 8],%o0       ! sets=%o0:    uses=%l5:     deads=
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 8
! succs: 10 40
!  doms: 1 4 5 6 7 8 9
!   ins=%o0:%l3:%l5:
!  outs=%l0:%l3:%l5:
!
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
! source statement 32
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 10
! preds: 9
! succs: 11 40
!  doms: 1 4 5 6 7 8 9 10
!   ins=%l0:%l3:%l5:
!  outs=%l0:%l3:%l5:
!
.L41:
	sethi	%hi(9999),%o1       ! sets=%o1:    uses=         deads=
	or	%o1,%lo(9999),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%l0,%o1             ! sets=        uses=%o1:%l0: deads=%o1:
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 12
!  doms: 1 4 5 6 7 8 9 10 11
!   ins=%l0:%l3:%l5:
!  outs=%l0:%l3:%l5:
!
.L40:
! source statement 34
	sethi	%hi(.L43),%o0       ! sets=%o0:    uses=         deads=
	sub	%l3,1,%o1           ! sets=%o1:    uses=%l3:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%lo(smon),%o2   ! sets=%o2:    uses=%o0:     deads=
	add	%o0,%lo(.L43),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	mov	%l0,%o2             ! sets=%o2:    uses=%l0:     deads=
	call	printf,3            ! sets=scratch uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
	nop
!
! block 12
! preds: 11
! succs: 13
!  doms: 1 4 5 6 7 8 9 10 11 12
!   ins=%l0:%l3:%l5:
!  outs=%l0:%l3:%l5:
!
! source statement 35
	sethi	%hi(.L44),%o0       ! sets=%o0:    uses=         deads=
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=
	add	%o0,%lo(.L44),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o1,%lo(dayw),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 13
! preds: 12
! succs: 14
!  doms: 1 4 5 6 7 8 9 10 11 12 13
!   ins=%l0:%l3:%l5:
!  outs=%l5:
!
! source statement 36
	sethi	%hi(string),%o2     ! sets=%o2:    uses=         deads=
	mov	%l3,%o0             ! sets=%o0:    uses=%l3:     deads=%l3:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=%l0:
	add	%o2,%lo(string),%o2 ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	24,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 14
! preds: 13
! succs: 15
!  doms: 1 4 5 6 7 8 9 10 11 12 13 14
!   ins=%l5:
!  outs=%l1:%l2:%l5:
!
! source statement 37
	mov	%g0,%l1             ! sets=%l1:    uses=%g0:     deads=
	sethi	%hi(string),%l0     ! sets=%l0:    uses=         deads=
	add	%l0,%lo(string),%l2 ! sets=%l2:    uses=%l0:     deads=%l0:
!
! block 15
! preds: 14 16
! succs: 16
!  doms: 1 4 5 6 7 8 9 10 11 12 13 14 15
!   ins=%l1:%l2:%l5:
!  outs=%l1:%l2:%l5:
!
.L48:
! source statement 38
	add	%l1,%l2,%o0         ! sets=%o0:    uses=%l1:%l2: deads=
	mov	24,%o1              ! sets=%o1:    uses=         deads=
	call	pstr,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 16
! preds: 15
! succs: 17 15
!  doms: 1 4 5 6 7 8 9 10 11 12 13 14 15 16
!   ins=%l1:%l2:%l5:
!  outs=%l1:%l2:%l5:
!
! source statement 38
	add	%l1,24,%o0          ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=
! source statement 38
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,144             ! sets=        uses=%o0:     deads=%o0:
	bl	.L48                ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18
!  doms: 1 4 5 6 7 8 9 10 11 12 13 14 15 16 17
!   ins=%l5:
!  outs=%l5:
!
.L50:
! source statement 39
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 18
! preds: 4 17
! succs: 19
!  doms: 1 4 18
!   ins=%l5:
!  outs=%o0:
!
.L34:
! source statement 46
	ld	[%l5 + 4],%o0       ! sets=%o0:    uses=%l5:     deads=%l5:
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 19
! preds: 18
! succs: 20 40
!  doms: 1 4 18 19
!   ins=%o0:
!  outs=%l0:
!
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
! source statement 47
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21 40
!  doms: 1 4 18 19 20
!   ins=%l0:
!  outs=%l0:
!
.L52:
	sethi	%hi(9999),%o1       ! sets=%o1:    uses=         deads=
	or	%o1,%lo(9999),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%l0,%o1             ! sets=        uses=%o1:%l0: deads=%o1:
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 21
! preds: 20
! succs: 22
!  doms: 1 4 18 19 20 21
!   ins=%l0:
!  outs=%l0:
!
.L51:
! source statement 49
	sethi	%hi(.L54),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L54),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 22
! preds: 21
! succs: 23
!  doms: 1 4 18 19 20 21 22
!   ins=%l0:
!  outs=%l0:
!
! source statement 50
	sethi	%hi(.L55),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L55),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 23
! preds: 22
! succs: 24
!  doms: 1 4 18 19 20 21 22 23
!   ins=%l0:
!  outs=%l0:
!
! source statement 51
	sethi	%hi(.L56),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L56),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 24
! preds: 23
! succs: 25
!  doms: 1 4 18 19 20 21 22 23 24
!   ins=%l0:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 52
	mov	%g0,%l1             ! sets=%l1:    uses=%g0:     deads=
	sethi	%hi(.L64),%l4       ! sets=%l4:    uses=         deads=
	mov	%l4,%l5             ! sets=%l5:    uses=%l4:     deads=
	mov	%l4,%l6             ! sets=%l6:    uses=%l4:     deads=
	mov	%l4,%l7             ! sets=%l7:    uses=%l4:     deads=
	mov	%l4,%i0             ! sets=%i0:    uses=%l4:     deads=
	mov	%l4,%i1             ! sets=%i1:    uses=%l4:     deads=
	mov	%l4,%i2             ! sets=%i2:    uses=%l4:     deads=
	mov	%l4,%i3             ! sets=%i3:    uses=%l4:     deads=
	mov	%l4,%i4             ! sets=%i4:    uses=%l4:     deads=
!
! block 25
! preds: 24 37
! succs: 26
!  doms: 1 4 18 19 20 21 22 23 24 25
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%g2:%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
.L59:
! source statement 53
	mov	%g0,%l2             ! sets=%l2:    uses=%g0:     deads=
	add	%i4,%lo(string),%g2 ! sets=%g2:    uses=%i4:     deads=
!
! block 26
! preds: 25 26
! succs: 27 26
!  doms: 1 4 18 19 20 21 22 23 24 25 26
!   ins=%g2:%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%g2:%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
.L62:
! source statement 54
	stb	%g0,[%l2 + %g2]     ! sets=        uses=%g0:%g2:%l2:deads=
! source statement 54
	add	%l2,1,%o0           ! sets=%o0:    uses=%l2:     deads=%l2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=
! source statement 54
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,432             ! sets=        uses=%o0:     deads=%o0:
	bl	.L62                ! sets=        uses=         deads=
	nop
!
! block 27
! preds: 26
! succs: 28
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
.L63:
! source statement 55
	sll	%l1,2,%o1           ! sets=%o1:    uses=%l1:     deads=
	add	%l4,%lo(smon),%o2   ! sets=%o2:    uses=%l4:     deads=
	mov	%o2,%o0             ! sets=%o0:    uses=%o2:     deads=
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 28
! preds: 27
! succs: 29
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 56
	add	%l1,1,%o1           ! sets=%o1:    uses=%l1:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%l5,%lo(smon),%o2   ! sets=%o2:    uses=%l5:     deads=
	mov	%o2,%o0             ! sets=%o0:    uses=%o2:     deads=
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 29
! preds: 28
! succs: 30
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 57
	add	%l1,2,%o1           ! sets=%o1:    uses=%l1:     deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%l6,%lo(smon),%o2   ! sets=%o2:    uses=%l6:     deads=
	mov	%o2,%o0             ! sets=%o0:    uses=%o2:     deads=
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 30
! preds: 29
! succs: 31
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 58
	sethi	%hi(dayw),%o2       ! sets=%o2:    uses=         deads=
	mov	%o2,%o3             ! sets=%o3:    uses=%o2:     deads=
	add	%l7,%lo(.L67),%o0   ! sets=%o0:    uses=%l7:     deads=
	mov	%o0,%o1             ! sets=%o1:    uses=%o0:     deads=
	add	%o2,%lo(dayw),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o3,%lo(dayw),%o3   ! sets=%o3:    uses=%o3:     deads=%o3:
	call	printf,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 31
! preds: 30
! succs: 32
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 59
	add	%l1,1,%o0           ! sets=%o0:    uses=%l1:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	add	%i0,%lo(string),%o2 ! sets=%o2:    uses=%i0:     deads=
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 32
! preds: 31
! succs: 33
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 60
	add	%i1,%lo(string),%o2 ! sets=%o2:    uses=%i1:     deads=
	add	%l1,2,%o0           ! sets=%o0:    uses=%l1:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	add	%o2,23,%o2          ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 33
! preds: 32
! succs: 34
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
! source statement 61
	add	%i2,%lo(string),%o2 ! sets=%o2:    uses=%i2:     deads=
	add	%l1,3,%o0           ! sets=%o0:    uses=%l1:     deads=
	mov	%l0,%o1             ! sets=%o1:    uses=%l0:     deads=
	add	%o2,46,%o2          ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 34
! preds: 33
! succs: 35
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:%i5:
!
! source statement 62
	mov	%g0,%l2             ! sets=%l2:    uses=%g0:     deads=
	add	%i3,%lo(string),%i5 ! sets=%i5:    uses=%i3:     deads=
!
! block 35
! preds: 34 36
! succs: 36
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
!   ins=%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:%i5:
!  outs=%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:%i5:
!
.L70:
! source statement 63
	add	%l2,%i5,%o0         ! sets=%o0:    uses=%l2:%i5: deads=
	mov	72,%o1              ! sets=%o1:    uses=         deads=
	call	pstr,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 36
! preds: 35
! succs: 37 35
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
!   ins=%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:%i5:
!  outs=%l0:%l1:%l2:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:%i5:
!
! source statement 63
	add	%l2,72,%o0          ! sets=%o0:    uses=%l2:     deads=%l2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=
! source statement 63
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,432             ! sets=        uses=%o0:     deads=%o0:
	bl	.L70                ! sets=        uses=         deads=
	nop
!
! block 37
! preds: 36
! succs: 38 25
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
!   ins=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!  outs=%l0:%l1:%l4:%l5:%l6:%l7:%i0:%i1:%i2:%i3:%i4:
!
.L71:
! source statement 64
	add	%l1,3,%o0           ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=
! source statement 64
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,12              ! sets=        uses=%o0:     deads=%o0:
	bl	.L59                ! sets=        uses=         deads=
	nop
!
! block 38
! preds: 37
! succs: 39
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38
!   ins=
!  outs=
!
.L72:
! source statement 65
	sethi	%hi(.L73),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L73),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 39
! preds: 38
! succs: 40
!  doms: 1 4 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
!   ins=
!  outs=
!
! source statement 66
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 40
! preds: 6 7 9 10 19 20 39
! succs: 41
!  doms: 1 4 40
!   ins=
!  outs=
!
.L39:
! source statement 69
	sethi	%hi(.L74),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L74),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 41
! preds: 40
! succs:
!  doms: 1 4 40 41
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L74:
	.ascii "Bad argument\12\0"
.L73:
	.ascii "\12\12\12\0"
.L67:
	.ascii "%s   %s   %s\12\0"
.L66:
	.ascii "\11\11       %.3s\12\0"
.L65:
	.ascii "\11\11\11%.3s\0"
.L64:
	.ascii "\11 %.3s\0"
.L56:
	.ascii "\12\0"
.L55:
	.ascii "\11\11\11\11%u\12\0"
.L54:
	.ascii "\12\12\12\0"
.L44:
	.ascii "%s\12\0"
.L43:
	.ascii "   %s %u\12\0"
.L31:
	.ascii "usage: cal [month] year\12\0"
.L24:
	.ascii "December\0"
.L23:
	.ascii "November\0"
.L22:
	.ascii "October\0"
.L21:
	.ascii "September\0"
.L20:
	.ascii "August\0"
.L19:
	.ascii "July\0"
.L18:
	.ascii "June\0"
.L17:
	.ascii "May\0"
.L16:
	.ascii "April\0"
.L15:
	.ascii "March\0"
.L14:
	.ascii "February\0"
.L13:
	.ascii "January\0"
	.seg	"text"
	.align	8
	.global	number
	.proc	1
! loops in function
!   loop: head = 2
!         blocks = 2 3 4 6

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=%g1:%g3:
!
number:
! .2_n = %g1
! .2_c = %g2
! .2_s = %g3
	save	%sp,(-80),%sp       ! sets=window  uses=%sp:     deads=
! .2_str = %g4
! source statement 78
	mov	%g0,%g1             ! sets=%g1:    uses=%g0:     deads=
! source statement 79
	mov	%i0,%g3             ! sets=%g3:    uses=%i0:     deads=%i0:
!
! block 2
! preds: 1 6
! succs: 3 7
!  doms: 1 2
!   ins=%g1:%g3:
!  outs=%g1:%g2:%g3:
!
.L77:
! source statement 80
	mov	%g3,%o0             ! sets=%o0:    uses=%g3:     deads=
	add	%g3,1,%o1           ! sets=%o1:    uses=%g3:     deads=%g3:
	mov	%o1,%g3             ! sets=%g3:    uses=%o1:     deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g2             ! sets=%g2:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L78                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms: 1 2 3
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g2:%g3:
!
! source statement 81
	cmp	%g2,48              ! sets=        uses=%g2:     deads=
	bl	.L81                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5 6
!  doms: 1 2 3 4
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g2:%g3:
!
.L80:
	cmp	%g2,57              ! sets=        uses=%g2:     deads=
	ble	.L79                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 3 4
! succs:
!  doms: 1 2 3 5
!   ins=
!  outs=
!
.L81:
! source statement 82
	mov	%g0,%i0             ! sets=%i0:    uses=%g0:     deads=
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	                    ! sets=window  uses=         deads=
!
! block 6
! preds: 4
! succs: 2
!  doms: 1 2 3 4 6
!   ins=%g1:%g2:%g3:
!  outs=%g1:%g3:
!
.L79:
! source statement 83
	smul	%g1,10,%o0          ! sets=%o0:    uses=%g1:     deads=%g1:
	add	%o0,%g2,%o0         ! sets=%o0:    uses=%g2:%o0: deads=%g2:%o0:
	sub	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%g1             ! sets=%g1:    uses=%o0:     deads=%o0:
	ba,a	.L77                ! sets=        uses=         deads=
!
! block 7
! preds: 2
! succs:
!  doms: 1 2 7
!   ins=%g1:
!  outs=
!
.L78:
! source statement 85
	mov	%g1,%i0             ! sets=%i0:    uses=%g1:     deads=%g1:
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	pstr
	.proc	0
! loops in function
!   loop: head = 2
!         blocks = 2 3 4 5
!   loop: head = 7
!         blocks = 7 8

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:
!  outs=%l0:%l1:%l2:%l3:
!
pstr:
! .3_i = %l0
! .3_s = %l1
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! .3_str = %l2
	mov	%i0,%l2             ! sets=%l2:    uses=%i0:     deads=
! .3_n = %l3
	mov	%i1,%l3             ! sets=%l3:    uses=%i1:     deads=
! source statement 94
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=%i0:
! source statement 95
	mov	%i1,%l0             ! sets=%l0:    uses=%i1:     deads=%i1:
!
! block 2
! preds: 1 3 5
! succs: 3 6
!  doms: 1 2
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L84:
! source statement 96
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	sub	%l0,1,%o1           ! sets=%o1:    uses=%l0:     deads=%l0:
	mov	%o1,%l0             ! sets=%l0:    uses=%o1:     deads=%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L85                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 2
!  doms: 1 2 3
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
! source statement 97
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	add	%l1,1,%o1           ! sets=%o1:    uses=%l1:     deads=%l1:
	mov	%o1,%l1             ! sets=%l1:    uses=%o1:     deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L84                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms: 1 2 3 4
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
! source statement 98
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	stb	%o0,[%l1 + (-1)]    ! sets=        uses=%o0:%l1: deads=%o0:
!
! block 5
! preds: 4
! succs: 2
!  doms: 1 2 3 4 5
!   ins=%l0:%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:%l3:
!
.L86:
	ba,a	.L84                ! sets=        uses=         deads=
!
! block 6
! preds: 2
! succs: 7
!  doms: 1 2 6
!   ins=%l1:%l2:%l3:
!  outs=%l0:%l1:%l2:
!
.L85:
! source statement 99
	add	%l3,1,%o0           ! sets=%o0:    uses=%l3:     deads=%l3:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
!
! block 7
! preds: 6 8
! succs: 8 10
!  doms: 1 2 6 7
!   ins=%l0:%l1:%l2:
!  outs=%l0:%l1:%l2:
!
.L87:
! source statement 100
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	sub	%l0,1,%o1           ! sets=%o1:    uses=%l0:     deads=%l0:
	mov	%o1,%l0             ! sets=%l0:    uses=%o1:     deads=%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L88                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 7
!  doms: 1 2 6 7 8
!   ins=%l0:%l1:%l2:
!  outs=%l0:%l1:%l2:
!
! source statement 101
	sub	%l1,1,%o0           ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	be	.L87                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms: 1 2 6 7 8 9
!   ins=%l1:%l2:
!  outs=%l1:%l2:
!
	ba,a	.L88                ! sets=        uses=         deads=
!
! block 10
! preds: 7 9
! succs: 11
!  doms: 1 2 6 7 10
!   ins=%l1:%l2:
!  outs=
!
.L88:
! source statement 103
	stb	%g0,[%l1 + 1]       ! sets=        uses=%g0:%l1: deads=%l1:
! source statement 104
	sethi	%hi(.L90),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L90),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%l2,%o1             ! sets=%o1:    uses=%l2:     deads=%l2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 11
! preds: 10
! succs:
!  doms: 1 2 6 7 10 11
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L90:
	.ascii "%s\12\0"
	.align	8
	.global	mon
mon:
	.ascii "\0\37\35\37\36\37\36\37\37\36\37\36\37\0\0\0"
	.seg	"text"
	.align	8
	.global	cal
	.proc	0
! loops in function
!   loop: head = 11
!         blocks = 10 11
!   loop: head = 24
!         blocks = 14 15 16 17 18 19 20 21 22 23 24

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:%i1:%i2:%i3:
!  outs=%o0:%l2:%l3:%l4:%l5:%l6:
!
cal:
! .4_d = %l0
! .4_i = %l1
! .4_s = %l2
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! .4_m = %l3
	mov	%i0,%l3             ! sets=%l3:    uses=%i0:     deads=%i0:
! .4_y = %l4
	mov	%i1,%l4             ! sets=%l4:    uses=%i1:     deads=
! .4_p = %l5
	mov	%i2,%l5             ! sets=%l5:    uses=%i2:     deads=
! .4_w = %l6
	mov	%i3,%l6             ! sets=%l6:    uses=%i3:     deads=%i3:
! source statement 120
	mov	%i2,%l2             ! sets=%l2:    uses=%i2:     deads=%i2:
! source statement 121
	mov	%i1,%o0             ! sets=%o0:    uses=%i1:     deads=%i1:
	call	jan1,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms: 1 2
!   ins=%o0:%l2:%l3:%l4:%l5:%l6:
!  outs=%o0:%l0:%l2:%l3:%l5:%l6:
!
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 122
	mov	29,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o0,[%o1 + 2]       ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 123
	mov	30,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o0,[%o1 + 9]       ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 125
	add	%l4,1,%o0           ! sets=%o0:    uses=%l4:     deads=%l4:
	call	jan1,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=%o0:%l0:%l2:%l3:%l5:%l6:
!  outs=%o0:%l0:%l2:%l3:%l5:%l6:
!
	add	%o0,7,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sub	%o0,%l0,%o0         ! sets=%o0:    uses=%o0:%l0: deads=%o0:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 4
! preds: 3
! succs: 7
!  doms: 1 2 3 4
!   ins=%o0:%l0:%l2:%l3:%l5:%l6:
!  outs=%o0:%l0:%l2:%l3:%l5:%l6:
!
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L96                ! sets=        uses=         deads=
!
! block 5
! preds: 7
! succs: 9
!  doms: 1 2 3 4 5 7
!   ins=%l0:%l2:%l3:%l5:%l6:
!  outs=%l0:%l2:%l3:%l5:%l6:
!
.L97:
! source statement 131
	mov	28,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o0,[%o1 + 2]       ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 6
! preds: 8
! succs: 9
!  doms: 1 2 3 4 6 7 8
!   ins=%l0:%l2:%l3:%l5:%l6:
!  outs=%l0:%l2:%l3:%l5:%l6:
!
.L98:
! source statement 138
	mov	19,%o0              ! sets=%o0:    uses=         deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o0,[%o1 + 9]       ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L95                ! sets=        uses=         deads=
!
! block 7
! preds: 4
! succs: 8 5
!  doms: 1 2 3 4 7
!   ins=%o0:%l0:%l2:%l3:%l5:%l6:
!  outs=%o0:%l0:%l2:%l3:%l5:%l6:
!
.L96:
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	be	.L97                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 6
!  doms: 1 2 3 4 7 8
!   ins=%o0:%l0:%l2:%l3:%l5:%l6:
!  outs=%l0:%l2:%l3:%l5:%l6:
!
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	bne	.L98                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 5 6 8
! succs: 11
!  doms: 1 2 3 4 7 9
!   ins=%l0:%l2:%l3:%l5:%l6:
!  outs=%g2:%l0:%l1:%l2:%l3:%l5:%l6:
!
.L95:
! source statement 147
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
	sethi	%hi(mon),%g1        ! sets=%g1:    uses=         deads=
	add	%g1,%lo(mon),%g2    ! sets=%g2:    uses=%g1:     deads=%g1:
	ba,a	.L102               ! sets=        uses=         deads=
!
! block 10
! preds: 11
! succs: 11
!  doms: 1 2 3 4 7 9 10 11
!   ins=%g2:%l0:%l1:%l2:%l3:%l5:%l6:
!  outs=%g2:%l0:%l1:%l2:%l3:%l5:%l6:
!
.L103:
! source statement 148
	ldsb	[%l1 + %g2],%o1     ! sets=%o1:    uses=%g2:%l1: deads=
	add	%l0,%o1,%o0         ! sets=%o0:    uses=%o1:%l0: deads=%o1:%l0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=%o0:
! source statement 148
	add	%l1,1,%o0           ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
!
! block 11
! preds: 9 10
! succs: 12 10
!  doms: 1 2 3 4 7 9 11
!   ins=%g2:%l0:%l1:%l2:%l3:%l5:%l6:
!  outs=%g2:%l0:%l1:%l2:%l3:%l5:%l6:
!
.L102:
! source statement 148
	cmp	%l1,%l3             ! sets=        uses=%l1:%l3: deads=
	bl	.L103               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13
!  doms: 1 2 3 4 7 9 11 12
!   ins=%l0:%l2:%l3:%l5:%l6:
!  outs=%o0:%l2:%l3:%l5:%l6:
!
.L104:
! source statement 149
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=%l0:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 13
! preds: 12
! succs: 24
!  doms: 1 2 3 4 7 9 11 12 13
!   ins=%o0:%l2:%l3:%l5:%l6:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
! source statement 150
	smul	%o0,3,%o1           ! sets=%o1:    uses=%o0:     deads=%o0:
	add	%l2,%o1,%o0         ! sets=%o0:    uses=%o1:%l2: deads=%o1:%l2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
! source statement 151
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
	sethi	%hi(mon),%l4        ! sets=%l4:    uses=         deads=
	add	%l4,%lo(mon),%i1    ! sets=%i1:    uses=%l4:     deads=%l4:
	mov	%i1,%i3             ! sets=%i3:    uses=%i1:     deads=
	add	%l3,%i1,%l4         ! sets=%l4:    uses=%l3:%i1: deads=
	ba,a	.L107               ! sets=        uses=         deads=
!
! block 14
! preds: 24
! succs: 15 17
!  doms: 1 2 3 4 7 9 11 12 13 14 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
.L108:
! source statement 152
	cmp	%l1,3               ! sets=        uses=%l1:     deads=
	bne	.L109               ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16 17
!  doms: 1 2 3 4 7 9 11 12 13 14 15 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
	ldsb	[%l3 + %i1],%o0     ! sets=%o0:    uses=%l3:%i1: deads=
	cmp	%o0,19              ! sets=        uses=%o0:     deads=%o0:
	bne	.L109               ! sets=        uses=         deads=
	nop
!
! block 16
! preds: 15
! succs: 17
!  doms: 1 2 3 4 7 9 11 12 13 14 15 16 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
! source statement 153
	add	%l1,11,%o0          ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
! source statement 154
	ldsb	[%l4],%o1           ! sets=%o1:    uses=%l4:     deads=
	add	%o1,11,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o1,[%l4]           ! sets=        uses=%o1:%l4: deads=%o1:
!
! block 17
! preds: 14 15 16
! succs: 18 20
!  doms: 1 2 3 4 7 9 11 12 13 14 17 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
.L109:
! source statement 156
	cmp	%l1,9               ! sets=        uses=%l1:     deads=
	ble	.L110               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 19
!  doms: 1 2 3 4 7 9 11 12 13 14 17 18 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%o0:%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
! source statement 157
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	mov	10,%o1              ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 19
! preds: 18
! succs: 20
!  doms: 1 2 3 4 7 9 11 12 13 14 17 18 19 24
!   ins=%o0:%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
	add	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	stb	%o0,[%l2]           ! sets=        uses=%o0:%l2: deads=%o0:
!
! block 20
! preds: 17 19
! succs: 21
!  doms: 1 2 3 4 7 9 11 12 13 14 17 20 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%o0:%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
.L110:
! source statement 158
	add	%l2,1,%o0           ! sets=%o0:    uses=%l2:     deads=%l2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
! source statement 159
	mov	%l1,%o0             ! sets=%o0:    uses=%l1:     deads=
	mov	10,%o1              ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 21
! preds: 20
! succs: 22 23
!  doms: 1 2 3 4 7 9 11 12 13 14 17 20 21 24
!   ins=%o0:%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
	add	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%l2,1,%o2           ! sets=%o2:    uses=%l2:     deads=
	stb	%o0,[%l2]           ! sets=        uses=%o0:%l2: deads=%o0:%l2:
! source statement 160
	add	%o2,1,%o0           ! sets=%o0:    uses=%o2:     deads=%o2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
! source statement 161
	add	%l0,1,%o0           ! sets=%o0:    uses=%l0:     deads=%l0:
	mov	%o0,%l0             ! sets=%l0:    uses=%o0:     deads=
	cmp	%o0,7               ! sets=        uses=%o0:     deads=%o0:
	bne	.L111               ! sets=        uses=         deads=
	nop
!
! block 22
! preds: 21
! succs: 23
!  doms: 1 2 3 4 7 9 11 12 13 14 17 20 21 22 24
!   ins=%l1:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
! source statement 162
	mov	%g0,%l0             ! sets=%l0:    uses=%g0:     deads=
! source statement 163
	add	%l5,%l6,%o0         ! sets=%o0:    uses=%l5:%l6: deads=%l5:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=
! source statement 164
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	%o0,%l5             ! sets=%l5:    uses=%o0:     deads=%o0:
!
! block 23
! preds: 21 22
! succs: 24
!  doms: 1 2 3 4 7 9 11 12 13 14 17 20 21 23 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
.L111:
! source statement 166
	add	%l1,1,%o0           ! sets=%o0:    uses=%l1:     deads=%l1:
	mov	%o0,%l1             ! sets=%l1:    uses=%o0:     deads=%o0:
!
! block 24
! preds: 13 23
! succs: 25 14
!  doms: 1 2 3 4 7 9 11 12 13 24
!   ins=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!  outs=%l0:%l1:%l2:%l3:%l4:%l5:%l6:%i1:%i3:
!
.L107:
! source statement 166
	ldsb	[%l3 + %i3],%o1     ! sets=%o1:    uses=%l3:%i3: deads=
	cmp	%l1,%o1             ! sets=        uses=%o1:%l1: deads=%o1:
	ble	.L108               ! sets=        uses=         deads=
	nop
!
! block 25
! preds: 24
! succs:
!  doms: 1 2 3 4 7 9 11 12 13 24 25
!   ins=
!  outs=
!
.L112:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	jan1
	.proc	1
! loops in function

!
! block 1
! preds:
! succs: 2
!  doms: 1
!   ins=%i0:
!  outs=%o0:%l0:%l1:%i0:
!
jan1:
! .5_y = %l1
! .5_d = %l2
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
! .5_yr = %l3
! source statement 184
	mov	%i0,%l1             ! sets=%l1:    uses=%i0:     deads=
! source statement 185
	add	%i0,4,%l0           ! sets=%l0:    uses=%i0:     deads=
	mov	%l0,%o0             ! sets=%o0:    uses=%l0:     deads=
	mov	4,%o1               ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 2
! preds: 1
! succs: 3 6
!  doms: 1 2
!   ins=%o0:%l0:%l1:%i0:
!  outs=%l1:%l2:%i0:
!
	add	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
	mov	%l0,%l2             ! sets=%l2:    uses=%l0:     deads=%l0:
! source statement 193
	cmp	%l1,1800            ! sets=        uses=%l1:     deads=
	ble	.L115               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms: 1 2 3
!   ins=%l1:%l2:%i0:
!  outs=%o0:%l0:%l1:%i0:
!
! source statement 194
	mov	%l2,%l0             ! sets=%l0:    uses=%l2:     deads=%l2:
	sub	%l1,1701,%o0        ! sets=%o0:    uses=%l1:     deads=
	mov	100,%o1             ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms: 1 2 3 4
!   ins=%o0:%l0:%l1:%i0:
!  outs=%o0:%l0:%l1:%i0:
!
	sub	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
! source statement 195
	mov	%l0,%l0             ! sets=%l0:    uses=%l0:     deads=%l0:
	sub	%l1,1601,%o0        ! sets=%o0:    uses=%l1:     deads=
	mov	400,%o1             ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 5
! preds: 4
! succs: 6
!  doms: 1 2 3 4 5
!   ins=%o0:%l0:%l1:%i0:
!  outs=%l1:%l2:%i0:
!
	add	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
	mov	%l0,%l2             ! sets=%l2:    uses=%l0:     deads=%l0:
!
! block 6
! preds: 2 5
! succs: 7 8
!  doms: 1 2 6
!   ins=%l1:%l2:%i0:
!  outs=%l2:%i0:
!
.L115:
! source statement 202
	cmp	%l1,1752            ! sets=        uses=%l1:     deads=%l1:
	ble	.L116               ! sets=        uses=         deads=
	nop
!
! block 7
! preds: 6
! succs: 8
!  doms: 1 2 6 7
!   ins=%l2:%i0:
!  outs=%l2:%i0:
!
! source statement 203
	add	%l2,3,%o0           ! sets=%o0:    uses=%l2:     deads=%l2:
	mov	%o0,%l2             ! sets=%l2:    uses=%o0:     deads=%o0:
!
! block 8
! preds: 6 7
! succs: 9
!  doms: 1 2 6 8
!   ins=%l2:%i0:
!  outs=%o0:%i0:
!
.L116:
! source statement 205
	mov	%l2,%o0             ! sets=%o0:    uses=%l2:     deads=%l2:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 9
! preds: 8
! succs:
!  doms: 1 2 6 8 9
!   ins=%o0:%i0:
!  outs=
!
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	%o0,%g0,%o0         ! sets=window  uses=%g0:%o0: deads=%o0:
	.seg	"data"
