.data
    arr1: .word 7, 9, 11, 1, 2, 3, 4, 5
    arr2: .word 3, 2, 5, 3, 4, 1, 7, 3
    DP1: .space 32
    DP2: .space 32
    n: .word 8
    k: .word 0
    msg: .asciiz "Min cost: "

.text
main:
    li $t8, 0
    lw $t0, arr1($t8)
    sw $t0, DP1($t8)

    lw $t0, arr2($t8)
    sw $t0, DP2($t8)

    li $t1, 0
    lw $t2, n
    lw $t3, k

    loop:

        addi $t1, $t1, 1
        bge $t1, $t2, output
        sll $s1, $t1, 2

        lw $s2, arr1($s1)
        lw $s3, arr2($s1)
        addi $t4, $t1, -1
        sll $t4, $t4, 2

        lw $s4, DP1($t4)
        lw $s5, DP2($t4)

    solve1:
        add $t5, $s4, $s2
        add $t6, $s5, $s2
        add $t6, $t6, $t3
        sw $t5, DP1($s1)
        blt $t5, $t6, solve2
        sw $t6, DP1($s1)

    solve2:
        add $t5, $s4, $s3
        add $t6, $s5, $s3
        add $t5, $t5, $t3
        sw $t5, DP2($s1)
        blt $t5, $t6, loop
        sw $t6, DP2($s1)
        j loop

    output:
        addi $t2, $t2, -1
        sll $t2, $t2, 2
        lw $s4, DP1($t2)
        lw $s5, DP2($t2)
        move $s6, $s5
        bgt $s4, $s5, print
        move $s6, $s4

    print:
        jal print_array1
        li $a0, 10
        li $v0, 11
        syscall
        jal print_array2
        li $a0, 10
        li $v0, 11
        syscall
        la $a0, msg
        li $v0, 4
        syscall

        move $a0, $s6
        li $v0, 1
        syscall

        li $v0, 10
        syscall


print_array1:
    add     $t0, $zero, $zero
    print_loop1:
        beq     $t0, 32, end_print1
        lw      $a0, DP1($t0)
        li      $v0, 1
        syscall
        li      $a0, 32
        li      $v0, 11
        syscall
        addi    $t0, $t0, 4
        j       print_loop1

    end_print1:
        jr		$ra			

print_array2:
    add     $t0, $zero, $zero
    print_loop2:
        beq     $t0, 32, end_print2
        lw      $a0, DP2($t0)
        li      $v0, 1
        syscall
        li      $a0, 32
        li      $v0, 11
        syscall
        addi    $t0, $t0, 4
        j       print_loop2

    end_print2:
        jr		$ra			

