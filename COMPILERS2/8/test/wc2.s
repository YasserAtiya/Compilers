	.seg	"data"
	.seg	"data"
	.align	8
sccsid:
	.word	.L12
	.common	linect,4,4
	.common	wordct,4,4
	.common	charct,4,4
	.common	pagect,4,4
	.common	tlinect,4,4
	.common	twordct,4,4
	.common	tcharct,4,4
	.common	tpagect,4,4
	.align	8
	.global	wd
wd:
	.word	.L94
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
.1_token = -8
.1_fp = -12
.1_c = -16
	save	%sp,(-112),%sp      ! sets=window  uses=%sp:     deads=
.1_argc = 68
	st	%i0,[%fp + .1_argc] ! sets=argc:   uses=%i0:%fp: deads=
.1_argv = 72
	st	%i1,[%fp + .1_argv] ! sets=argv:   uses=%i1:%fp: deads=
!
! block 2
! preds: 1 15
! succs: 3 16
!  doms:
!   ins=
!  outs=
!
.L98:
! source statement 16
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	ble	.L99                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 16
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,45              ! sets=        uses=%o0:     deads=
	bne	.L99                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 11
!  doms:
!   ins=
!  outs=
!
! source statement 17
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=
	ldsb	[%o0 + 1],%o0       ! sets=%o0:    uses=%o0:     deads=
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 5
! preds: 12
! succs: 6
!  doms:
!   ins=
!  outs=
!
.L102:
!
! block 6
! preds: 5 13
! succs: 7
!  doms:
!   ins=
!  outs=
!
.L103:
!
! block 7
! preds: 6 11
! succs: 15
!  doms:
!   ins=
!  outs=
!
.L104:
! source statement 19
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(wd),%o1         ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wd)] ! sets=        uses=%o0:%o1: deads=
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 8
! preds: 14
! succs: 9
!  doms:
!   ins=
!  outs=
!
.L105:
! source statement 23
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(.L107),%o1      ! sets=%o1:    uses=         deads=
	add	%o0,32,%o0          ! sets=%o0:    uses=%o0:     deads=
	add	%o1,%lo(.L107),%o1  ! sets=%o1:    uses=%o1:     deads=
	call	fprintf,2           ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms:
!   ins=
!  outs=
!
! source statement 24
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=
	nop
!
! block 10
! preds: 9
! succs: 15
!  doms:
!   ins=
!  outs=
!
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 11
! preds: 4
! succs: 12 7
!  doms:
!   ins=
!  outs=
!
.L101:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L104               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13 5
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L102               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 14 6
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=
	be	.L103               ! sets=        uses=         deads=
	nop
!
! block 14
! preds: 13
! succs: 8
!  doms:
!   ins=
!  outs=
!
	ba,a	.L105               ! sets=        uses=         deads=
!
! block 15
! preds: 7 10
! succs: 2
!  doms:
!   ins=
!  outs=
!
.L100:
! source statement 26
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_argc] ! sets=argc:   uses=%o0:%fp: deads=
! source statement 27
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_argv] ! sets=argv:   uses=%o0:%fp: deads=
	ba,a	.L98                ! sets=        uses=         deads=
!
! block 16
! preds: 2 3
! succs: 17
!  doms:
!   ins=
!  outs=
!
.L99:
! source statement 30
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
! source statement 31
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_fp]   ! sets=fp:     uses=%o0:%fp: deads=
!
! block 17
! preds: 16 51
! succs: 18 22
!  doms:
!   ins=
!  outs=
!
.L111:
! source statement 33
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	ble	.L113               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 19
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=
	sethi	%hi(.L112),%o2      ! sets=%o2:    uses=         deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	add	%o2,%lo(.L112),%o1  ! sets=%o1:    uses=%o2:     deads=
	call	fopen,2             ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 19
! preds: 18
! succs: 20 22
!  doms:
!   ins=
!  outs=
!
	st	%o0,[%fp + .1_fp]   ! sets=fp:     uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bne	.L113               ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21
!  doms:
!   ins=
!  outs=
!
! source statement 34
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=
	call	perror,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 21
! preds: 20
! succs: 50
!  doms:
!   ins=
!  outs=
!
	ba,a	.L110               ! sets=        uses=         deads=
