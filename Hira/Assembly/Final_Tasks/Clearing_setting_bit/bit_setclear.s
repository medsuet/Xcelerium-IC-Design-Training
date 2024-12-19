	.file	"bit_setclear.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	set_bit
	.type	set_bit, @function
set_bit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	li	a4,1
	sllw	a5,a4,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	or	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	set_bit, .-set_bit
	.align	1
	.globl	clear_bit
	.type	clear_bit, @function
clear_bit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a4,a1
	sw	a5,-20(s0)
	mv	a5,a4
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	li	a4,1
	sllw	a5,a4,a5
	sext.w	a5,a5
	not	a5,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	and	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	clear_bit, .-clear_bit
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L6
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	set_bit
	mv	a5,a0
	sw	a5,-24(s0)
	j	.L7
.L6:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,zero,.L7
	lw	a4,-28(s0)
	lw	a5,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	clear_bit
	mv	a5,a0
	sw	a5,-24(s0)
.L7:
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
