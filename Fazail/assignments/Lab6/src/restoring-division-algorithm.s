.global _start

.section .text

end:
    # Code to exit from spike
    li t0, 1
    la t1, tohost
    sw t0, 0(t1)

1: j 1b

restoring_division_algo:
    mv t0, s0   # M = divisor
    mv t1, s1   # Q = dividend
    li t2, 0    # A = 0
    li t3, 0x0000FFFF   # 0x0000FFFF
    li t4, 0
    li t5, 0

    li s5, 1    # i = 1
    li s3, 16    # (N) No. of bits in dividend
    slli s2, s5, 15  # 0x00008000 --> s2 = s2 << (N - 1)
    xor s4, t3, s5  # s4 = 0x0000FFFE

loop:
    slli t2, t2, 1  # A = A << 1
    and t5, t1, s2  # t5 = Q & 0x00008000
    j checkQ

	elseQ:
		addi t2, t2, 0
		j reloop1

	checkQ:
		beqz t5, elseQ
		or t2, t2, s5   # A = A | 1

	reloop1:
		slli t1, t1, 1  # Q = Q << 1
		mv t3, t2		# restA = A
		sub t2, t2, t0	# A = A - M

		and t4, t2, s2	# t4 = A & 0x00008000

	checkA:
		beqz t4, elseA
		and t1, t1, s4
		mv t2, t3
		j reloop2

	elseA:
		or t1, t1, s5
		
	reloop2:
		addi s3, s3, -1
		bgt s3, zero, loop
		
    ret

_start:
    li s0, 14   # divisor = 14
    li s1, 20   # dividend = 20
	li s7, 0	# quotient = 0
	li s8, 0	# remainder = 0 
    call restoring_division_algo
    mv s7, t1
	mv s8, t2
    j end

.section .tohost
.align 3
tohost: .dword 0
fromhost: .dword 0