!
! block 22
! preds: 17 19
! succs: 23
!  doms:
!   ins=
!  outs=
!
.L113:
! source statement 37
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(linect)]! sets=        uses=%g0:%o0: deads=
! source statement 38
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(wordct)]! sets=        uses=%g0:%o0: deads=
! source statement 39
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(charct)]! sets=        uses=%g0:%o0: deads=
! source statement 40
	st	%g0,[%fp + .1_token]! sets=token:  uses=%g0:%fp: deads=
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 23
! preds: 22 42
! succs: 24 26
!  doms:
!   ins=
!  outs=
!
.L117:
! source statement 42
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=
	bge	.L118               ! sets=        uses=         deads=
	nop
!
! block 24
! preds: 23
! succs: 25
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	call	_filbuf,1           ! sets=scratch uses=%o0:     deads=
	nop
!
! block 25
! preds: 24
! succs: 27
!  doms:
!   ins=
!  outs=
!
	ba,a	.L119               ! sets=        uses=         deads=
!
! block 26
! preds: 23
! succs: 27
!  doms:
!   ins=
!  outs=
!
.L118:
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%o0]           ! sets=        uses=%o0:%o2: deads=
	ldub	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=
!
! block 27
! preds: 25 26
! succs: 28 29
!  doms:
!   ins=
!  outs=
!
.L119:
	st	%o0,[%fp + .1_c]    ! sets=c:      uses=%o0:%fp: deads=
! source statement 43
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,(-1)            ! sets=        uses=%o0:     deads=
	bne	.L120               ! sets=        uses=         deads=
	nop
!
! block 28
! preds: 27
! succs: 43
!  doms:
!   ins=
!  outs=
!
	ba,a	.L115               ! sets=        uses=         deads=
!
! block 29
! preds: 27
! succs: 30 34
!  doms:
!   ins=
!  outs=
!
.L120:
! source statement 45
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(charct)],%o0! sets=%o0:    uses=%o0:     deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(charct)]! sets=        uses=%o0:%o1: deads=
! source statement 46
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=
	ble	.L121               ! sets=        uses=         deads=
	nop
!
! block 30
! preds: 29
! succs: 31 34
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,127             ! sets=        uses=%o0:     deads=
	bge	.L121               ! sets=        uses=         deads=
	nop
!
! block 31
! preds: 30
! succs: 32 41
!  doms:
!   ins=
!  outs=
!
! source statement 47
	ld	[%fp + .1_token],%o0! sets=%o0:    uses=%fp:token:deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 32
! preds: 31
! succs: 33
!  doms:
!   ins=
!  outs=
!
! source statement 48
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(wordct)],%o0! sets=%o0:    uses=%o0:     deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wordct)]! sets=        uses=%o0:%o1: deads=
! source statement 49
	ld	[%fp + .1_token],%o0! sets=%o0:    uses=%fp:token:deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_token]! sets=token:  uses=%o0:%fp: deads=
!
! block 33
! preds: 32
! succs: 41
!  doms:
!   ins=
!  outs=
!
.L122:
	ba,a	.L114               ! sets=        uses=         deads=
!
! block 34
! preds: 29 30
! succs: 35 36
!  doms:
!   ins=
!  outs=
!
.L121:
! source statement 53
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,10              ! sets=        uses=%o0:     deads=
	bne	.L123               ! sets=        uses=         deads=
	nop
!
! block 35
! preds: 34
! succs: 40
!  doms:
!   ins=
!  outs=
!
! source statement 54
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(linect)],%o0! sets=%o0:    uses=%o0:     deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(linect)]! sets=        uses=%o0:%o1: deads=
	ba,a	.L124               ! sets=        uses=         deads=
!
! block 36
! preds: 34
! succs: 37 39
!  doms:
!   ins=
!  outs=
!
.L123:
! source statement 56
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=
	be	.L125               ! sets=        uses=         deads=
	nop
!
! block 37
! preds: 36
! succs: 38 39
!  doms:
!   ins=
!  outs=
!
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,9               ! sets=        uses=%o0:     deads=
	be	.L125               ! sets=        uses=         deads=
	nop
!
! block 38
! preds: 37
! succs: 41
!  doms:
!   ins=
!  outs=
!
	ba,a	.L114               ! sets=        uses=         deads=
