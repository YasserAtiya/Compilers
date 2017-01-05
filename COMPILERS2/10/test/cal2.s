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

!
! block 1
! preds:
! succs: 2 4
!  doms:
!   ins=%i0:%i1:
!  outs=argc:argv:
!
main:
.1_y = -4
.1_i = -8
.1_j = -12
.1_m = -16
	save	%sp,(-112),%sp      ! sets=window  uses=%sp:     deads=
.1_argc = 68
	st	%i0,[%fp + .1_argc] ! sets=argc:   uses=%i0:%fp: deads=%i0:
.1_argv = 72
	st	%i1,[%fp + .1_argv] ! sets=argv:   uses=%i1:%fp: deads=%i1:
! source statement 17
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	bge	.L29                ! sets=        uses=         deads=
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
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
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
! source statement 19
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 4
! preds: 1 3
! succs: 5 18
!  doms:
!   ins=argc:argv:
!  outs=argv:
!
.L29:
! source statement 21
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=argc:
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	be	.L34                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 4
! succs: 6
!  doms:
!   ins=argv:
!  outs=%o0:argv:
!
.L33:
! source statement 28
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 6
! preds: 5
! succs: 7 40
!  doms:
!   ins=%o0:argv:
!  outs=m:argv:
!
	st	%o0,[%fp + .1_m]    ! sets=m:      uses=%o0:%fp: deads=%o0:
