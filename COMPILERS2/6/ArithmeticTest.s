	.seg	"text"
	.global main
main:
	save	%sp,(-112),%sp
	st	%i0,[%fp + 68]
L4:
	add	%sp,104,%l0
	mov	5,%l1
	st	%l1,[%l0]
L7:
	.seg	"data"
LS7:
	.asciz	"b=1\n a: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS7),%l0
	or	%l0,%lo(LS7),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L17:
	add	%fp,68,%l0
	add	%sp,104,%l1
	ld	[%l1],%l2
	st	%l2,[%l0]
L21:
	.seg	"data"
LS21:
	.asciz	"a=nb\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS21),%l0
	or	%l0,%lo(LS21),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L31:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	add	%l2,%l4,%l2
	st	%l2,[%l0]
L38:
	.seg	"data"
LS38:
	.asciz	"a+b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS38),%l0
	or	%l0,%lo(LS38),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L48:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sub	%l2,%l4,%l2
	st	%l2,[%l0]
L55:
	.seg	"data"
LS55:
	.asciz	"a-b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS55),%l0
	or	%l0,%lo(LS55),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L65:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	smul	%l2,%l4,%l2
	st	%l2,[%l0]
L72:
	.seg	"data"
LS72:
	.asciz	"a*b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS72),%l0
	or	%l0,%lo(LS72),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L82:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	mov	2,%l3
	sdiv	%l2,%l3,%l2
	st	%l2,[%l0]
L88:
	.seg	"data"
LS88:
	.asciz	"a\\2\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS88),%l0
	or	%l0,%lo(LS88),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L98:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	or	%l2,%l4,%l2
	st	%l4,[%l0]
L105:
	.seg	"data"
LS105:
	.asciz	"a|b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS105),%l0
	or	%l0,%lo(LS105),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L115:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	and	%l2,%l4,%l2
	st	%l4,[%l0]
L122:
	.seg	"data"
LS122:
	.asciz	"a&b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS122),%l0
	or	%l0,%lo(LS122),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L132:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	xor	%l2,%l4,%l2
	st	%l4,[%l0]
L139:
	.seg	"data"
LS139:
	.asciz	"a^b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS139),%l0
	or	%l0,%lo(LS139),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L149:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sll	%l2,%l4,%l2
	st	%l4,[%l0]
L156:
	.seg	"data"
LS156:
	.asciz	"a<<b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS156),%l0
	or	%l0,%lo(LS156),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L166:
	add	%fp,68,%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	srl	%l2,%l4,%l2
	st	%l4,[%l0]
L173:
	.seg	"data"
LS173:
	.asciz	"a>>b\na: %d\nb: %d\n"

	.seg	"text"
	sethi	%hi(LS173),%l0
	or	%l0,%lo(LS173),%l0
	add	%fp,68,%l1
	ld	[%l1],%l2
	add	%sp,104,%l3
	ld	[%l3],%l4
	sethi	%hi(printf),%l5
	or	%l5,%lo(printf),%l5
	mov	%l0,%o0
	mov	%l2,%o1
	mov	%l4,%o2
	call	%l5,3
	nop
L183:
	ret
	restore
