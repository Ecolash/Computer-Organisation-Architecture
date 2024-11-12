.data
num1:  .int 36 

.text
main:
    li $2, 5
    li $3, 8
    cmov $1, $2, $3
    ham $A, $1
    halt