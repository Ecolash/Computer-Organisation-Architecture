# Greatest Common Divisor (GCD)

.data
prompt1: .asciiz "Enter first number: "
prompt2: .asciiz "Enter second number: "
message: .asciiz "The GCD value is: "

.text
main: 
li $v0, 4
la $a0, prompt1
syscall

li $v0, 5
syscall
move $t1, $v0

li $v0, 4
la $a0, prompt2
syscall

li $v0, 5
syscall
move $t2, $v0

move $a0, $t1
move $a1, $t2
jal GCD
move $t3, $v0

li $v0, 4
la $a0, message
syscall

li $v0, 1
move $a0, $a1
syscall
li $v0, 10
syscall


GCD:
    addi $sp, $sp, -8
    sw $s0, 4($sp)
    sw $ra, 0($sp)
    beq $a0, 0, base_case

    div $a1, $a0
    mfhi $t1
    move $a1, $a0
    move $a0, $t1
    jal GCD
    move $s0, $v0
    j GCD_return

    base_case:
    move $v0, $a1
    j GCD_return

    GCD_return:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