!
! block 39
! preds: 36 37
! succs: 40
!  doms:
!   ins=
!  outs=
!
.L125:
!
! block 40
! preds: 35 39
! succs: 41
!  doms:
!   ins=
!  outs=
!
.L124:
! source statement 58
	st	%g0,[%fp + .1_token]! sets=token:  uses=%g0:%fp: deads=
!
! block 41
! preds: 31 33 38 40
! succs: 42
!  doms:
!   ins=
!  outs=
!
.L114:
!
! block 42
! preds: 41
! succs: 23
!  doms:
!   ins=
!  outs=
!
.L116:
! source statement 59
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 43
! preds: 28
! succs: 44
!  doms:
!   ins=
!  outs=
!
.L115:
! source statement 61
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	sethi	%hi(wordct),%o2     ! sets=%o2:    uses=         deads=
	sethi	%hi(linect),%o3     ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=
	ld	[%o2 + %lo(wordct)],%o2! sets=%o2:    uses=%o2:     deads=
	ld	[%o3 + %lo(linect)],%o3! sets=%o3:    uses=%o3:     deads=
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=
	nop
!
! block 44
! preds: 43
! succs: 45 47
!  doms:
!   ins=
!  outs=
!
! source statement 62
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=
	ble	.L127               ! sets=        uses=         deads=
	nop
!
! block 45
! preds: 44
! succs: 46
!  doms:
!   ins=
!  outs=
!
! source statement 63
	sethi	%hi(.L128),%o0      ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_argv],%o1 ! sets=%o1:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o2    ! sets=%o2:    uses=%fp:i:   deads=
	sll	%o2,2,%o2           ! sets=%o2:    uses=%o2:     deads=
	add	%o0,%lo(.L128),%o0  ! sets=%o0:    uses=%o0:     deads=
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
	nop
!
! block 46
! preds: 45
! succs: 48
!  doms:
!   ins=
!  outs=
!
	ba,a	.L129               ! sets=        uses=         deads=
!
! block 47
! preds: 44
! succs: 48
!  doms:
!   ins=
!  outs=
!
.L127:
! source statement 65
	sethi	%hi(.L130),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L130),%o0  ! sets=%o0:    uses=%o0:     deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 48
! preds: 46 47
! succs: 49
!  doms:
!   ins=
!  outs=
!
.L129:
! source statement 66
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	call	fclose,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 49
! preds: 48
! succs: 50
!  doms:
!   ins=
!  outs=
!
! source statement 67
	sethi	%hi(tlinect),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tlinect)],%o0! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(linect)],%o1! sets=%o1:    uses=%o1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	sethi	%hi(tlinect),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tlinect)]! sets=        uses=%o0:%o1: deads=
! source statement 68
	sethi	%hi(twordct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(twordct)],%o0! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(wordct)],%o1! sets=%o1:    uses=%o1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	sethi	%hi(twordct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(twordct)]! sets=        uses=%o0:%o1: deads=
! source statement 69
	sethi	%hi(tcharct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tcharct)],%o0! sets=%o0:    uses=%o0:     deads=
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tcharct)]! sets=        uses=%o0:%o1: deads=
!
! block 50
! preds: 21 49
! succs: 51 52
!  doms:
!   ins=
!  outs=
!
.L110:
! source statement 70
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=
	bge	.L131               ! sets=        uses=         deads=
	nop
!
! block 51
! preds: 50
! succs: 17
!  doms:
!   ins=
!  outs=
!
	ba,a	.L111               ! sets=        uses=         deads=
!
! block 52
! preds: 50
! succs: 53 55
!  doms:
!   ins=
!  outs=
!
.L131:
! source statement 71
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,2               ! sets=        uses=%o0:     deads=
	ble	.L132               ! sets=        uses=         deads=
	nop
!
! block 53
! preds: 52
! succs: 54
!  doms:
!   ins=
!  outs=
!
! source statement 72
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	sethi	%hi(twordct),%o2    ! sets=%o2:    uses=         deads=
	sethi	%hi(tlinect),%o3    ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=
	ld	[%o1 + %lo(tcharct)],%o1! sets=%o1:    uses=%o1:     deads=
	ld	[%o2 + %lo(twordct)],%o2! sets=%o2:    uses=%o2:     deads=
	ld	[%o3 + %lo(tlinect)],%o3! sets=%o3:    uses=%o3:     deads=
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=
	nop
