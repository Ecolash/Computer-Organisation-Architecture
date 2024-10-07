
## ASSIGNMENT - 2 : Q2
##---------------------------------------------------------------------------
## TUHIN MONDAL(22CS10087)
## DIGANTA MANDAL(22CS30062) 
##---------------------------------------------------------------------------
.data
array: .word 7, 3, 2, 1, 11, 105, 10
n: .word 7
k: .word 3
msg1: .asciiz "K="
msg2: .asciiz "Kth smallest element is: "
msg3: .asciiz "Kth largest element is: "
msg4: .asciiz "Sorted array: "

.text
.globl main
main:
    la $s1, k
    lw $s0, 0($s1)
    la $a0, msg1
    li $v0, 4
    syscall
    move $a0, $s0
    li $v0, 1
    syscall
    li $a0, 10
    li $v0, 11
    syscall
    la $t1, n
    lw $t0, 0($t1)
    # counter i
    li $t2, 0

outer_loop:
    bge $t2,$t0, end_outer_loop
    #counter j
    li $t3, 0

inner_loop:
    #check if j<n-i-1
    sub $t4,$t0,$t2
    sub $t4,$t4,1
    bge $t3, $t4,end_inner_loop
    #$t5=arr[j]
    la $t6, array
    sll $t7,$t3,2
    add $t6,$t6,$t7
    lw $t5, 0($t6)
    #$t8=arr[j+1]
    addi $t6,$t6,4
    lw $t8, 0($t6)

    ble $t5,$t8, no_swap

swap:
    sub $t6,$t6,4
    sw $t8,0($t6)
    sw $t5,4($t6)

no_swap:
    addi $t3,$t3,1
    j inner_loop

end_inner_loop:
    addi $t2,$t2,1
    j outer_loop

end_outer_loop:
    #counter i
    la $a0, msg4
    li $v0, 4
    syscall
    li $t2, 0
    la $t1, array

print_loop:
    bge $t2,$t0, end_print_loop
    sll $t3,$t2,2
    add $t4,$t1,$t3
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    li $a0, 32
    li $v0, 11
    syscall 
    addi $t2,$t2,1
    j print_loop

end_print_loop:
    li $a0,10
    li $v0,11 
    syscall
    li $t2, 0
    la $t1, array

find_kth_smallest:
    sub $s1, $s0,1
    beq $t2, $s1, print_kth_smallest
    addi $t2, $t2, 1
    j find_kth_smallest

print_kth_smallest:
    la $a0,msg2
    li $v0, 4
    syscall
    sll $t3, $t2, 2
    add $t4,$t3,$t1
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    li $a0, 10
    li $v0, 11
    syscall
    li $t2, 0
    la $t1, array

find_kth_largest:
    sub $s1, $t0, $s0
    beq $t2, $s1, print_kth_largest
    addi $t2, $t2, 1
    j find_kth_largest

print_kth_largest:
    la $a0,msg3
    li $v0, 4
    syscall
    sll $t3, $t2, 2
    add $t4, $t3, $t1
    lw $a0, 0($t4)
    li $v0, 1
    syscall
    li $a0, 10
    li $v0, 11
    syscall
    li $v0, 10
    syscall