! source statement 29
	ld	[%fp + .1_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 7
! preds: 6
! succs: 8 40
!  doms:
!   ins=m:argv:
!  outs=m:argv:
!
.L37:
	ld	[%fp + .1_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	cmp	%o0,12              ! sets=        uses=%o0:     deads=%o0:
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9
!  doms:
!   ins=m:argv:
!  outs=%o0:m:argv:
!
.L36:
! source statement 31
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 8],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 8
! succs: 10 40
!  doms:
!   ins=%o0:m:argv:
!  outs=y:m:argv:
!
	st	%o0,[%fp + .1_y]    ! sets=y:      uses=%o0:%fp: deads=%o0:
! source statement 32
	ld	[%fp + .1_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 10
! preds: 9
! succs: 11 40
!  doms:
!   ins=y:m:argv:
!  outs=y:m:argv:
!
.L41:
	ld	[%fp + .1_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	sethi	%hi(9999),%o1       ! sets=%o1:    uses=         deads=
	or	%o1,%lo(9999),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 12
!  doms:
!   ins=y:m:argv:
!  outs=y:m:argv:
!
.L40:
! source statement 34
	sethi	%hi(.L43),%o0       ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_m],%o1    ! sets=%o1:    uses=%fp:m:   deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(smon),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(smon),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L43),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	ld	[%fp + .1_y],%o2    ! sets=%o2:    uses=%fp:y:   deads=
	call	printf,3            ! sets=scratch uses=%o0:%o1:%o2:deads=%o0:%o1:%o2:
	nop
!
! block 12
! preds: 11
! succs: 13
!  doms:
!   ins=y:m:argv:
!  outs=y:m:argv:
!
! source statement 35
	sethi	%hi(.L44),%o0       ! sets=%o0:    uses=         deads=
	sethi	%hi(dayw),%o1       ! sets=%o1:    uses=         deads=
	add	%o0,%lo(.L44),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o1,%lo(dayw),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 13
! preds: 12
! succs: 14
!  doms:
!   ins=y:m:argv:
!  outs=argv:
!
! source statement 36
	sethi	%hi(string),%o2     ! sets=%o2:    uses=         deads=
	ld	[%fp + .1_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=m:
	ld	[%fp + .1_y],%o1    ! sets=%o1:    uses=%fp:y:   deads=y:
	add	%o2,%lo(string),%o2 ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	24,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 14
! preds: 13
! succs: 15
!  doms:
!   ins=argv:
!  outs=i:argv:
!
! source statement 37
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 15
! preds: 14 16
! succs: 16
!  doms:
!   ins=i:argv:
!  outs=i:argv:
!
.L48:
! source statement 38
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	sethi	%hi(string),%o1     ! sets=%o1:    uses=         deads=
	add	%o1,%lo(string),%o1 ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	24,%o1              ! sets=%o1:    uses=         deads=
	call	pstr,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 16
! preds: 15
! succs: 17 15
!  doms:
!   ins=i:argv:
!  outs=i:argv:
!
! source statement 38
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,24,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 38
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,144             ! sets=        uses=%o0:     deads=%o0:
	bl	.L48                ! sets=        uses=         deads=
	nop
!
! block 17
! preds: 16
! succs: 18
!  doms:
!   ins=argv:
!  outs=argv:
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
!  doms:
!   ins=argv:
!  outs=%o0:
!
.L34:
! source statement 46
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=argv:
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	call	number,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 19
! preds: 18
! succs: 20 40
!  doms:
!   ins=%o0:
!  outs=y:
!
	st	%o0,[%fp + .1_y]    ! sets=y:      uses=%o0:%fp: deads=%o0:
! source statement 47
	ld	[%fp + .1_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	bl	.L39                ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21 40
!  doms:
!   ins=y:
!  outs=y:
!
.L52:
	ld	[%fp + .1_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	sethi	%hi(9999),%o1       ! sets=%o1:    uses=         deads=
	or	%o1,%lo(9999),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bg	.L39                ! sets=        uses=         deads=
	nop
!
! block 21
! preds: 20
! succs: 22
!  doms:
!   ins=y:
!  outs=y:
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
!  doms:
!   ins=y:
!  outs=y:
!
! source statement 50
	sethi	%hi(.L55),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L55),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .1_y],%o1    ! sets=%o1:    uses=%fp:y:   deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 23
! preds: 22
! succs: 24
!  doms:
!   ins=y:
!  outs=y:
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
!  doms:
!   ins=y:
!  outs=y:i:
!
! source statement 52
	st	%g0,[%fp + .1_i]    ! sets=i:      uses=%g0:%fp: deads=
!
! block 25
! preds: 24 37
! succs: 26
!  doms:
!   ins=y:i:
!  outs=y:i:j:
!
.L59:
! source statement 53
	st	%g0,[%fp + .1_j]    ! sets=j:      uses=%g0:%fp: deads=
!
! block 26
! preds: 25 26
! succs: 27 26
!  doms:
!   ins=y:i:j:
!  outs=y:i:j:
!
.L62:
! source statement 54
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	sethi	%hi(string),%o1     ! sets=%o1:    uses=         deads=
	add	%o1,%lo(string),%o1 ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%g0,[%o0 + %o1]     ! sets=        uses=%g0:%o0:%o1:deads=%o0:%o1:
! source statement 54
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=j:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_j]    ! sets=j:      uses=%o0:%fp: deads=%o0:
! source statement 54
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	cmp	%o0,432             ! sets=        uses=%o0:     deads=%o0:
	bl	.L62                ! sets=        uses=         deads=
	nop
!
! block 27
! preds: 26
! succs: 28
!  doms:
!   ins=y:i:
!  outs=y:i:
!
.L63:
! source statement 55
	sethi	%hi(.L64),%o0       ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(smon),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(smon),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L64),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 28
! preds: 27
! succs: 29
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 56
	sethi	%hi(.L65),%o0       ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	add	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(smon),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(smon),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L65),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 29
! preds: 28
! succs: 30
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 57
	sethi	%hi(.L66),%o0       ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	add	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(smon),%o2       ! sets=%o2:    uses=         deads=
	add	%o2,%lo(smon),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L66),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 30
! preds: 29
! succs: 31
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 58
	sethi	%hi(.L67),%o0       ! sets=%o0:    uses=         deads=
	sethi	%hi(dayw),%o1       ! sets=%o1:    uses=         deads=
	sethi	%hi(dayw),%o2       ! sets=%o2:    uses=         deads=
	sethi	%hi(dayw),%o3       ! sets=%o3:    uses=         deads=
	add	%o0,%lo(.L67),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o1,%lo(dayw),%o1   ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o2,%lo(dayw),%o2   ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o3,%lo(dayw),%o3   ! sets=%o3:    uses=%o3:     deads=%o3:
	call	printf,4            ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 31
