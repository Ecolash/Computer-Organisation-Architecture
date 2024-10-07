## ASSIGNMENT - 2 : Q1
##---------------------------------------------------------------------------
## TUHIN MONDAL(22CS10087)
## DIGANTA MANDAL(22CS30062) 
##---------------------------------------------------------------------------
 .text
main:
    la $a0, msg1
    li $v0, 4
    syscall 
    li $v0, 5
    syscall
    move $t4,$v0
    srl $t0, $t4,8
    sll $t1, $t0, 8
    sub $t7, $t4, $t1
    add $t7, $t0, $t7
    bgt $t7, 255, process

edgecase:
    bne $t7,255, output
    move $t7,$0
    addi $t0,$t0,1
 
output:
    li $v0, 4
    la $a0, quotient

    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, nl
    syscall
    li $v0, 4
    la $a0, remainder
    syscall
    move $a0,$t7
    li $v0,1
    syscall

    li $v0,10
    syscall

process:
   addi $t2,$0,255
   sub $t7,$t7,$t2
   addi $t0,$t0,1
   bge $t7,255, process
   j output




.data
msg1:  .asciiz "Enter a positive integer : "
quotient: .asciiz "Quotient is : "
nl: .asciiz "\n"
remainder: .asciiz "Remainder is : "

