# SUM OF ALL ELEMENTS OF AN ARRAY

.data
array: .word 1, 10, 100, 1000
msg1: .asciiz "Sum of elements of array: "
n: .word 4

.text
.globl main

main:
    la $s1, n
    la $s5, array
    lw $s0, 0($s1)
    sll $s0, $s0, 2
    add $s6, $s5, $s0
    li $t1, 0
    li $t2, 0

loop:
    beq $s6, $s5, output
    lw $s4, 0($s5)
    add $t2, $t2, $s4
    addi $s5, $s5, 4
    b loop

output:
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 10
    syscall



