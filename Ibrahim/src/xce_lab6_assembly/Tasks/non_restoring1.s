	.file	"non_restoring.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	non_restoring_division
	.type	non_restoring_division, @function
non_restoring_division:
	li	a4,32
	li	a5,0
	bne	a1,zero,.L2
	sw	zero,0(a2)
	sw	zero,0(a3)
	ret
.L12:
	slli	a5,a5,32
	slli	a0,a0,32
	srli	a0,a0,32
	or	a5,a5,a0
	slli	a5,a5,1
	sext.w	a0,a5
	srai	a5,a5,32
	addw	a5,a1,a5
	j	.L5
.L6:
	addiw	a4,a4,-1
	beq	a4,zero,.L11
.L2:
	blt	a5,zero,.L12
	slli	a5,a5,32
	slli	a0,a0,32
	srli	a0,a0,32
	or	a5,a5,a0
	slli	a5,a5,1
	sext.w	a0,a5
	srai	a5,a5,32
	subw	a5,a5,a1
.L5:
	sext.w	a6,a5
	blt	a5,zero,.L6
	ori	a0,a0,1
	j	.L6
.L11:
	blt	a6,zero,.L13
.L7:
	sw	a0,0(a2)
	sw	a5,0(a3)
	ret
.L13:
	addw	a5,a5,a1
	j	.L7
	.size	non_restoring_division, .-non_restoring_division
	.align	1
	.globl	run_test_case
	.type	run_test_case, @function
run_test_case:
	addi	sp,sp,-32
	sd	ra,24(sp)
	addi	a3,sp,8
	addi	a2,sp,12
	call	non_restoring_division
	ld	ra,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	run_test_case, .-run_test_case
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	li	a1,6
	li	a0,122
	call	run_test_case
	li	a1,9
	li	a0,12
	call	run_test_case
	li	a1,722
	li	a0,443
	call	run_test_case
	li	a1,222
	li	a0,122
	call	run_test_case
	li	a1,2000
	li	a0,8192
	addi	a0,a0,1808
	call	run_test_case
	li	a0,0
	ld	ra,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
