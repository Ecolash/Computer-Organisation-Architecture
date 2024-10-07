.data
array: .space 40
msg1: .asciiz "Enter 10 integers: "
dbg1: .asciiz "Before recursion right= "
dbg2: .asciiz "After recursion right= "
msg2: .asciiz "Sorted array: "
msg3: .asciiz "Enter the number to search: "
msg4: .asciiz " is FOUND in the array at index "
msg5: .asciiz " NOT FOUND in the array"
.text
.globl main
main:
    la $a0,msg1
    li $v0,4
    syscall
    jal get_array
    li $a0,0
    li $a1,9
    jal recursive_sort
    jal print_array
    la $a0,msg3
    li $v0,4
    syscall
    li $v0,5
    syscall
    move $s0,$v0#key
    li $a0,0
    li $a1,9
    jal recursive_search
    jal final_stmt
    j exit


get_array:
    li $t0,0
    li $t1,10
    loop:
        beq $t0,$t1,end_loop
        li $v0,5
        syscall
        sll $t2,$t0,2
        sw $v0,array($t2)
        addi $t0,$t0,1
        j loop
    end_loop:
        jr $ra

recursive_sort:
    addi $sp,$sp,-16
    sw $ra,0($sp)
    addi $t0,$a0,0#l
    addi $t1,$a1,0#r
    addi $t2,$a0,0#p
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $t1, 12($sp)
    while1:
        bge $t0,$t1,end_while1
        while2:
            sll $t3,$t0,2
            sll $t4,$t2,2
            lw $t5,array($t3)
            lw $t6,array($t4)
            bgt $t5,$t6,while3
            bge $t0,$a1,while3
            addi $t0,$t0,1
            j while2
        while3:
            sll $t3,$t1,2
            sll $t4,$t2,2
            lw $t5,array($t3)
            lw $t6,array($t4)
            blt $t5,$t6,ifcase
            ble $t1,$a0,ifcase
            addi $t1,$t1,-1
            j while3
        ifcase:
            blt $t0,$t1,swap_and_return
            sll $t3,$t1,2
            sll $t4,$t2,2
            lw $t5,array($t3)
            lw $t6,array($t4)
            sw $t5,array($t4)
            sw $t6,array($t3)

            move $a1,$t1
            addi $a1,$a1,-1
            # #Debugging
            # move $s1,$a0
            # la $a0,dbg1
            # li $v0,4
            # syscall
            # move $a0,$a1
            # li $v0,1
            # syscall
            # li $a0,10
            # li $v0,11
            # syscall
            # move $a0,$s1
            jal recursive_sort

            move $a0,$a1
            addi $a0,$a0,2
            lw $a1,8($sp)
            jal recursive_sort
            j end_while1
        swap_and_return:
            sll $t3,$t0,2
            sll $t4,$t1,2
            lw $t5,array($t3)
            lw $t6,array($t4)
            sw $t5,array($t4)
            sw $t6,array($t3)
        j while1
    end_while1:
        lw $ra,0($sp)
        lw $a0,4($sp)
        lw $a1,8($sp)
        lw $t1,12($sp)
        addi $sp,$sp,16
        jr $ra
        

print_array:
    la $a0,msg2
    li $v0,4
    syscall
    li $t0,0
    li $t1,10
    print_loop:
        bge $t0,$t1,end_print
        sll $t2,$t0,2
        lw $a0,array($t2)
        li $v0,1
        syscall
        li $a0,32
        li $v0,11
        syscall
        addi $t0,$t0,1
        j print_loop
    end_print:
        li $a0,10
        li $v0,11
        syscall
        jr $ra


recursive_search:
    addi $sp,$sp,-4
    sw $ra,0($sp)
    addi $t0,$a0,0#l
    addi $t1,$a1,0#r
    while:
        bgt $t0,$t1,not_found
        sub $t2,$t1,$t0
        addi $t9,$zero,3
        div $t2,$t9
        mflo $t2
        add $t3,$t0,$t2#mid1
        sub $t4,$t1,$t2#mid2
        sll $t5,$t3,2
        lw $t6,array($t5)#arr[mid1]
        bne $s0,$t6,lab1
        move $v0,$t3
        lw $ra,0($sp)
        addi $sp,$sp,4
        jr $ra
        lab1:
            sll $t5,$t4,2
            lw $t7,array($t5)#arr[mid2]
            bne $s0,$t7,lab2
            move $v0,$t4
            lw $ra,0($sp)
            addi $sp,$sp,4
            jr $ra
        lab2:
            bge $s0,$t6,lab3
            move $a1,$t3
            addi $a1,$a1,-1
            jal recursive_search
            lw $ra,0($sp)
            addi $sp,$sp,4
            jr $ra

        lab3:
            ble $s0,$t7, lab4
            move $a0,$t4
            addi $a0,$a0,1
            jal recursive_search
            lw $ra,0($sp)
            addi $sp,$sp,4
            jr $ra
        lab4:
            move $a0,$t3
            addi $a0,$a0,1
            move$a1,$t4
            addi $a1,$a1,-1
            jal recursive_search
            lw $ra,0($sp)
            addi $sp,$sp,4
            jr $ra
    not_found:
        li $v0,-1
        lw $ra,0($sp)
        addi $sp,$sp,4
        jr $ra

final_stmt:
    move $s1,$v0#index
    addi $t1,$zero,-1
    beq $t1,$s1,not_found_2
    move $a0,$s0
    li $v0,1
    syscall
    la $a0,msg4
    li $v0,4
    syscall
    move $a0,$s1
    li $v0,1
    syscall
    j return
    not_found_2:
        move $a0,$s0
        li $v0,1
        syscall
        la $a0,msg5
        li $v0,4
        syscall
    return:
        jr $ra
exit:
    li $v0,10
    syscall






