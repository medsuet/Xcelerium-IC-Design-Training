	.file	"restoring_div.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	Left_shift
	.type	Left_shift, @function
Left_shift:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	mv	a4,a1
	sw	a5,-36(s0)
	mv	a5,a4
	sw	a5,-40(s0)
	lwu	a5,-40(s0)
	slli	a5,a5,32
	sd	a5,-24(s0)
	lwu	a5,-36(s0)
	ld	a4,-24(s0)
	or	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	slli	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	Left_shift, .-Left_shift
	.section	.rodata
	.align	3
.LC0:
	.string	"invalid division"
	.align	3
.LC1:
	.string	"The remainder and quotient of divided %d and divisor %d using operaots: %d %d\n"
	.align	3
.LC2:
	.string	"Final Remainder: %u, Final Quotient: %u\n"
	.text
	.align	1
	.globl	Divider
	.type	Divider, @function
Divider:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	mv	a5,a0
	mv	a4,a1
	sw	a5,-52(s0)
	mv	a5,a4
	sw	a5,-56(s0)
	lw	a5,-56(s0)
	sext.w	a5,a5
	bne	a5,zero,.L4
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	j	.L10
.L4:
	lw	a4,-52(s0)
	lw	a5,-56(s0)
	remuw	a5,a4,a5
	sext.w	a3,a5
	lw	a4,-52(s0)
	lw	a5,-56(s0)
	divuw	a5,a4,a5
	sext.w	a4,a5
	lw	a2,-56(s0)
	lw	a5,-52(s0)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	li	a5,32
	sw	a5,-28(s0)
	sw	zero,-20(s0)
	sw	zero,-32(s0)
	sw	zero,-36(s0)
	sw	zero,-24(s0)
	j	.L6
.L9:
	lw	a4,-20(s0)
	lw	a5,-52(s0)
	mv	a1,a4
	mv	a0,a5
	call	Left_shift
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	srli	a5,a5,32
	sw	a5,-20(s0)
	ld	a5,-48(s0)
	sw	a5,-52(s0)
	lw	a4,-20(s0)
	lw	a5,-56(s0)
	subw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	li	a5,-2147483648
	and	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,-2147483648
	bne	a4,a5,.L7
	lw	a4,-20(s0)
	lw	a5,-56(s0)
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-52(s0)
	andi	a5,a5,-2
	sw	a5,-52(s0)
	j	.L8
.L7:
	lw	a5,-52(s0)
	ori	a5,a5,1
	sw	a5,-52(s0)
.L8:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L6:
	lw	a4,-24(s0)
	lw	a5,-28(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L9
	lw	a4,-52(s0)
	lw	a5,-20(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
.L10:
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	Divider, .-Divider
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	li	a0,0
	call	time
	mv	a5,a0
	sext.w	a5,a5
	mv	a0,a5
	call	srand
	sw	zero,-36(s0)
	j	.L12
.L13:
	call	rand
	mv	a5,a0
	mv	a4,a5
	li	a5,1000
	remw	a5,a4,a5
	sext.w	a5,a5
	sext.w	s1,a5
	call	rand
	mv	a5,a0
	mv	a4,a5
	li	a5,1000
	remw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a5,a5
	mv	a1,a5
	mv	a0,s1
	call	Divider
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L12:
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,39
	ble	a4,a5,.L13
	li	a5,0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC-Metal 10.2.0-2020.12.8) 10.2.0"
