.data
arr: .word 100, 12, 13, 14, 15, 17, 19, 21
n: .word 8
mssg: .asciiz "Rotated by K = "

.text
main:
    la $a0, mssg
    li $v0, 4
    syscall
    la $t0, arr
    lw $s0, 0($t0)

    jal bin
    lw $s5, n
    sll $s5, $s5, 2
    lw  $s5, arr($s5)
    blt $s5, $s0, output
    li $v0, 0

output:
    move $a0, $v0
    li $v0, 1
    syscall
    li $v0, 10
    syscall

bin:
    la $a0, n
    la $t0, arr
    li $t1, 0              
    lw $t2, 0($a0)         
    addi $t2, $t2, -1      

loop:
    bge $t1, $t2, exit
    add $t3, $t1, $t2 
    srl $t3, $t3, 1     
    sll $t3, $t3, 2    
    la  $t4, arr         
    add $t4, $t4, $t3
    lw  $t5, 0($t4)      
    bgt $s0, $t5, yes

no:
    srl  $t3, $t3, 2
    addi $t1, $t3, 1
    j    loop
yes:
    srl  $t3, $t3, 2
    move $t2, $t3
    j loop

exit:
    move $v0, $t1
    jr $ra
