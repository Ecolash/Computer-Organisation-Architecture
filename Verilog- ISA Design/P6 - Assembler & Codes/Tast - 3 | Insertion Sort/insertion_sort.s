.data
array:  .arr {5, 2, 9, 3, 6}
n:      .int 5

.text
main:
    LD $1, n($0)
    ADDI $2, $0, 1
    BR check_i

outer_loop:
    LD $3, array($2)
    SUBI $4, $2, 1

inner_loop:
    LD $5, array($4)
    SLT $6, $3, $5
    BZ $6, insert

    INC $4
    ST $5, array($4)
    SUBI $4, $4, 2
    BMI $4, insert
    BR inner_loop

insert:
    INC $4
    ST $3, array($4)
    DEC $4
    INC $2

check_i:
    SLT $6, $2, $1
    BZ $6, end
    BR outer_loop

end:
    HALT
