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
!   ins=%i0:%i1:
!  outs=argc:argv:
!
main:
.1_i = -4
.1_token = -8
.1_fp = -12
.1_c = -16
	save	%sp,(-112),%sp      ! sets=window  uses=%sp:     deads=
.1_argc = 68
	st	%i0,[%fp + .1_argc] ! sets=argc:   uses=%i0:%fp: deads=%i0:
.1_argv = 72
	st	%i1,[%fp + .1_argv] ! sets=argv:   uses=%i1:%fp: deads=%i1:
!
! block 2
! preds: 1 15
! succs: 3 16
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L98:
! source statement 16
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L99                ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 4 16
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,45              ! sets=        uses=%o0:     deads=%o0:
	bne	.L99                ! sets=        uses=         deads=
	nop
!
! block 4
! preds: 3
! succs: 11
!  doms:
!   ins=argc:argv:
!  outs=%o0:argc:argv:
!
! source statement 17
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ldsb	[%o0 + 1],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L101               ! sets=        uses=         deads=
!
! block 5
! preds: 12
! succs: 6
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L102:
!
! block 6
! preds: 5 13
! succs: 7
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L103:
!
! block 7
! preds: 6 11
! succs: 15
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L104:
! source statement 19
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%o0 + 4],%o0       ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wd),%o1         ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wd)] ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 8
! preds: 14
! succs: 9
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L105:
! source statement 23
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(.L107),%o1      ! sets=%o1:    uses=         deads=
	add	%o0,32,%o0          ! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o1,%lo(.L107),%o1  ! sets=%o1:    uses=%o1:     deads=%o1:
	call	fprintf,2           ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 9
! preds: 8
! succs: 10
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
! source statement 24
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 10
! preds: 9
! succs: 15
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
	ba,a	.L100               ! sets=        uses=         deads=
!
! block 11
! preds: 4
! succs: 12 7
!  doms:
!   ins=%o0:argc:argv:
!  outs=%o0:argc:argv:
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
!   ins=%o0:argc:argv:
!  outs=%o0:argc:argv:
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L102               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 14 6
!  doms:
!   ins=%o0:argc:argv:
!  outs=argc:argv:
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=%o0:
	be	.L103               ! sets=        uses=         deads=
	nop
!
! block 14
! preds: 13
! succs: 8
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
	ba,a	.L105               ! sets=        uses=         deads=
!
! block 15
! preds: 7 10
! succs: 2
!  doms:
!   ins=argc:argv:
!  outs=argc:argv:
!
.L100:
! source statement 26
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=argc:
	sub	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_argc] ! sets=argc:   uses=%o0:%fp: deads=%o0:
! source statement 27
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=argv:
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_argv] ! sets=argv:   uses=%o0:%fp: deads=%o0:
	ba,a	.L98                ! sets=        uses=         deads=
!
! block 16
! preds: 2 3
! succs: 17
!  doms:
!   ins=argc:argv:
!  outs=i:fp:argc:argv:
!
.L99:
! source statement 30
	mov	1,%o0               ! sets=%o0:    uses=         deads=
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=%o0:
! source statement 31
	sethi	%hi(_iob),%o0       ! sets=%o0:    uses=         deads=
	add	%o0,%lo(_iob),%o0   ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_fp]   ! sets=fp:     uses=%o0:%fp: deads=%o0:
!
! block 17
! preds: 16 48
! succs: 18 22
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L111:
! source statement 33
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L113               ! sets=        uses=         deads=
	nop
!
! block 18
! preds: 17
! succs: 19
!  doms:
!   ins=i:argc:argv:
!  outs=%o0:i:argc:argv:
!
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	sethi	%hi(.L112),%o2      ! sets=%o2:    uses=         deads=
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	add	%o2,%lo(.L112),%o1  ! sets=%o1:    uses=%o2:     deads=%o2:
	call	fopen,2             ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 19
