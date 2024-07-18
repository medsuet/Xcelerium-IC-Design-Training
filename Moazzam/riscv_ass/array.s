	.file	"array.c"
	.option pic
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	lla	a5,.LANCHOR0
	li	a4,12
	sd	a4,40(a5)
	lla	a3,.LANCHOR0+48
.L2:
	ld	a4,0(a5)
	slli	a4,a4,1
	sd	a4,0(a5)
	addi	a5,a5,8
	bne	a5,a3,.L2
	li	a0,0
	ret
	.size	main, .-main
	.globl	arr_gol
	.data
	.align	3
	.set	.LANCHOR0,. + 0
	.type	arr_gol, @object
	.size	arr_gol, 48
arr_gol:
	.dword	22
	.dword	4
	.dword	6
	.dword	8
	.dword	10
	.zero	8
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