! preds: 30
! succs: 32
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 59
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	sethi	%hi(string),%o2     ! sets=%o2:    uses=         deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .1_y],%o1    ! sets=%o1:    uses=%fp:y:   deads=
	add	%o2,%lo(string),%o2 ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 32
! preds: 31
! succs: 33
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 60
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	sethi	%hi(string),%o2     ! sets=%o2:    uses=         deads=
	add	%o2,%lo(string),%o2 ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,2,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .1_y],%o1    ! sets=%o1:    uses=%fp:y:   deads=
	add	%o2,23,%o2          ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 33
! preds: 32
! succs: 34
!  doms:
!   ins=y:i:
!  outs=y:i:
!
! source statement 61
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	sethi	%hi(string),%o2     ! sets=%o2:    uses=         deads=
	add	%o2,%lo(string),%o2 ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .1_y],%o1    ! sets=%o1:    uses=%fp:y:   deads=
	add	%o2,46,%o2          ! sets=%o2:    uses=%o2:     deads=%o2:
	mov	72,%o3              ! sets=%o3:    uses=         deads=
	call	cal,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 34
! preds: 33
! succs: 35
!  doms:
!   ins=y:i:
!  outs=y:i:j:
!
! source statement 62
	st	%g0,[%fp + .1_j]    ! sets=j:      uses=%g0:%fp: deads=
!
! block 35
! preds: 34 36
! succs: 36
!  doms:
!   ins=y:i:j:
!  outs=y:i:j:
!
.L70:
! source statement 63
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	sethi	%hi(string),%o1     ! sets=%o1:    uses=         deads=
	add	%o1,%lo(string),%o1 ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	72,%o1              ! sets=%o1:    uses=         deads=
	call	pstr,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 36
! preds: 35
! succs: 37 35
!  doms:
!   ins=y:i:j:
!  outs=y:i:j:
!
! source statement 63
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=j:
	add	%o0,72,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_j]    ! sets=j:      uses=%o0:%fp: deads=%o0:
! source statement 63
	ld	[%fp + .1_j],%o0    ! sets=%o0:    uses=%fp:j:   deads=
	cmp	%o0,432             ! sets=        uses=%o0:     deads=%o0:
	bl	.L70                ! sets=        uses=         deads=
	nop
!
! block 37
! preds: 36
! succs: 38 25
!  doms:
!   ins=y:i:
!  outs=y:i:
!
.L71:
! source statement 64
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 64
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,12              ! sets=        uses=%o0:     deads=%o0:
	bl	.L59                ! sets=        uses=         deads=
	nop
!
! block 38
! preds: 37
! succs: 39
!  doms:
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
!  doms:
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
!  doms:
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
!  doms:
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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=%i0:
!  outs=n:s:
!
number:
.2_n = -4
.2_c = -8
.2_s = -12
	save	%sp,(-80),%sp       ! sets=window  uses=%sp:     deads=
.2_str = 68
	st	%i0,[%fp + .2_str]  ! sets=str:    uses=%i0:%fp: deads=%i0:
! source statement 78
	st	%g0,[%fp + .2_n]    ! sets=n:      uses=%g0:%fp: deads=
! source statement 79
	ld	[%fp + .2_str],%o0  ! sets=%o0:    uses=%fp:str: deads=str:
	st	%o0,[%fp + .2_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
!
! block 2
! preds: 1 6
! succs: 3 7
!  doms:
!   ins=n:s:
!  outs=n:c:s:
!
.L77:
! source statement 80
	ld	[%fp + .2_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .2_s]    ! sets=s:      uses=%o1:%fp: deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .2_c]    ! sets=c:      uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L78                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 5
