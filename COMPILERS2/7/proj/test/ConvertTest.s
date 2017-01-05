	.seg	"text"
	.global main
main:
	save	%sp,(-120),%sp
L4:
	add	%sp,104,%l0
	add	%sp,112,%l1
	ld	[%l1],%l2
	st	%l2,[%sp + 96]
	ldd	[%sp + 96],%f0
	fitod	%f0,%f0
L9:
	add	%sp,112,%l0
	add	%sp,104,%l1
	std	%`102,[%sp + 0]
	ld	[%sp + 96],%l2
	fdtoi	%l2,%l2
	st	%l2,[%l0]
L14:
	ret
	restore
