	.file	"T1.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	shiftLeft
	.type	shiftLeft, @function
shiftLeft:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	slli	a4,a5,32
	ld	a5,-48(s0)
	lw	a5,0(a5)
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	or	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	slli	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	srai	a5,a5,32
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	shiftLeft, .-shiftLeft
	.align	1
	.globl	restoringDivisionAlgorithm
	.type	restoringDivisionAlgorithm, @function
restoringDivisionAlgorithm:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	mv	a5,a0
	mv	a4,a1
	sd	a2,-64(s0)
	sd	a3,-72(s0)
	sw	a5,-52(s0)
	mv	a5,a4
	sw	a5,-56(s0)
	li	a5,32
	sw	a5,-24(s0)
	sw	zero,-32(s0)
	lw	a5,-52(s0)
	sw	a5,-28(s0)
	lw	a5,-56(s0)
	sw	a5,-36(s0)
	lw	a5,-24(s0)
	sw	a5,-20(s0)
	j	.L3
.L6:
	addi	a4,s0,-36
	addi	a5,s0,-32
	mv	a1,a4
	mv	a0,a5
	call	shiftLeft
	lw	a4,-32(s0)
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	bge	a5,zero,.L4
	lw	a5,-36(s0)
	andi	a5,a5,-2
	sext.w	a5,a5
	sw	a5,-36(s0)
	lw	a5,-32(s0)
	lw	a4,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-32(s0)
	j	.L5
.L4:
	lw	a5,-36(s0)
	ori	a5,a5,1
	sext.w	a5,a5
	sw	a5,-36(s0)
.L5:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L3:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L6
	lw	a4,-36(s0)
	ld	a5,-64(s0)
	sw	a4,0(a5)
	lw	a4,-32(s0)
	ld	a5,-72(s0)
	sw	a4,0(a5)
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	restoringDivisionAlgorithm, .-restoringDivisionAlgorithm
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a5,5
	sw	a5,-20(s0)
	li	a5,2
	sw	a5,-24(s0)
	sw	zero,-28(s0)
	sw	zero,-32(s0)
	addi	a3,s0,-32
	addi	a2,s0,-28
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	restoringDivisionAlgorithm
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