!
! block 54
! preds: 53
! succs: 55
!  doms:
!   ins=
!  outs=
!
! source statement 73
	sethi	%hi(.L133),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L133),%o0  ! sets=%o0:    uses=%o0:     deads=
	call	printf,1            ! sets=scratch uses=%o0:     deads=
	nop
!
! block 55
! preds: 52 54
! succs: 56
!  doms:
!   ins=
!  outs=
!
.L132:
! source statement 75
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=
	nop
!
! block 56
! preds: 55
! succs:
!  doms:
!   ins=
!  outs=
!
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
.L133:
	.ascii " total\12\0"
.L130:
	.ascii "\12\0"
.L128:
	.ascii " %s\12\0"
.L112:
	.ascii "r\0"
.L107:
	.ascii "Usage: wc [-lwc] [files]\12\0"
.L94:
	.ascii "lwc\0"
.L12:
	.ascii "@(#)wc.c\11"
	.ascii "4.6 (Berkeley) 6/1/83\0"
	.seg	"text"
	.align	8
	.global	wcp
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
wcp:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.2_wd = 68
	st	%i0,[%fp + .2_wd]   ! sets=wd:     uses=%i0:%fp: deads=
.2_charct = 72
	st	%i1,[%fp + .2_charct]! sets=charct: uses=%i1:%fp: deads=
.2_wordct = 76
	st	%i2,[%fp + .2_wordct]! sets=wordct: uses=%i2:%fp: deads=
.2_linect = 80
	st	%i3,[%fp + .2_linect]! sets=linect: uses=%i3:%fp: deads=
!
! block 2
! preds: 1 5 7 9 13
! succs: 3 14
!  doms:
!   ins=
!  outs=
!
.L136:
! source statement 82
	ld	[%fp + .2_wd],%o0   ! sets=%o0:    uses=%fp:wd:  deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=
	be	.L137               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 10
!  doms:
!   ins=
!  outs=
!
! source statement 82
	ld	[%fp + .2_wd],%o0   ! sets=%o0:    uses=%fp:wd:  deads=
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .2_wd]   ! sets=wd:     uses=%o1:%fp: deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=
	ba,a	.L139               ! sets=        uses=         deads=
!
! block 4
! preds: 11
! succs: 5
!  doms:
!   ins=
!  outs=
!
.L140:
! source statement 84
	ld	[%fp + .2_linect],%o0! sets=%o0:    uses=%fp:linect:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=
	nop
!
! block 5
! preds: 4
! succs: 2
!  doms:
!   ins=
!  outs=
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 6
! preds: 12
! succs: 7
!  doms:
!   ins=
!  outs=
!
.L142:
! source statement 88
	ld	[%fp + .2_wordct],%o0! sets=%o0:    uses=%fp:wordct:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=
	nop
!
! block 7
! preds: 6
! succs: 2
!  doms:
!   ins=
!  outs=
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 8
! preds: 10
! succs: 9
!  doms:
!   ins=
!  outs=
!
.L143:
! source statement 92
	ld	[%fp + .2_charct],%o0! sets=%o0:    uses=%fp:charct:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=
	nop
!
! block 9
! preds: 8
! succs: 2
!  doms:
!   ins=
!  outs=
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 10
! preds: 3
! succs: 11 8
!  doms:
!   ins=
!  outs=
!
.L139:
	cmp	%o0,99              ! sets=        uses=%o0:     deads=
	be	.L143               ! sets=        uses=         deads=
	nop
!
! block 11
! preds: 10
! succs: 12 4
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L140               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13 6
!  doms:
!   ins=
!  outs=
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=
	be	.L142               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 2
!  doms:
!   ins=
!  outs=
!
.L138:
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 14
! preds: 2
! succs:
!  doms:
!   ins=
!  outs=
!
.L137:
	ret	                    ! sets=        uses=         deads=
	restore	                    ! sets=window  uses=         deads=
	.seg	"data"
	.seg	"text"
	.align	8
	.global	ipr
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
ipr:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.3_num = 68
	st	%i0,[%fp + .3_num]  ! sets=num:    uses=%i0:%fp: deads=
! source statement 101
	sethi	%hi(.L146),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L146),%o0  ! sets=%o0:    uses=%o0:     deads=
	ld	[%fp + .3_num],%o1  ! sets=%o1:    uses=%fp:num: deads=
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=
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
.L146:
	.ascii " %7ld\0"
