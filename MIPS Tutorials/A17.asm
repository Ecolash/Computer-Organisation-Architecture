.data
string:  .space 1000
msg1:    .asciiz "Enter string: "
yes:     .asciiz "Valid parenthesis!"
no:      .asciiz "Invalid parenthesis!"

.text
main: 
    la $a0, msg1
    li $v0, 4
    syscall

    li $v0, 8
    la $a0, string
    li $a1, 1000
    syscall

    la $s0, string
    move $s1, $sp

    loop:
    lb $t1, 0($s0)
    beq $t1, 0, end
    beq $t1, '(', push
    beq $t1, ')', pop
    j next

    push:
    sb $t1, 0($sp)          
    addi $sp, $sp, -1       
    j next
    
    pop:
    addi $sp, $sp, 1        
    lb $t2, 0($sp)         
    bne $t2, '(', invalid  
    j next

    next:
    addi $s0, $s0, 1
    j loop

    end:
    bne $sp, $s1, invalid

    valid:
    la $a0, yes
    li $v0, 4
    syscall
    li $v0, 10
    syscall

    invalid:
    la $a0, no
    li $v0, 4
    syscall
    li $v0, 10
    syscall



