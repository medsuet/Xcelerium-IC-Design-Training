	.file	"division.c"
	.option pic
	.text
	.align	1
	.globl	leftShiftFunc
	.type	leftShiftFunc, @function
leftShiftFunc:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	mv	a5,a2
	sw	a5,-52(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	slli	a5,a5,32
	srli	a5,a5,32
	slli	a4,a5,32
	ld	a5,-48(s0)
	lw	a5,0(a5)
	slli	a5,a5,32
	srli	a5,a5,32
	or	a5,a4,a5
	sd	a5,-32(s0)
	lw	a5,-52(s0)
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,26
	addw	a4,a4,a5
	andi	a4,a4,63
	subw	a5,a4,a5
	sw	a5,-52(s0)
	lw	a5,-52(s0)
	mv	a4,a5
	ld	a5,-32(s0)
	sll	a5,a5,a4
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	srli	a5,a5,32
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,0(a5)
	nop
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	leftShiftFunc, .-leftShiftFunc
	.align	1
	.globl	restoring_division
	.type	restoring_division, @function
restoring_division:
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
	la	a5,__stack_chk_guard
	ld	a4, 0(a5)
	sd	a4, -24(s0)
	li	a4, 0
	lw	a5,-52(s0)
	sw	a5,-40(s0)
	lw	a5,-56(s0)
	sw	a5,-32(s0)
	sw	zero,-36(s0)
	li	a5,32
	sb	a5,-41(s0)
.L7:
	addi	a4,s0,-40
	addi	a5,s0,-36
	li	a2,1
	mv	a1,a4
	mv	a0,a5
	call	leftShiftFunc
	lw	a5,-36(s0)
	lw	a4,-32(s0)
	subw	a5,a5,a4
	sext.w	a5,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	srliw	a5,a5,31
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a5,a5
	beq	a5,zero,.L3
	lw	a5,-40(s0)
	andi	a5,a5,-2
	sext.w	a5,a5
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	lw	a4,-32(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-36(s0)
	j	.L4
.L3:
	lw	a5,-40(s0)
	ori	a5,a5,1
	sext.w	a5,a5
	sw	a5,-40(s0)
.L4:
	lbu	a5,-41(s0)
	addiw	a5,a5,-1
	sb	a5,-41(s0)
	lbu	a5,-41(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L10
	j	.L7
.L10:
	nop
	lw	a4,-40(s0)
	ld	a5,-64(s0)
	sw	a4,0(a5)
	lw	a4,-36(s0)
	ld	a5,-72(s0)
	sw	a4,0(a5)
	nop
	la	a5,__stack_chk_guard
	ld	a4, -24(s0)
	ld	a5, 0(a5)
	xor	a5, a4, a5
	li	a4, 0
	beq	a5,zero,.L8
	call	__stack_chk_fail@plt
.L8:
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	restoring_division, .-restoring_division
	.align	1
	.globl	run_test_case
	.type	run_test_case, @function
run_test_case:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	mv	a5,a0
	mv	a4,a1
	sw	a5,-52(s0)
	mv	a5,a4
	sw	a5,-56(s0)
	la	a5,__stack_chk_guard
	ld	a4, 0(a5)
	sd	a4, -24(s0)
	li	a4, 0
	addi	a3,s0,-36
	addi	a2,s0,-40
	lw	a4,-56(s0)
	lw	a5,-52(s0)
	mv	a1,a4
	mv	a0,a5
	call	restoring_division
	lw	a5,-52(s0)
	mv	a4,a5
	lw	a5,-56(s0)
	divuw	a5,a4,a5
	sw	a5,-32(s0)
	lw	a5,-52(s0)
	mv	a4,a5
	lw	a5,-56(s0)
	remuw	a5,a4,a5
	sw	a5,-28(s0)
	nop
	la	a5,__stack_chk_guard
	ld	a4, -24(s0)
	ld	a5, 0(a5)
	xor	a5, a4, a5
	li	a4, 0
	beq	a5,zero,.L13
	call	__stack_chk_fail@plt
.L13:
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	run_test_case, .-run_test_case
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	li	a0,0
	call	time@plt
	mv	a5,a0
	sext.w	a5,a5
	mv	a0,a5
	call	srand@plt
	sw	zero,-32(s0)
	sw	zero,-28(s0)
	li	a5,10
	sw	a5,-24(s0)
	li	a5,3
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	mv	a1,a4
	mv	a0,a5
	call	run_test_case
	li	a5,0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
