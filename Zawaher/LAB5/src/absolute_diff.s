.global _start


.section .data

num1: .word 25
num2: .word 35

result: .word 0 

.section .text

_start :

    la t0, num1 # load the adress of num1 to t0
    la t1, num2 # load the address of num2 to t1

    lw t2, 0(t0) #load the data of t0 to t2  
    lw t3, 0(t1) #load the data of t1 to  t1  

    sub t4 ,t2,t3

    blt t4, zero, absolute # if t0 < t1 then target

    j end #if number is not negativ jump to the end

absolute :
    neg t4 , t4

end :

    #Store the result to t4 register 
    la t0 , result
    sw t3 , 0(t0)

    #Signal test pass to Spike
    li t0, 1
    la t1, tohost
    sd t0, (t1)

#Loop Forever
1 : j 1b

.section .tohost

.align 3

tohost : .dword 0

fromhost : .dword 0

