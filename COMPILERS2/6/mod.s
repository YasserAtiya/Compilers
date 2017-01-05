	.seg	"text"
	.global	main
main:
	save	%sp,(-120),%sp
L4:
	add	%sp,112,%l0
	mov	10,%l1
	st	%l1,[%l0]
L7:
	add	%sp,104,%l0
	mov	15,%l1
	st	%l1,[%sp + 96]
	ld	[%sp + 96],%f0
	fitod	%f0,%f0
	std	%f0,[%l0]
L11:
	.seg	"data"
LS11:
	.asciz	"i is %d\n"

	.seg	"text"
	sethi	%hi(LS11),%l0
	or	%l0,%lo(LS11),%l0
	add	%sp,112,%l1
	ld	[%l1],%l2
	sethi	%hi(printf),%l3
	or	%l3,%lo(printf),%l3
	mov	%l0,%o0
	mov	%l2,%o1
	call	%l3,2
	nop
L18:
	.seg	"data"
LS18:
	.asciz	"x is %f\n"

	.seg	"text"
	sethi	%hi(LS18),%l0
	or	%l0,%lo(LS18),%l0
	add	%sp,104,%l1
	ldd	[%l1],%f0
	sethi	%hi(printf),%l2
	or	%l2,%lo(printf),%l2
	mov	%l0,%o0
	std	%f0,[%sp + 96]
	ld	[%sp + 96],%o1
	ld	[%sp + 100],%o2
	call	%l2,3
	nop
L25:
	add	%sp,112,%l0
	mov	3,%l1
	ld	[%l0],%l2
	add	%l2,%l1,%l2
	st	%l2,[%l0]
L30:
	add	%sp,104,%l0
	mov	3,%l1
	ldd	[%l0],%f0
	st	%l1,[%sp + 96]
	ld	[%sp + 96],%f2
	fitod	%f2,%f2
	fdivd	%f0,%f2,%f0
	std	%f0,[%l0]
L36:
	add	%sp,112,%l0
	ld	[%l0],%l1
	add	%sp,104,%l2
	ldd	[%l2],%f0
	sethi	%hi(foo),%l3
	or	%l3,%lo(foo),%l3
	mov	%l1,%o0
	std	%f0,[%sp + 96]
	ld	[%sp + 96],%o1
	ld	[%sp + 100],%o2
	call	%l3,3
	nop

	add	%sp,112,%l0
	ld	[%l0],%l1
	add	%sp,104,%l2
	ld	[%l2],%f0
	sethi	%hi(foo),%l3
	or	%l3,%lo(foo),%l3
	mov	%l1,%o0
	std	%f0,[%sp + 96]
	ld	[%sp + 96],%o1
	ld	[%sp + 100],%o2
	call	%l3,3

L44:
	ret
	restore
	.seg	"text"
	.global	foo
foo:
	save	%sp,(-104),%sp
	st	%i0,[%fp + 68]
	st	%i1,[%fp + 72]
	st	%i2,[%fp + 76]
L48:
	.seg	"data"
LS48:
	.asciz	"j is %d\n"

	.seg	"text"
	sethi	%hi(LS48),%l0
	or	%l0,%lo(LS48),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	sethi	%hi(printf),%l3
	or	%l3,%lo(printf),%l3
	mov	%l0,%o0
	mov	%l2,%o1
	call	%l3,2
	nop
L55:
	.seg	"data"
LS55:
	.asciz	"z is %f\n"

	.seg	"text"
	sethi	%hi(LS55),%l0
	or	%l0,%lo(LS55),%l0
	add	%fp,72,%l1
	ldd	[%l1],%f0
	sethi	%hi(printf),%l2
	or	%l2,%lo(printf),%l2
	mov	%l0,%o0
	std	%f0,[%sp + 96]
	ld	[%sp + 96],%o1
	ld	[%sp + 100],%o2
	call	%l2,3
	nop
L62:
	ret
	restore
