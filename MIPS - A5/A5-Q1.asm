## GROUP-26 
#---------------------------------------------------------------
##  TUHIN MONDAL(22CS10087)
##  DIGANTA MANDAL(22CS30062)
#---------------------------------------------------------------

.data
buffer: .space 100          
in1:    .asciiz "Enter a string: "
out:    .asciiz "Reversed string: "

.text
main:
    li  $v0, 4              
    la  $a0, in1          
    syscall

    li  $v0, 8               
    la  $a0, buffer          
    li  $a1, 100             
    syscall

    la  $t0, buffer          
    li  $t1, 0               

#---------------------------------------------------------------
# PUSH THE STRING INTO THE STACK
#---------------------------------------------------------------
push_loop:
    lb  $t2, 0($t0)          
    beq $t2, 10, done_push    
    sb  $t2, 0($sp)          
    add $sp, $sp, -1       
    add $t0, $t0, 1        
    j push_loop

    done_push:
    add $sp, $sp, 1       
    la  $t0, buffer         

#---------------------------------------------------------------
# POP THE CHARACTERS IN THE STACK TO REVERSE STRING
#---------------------------------------------------------------
pop_loop:
    lb  $t2, 0($sp)          
    sb  $t2, 0($t0)          
    beq $t2, 0, done_pop      
    add $sp, $sp, 1        
    add $t0, $t0, 1       
    j pop_loop

done_pop:
    li  $v0, 4               
    la  $a0, out  
    syscall

    li  $v0, 4               
    la  $a0, buffer          
    syscall

    li  $v0, 10              
    syscall