! preds: 18
! succs: 20 22
!  doms:
!   ins=%o0:i:argc:argv:
!  outs=i:fp:argc:argv:
!
	st	%o0,[%fp + .1_fp]   ! sets=fp:     uses=%o0:%fp: deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L113               ! sets=        uses=         deads=
	nop
!
! block 20
! preds: 19
! succs: 21
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
! source statement 34
	ld	[%fp + .1_argv],%o0 ! sets=%o0:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o1    ! sets=%o1:    uses=%fp:i:   deads=
	sll	%o1,2,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o0 + %o1],%o0     ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	call	perror,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 21
! preds: 20
! succs: 48
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
	ba,a	.L110               ! sets=        uses=         deads=
!
! block 22
! preds: 17 19
! succs: 23
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L113:
! source statement 37
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(linect)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 38
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(wordct)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 39
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	st	%g0,[%o0 + %lo(charct)]! sets=        uses=%g0:%o0: deads=%o0:
! source statement 40
	st	%g0,[%fp + .1_token]! sets=token:  uses=%g0:%fp: deads=
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 23
! preds: 22 40
! succs: 24 26
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L117:
! source statement 42
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	sub	%o1,1,%o1           ! sets=%o1:    uses=%o1:     deads=%o1:
	st	%o1,[%o0]           ! sets=        uses=%o0:%o1: deads=%o0:
	cmp	%o1,%g0             ! sets=        uses=%g0:%o1: deads=%o1:
	bge	.L118               ! sets=        uses=         deads=
	nop
!
! block 24
! preds: 23
! succs: 25
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=%o0:i:token:fp:argc:argv:
!
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	call	_filbuf,1           ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 25
! preds: 24
! succs: 27
!  doms:
!   ins=%o0:i:token:fp:argc:argv:
!  outs=%o0:i:token:fp:argc:argv:
!
	ba,a	.L119               ! sets=        uses=         deads=
!
! block 26
! preds: 23
! succs: 27
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=%o0:i:token:fp:argc:argv:
!
.L118:
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	add	%o0,4,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o0],%o1           ! sets=%o1:    uses=%o0:     deads=
	add	%o1,1,%o2           ! sets=%o2:    uses=%o1:     deads=
	st	%o2,[%o0]           ! sets=        uses=%o0:%o2: deads=%o0:%o2:
	ldub	[%o1],%o0           ! sets=%o0:    uses=%o1:     deads=%o1:
!
! block 27
! preds: 25 26
! succs: 28 41
!  doms:
!   ins=%o0:i:token:fp:argc:argv:
!  outs=i:token:fp:c:argc:argv:
!
.L119:
	st	%o0,[%fp + .1_c]    ! sets=c:      uses=%o0:%fp: deads=%o0:
! source statement 43
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,(-1)            ! sets=        uses=%o0:     deads=%o0:
	be	.L115               ! sets=        uses=         deads=
	nop
