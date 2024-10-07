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
    jal check_ascending
    la $a0, msg1
    li $v0, 4
    syscall
    jal bin_search
    j exit

get_array:
    # Initialize index to 0
    add $t0, $zero, $zero
    la $a0, in1
    li $v0, 4
    syscall
    move $t1, $ra  # Save return address

    loop:
        beq $t0, 32, end_loop  # Check if array is full
        li $v0, 5
        syscall
        sw $v0, array($t0)  # Store input in array
        addi $t0, $t0, 4  # Increment index
        j loop

    end_loop:
        jr $t1  # Return to caller

check_ascending:
    # Initialize index to 0
    add $t0, $zero, $zero
    lw $a0, array($t0)  # Load first element

    Again:
        addi $t0, $t0, 4  # Increment index
        beq $t0, 32, valid  # Check if end of array
        lw $a1, array($t0)  # Load next element
        blt $a1, $a0, invalid  # Check if not ascending
        move $a0, $a1  # Update current element
        j Again

    invalid:
        la $a0, notvalid
        li $v0, 4
        syscall
        j exit

    valid:
        jr $ra  # Return to caller

bin_search:
    la $a0, in2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    move $s0, $v0  # Store search value
    add $t0, $zero, $zero  # Initialize low index
    addi $t1, $zero, 28  # Initialize high index
    addi $t2, $zero, -1  # Initialize index of element to be searched

    bin_loop:
        bgt $t0, $t1, not_found  # Check if low > high
        srl $t3, $t0, 2  # Calculate mid index
        srl $t4, $t1, 2
        add $t5, $t3, $t4
        srl $t5, $t5, 1
        sll $t5, $t5, 2  # Convert mid index to byte offset
        lw $a1, array($t5)  # Load middle element

        beq $a1, $s0, success  # Check if found
        blt $a1, $s0, inc_lo  # Adjust low index
        j dec_hi  # Adjust high index

    inc_lo:
        addi $t0, $t5, 4
        j bin_loop

    dec_hi:
        addi $t1, $t5, -4
        j bin_loop

    success:
        move $t2, $t5  # Store index of found element
        srl $t2, $t2, 2  # Convert byte offset to index
        la $a0, msg2
        li $v0, 4
        syscall
        move $a0, $t2
        li $v0, 1
        syscall
        j exit

    not_found:
        la $a0, msg2  # Assuming you want to print "Element found at index: -1" for not found
        li $v0, 4
        syscall
        li $a0, -1
        li $v0, 1
        syscall

    exit:
        li $v0, 10
        syscall
