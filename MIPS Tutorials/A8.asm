.data
	msg1: .asciiz "Enter n: "
	msg3: .asciiz "Factorial(n) is: "

.text
main:
	la $a0, msg1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

    li $t0, 1
    move $a0, $v0
    jal factorial

	la $a0, msg3
	li $v0, 4
	syscall

    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 10
    syscall

factorial:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    mul $t0, $t0, $a0
    addi $a0, $a0, -1
    ble $a0, 1, return
    jal factorial

    return:
        lw $ra, 0($sp)
        addi $sp, $sp, 4 
        jr $ra
