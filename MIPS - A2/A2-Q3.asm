## ASSIGNMENT - 2 : Q3
##---------------------------------------------------------------------------
## TUHIN MONDAL(22CS10087)
## DIGANTA MANDAL(22CS30062) 
##---------------------------------------------------------------------------
.data
array: .word 5, 6, 3, 5, 7, 8, 9, 10, 2
n: .word 9
msg1: .asciiz "Longest Increasing  Continuous Subsequence is: "
msg2: .asciiz "Size of Longest Increasing Continuous Subsequence is: "

.text
.globl main
main:
    la $s0, n
    lw $s1, 0($s0)
    li $t1,1 #maxlen
    li $t2,1 #currentlen
    li $t3,0 #starting index
    li $s2,0 #starting index of max len
    li $t4, 1 #counter i
    la $t5, array

loop:
    bge $t4,$s1,end_loop
    #check if arr[i]>arr[i-1]
    sll $t6,$t4,2
    add $t7,$t5,$t6
    lw $t8,0($t7)
    sub $t7,$t7,4
    lw $t9,0($t7)
    bgt $t8,$t9,inc_len
    j reset_len

inc_len:
    addi $t2,$t2,1
    addi $t4,$t4,1
    j loop

reset_len:
    ble $t2,$t1,continue_loop
    move $t1,$t2
    move $s2,$t3

continue_loop:
    li $t2,1
    move $t3,$t4
    addi $t4,$t4,1
    j loop

end_loop:
    ble $t2,$t1,print_subarray
    move $t1,$t2
    move $s2,$t3

print_subarray:
    la $a0,msg2
    li $v0,4
    syscall
    move $a0,$t1
    li $v0, 1
    syscall
    li $a0, 10
    li $v0, 11
    syscall
    la $a0, msg1
    li $v0, 4
    syscall
    la $t5,array
    sll $t6,$s2,2
    add $t5,$t5,$t6 # t5 stores address of first element of max_len subarray
    li $t2,0

print_loop:
    bge $t2,$t1,exit
    sll $t4,$t2,2
    add $t6,$t5,$t4
    lw $a0, 0($t6)
    li $v0, 1
    syscall
    li $a0, 32
    li $v0, 11
    syscall 
    addi $t2,$t2,1
    j print_loop

exit:
    li $v0, 10
    syscall