!  doms:
!   ins=n:c:s:
!  outs=n:c:s:
!
! source statement 81
	ld	[%fp + .2_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,48              ! sets=        uses=%o0:     deads=%o0:
	bl	.L81                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5 6
!  doms:
!   ins=n:c:s:
!  outs=n:c:s:
!
.L80:
	ld	[%fp + .2_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,57              ! sets=        uses=%o0:     deads=%o0:
	ble	.L79                ! sets=        uses=         deads=
	nop
!
! block 5
! preds: 3 4
! succs:
!  doms:
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
!  doms:
!   ins=n:c:s:
!  outs=n:s:
!
.L79:
! source statement 83
	ld	[%fp + .2_n],%o0    ! sets=%o0:    uses=%fp:n:   deads=n:
	smul	%o0,10,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .2_c],%o1    ! sets=%o1:    uses=%fp:c:   deads=c:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sub	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .2_n]    ! sets=n:      uses=%o0:%fp: deads=%o0:
	ba,a	.L77                ! sets=        uses=         deads=
!
! block 7
! preds: 2
! succs:
!  doms:
!   ins=n:
!  outs=
!
.L78:
! source statement 85
	ld	[%fp + .2_n],%i0    ! sets=%i0:    uses=%fp:n:   deads=n:
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	pstr
	.proc	0
! loops in function

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=%i0:%i1:
!  outs=i:s:str:n:
!
pstr:
.3_i = -4
.3_s = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.3_str = 68
	st	%i0,[%fp + .3_str]  ! sets=str:    uses=%i0:%fp: deads=%i0:
.3_n = 72
	st	%i1,[%fp + .3_n]    ! sets=n:      uses=%i1:%fp: deads=%i1:
