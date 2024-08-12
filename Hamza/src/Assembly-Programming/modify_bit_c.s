	.file	"modify_bit.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	modify_bit
	.type	modify_bit, @function
modify_bit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	mv	a3,a1
	mv	a4,a2
	sw	a5,-20(s0)
	mv	a5,a3
	sw	a5,-24(s0)
	mv	a5,a4
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L2
	lw	a5,-24(s0)
	li	a4,1
	sllw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	or	a5,a5,a4
	sw	a5,-20(s0)
	j	.L3
.L2:
	lw	a5,-24(s0)
	li	a4,1
	sllw	a5,a4,a5
	sext.w	a5,a5
	not	a5,a5
	sext.w	a5,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	and	a5,a5,a4
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	modify_bit, .-modify_bit
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,156
	sw	a5,-20(s0)
	li	a5,5
	sw	a5,-24(s0)
	li	a5,1
	sw	a5,-28(s0)
	lw	a3,-28(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	modify_bit
	mv	a5,a0
	sw	a5,-32(s0)
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
