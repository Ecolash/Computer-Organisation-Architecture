# Binary Exponentiation

.data
prompt1: .asciiz "Enter base: "
prompt2: .asciiz "Enter exponent: "
message: .asciiz "The value is: "

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

li $s6, 2
move $a0, $t1
move $a1, $t2
jal binpow
move $t3, $v0

li $v0, 4
la $a0, message
syscall

li $v0, 1
move $a0, $t3
syscall
li $v0, 10
syscall


binpow:
    addi $sp, $sp, -8
    sw $s0, 4($sp)
    sw $ra, 0($sp)
    beq $a1, 0, base_case1
    

    div $a1, $s6
    mfhi $s0
    mflo $a1
    # move $a1, $t2
    # move $s0, $t1 
    jal binpow

    mul $t5, $v0, $v0
    move $v0, $t5
    beq $s0, 0, binpow_return
    mul $v0, $v0, $a0
    j binpow_return

    base_case1:
    li $v0, 1
    j binpow_return    
    

    binpow_return:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

