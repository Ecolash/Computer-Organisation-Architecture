# NEXT GREATER ELEMENT

.data
array: .space 1000
NGE:   .word -1, -1, -1,-1, -1, -1,-1, -1, -1,-1, -1, -1,-1, -1, -1,-1, -1, -1,-1
size:  .word 0
in1:   .asciiz "Enter size of array: "
in2:   .asciiz "Enter elements of array:\n"
out1:  .asciiz "NGE Array: "

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

    jal solve

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

solve:
    li $t0, 0
    li $t1, 100000
    li $t2, -1
    sw $t2, 4($sp)
    sw $t1, 0($sp)
    addi $sp, $sp, -8

    loop:
    bge $t0, $s0, return
    sll $t1, $t0, 2
    lw $t1, array($t1)

    while:
    addi $sp, $sp, 8
    lw $t2, 0($sp)
    lw $t3, 4($sp)
    ble $t1, $t2, push
    sll $t3, $t3, 2
    sw $t0, NGE($t3)
    j while

    push:
    addi $sp, $sp, -8
    sw $t0, 4($sp)
    sw $t1, 0($sp)
    addi $sp, $sp, -8
    addi $t0, $t0, 1
    j loop

output:
    li $t4, 0
    print:
    bge $t4, $s0, return
    sll $t5, $t4, 2

    lw $a0, NGE($t5)
    li $v0, 1
    syscall

    li $a0, 32
    li $v0, 11
    syscall
    addi $t4, $t4, 1
    j print

return: jr $ra

