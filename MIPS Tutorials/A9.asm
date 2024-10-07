## RECURSIVE RELATION FORMULATION

# F(0) = F(1) = F(2) = 1
# F(n) = F(n - 1) + F(n - 2) + F(n - 3)

.data
label1: .asciiz "Enter n: "
output: .asciiz "Ans : "

.text
.globl main

main:
    li $v0, 4
    la $a0, label1
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    jal fib3

    move $t3, $v0
    li $v0, 4
    la $a0, output
    syscall

    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 10
    syscall

fib3:
    addi $sp, $sp, -16
    sw $s2, 12($sp)
    sw $s1, 8($sp)
    sw $s0, 4($sp)
    sw $ra, 0($sp)

    move $s0, $a0
    ble $a0, 2, base_case

    addi $a0, $s0, -1
    jal fib3
    move $s1, $v0

    addi $a0, $s0, -2
    jal fib3
    move $s2, $v0

    addi $a0, $s0, -3
    jal fib3

    add $v0, $v0, $s1
    add $v0, $v0, $s2
    j return

    base_case:
        li $v0, 1
        j return

    return:
        lw $s2, 12($sp)
        lw $s1, 8($sp)
        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addi $sp, $sp, 16
        jr $ra


