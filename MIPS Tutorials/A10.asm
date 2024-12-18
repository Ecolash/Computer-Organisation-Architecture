.data
prompt1: .asciiz "Enter the sequence index\n"
prompt2: .asciiz "The Fibonacci value is:\n"
message: .asciiz "The Fibonacci value is:\n0"

.text
main: 
li $v0, 4
la $a0, prompt1
syscall

li $v0, 5
syscall

beq $v0, 0, equalToZero

move $a0, $v0
jal fibonacci
move $a1, $v0

li $v0, 4
la $a0, prompt2
syscall

li $v0, 1
move $a0, $a1
syscall
li $v0, 10
syscall

fibonacci:
addi $sp, $sp, -12
sw $ra, 8($sp)
sw $s0, 4($sp)
sw $s1, 0($sp)
move $s0, $a0

li $v0, 1 
ble $s0, 2, fib_return 
addi $a0, $s0, -1 # set args for recursive call to f(n-1)
jal fibonacci
move $s1, $v0 # store result of f(n-1) to s1
addi $a0, $s0, -2 # set args for recursive call to f(n-2)
jal fibonacci
add $v0, $s1, $v0 # add result of f(n-1) to it

fib_return:
lw $ra, 8($sp)
lw $s0, 4($sp)
lw $s1, 0($sp)
addi $sp, $sp, 12
jr $ra

equalToZero:
li $v0, 4
la $a0, message
syscall