 .data 
	msg_1:
		.asciiz "Enter first Number (Non Negative): "
	msg_2:
		.asciiz "Enter second Number (Non Negative): "
	error_msg:
		.asciiz "Invalid Number!! "
	output_msg:
		.asciiz "GCD of given two numbers is : "

.text
.globl main
main:
    la $a0, msg_1
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s0,$v0

    la $a0, msg_2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s1,$v0

    add $a0,$s0,$zero
    add $a1,$s1,$zero

    slt $s3,$s0,$s1
    beq $s3,$zero,swap_and_compute
    jal find_gcd
    j print_array

swap_and_compute:
    add $a3,$a0,$zero
    add $a0,$a1,$zero
    add $a1,$a3,$zero
    jal find_gcd
    j print_array

find_gcd:
    addi $sp,$sp,-4
    sw $ra,0($sp)
    bne $a0,0,recursion
    lw $ra,0($sp)
    addi $sp,$sp,4
    jr $ra

recursion:
    add $t0,$a0,$zero
    rem $a0,$a1,$a0
    add $a1,$t0,$zero
    jal find_gcd
    lw $ra,0($sp)
    addi $sp,$sp,4
    jr $ra

print_array:
    la $a0,output_msg 
	li $v0,4  
	syscall
    move $a0,$a1
    li $v0,1
    syscall
    li $v0,10
    syscall
    