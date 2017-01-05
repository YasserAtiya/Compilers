	.seg	"data"
	.file	"BranchingTest.c"
	.section	".rodata"
	.align 8
.LLC0:
	.asciz	"i is %d\n"
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -104, %sp
	st	%g0, [%fp-4]
.LL2:
	sethi	%hi(.LLC0), %g1
	or	%g1, %lo(.LLC0), %o0
	ld	[%fp-4], %o1
	call	printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	cmp	%g1, 0
	bne	%icc, .LL2
	 nop
	mov	%g1, %i0
	return	%i7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.4"
