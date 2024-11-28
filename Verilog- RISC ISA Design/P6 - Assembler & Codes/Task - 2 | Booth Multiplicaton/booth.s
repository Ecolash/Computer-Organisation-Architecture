.data
a:      .int 5
b:      .int 4

.text
main: 
    li $1, 5
    li $2, 4
    move $3, $0
    move $4, $0
    li $5, 32

multiply_booth:
    andi $6, $2, 1
    xor $7, $6, $4
    bz $7, shift_right

case:
    bz $6, case_01
    br case_10

case_01:
    add $3, $3, $1
    br shift_right

case_10:
    sub $3, $3, $1
    br shift_right

shift_right:
    andi $4, $2, 1
    srli $2, $2, 1
    slli $6, $3, 31
    or $2, $2, $6
    srai $3, $3, 1
    dec $5

bz $5, end
    br multiply_booth

end:
    halt


