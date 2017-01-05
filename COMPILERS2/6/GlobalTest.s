	.common	m,48,8
	.seg	"text"
	.global main
main:
	save	%sp,(-104),%sp
L3:
	mov	3,%l0
	sethi	%hi(m),%g1
	or	%g1,%lo(m),%g1
	sll	%l0,3,%l0
	ld	[%g1+%l0],%g1
	mov	9,%l1
	st	%l1,[%sp + 96]
	ld	[%sp + 96],%f0
	fitod	%f0,%f0
	st	%f0,[%sp + 96]
	ld	[%sp + 96],%g1
	fdtoi	%f0,%f0
L9:
	.seg	"data"
LS9:
	.asciz	"Element %d of m = %f\n"

	.seg	"text"
	sethi	%hi(LS9),%l0
	or	%l0,%lo(LS9),%l0
	mov	3,%l1
	mov	3,%l2
	sethi	%hi(m),%g2
	or	%g2,%lo(m),%g2
	sll	%l2,3,%l2
	ld	[%g2+%l2],%g2
	st	%g2,[%sp + 96]
	ldd	[%sp + 96],%f0
	fitod	%f0,%f0
	sethi	%hi(printf),%l3
	or	%l3,%lo(printf),%l3
	mov	%l0,%o0
	mov	%l1,%o1
	std	%f0,[%sp + 96]
	ld	[%sp + 96],%o2
	ld	[%sp + 100],%o3
	call	%l3,4
	nop
L20:
	ret
	restore
