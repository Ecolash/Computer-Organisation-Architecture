.data
array:       .space 32
tmp:         .space 40
msg_input:   .asciiz "Enter 8 integers: "
msg_sort:    .asciiz "\nThe sorted array is: "
msg_unsort:  .asciiz "The unsorted array is: "

.text
.globl main
main:
    la $a0,msg_input
    li $v0,4
    syscall
    jal get_array
    la $a0, msg_unsort
    li $v0, 4
    syscall
    jal print_array
    add $a0, $zero, $zero
    add $a1, $zero, 7
    jal merge_sort
    la $a0, msg_sort
    li $v0, 4
    syscall
    jal print_array
    j exit

   
get_array:
    li $t0,0
    li $t1,8
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

print_array:
    add $t0, $zero, $zero
    loop2:
        beq $t0, 32, end_loop2
        lw $a0, array($t0)
        li $v0, 1
        syscall
        li $a0,32
        li $v0, 11
        syscall
        addi $t0, $t0, 4
        j loop2
    end_loop2:
        jr $ra

merge_sort:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    blt $a0, $a1, lab1
    addi $sp, $sp, 16
    jr $ra
    lab1:
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        add $a2, $a0, $a1
        srl $a2, $a2, 1
        sw $a2, 12($sp)
        move $a1,$a2
        jal merge_sort
        lw $a2, 12($sp)
        lw $a1, 8($sp)
        move $a0, $a2
        addi $a0,$a0,1
        jal merge_sort
        lw $a0, 4($sp)
        lw $a1, 8($sp)
        lw $a2, 12($sp)
        jal merge
        lw $ra, 0($sp)
        addi $sp,$sp,16
        jr $ra

merge:
    move $s0,$a0#i
    move $s1,$a2#j
    move $s2,$a0#k
    addi $t1,$a2,0#mid-1
    addi $s1,$s1,1
    while1:
        bgt $s0,$t1,while2
        bgt $s1,$a1,while2
        sll $t2,$s0,2
        sll $t3,$s1,2
        lw $t4,array($t2)
        lw $t5,array($t3)
        bgt $t4,$t5,lab
        sll $t2,$s0,2
        sll $t3,$s2,2
        lw $t4,array($t2)
        sw $t4,tmp($t3)
        addi $s2,$s2,1
        addi $s0,$s0,1
        j while1
        lab:
            sll $t2,$s1,2
            sll $t3,$s2,2
            lw $t4,array($t2)
            sw $t4,tmp($t3)
            addi $s2,$s2,1
            addi $s1,$s1,1
            j while1
    while2:
        bgt $s0,$t1,while3
        sll $t2,$s0,2
        sll $t3,$s2,2
        lw $t4,array($t2)
        sw $t4,tmp($t3)
        addi $s2,$s2,1
        addi $s0,$s0,1
        j while2
    while3:
        bgt $s1,$a1,for
        sll $t2,$s1,2
        sll $t3,$s2,2
        lw $t4,array($t2)
        sw $t4,tmp($t3)
        addi $s2,$s2,1
        addi $s1,$s1,1
        j while3
    for:
        move $t1,$a0,
        for_loop:
            bgt $t1,$a1,end_for
            sll $t3,$t1,2
            lw $t2,tmp($t3)
            sw $t2,array($t3)
            addi $t1,$t1,1
            j for_loop
    end_for:
        jr $ra

exit:
    li $v0, 10
    syscall