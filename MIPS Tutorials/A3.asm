# BINARY SEARCH

.data
    in1:  .asciiz "Enter 8 integers in an array (non-decreasing): "
    in2:  .asciiz "Enter the number to search: "
    msg1: .asciiz "Initial check passed. Array is sorted.\n"
    msg2: .asciiz "Element found at index: "
    notvalid: .asciiz "Array is not in non-decreasing order\n"
    array: .space 32

.text
.globl main

main:
    jal get_array
    la $a0, in2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s0, $v0  
    
    li $a0, 0  
    li $a1, 7  
    jal bin_search
    j exit

get_array:
    add $t0, $zero, $zero
    la $a0, in1
    li $v0, 4
    syscall
    move $t1, $ra  

    loop:
        beq $t0, 32, end_loop  
        li $v0, 5
        syscall
        sw $v0, array($t0) 
        addi $t0, $t0, 4 
        j loop

    end_loop: jr $t1  

bin_search:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    sub $t1, $a1, $a0
    li $s1, 3
    div $t1, 3

    mflo $t1
    add $t4, $a0, $t1
    sub $t5, $a1, $t1

    bgt $a0, $a1, cross
    

