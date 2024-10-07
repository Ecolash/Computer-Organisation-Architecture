## GROUP-26 
#---------------------------------------------------------------
##  TUHIN MONDAL(22CS10087)
##  DIGANTA MANDAL(22CS30062)
#---------------------------------------------------------------

.data
matrix: .space 1000
msg1: .asciiz "Enter Number of rows: "
msg2: .asciiz "Enter Number of columns: "
msg3: .asciiz "Enter a: "
msg4: .asciiz "Enter b: "
msg5: .asciiz "Matrix is: "

.text
.globl main
main:
    la $a0,msg1        #Prompt for N
    li $v0,4
    syscall
    li $v0,5
    syscall
    move $s0,$v0

    la $a0,msg2         #Prompt for M
    li $v0,4
    syscall
    li $v0,5
    syscall
    move $s1,$v0

    la $a0,msg3         #Prompt for a
    li $v0,4
    syscall
    li $v0,5
    syscall
    move $s2,$v0

    la $a0,msg4         #Prompt for b
    li $v0,4
    syscall
    li $v0,5
    syscall
    move $s3,$v0

    jal fill_matrix     #Fill the matrix
    jal print_matrix    #Print the matrix
    j exit              #Exit

#---------------------------------------------------------------
# FUNCTION TO FILL THE MATRIX
#---------------------------------------------------------------
fill_matrix:
    li $t0,0
    li $t1,1
    sw $t1,matrix($t0)
    addi $t0,$t0,1

    loop1:
        beq $t0,$s1,end_loop1
        mul $t1,$t1,$s3
        mul $t1,$t1,-1
        sll $t2,$t0,2
        sw $t1,matrix($t2)
        addi $t0,$t0,1
        j loop1

    end_loop1:
        li $t0,0
        li $t3,4
        move $t4,$s1#m

    loop:
        beq $t0,$s1,end_loop
        move $t3,$t0
        sll $t5,$t3,2
        lw $t6,matrix($t5)
        li $t1,1

        inner_loop:
            beq $t1,$s0,end_inner_loop
            add $t3,$t3,$t4
            sll $t5,$t3,2
            mul $t6,$t6,$s2
            mul $t6,$t6,-1
            sw $t6,matrix($t5)
            addi $t1,$t1,1
            j inner_loop

        end_inner_loop:
            addi $t0,$t0,1
            j loop
    end_loop:
        jr $ra


#---------------------------------------------------------------
# FUNCTION TO PRINT THE MATRIX
#---------------------------------------------------------------

print_matrix:
    la $a0,msg5
    li $v0,4
    syscall
    li $a0,10
    li $v0,11
    syscall

    li $t0,0#i
    li $t1,0#j
    li $t2,0#curr_base_address
    move $t4,$s1#m

    for_loop:
        beq $t0,$s0,end_for_loop
        inner_for_loop:
            beq $t1,$s1,end_inner_for_loop
            move $t3,$t2
            add $t3,$t3,$t1
            sll $t3,$t3,2
            lw $a0,matrix($t3)
            li $v0,1
            syscall
            li $a0,32
            li $v0,11
            syscall
            addi $t1,$t1,1
            j inner_for_loop

        end_inner_for_loop:
            li $a0,10
            li $v0,11
            syscall
            addi $t0,$t0,1
            add $t2,$t2,$t4
            li $t1,0
            j for_loop
            
    end_for_loop:
        jr $ra

exit:
    li $v0,10
    syscall

            




        



