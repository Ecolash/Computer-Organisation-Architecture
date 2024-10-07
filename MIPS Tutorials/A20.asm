.data
array: .space 1000
size:  .word 0
in1:   .asciiz "Enter size of array: "
in2:   .asciiz "Enter elements of array:\n"
in3:   .asciiz "Rotate array by K = "
out1:  .asciiz "Rotated array is "

.text
.globl main

main:
    la $a0, in1
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s0, $v0   # s0 = n

    la $a0, in2
    li $v0, 4
    syscall
    jal get_array

    la $a0, in3
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s1, $v0   # s1 = k

    div $s1, $s0
    mfhi $s1        # s1 = k % n

    li $a0, 0
    sub $t1, $s0, $s1
    addi $t1, $t1, -1
    move $a1, $t1
    jal reverse

    addi $a1, $s0, -1
    addi $t1, $t1, 1
    move $a0, $t1
    jal reverse

    li $a0, 0
    addi $a1, $s0, -1
    jal reverse

    la $a0, out1
    li $v0, 4
    syscall
    jal output
    li $v0, 10
    syscall

get_array:
    li $t4, 0
    input:
    bge $t4, $s0, return
    sll $t5, $t4, 2

    li $v0, 5
    syscall
    sw $v0, array($t5)
    addi $t4, $t4, 1
    j input

reverse:
    move $t6, $a0
    move $t7, $a1

    rev_loop:
    bge $t6, $t7, return
    sll $t8, $t6, 2
    sll $t9, $t7, 2
    lw $s2, array($t8)
    lw $s3, array($t9)    
    sw $s3, array($t8)
    sw $s2, array($t9)
    addi $t6, $t6, 1
    addi $t7, $t7, -1
    j rev_loop

output:
    li $t4, 0
    print:
    bge $t4, $s0, return
    sll $t5, $t4, 2

    lw $a0, array($t5)
    li $v0, 1
    syscall

    li $a0, 32
    li $v0, 11
    syscall
    addi $t4, $t4, 1
    j print

return: jr $ra

