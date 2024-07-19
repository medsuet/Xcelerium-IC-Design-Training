	.file	"division.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"%d"
	.text
	.align	1
	.globl	print_binary
	.type	print_binary, @function
print_binary:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	sd	a5,-32(s0)
	li	a5,31
	sw	a5,-20(s0)
	j	.L2
.L3:
	ld	a5,-32(s0)
	lw	a4,0(a5)
	lw	a5,-20(s0)
	sraw	a5,a4,a5
	sext.w	a5,a5
	andi	a5,a5,1
	sext.w	a5,a5
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,zero,.L3
	li	a0,10
	call	putchar
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	print_binary, .-print_binary
	.align	1
	.globl	binary_width
	.type	binary_width, @function
binary_width:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	sw	zero,-20(s0)
	lw	a5,-36(s0)
	sext.w	a5,a5
	bne	a5,zero,.L5
	li	a5,1
	j	.L6
.L5:
	lw	a5,-36(s0)
	sraiw	a5,a5,31
	lw	a4,-36(s0)
	xor	a4,a5,a4
	subw	a5,a4,a5
	sw	a5,-24(s0)
	j	.L7
.L8:
	lw	a5,-24(s0)
	sraiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L7:
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,zero,.L8
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
.L6:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	binary_width, .-binary_width
	.align	1
	.globl	arithmeticleftshift
	.type	arithmeticleftshift, @function
arithmeticleftshift:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	mv	a5,a2
	sw	a5,-52(s0)
	ld	a5,-48(s0)
	lw	a4,0(a5)
	lw	a5,-52(s0)
	addiw	a5,a5,-2
	sext.w	a5,a5
	sraw	a5,a4,a5
	sext.w	a5,a5
	andi	a5,a5,1
	sw	a5,-20(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	slliw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-20(s0)
	or	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	ld	a5,-48(s0)
	lw	a5,0(a5)
	slliw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,0(a5)
	nop
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	arithmeticleftshift, .-arithmeticleftshift
	.align	1
	.globl	correcting_Q
	.type	correcting_Q, @function
correcting_Q:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	lw	a4,0(a5)
	li	a3,33
	lw	a5,-44(s0)
	subw	a5,a3,a5
	sext.w	a5,a5
	sllw	a5,a4,a5
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,0(a5)
	ld	a5,-40(s0)
	lw	a4,0(a5)
	li	a3,33
	lw	a5,-44(s0)
	subw	a5,a3,a5
	sext.w	a5,a5
	sraw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	correcting_Q, .-correcting_Q
	.section	.rodata
	.align	3
.LC1:
	.string	"remainder: %d \n"
	.align	3
.LC2:
	.string	"quotient: %d \n"
	.text
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
	lw	a5,-52(s0)
	sext.w	a5,a5
	beq	a5,zero,.L13
	lw	a5,-56(s0)
	sext.w	a5,a5
	bne	a5,zero,.L14
.L13:
	ld	a5,-64(s0)
	sw	zero,0(a5)
	ld	a5,-72(s0)
	sw	zero,0(a5)
.L14:
	sw	zero,-24(s0)
	lw	a5,-52(s0)
	mv	a0,a5
	call	binary_width
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-52(s0)
	mv	a0,a5
	call	binary_width
	mv	a5,a0
	sw	a5,-28(s0)
	sw	zero,-40(s0)
	lw	a5,-56(s0)
	sw	a5,-32(s0)
	lw	a5,-52(s0)
	sw	a5,-44(s0)
	lw	a5,-40(s0)
	sw	a5,-36(s0)
	j	.L15
.L18:
	lw	a3,-28(s0)
	addi	a4,s0,-44
	addi	a5,s0,-40
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	arithmeticleftshift
	lw	a5,-40(s0)
	sw	a5,-36(s0)
	lw	a4,-40(s0)
	lw	a5,-32(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-40(s0)
	lw	a4,-40(s0)
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	sraw	a5,a4,a5
	sext.w	a5,a5
	andi	a5,a5,1
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,zero,.L16
	lw	a5,-44(s0)
	ori	a5,a5,1
	sext.w	a5,a5
	sw	a5,-44(s0)
	j	.L17
.L16:
	lw	a5,-36(s0)
	sw	a5,-40(s0)
.L17:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sw	a5,-20(s0)
.L15:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bgt	a4,a5,.L18
	lw	a4,-28(s0)
	addi	a5,s0,-44
	mv	a1,a4
	mv	a0,a5
	call	correcting_Q
	mv	a5,a0
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	bge	a5,zero,.L19
	lw	a5,-48(s0)
	negw	a5,a5
	sext.w	a5,a5
	sw	a5,-48(s0)
.L19:
	addi	a5,s0,-40
	mv	a0,a5
	call	print_binary
	lw	a5,-40(s0)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a5,s0,-48
	mv	a0,a5
	call	print_binary
	lw	a5,-48(s0)
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	lw	a4,-40(s0)
	ld	a5,-64(s0)
	sw	a4,0(a5)
	lw	a4,-48(s0)
	ld	a5,-72(s0)
	sw	a4,0(a5)
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	restoring_division, .-restoring_division
	.section	.rodata
	.align	3
.LC3:
	.string	"Test case %d:\n"
	.align	3
.LC4:
	.string	"%d / %d \n"
	.text
	.align	1
	.globl	run_test_case
	.type	run_test_case, @function
run_test_case:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sw	zero,-24(s0)
	sw	zero,-20(s0)
	j	.L21
.L22:
	call	rand
	mv	a5,a0
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,16
	addw	a3,a4,a5
	li	a4,65536
	addi	a4,a4,-1
	and	a4,a3,a4
	subw	a5,a4,a5
	sw	a5,-28(s0)
	call	rand
	mv	a5,a0
	mv	a4,a5
	sraiw	a5,a4,31
	srliw	a5,a5,16
	addw	a3,a4,a5
	li	a4,65536
	addi	a4,a4,-1
	and	a4,a3,a4
	subw	a5,a4,a5
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	printf
	lw	a4,-32(s0)
	lw	a5,-28(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
	addi	a3,s0,-48
	addi	a2,s0,-44
	lw	a4,-32(s0)
	lw	a5,-28(s0)
	mv	a1,a4
	mv	a0,a5
	call	restoring_division
	lw	a4,-28(s0)
	lw	a5,-32(s0)
	remw	a5,a4,a5
	sw	a5,-36(s0)
	lw	a4,-28(s0)
	lw	a5,-32(s0)
	divw	a5,a4,a5
	sw	a5,-40(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L21:
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	ble	a4,a5,.L22
	nop
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
	call	run_test_case
	li	a5,0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
