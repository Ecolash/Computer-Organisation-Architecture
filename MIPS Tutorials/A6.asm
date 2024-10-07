# Check if a number is a factorial of a natural number

.text
main:
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

process:
    li $t1, 1
    li $t2, 0

loop:
    bge $t1, $t0, output
    addi $t2, $t2, 1
    mul $t1, $t1, $t2
    b loop 

output:
    beq $t1, $t0, yess
    bne $t1, $t0, noo

yess:
    la $a0, msg3
    li $v0, 4
    syscall

    li $v0, 1
    move $a0, $t2
    syscall
    b exit

noo:
    la $a0, msg2
    li $v0, 4
    syscall
    b exit

exit:
    li $v0, 10
    syscall

.data
msg1: .asciiz "Enter a natural number: "
msg2: .asciiz "Not a factorial of a number! "
msg3: .asciiz "The number is a factorial of "