!
! block 28
! preds: 27
! succs: 29 33
!  doms:
!   ins=i:token:fp:c:argc:argv:
!  outs=i:token:fp:c:argc:argv:
!
.L120:
! source statement 45
	sethi	%hi(charct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(charct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(charct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 46
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	ble	.L121               ! sets=        uses=         deads=
	nop
!
! block 29
! preds: 28
! succs: 30 33
!  doms:
!   ins=i:token:fp:c:argc:argv:
!  outs=i:token:fp:c:argc:argv:
!
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,127             ! sets=        uses=%o0:     deads=%o0:
	bge	.L121               ! sets=        uses=         deads=
	nop
!
! block 30
! preds: 29
! succs: 31 39
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
! source statement 47
	ld	[%fp + .1_token],%o0! sets=%o0:    uses=%fp:token:deads=
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 31
! preds: 30
! succs: 32
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
! source statement 48
	sethi	%hi(wordct),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(wordct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(wordct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 49
	ld	[%fp + .1_token],%o0! sets=%o0:    uses=%fp:token:deads=token:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_token]! sets=token:  uses=%o0:%fp: deads=%o0:
!
! block 32
! preds: 31
! succs: 39
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L122:
	ba,a	.L114               ! sets=        uses=         deads=
!
! block 33
! preds: 28 29
! succs: 34 35
!  doms:
!   ins=i:token:fp:c:argc:argv:
!  outs=i:token:fp:c:argc:argv:
!
.L121:
! source statement 53
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,10              ! sets=        uses=%o0:     deads=%o0:
	bne	.L123               ! sets=        uses=         deads=
	nop
!
! block 34
! preds: 33
! succs: 38
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
! source statement 54
	sethi	%hi(linect),%o0     ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(linect)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(linect)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
	ba,a	.L124               ! sets=        uses=         deads=
!
! block 35
! preds: 33
! succs: 36 37
!  doms:
!   ins=i:token:fp:c:argc:argv:
!  outs=i:token:fp:c:argc:argv:
!
.L123:
! source statement 56
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=
	cmp	%o0,32              ! sets=        uses=%o0:     deads=%o0:
	be	.L125               ! sets=        uses=         deads=
	nop
!
! block 36
! preds: 35
! succs: 37 39
!  doms:
!   ins=i:token:fp:c:argc:argv:
!  outs=i:token:fp:argc:argv:
!
	ld	[%fp + .1_c],%o0    ! sets=%o0:    uses=%fp:c:   deads=c:
	cmp	%o0,9               ! sets=        uses=%o0:     deads=%o0:
	bne	.L114               ! sets=        uses=         deads=
	nop
!
! block 37
! preds: 35 36
! succs: 38
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L125:
!
! block 38
! preds: 34 37
! succs: 39
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L124:
! source statement 58
	st	%g0,[%fp + .1_token]! sets=token:  uses=%g0:%fp: deads=
!
! block 39
! preds: 30 32 36 38
! succs: 40
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L114:
!
! block 40
! preds: 39
! succs: 23
!  doms:
!   ins=i:token:fp:argc:argv:
!  outs=i:token:fp:argc:argv:
!
.L116:
! source statement 59
	ba,a	.L117               ! sets=        uses=         deads=
!
! block 41
! preds: 27
! succs: 42
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L115:
! source statement 61
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	sethi	%hi(wordct),%o2     ! sets=%o2:    uses=         deads=
	sethi	%hi(linect),%o3     ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o2 + %lo(wordct)],%o2! sets=%o2:    uses=%o2:     deads=%o2:
	ld	[%o3 + %lo(linect)],%o3! sets=%o3:    uses=%o3:     deads=%o3:
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 42
! preds: 41
! succs: 43 45
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
! source statement 62
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=
	cmp	%o0,1               ! sets=        uses=%o0:     deads=%o0:
	ble	.L127               ! sets=        uses=         deads=
	nop
!
! block 43
! preds: 42
! succs: 44
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
! source statement 63
	sethi	%hi(.L128),%o0      ! sets=%o0:    uses=         deads=
	ld	[%fp + .1_argv],%o1 ! sets=%o1:    uses=%fp:argv:deads=
	ld	[%fp + .1_i],%o2    ! sets=%o2:    uses=%fp:i:   deads=
	sll	%o2,2,%o2           ! sets=%o2:    uses=%o2:     deads=%o2:
	add	%o0,%lo(.L128),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %o2],%o1     ! sets=%o1:    uses=%o1:%o2: deads=%o1:%o2:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
	nop
!
! block 44
! preds: 43
! succs: 46
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
	ba,a	.L129               ! sets=        uses=         deads=
!
! block 45
! preds: 42
! succs: 46
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L127:
! source statement 65
	sethi	%hi(.L130),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L130),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 46
! preds: 44 45
! succs: 47
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L129:
! source statement 66
	ld	[%fp + .1_fp],%o0   ! sets=%o0:    uses=%fp:fp:  deads=
	call	fclose,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 47
! preds: 46
! succs: 48
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
! source statement 67
	sethi	%hi(tlinect),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tlinect)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(linect),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(linect)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(tlinect),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tlinect)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 68
	sethi	%hi(twordct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(twordct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(wordct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(wordct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(twordct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(twordct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
! source statement 69
	sethi	%hi(tcharct),%o0    ! sets=%o0:    uses=         deads=
	ld	[%o0 + %lo(tcharct)],%o0! sets=%o0:    uses=%o0:     deads=%o0:
	sethi	%hi(charct),%o1     ! sets=%o1:    uses=         deads=
	ld	[%o1 + %lo(charct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	add	%o0,%o1,%o0         ! sets=%o0:    uses=%o0:%o1: deads=%o0:%o1:
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	st	%o0,[%o1 + %lo(tcharct)]! sets=        uses=%o0:%o1: deads=%o0:%o1:
!
! block 48
! preds: 21 47
! succs: 49 17
!  doms:
!   ins=i:fp:argc:argv:
!  outs=i:fp:argc:argv:
!
.L110:
! source statement 70
	ld	[%fp + .1_i],%o0    ! sets=%o0:    uses=%fp:i:   deads=i:
	add	%o0,1,%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	st	%o0,[%fp + .1_i]    ! sets=i:      uses=%o0:%fp: deads=
	ld	[%fp + .1_argc],%o1 ! sets=%o1:    uses=%fp:argc:deads=
	cmp	%o0,%o1             ! sets=        uses=%o0:%o1: deads=%o0:%o1:
	bl	.L111               ! sets=        uses=         deads=
	nop
!
! block 49
! preds: 48
! succs: 50 52
!  doms:
!   ins=argc:
!  outs=
!
.L131:
! source statement 71
	ld	[%fp + .1_argc],%o0 ! sets=%o0:    uses=%fp:argc:deads=argc:
	cmp	%o0,2               ! sets=        uses=%o0:     deads=%o0:
	ble	.L132               ! sets=        uses=         deads=
	nop
!
! block 50
! preds: 49
! succs: 51
!  doms:
!   ins=
!  outs=
!
! source statement 72
	sethi	%hi(wd),%o0         ! sets=%o0:    uses=         deads=
	sethi	%hi(tcharct),%o1    ! sets=%o1:    uses=         deads=
	sethi	%hi(twordct),%o2    ! sets=%o2:    uses=         deads=
	sethi	%hi(tlinect),%o3    ! sets=%o3:    uses=         deads=
	ld	[%o0 + %lo(wd)],%o0 ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%o1 + %lo(tcharct)],%o1! sets=%o1:    uses=%o1:     deads=%o1:
	ld	[%o2 + %lo(twordct)],%o2! sets=%o2:    uses=%o2:     deads=%o2:
	ld	[%o3 + %lo(tlinect)],%o3! sets=%o3:    uses=%o3:     deads=%o3:
	call	wcp,4               ! sets=scratch uses=%o0:%o1:%o2:%o3:deads=%o0:%o1:%o2:%o3:
	nop
!
! block 51
! preds: 50
! succs: 52
!  doms:
!   ins=
!  outs=
!
! source statement 73
	sethi	%hi(.L133),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L133),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	call	printf,1            ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 52
! preds: 49 51
! succs: 53
!  doms:
!   ins=
!  outs=
!
.L132:
! source statement 75
	mov	%g0,%o0             ! sets=%o0:    uses=%g0:     deads=
	call	exit,1              ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 53
! preds: 52
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
!   ins=%i0:%i1:%i2:%i3:
!  outs=wd:charct:wordct:linect:
!
wcp:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.2_wd = 68
	st	%i0,[%fp + .2_wd]   ! sets=wd:     uses=%i0:%fp: deads=%i0:
.2_charct = 72
	st	%i1,[%fp + .2_charct]! sets=charct: uses=%i1:%fp: deads=%i1:
.2_wordct = 76
	st	%i2,[%fp + .2_wordct]! sets=wordct: uses=%i2:%fp: deads=%i2:
.2_linect = 80
	st	%i3,[%fp + .2_linect]! sets=linect: uses=%i3:%fp: deads=%i3:
!
! block 2
! preds: 1 5 7 9 13
! succs: 3 14
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
.L136:
! source statement 82
	ld	[%fp + .2_wd],%o0   ! sets=%o0:    uses=%fp:wd:  deads=
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	cmp	%o0,%g0             ! sets=        uses=%g0:%o0: deads=%o0:
	be	.L137               ! sets=        uses=         deads=
	nop
!
! block 3
! preds: 2
! succs: 10
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=%o0:wd:charct:wordct:linect:
!
! source statement 82
	ld	[%fp + .2_wd],%o0   ! sets=%o0:    uses=%fp:wd:  deads=wd:
	add	%o0,1,%o1           ! sets=%o1:    uses=%o0:     deads=
	st	%o1,[%fp + .2_wd]   ! sets=wd:     uses=%o1:%fp: deads=%o1:
	ldsb	[%o0],%o0           ! sets=%o0:    uses=%o0:     deads=%o0:
	ba,a	.L139               ! sets=        uses=         deads=
!
! block 4
! preds: 11
! succs: 5
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
.L140:
! source statement 84
	ld	[%fp + .2_linect],%o0! sets=%o0:    uses=%fp:linect:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 5
! preds: 4
! succs: 2
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 6
! preds: 12
! succs: 7
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
.L142:
! source statement 88
	ld	[%fp + .2_wordct],%o0! sets=%o0:    uses=%fp:wordct:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 7
! preds: 6
! succs: 2
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 8
! preds: 10
! succs: 9
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
.L143:
! source statement 92
	ld	[%fp + .2_charct],%o0! sets=%o0:    uses=%fp:charct:deads=
	call	ipr,1               ! sets=scratch uses=%o0:     deads=%o0:
	nop
!
! block 9
! preds: 8
! succs: 2
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
	ba,a	.L136               ! sets=        uses=         deads=
!
! block 10
! preds: 3
! succs: 11 8
!  doms:
!   ins=%o0:wd:charct:wordct:linect:
!  outs=%o0:wd:charct:wordct:linect:
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
!   ins=%o0:wd:charct:wordct:linect:
!  outs=%o0:wd:charct:wordct:linect:
!
	cmp	%o0,108             ! sets=        uses=%o0:     deads=
	be	.L140               ! sets=        uses=         deads=
	nop
!
! block 12
! preds: 11
! succs: 13 6
!  doms:
!   ins=%o0:wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
!
	cmp	%o0,119             ! sets=        uses=%o0:     deads=%o0:
	be	.L142               ! sets=        uses=         deads=
	nop
!
! block 13
! preds: 12
! succs: 2
!  doms:
!   ins=wd:charct:wordct:linect:
!  outs=wd:charct:wordct:linect:
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
!   ins=%i0:
!  outs=
!
ipr:
	save	%sp,(-96),%sp       ! sets=window  uses=%sp:     deads=
.3_num = 68
	st	%i0,[%fp + .3_num]  ! sets=num:    uses=%i0:%fp: deads=%i0:
! source statement 101
	sethi	%hi(.L146),%o0      ! sets=%o0:    uses=         deads=
	add	%o0,%lo(.L146),%o0  ! sets=%o0:    uses=%o0:     deads=%o0:
	ld	[%fp + .3_num],%o1  ! sets=%o1:    uses=%fp:num: deads=num:
	call	printf,2            ! sets=scratch uses=%o0:%o1: deads=%o0:%o1:
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
