.data
array: .space 1000
size:  .word 0
in1:   .asciiz "Enter size of array: "
in2:   .asciiz "Enter elements of array:\n"
out1:  .asciiz "Sorted array is "

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
    jal sort

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

sort:
    move $t0, $s0

    loop1:
    addi $t0, $t0, -1
    blt $t0, 0, return
    li $t1, 0
    move $t2, $t0

    loop2:
    bge $t1, $t0, loop1
    move $t3, $t1
    addi $t4, $t3, 1
    sll $t3, $t3, 2
    sll $t4, $t4, 2

    lw $t5, array($t3)
    lw $t6, array($t4)
    ble $t5, $t6, continue
    sw $t6, array($t3)
    sw $t5, array($t4)

    continue:
    addi $t1, $t1, 1
    j loop2

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
