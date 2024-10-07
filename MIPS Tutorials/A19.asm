.data
	msg1: .asciiz "Enter size of array: "
	msg2: .asciiz "Enter elements of array: \n"
	msg3: .asciiz "Reverse Array is: "
	arr:  .space 1000
	size: .word 0

.text
main:
	la $a0, msg1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	# sw $s0, size
	
	la $a0, msg2
	li $v0, 4
	syscall
	
	jal input
	jal reverse
	
	la $a0, msg3
	li $v0, 4
	syscall
	jal output
	li $v0, 10
	syscall
	
input:
	li $t0, 0
	input_loop:
		li $v0, 5
		syscall
		move $s1, $v0
		sll $t1, $t0, 2
		sw $s1, arr($t1)
		addi $t0, $t0, 1
		bge $t0, $s0, return
		j input_loop

reverse:
    li $t0, 0
    move $t2, $s0
    addi $t2, $t2, -1

    reverse_loop:
        sll $t3, $t0, 2
        sll $t4, $t2, 2
        lw $s3, arr($t3)
        lw $s4, arr($t4)
        sw $s3, arr($t4)
        sw $s4, arr($t3)
        addi $t0, $t0, 1
        addi $t2, $t2, -1
        bge $t0, $t2, return
        j reverse_loop

	
output:
	li $t0, 0
	output_loop:
		la $a0, 32
		li $v0, 11
		syscall
		
		sll $t1, $t0, 2
		lw $s1, arr($t1)
		move $a0, $s1
		li $v0, 1
		syscall
		addi $t0, $t0, 1
		bge $t0, $s0, return
		j output_loop
	
	
return: jr $ra
