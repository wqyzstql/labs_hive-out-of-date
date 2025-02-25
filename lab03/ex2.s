.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1 #a0 is the value of x
    sub t1, x0, a0 #t1 = -x
    mul a0, t0, t1 # a0=-x*(x+1)
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp) #store the address
    # END PROLOGUE
    addi t0, x0, 0
    addi s0, x0, 0
    la s1, source
    la s2, dest

# for Problem1: The register representing the variable k is t0
# for Problem2: The register representing the variable sum is s0
# for Problem3: The registers acting as pointers to the source and dest arrays is s1 and s2
# for Problem4: The assembly code for the loop found in the C code is undering.
# for Problem5: How the pointers are manipulated in the assembly code.
# First of all, s1 and s2 is the start address of Array source and dest, then calculate the value of offset
# then use start + 4 * offset to get the address of array[now]

loop:
    slli s3, t0, 2 #s3 = t0<<2 , t0 is offset,because a word is 4Byte so need to shift left 2 （2^2=4)
    add t1, s1, s3
    lw t2, 0(t1)#t2 = source[s3] t0=k
    beq t2, x0, exit#if source[k]==0 break
    add a0, x0, t2#a0 = source[k]

    addi sp, sp, -8#call func
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8#return func then a0 is the ans

    add t2, x0, a0#t2 = a0
    add t3, s2, s3#t3 = dest[s3]
    sw t2, 0(t3)
    add s0, s0, t2#s0 = s0+dest[s3], s0=sum
    addi t0, t0, 1
    jal x0, loop
exit:
    add a1, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    addi a0, x0, 1
    ecall
    addi a0, x0, 10
    ecall
