.data
    in1: .asciiz "\nEnter M (base): "
    in2: .asciiz "Enter d (exponent): "
    in3: .asciiz "Enter N (modulo): "
    out1: .asciiz "Binary representation of exponent d: "
    out2: .asciiz "\n(M ^ d) % N = "
    bits: .space 32
    size: .word 0

.text
main: 
    li $v0, 4              
    la $a0, in1
    syscall
    li $v0, 5              
    syscall
    move $t1, $v0

    li $v0, 4              
    la $a0, in2
    syscall
    li $v0, 5              
    syscall
    move $t2, $v0

    li $v0, 4              
    la $a0, in3
    syscall
    li $v0, 5              
    syscall
    move $s3, $v0
    li $s6, 2              

    li $s4, 0             
    move $t7, $t2          
    jal decimaltobinary    
    sw $s4, size           

    li $v0, 4              
    la $a0, out1
    syscall
    jal print_binary       

    move $a0, $t1          
    move $a1, $t2          
    jal binpow             
    move $t3, $v0          

    li $v0, 4              
    la $a0, out2
    syscall

    li $v0, 1              
    move $a0, $t3
    syscall

    li $v0, 10             
    syscall

multiply:
    mul $v0, $a0, $a1
    div $v0, $s3
    mfhi $v0
    jr $ra

square:
    mul $v0, $a0, $a0
    div $v0, $s3
    mfhi $v0
    jr $ra

decimaltobinary:
    ble $t7, 0, finished
    div $t7, $s6                # divide $t7 by 2
    mfhi $t2                    # remainder in $t2
    mflo $t7                    # quotient in $t7
    sb  $t2, bits($s4)          # store bit in bits array
    addi $s4, $s4, 1            # increment size
    j decimaltobinary

    finished: jr $ra

print_binary:
    move $t0, $s4               # move size to $t0
    addi $t0, $t0, -1           # decrement to get last index

    loop:
        blt $t0, 0, end_loop   # if index < 0, end loop
        lb $a0, bits($t0)      # load bit into $a0
        li $v0, 1              # print integer syscall
        syscall
        addi $t0, $t0, -1      # decrement index
        j loop

    end_loop: jr $ra

binpow:
    li $v1, 1             
    move $t0, $a0         
    lw $t9, size 
    li $t1, -1
    move $t5, $ra         

    binpow_loop:
        addi $t1, $t1, 1
        bgt $t1, $t9, binpow_end
        
        lb $t2, bits($t1)                    # Load current bit
        beq $t2, 0, skip_multiplication
        
        # mul $v0, $v0, $t0                   # result = result * base
        # div $v0, $s3
        # mfhi $v0                            # result = result % mod

        move $a0, $t0
        move $a1, $v1
        jal multiply
        move $v1, $v0

        skip_multiplication:
            # mul $t0, $t0, $t0               # base = base * base
            # div $t0, $s3
            # mfhi $t0                        # base = base % mod
            move $a0, $t0
            jal square
            move $t0, $v0
            j binpow_loop

    binpow_end: 
        move $ra, $t5
        move $v0, $v1
        jr $ra