! source statement 94
	ld	[%fp + .3_str],%o0  ! sets=%o0:    uses=%fp:str: deads=
	st	%o0,[%fp + .3_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 95
	ld	[%fp + .3_n],%o0    ! sets=%o0:    uses=%fp:n:   deads=
	st	%o0,[%fp + .3_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
!
! block 2
! preds: 1 3 5
! succs: 3 6
!  doms:
!   ins=i:s:str:n:
!  outs=i:s:str:n:
!
.L84:
! source statement 96
	ld	[%fp + .3_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	sub	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .3_i]    ! sets=i:      uses=%o1:%fp: deads=%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L85                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 2
!  doms:
!   ins=i:s:str:n:
!  outs=i:s:str:n:
!
! source statement 97
	ld	[%fp + .3_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .3_s]    ! sets=s:      uses=%o1:%fp: deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L84                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms:
!   ins=i:s:str:n:
!  outs=i:s:str:n:
!
! source statement 98
	mov	32,%o0              ! sets=%o0:    uses=         deads=
	ld	[%fp + .3_s],%o1    ! sets=%o1:    uses=%fp:s:   deads=
	stb	%o0,[%o1 + (-1)]    ! sets=        uses=%o0:%o1: deads=%o0:%o1:
!
! block 5
! preds: 4
! succs: 2
!  doms:
!   ins=i:s:str:n:
!  outs=i:s:str:n:
!
.L86:
	ba,a	.L84                ! sets=        uses=         deads=
!
! block 6
! preds: 2
! succs: 7
!  doms:
!   ins=s:str:n:
!  outs=i:s:str:
!
.L85:
! source statement 99
	ld	[%fp + .3_n],%o0    ! sets=%o0:    uses=%fp:n:   deads=n:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .3_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
!
! block 7
! preds: 6 8
! succs: 8 10
!  doms:
!   ins=i:s:str:
!  outs=i:s:str:
!
.L87:
! source statement 100
	ld	[%fp + .3_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	sub	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .3_i]    ! sets=i:      uses=%o1:%fp: deads=%o1:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L88                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 7
!  doms:
!   ins=i:s:str:
!  outs=i:s:str:
!
! source statement 101
	ld	[%fp + .3_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .3_s]    ! sets=s:      uses=%o0:%fp: deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	be	.L87                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms:
!   ins=s:str:
!  outs=s:str:
!
	ba,a	.L88                ! sets=        uses=         deads=
!
! block 10
! preds: 7 9
! succs: 11
!  doms:
!   ins=s:str:
!  outs=
!
.L88:
! source statement 103
	ld	[%fp + .3_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	stb	%g0,[%o0 + 1]       ! sets=        uses=%g0:%o0: deads=%o0:
! source statement 104
	sethi	%hi(.L90),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L90),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .3_str],%o1  ! sets=%o1:    uses=%fp:str: deads=str:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 11
! preds: 10
! succs:
!  doms:
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

!
! block 1
! preds:
! succs: 2
!  doms:
!   ins=%i0:%i1:%i2:%i3:
!  outs=%o0:s:m:y:p:w:
!
cal:
.4_d = -4
.4_i = -8
.4_s = -12
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.4_m = 68
	st	%i0,[%fp + .4_m]    ! sets=m:      uses=%i0:%fp: deads=%i0:
.4_y = 72
	st	%i1,[%fp + .4_y]    ! sets=y:      uses=%i1:%fp: deads=%i1:
.4_p = 76
	st	%i2,[%fp + .4_p]    ! sets=p:      uses=%i2:%fp: deads=%i2:
.4_w = 80
	st	%i3,[%fp + .4_w]    ! sets=w:      uses=%i3:%fp: deads=%i3:
! source statement 120
	ld	[%fp + .4_p],%o0    ! sets=%o0:    uses=%fp:p:   deads=
	st	%o0,[%fp + .4_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 121
	ld	[%fp + .4_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	call	jan1,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 2
! preds: 1
! succs: 3
!  doms:
!   ins=%o0:s:m:y:p:w:
!  outs=d:s:m:p:w:
!
	st	%o0,[%fp + .4_d]    ! sets=d:      uses=%o0:%fp: deads=%o0:
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
	ld	[%fp + .4_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=y:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	call	jan1,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms:
!   ins=d:s:m:p:w:
!  outs=d:s:m:p:w:
!
	add	%o0,7,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .4_d],%o1    ! sets=%o1:    uses=%fp:d:   deads=
	sub	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 4
! preds: 3
! succs: 7
!  doms:
!   ins=d:s:m:p:w:
!  outs=%o0:d:s:m:p:w:
!
	mov	%o0,%o0             ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L96                ! sets=        uses=         deads=
!
! block 5
! preds: 7
! succs: 9
!  doms:
!   ins=d:s:m:p:w:
!  outs=d:s:m:p:w:
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
!  doms:
!   ins=d:s:m:p:w:
!  outs=d:s:m:p:w:
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
!  doms:
!   ins=%o0:d:s:m:p:w:
!  outs=%o0:d:s:m:p:w:
!
.L96:
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	be	.L97                ! sets=        uses=         deads=
	nop
!
! block 8
! preds: 7
! succs: 9 6
!  doms:
!   ins=%o0:d:s:m:p:w:
!  outs=d:s:m:p:w:
!
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	bne	.L98                ! sets=        uses=         deads=
	nop
!
! block 9
! preds: 5 6 8
! succs: 11
!  doms:
!   ins=d:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L95:
! source statement 147
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .4_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
	ba,a	.L102               ! sets=        uses=         deads=
!
! block 10
! preds: 11
! succs: 11
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L103:
! source statement 148
	ld	[%fp + .4_d],%o0    ! sets=%o0:    uses=%fp:d:   deads=d:
	ld	[%fp + .4_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sethi	%hi(mon),%o2        ! sets=%o2:    uses=         deads=
	add	%o2,%lo(mon),%o2    ! sets=%o2:    uses=%o2:     deads=%o2:
	ldsb	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	st	%o0,[%fp + .4_d]    ! sets=d:      uses=%o0:%fp: deads=%o0:
! source statement 148
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
!
! block 11
! preds: 9 10
! succs: 12 10
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L102:
! source statement 148
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .4_m],%o1    ! sets=%o1:    uses=%fp:m:   deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L103               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13
!  doms:
!   ins=d:s:m:p:w:
!  outs=%o0:s:m:p:w:
!
.L104:
! source statement 149
	ld	[%fp + .4_d],%o0    ! sets=%o0:    uses=%fp:d:   deads=d:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 13
! preds: 12
! succs: 24
!  doms:
!   ins=%o0:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
	st	%o0,[%fp + .4_d]    ! sets=d:      uses=%o0:%fp: deads=%o0:
! source statement 150
	ld	[%fp + .4_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	ld	[%fp + .4_d],%o1    ! sets=%o1:    uses=%fp:d:   deads=
	smul	%o1,3,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	st	%o0,[%fp + .4_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 151
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .4_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
	ba,a	.L107               ! sets=        uses=         deads=
!
! block 14
! preds: 24
! succs: 15 17
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L108:
! source statement 152
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,3               ! sets=        uses=%o0:     deads=%o0:
	bne	.L109               ! sets=        uses=         deads=
	nop
!
! block 15
! preds: 14
! succs: 16 17
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
	ld	[%fp + .4_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	ldsb	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	cmp	%o0,19              ! sets=        uses=%o0:     deads=%o0:
	bne	.L109               ! sets=        uses=         deads=
	nop
!
! block 16
! preds: 15
! succs: 17
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
! source statement 153
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,11,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 154
	ld	[%fp + .4_m],%o0    ! sets=%o0:    uses=%fp:m:   deads=
	sethi	%hi(mon),%o1        ! sets=%o1:    uses=         deads=
	add	%o1,%lo(mon),%o1    ! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	ldsb	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,11,%o1          ! sets=%o1:    uses=%o1:     deads=%o1:
	stb	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
!
! block 17
! preds: 14 15 16
! succs: 18 20
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L109:
! source statement 156
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	ble	.L110               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 19
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
! source statement 157
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	mov	10,%o1              ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 19
! preds: 18
! succs: 20
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
	add	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .4_s],%o1    ! sets=%o1:    uses=%fp:s:   deads=
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
!
! block 20
! preds: 17 19
! succs: 21
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L110:
! source statement 158
	ld	[%fp + .4_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 159
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	mov	10,%o1              ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 21
! preds: 20
! succs: 22 23
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
	add	%o0,48,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .4_s],%o1    ! sets=%o1:    uses=%fp:s:   deads=s:
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%fp + .4_s]    ! sets=s:      uses=%o2:%fp: deads=%o2:
	stb	%o0,[%o1]           ! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 160
	ld	[%fp + .4_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=s:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 161
	ld	[%fp + .4_d],%o0    ! sets=%o0:    uses=%fp:d:   deads=d:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_d]    ! sets=d:      uses=%o0:%fp: deads=
	cmp	%o0,7               ! sets=        uses=%o0:     deads=%o0:
	bne	.L111               ! sets=        uses=         deads=
	nop
!
! block 22
! preds: 21
! succs: 23
!  doms:
!   ins=i:m:p:w:
!  outs=d:i:s:m:p:w:
!
! source statement 162
	st	%g0,[%fp + .4_d]    ! sets=d:      uses=%g0:%fp: deads=
! source statement 163
	ld	[%fp + .4_p],%o0    ! sets=%o0:    uses=%fp:p:   deads=p:
	ld	[%fp + .4_w],%o1    ! sets=%o1:    uses=%fp:w:   deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	st	%o0,[%fp + .4_s]    ! sets=s:      uses=%o0:%fp: deads=%o0:
! source statement 164
	ld	[%fp + .4_s],%o0    ! sets=%o0:    uses=%fp:s:   deads=
	st	%o0,[%fp + .4_p]    ! sets=p:      uses=%o0:%fp: deads=%o0:
!
! block 23
! preds: 21 22
! succs: 24
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L111:
! source statement 166
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .4_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
!
! block 24
! preds: 13 23
! succs: 25 14
!  doms:
!   ins=d:i:s:m:p:w:
!  outs=d:i:s:m:p:w:
!
.L107:
! source statement 166
	ld	[%fp + .4_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	ld	[%fp + .4_m],%o1    ! sets=%o1:    uses=%fp:m:   deads=
	sethi	%hi(mon),%o2        ! sets=%o2:    uses=         deads=
	add	%o2,%lo(mon),%o2    ! sets=%o2:    uses=%o2:     deads=%o2:
	ldsb	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ble	.L108               ! sets=        uses=         deads=
	nop
!
! block 25
! preds: 24
! succs:
!  doms:
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
!  doms:
!   ins=%i0:
!  outs=%o0:%i0:y:
!
jan1:
.5_y = -4
.5_d = -8
	save	%sp,(-104),%sp      ! sets=window  uses=%sp:     deads=
.5_yr = 68
	st	%i0,[%fp + .5_yr]   ! sets=yr:     uses=%i0:%fp: deads=
! source statement 184
	ld	[%fp + .5_yr],%o0   ! sets=%o0:    uses=%fp:yr:  deads=yr:
	st	%o0,[%fp + .5_y]    ! sets=y:      uses=%o0:%fp: deads=%o0:
! source statement 185
	ld	[%fp + .5_y],%l0    ! sets=%l0:    uses=%fp:y:   deads=
	add	%l0,4,%l0           ! sets=%l0:    uses=%l0:     deads=%l0:
	ld	[%fp + .5_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	add	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	4,%o1               ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 2
! preds: 1
! succs: 3 6
!  doms:
!   ins=%o0:%i0:y:
!  outs=%i0:y:d:
!
	add	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
	st	%l0,[%fp + .5_d]    ! sets=d:      uses=%l0:%fp: deads=%l0:
! source statement 193
	ld	[%fp + .5_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	cmp	%o0,1800            ! sets=        uses=%o0:     deads=%o0:
	ble	.L115               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4
!  doms:
!   ins=%i0:y:d:
!  outs=%o0:%i0:y:
!
! source statement 194
	ld	[%fp + .5_d],%l0    ! sets=%l0:    uses=%fp:d:   deads=d:
	ld	[%fp + .5_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	sub	%o0,1701,%o0        ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	100,%o1             ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 4
! preds: 3
! succs: 5
!  doms:
!   ins=%o0:%i0:y:
!  outs=%o0:%i0:y:
!
	sub	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
	st	%l0,[%fp + .5_d]    ! sets=d:      uses=%l0:%fp: deads=%l0:
! source statement 195
	ld	[%fp + .5_d],%l0    ! sets=%l0:    uses=%fp:d:   deads=d:
	ld	[%fp + .5_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=
	sub	%o0,1601,%o0        ! sets=%o0:    uses=%o0:     deads=%o0:
	mov	400,%o1             ! sets=%o1:    uses=         deads=
	call	.div,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 5
! preds: 4
! succs: 6
!  doms:
!   ins=%o0:%i0:y:
!  outs=%i0:y:d:
!
	add	%l0,%o0,%l0         ! sets=%l0:    uses=%o0:%l0: deads=%o0:%l0:
	st	%l0,[%fp + .5_d]    ! sets=d:      uses=%l0:%fp: deads=%l0:
!
! block 6
! preds: 2 5
! succs: 7 8
!  doms:
!   ins=%i0:y:d:
!  outs=%i0:d:
!
.L115:
! source statement 202
	ld	[%fp + .5_y],%o0    ! sets=%o0:    uses=%fp:y:   deads=y:
	cmp	%o0,1752            ! sets=        uses=%o0:     deads=%o0:
	ble	.L116               ! sets=        uses=         deads=
	nop
!
! block 7
! preds: 6
! succs: 8
!  doms:
!   ins=%i0:d:
!  outs=%i0:d:
!
! source statement 203
	ld	[%fp + .5_d],%o0    ! sets=%o0:    uses=%fp:d:   deads=d:
	add	%o0,3,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .5_d]    ! sets=d:      uses=%o0:%fp: deads=%o0:
!
! block 8
! preds: 6 7
! succs: 9
!  doms:
!   ins=%i0:d:
!  outs=%i0:
!
.L116:
! source statement 205
	ld	[%fp + .5_d],%o0    ! sets=%o0:    uses=%fp:d:   deads=d:
	mov	7,%o1               ! sets=%o1:    uses=         deads=
	call	.rem,2              ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 9
! preds: 8
! succs:
!  doms:
!   ins=%i0:
!  outs=
!
	ret	                    ! sets=        uses=%i0:     deads=%i0:
	restore	%o0,%g0,%o0         ! sets=window  uses=%g0:%o0: deads=%o0:
	.seg	"data"
