.data
a:      .int 139
b:      .int 13

.text
    li $1, 139
    li $2, 13
    move $3, $0
    li $4, 32

non_restoring_loop:
    bpl $3 sub_case
    br add_case

sub_case:
    slli $3, $3, 1
    srli $5, $1, 31
    or $3, $3, $5
    slli $1, $1, 1
    sub $3, $3, $2
    br choose_q

add_case:
    slli $3, $3, 1
    srli $5, $1, 31
    or $3, $3, $5
    slli $1, $1, 1
    add $3, $3, $2
    br choose_q


choose_q:
    bpl $3, setqto1
    br deccount

setqto1:
    ori $1, $1, 1

deccount:
    subi $4, $4, 1
    bz $4, loop_end
    br non_restoring_loop

loop_end:
    bpl $3, exit
    add $3, $3, $2

exit:
    halt
