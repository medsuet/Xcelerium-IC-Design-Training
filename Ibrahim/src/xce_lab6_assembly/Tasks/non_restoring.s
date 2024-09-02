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
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	mv	a5,a0
	mv	a4,a1
	sd	a2,-64(s0)
	sd	a3,-72(s0)
	sw	a5,-52(s0)
	mv	a5,a4
	sw	a5,-56(s0)
	lw	a5,-52(s0)
	sw	a5,-20(s0)
	lw	a5,-56(s0)
	sw	a5,-32(s0)
	sw	zero,-24(s0)
	li	a5,32
	sw	a5,-28(s0)
	lw	a5,-56(s0)
	sext.w	a5,a5
	bne	a5,zero,.L2
	ld	a5,-64(s0)
	sw	zero,0(a5)
	ld	a5,-72(s0)
	sw	zero,0(a5)
	j	.L1
.L2:
	ld	a5,-64(s0)
	sw	zero,0(a5)
	ld	a5,-72(s0)
	sw	zero,0(a5)
	j	.L4
.L9:
	lw	a5,-24(s0)
	bge	a5,zero,.L5
	lwu	a5,-24(s0)
	slli	a4,a5,32
	lwu	a5,-20(s0)
	or	a5,a4,a5
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	slli	a5,a5,1
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	sw	a5,-20(s0)
	ld	a5,-40(s0)
	srli	a5,a5,32
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-32(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
	j	.L6
.L5:
	lwu	a5,-24(s0)
	slli	a4,a5,32
	lwu	a5,-20(s0)
	or	a5,a4,a5
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	slli	a5,a5,1
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	sw	a5,-20(s0)
	ld	a5,-40(s0)
	srli	a5,a5,32
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-32(s0)
	subw	a5,a4,a5
	sw	a5,-24(s0)
.L6:
	lw	a5,-24(s0)
	bge	a5,zero,.L7
	lw	a5,-20(s0)
	andi	a5,a5,-2
	sw	a5,-20(s0)
	j	.L8
.L7:
	lw	a5,-20(s0)
	ori	a5,a5,1
	sw	a5,-20(s0)
.L8:
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
.L4:
	lw	a5,-28(s0)
	sext.w	a5,a5
	bne	a5,zero,.L9
	lw	a5,-24(s0)
	bge	a5,zero,.L10
	lw	a4,-24(s0)
	lw	a5,-32(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
.L10:
	ld	a5,-64(s0)
	lw	a4,-20(s0)
	sw	a4,0(a5)
	ld	a5,-72(s0)
	lw	a4,-24(s0)
	sw	a4,0(a5)
.L1:
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	non_restoring_division, .-non_restoring_division
	.align	1
	.globl	run_test_case
	.type	run_test_case, @function
run_test_case:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	mv	a4,a1
	sw	a5,-36(s0)
	mv	a5,a4
	sw	a5,-40(s0)
	addi	a3,s0,-32
	addi	a2,s0,-28
	lw	a4,-40(s0)
	lw	a5,-36(s0)
	mv	a1,a4
	mv	a0,a5
	call	non_restoring_division
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	divuw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	remuw	a5,a4,a5
	sw	a5,-24(s0)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	run_test_case, .-run_test_case
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
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
	li	a5,8192
	addi	a0,a5,1808
	call	run_test_case
	li	a5,0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
