	.file	"T2.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	changeBit
	.type	changeBit, @function
changeBit:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-28(s0)
	mv	a5,a4
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sext.w	a5,a5
	bne	a5,zero,.L2
	ld	a5,-24(s0)
	lw	a4,0(a5)
	lw	a5,-28(s0)
	li	a3,1
	sllw	a5,a3,a5
	sext.w	a5,a5
	not	a5,a5
	sext.w	a5,a5
	and	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,0(a5)
	j	.L3
.L2:
	ld	a5,-24(s0)
	lw	a4,0(a5)
	lw	a5,-28(s0)
	li	a3,1
	sllw	a5,a3,a5
	sext.w	a5,a5
	or	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,0(a5)
.L3:
	nop
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	changeBit, .-changeBit
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,15
	sw	a5,-20(s0)
	addi	a5,s0,-20
	li	a2,0
	li	a1,3
	mv	a0,a5
	call	changeBit
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
