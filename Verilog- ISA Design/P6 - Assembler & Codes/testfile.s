.data
num1:  .int 36 # First number
num2:  .int 60 # Second number
res: .int 0 # result

.text
ld $1 num1 # Load num1 into Register 1
ld $2 num2 # Load num2 into Register 2

gcd_loop:
    li $5, 200
    lui $4, 31
    addi $4, $5, 20
    subi $4, $5, -10
    slli $4, $5, 2
    andi $4, $5, 15
    ori $4, $5, -8
    srli $4, $5, 1
    srai $4, $5, 3
    xori $4, $5, 7
    nori $4, $5, 12
    
    add $1, $2, $3
    sub $3, $1, $2
    not $4, $5
    sll $1, $2, $3
    and $1, $2, $3
    or  $1, $2, $3
    srl $1, $2, $3
    sra $1, $2, $3
    xor $1, $4, $6
    nor $1, $2, $3
    inc $4
    dec $4
    slt $1, $2, $3
    sgt $1, $1, $2
    ham $4, $5

    bpl $4, gcd_loop
    bmi $5, less_than
    bz  $6, gcd_loop
    br gcd_loop
    br less_than
    halt
    nop

    ld $1, 3($2)
    st $1, 3($2)
    ld $5, 63
    st $5, 127

    la $4, num1
    la $6, num2

    move $3, $2
    cmov $3, $4, $5
    jal gcd_loop

    sub $c $1 $2 
    bz $c end

    sgt $c $1 $2
    bz $c less_than
    sub $1 $1 $2
    br gcd_loop

less_than:
    sub $2 $2 $1
    br gcd_loop

end:
    st $1 res
    ld $d res
    halt