## ASSIGNMENT - 1 : PRIME FACTORIZATION OF A NUMBER
##---------------------------------------------------------------------------
## TUHIN MONDAL(22CS10087)
## DIGANTA MANDAL(22CS30062) 
##---------------------------------------------------------------------------
## Takes in a positive integer n - num and prints out all of its prime factors
## Registers Used :
## $t0 for storing n
## $t1 for storing increment counter 
## $t2 for t1 * t1 for checking whether t2<=n or not
## $t3 for storing current value of n after each division whenever possible

.text
main:
    la $a0, msg1                         # Load address of msg1 into $a0
    li $v0, 4                            # Load syscall code for print string into $v0
    syscall                              # Perform syscall to print msg1
    li $v0, 5                            # Load syscall code for read integer into $v0
    syscall                              # Perform syscall to read user input
    move $t0, $v0                        # Move user input into $t0
    li $t1, 1                            # Initialize counter $t1 to 1
    move $t3, $t0                        # Move user input into $t3

loop1:
    addi $t1, $t1, 1                     # Increment counter $t1
    mul $t2, $t1, $t1                    # Square counter $t1 and store in $t2
    bgt $t2, $t0, label                  # If $t2 > $t0, jump to label
    div $t3 , $t1                        # Divide $t3 by $t1

    mfhi $t4                                     # Move remainder of division into $t4
    bne $t4, $zero, loop1                        # If remainder is not zero, go back to loop1

while:
    mflo $t3                         # Move quotient of division into $t3
    move $a0, $t1                    # Move counter $t1 into $a0
    li $v0, 1                        # Load syscall code for print integer into $v0
    syscall                          # Perform syscall to print $t1

    la $a0, msg2                     # Load address of msg2 into $a0
    li $v0, 4                        # Load syscall code for print string into $v0
    syscall                          # Perform syscall to print msg2

    div $t3 , $t1                    # Divide $t3 by $t1
    mfhi $t4                         # Move remainder of division into $t4
    bne $t4, $zero, loop1            # If remainder is not zero, go back to loop1
    b while                          # Go to while loop

label:

    beq $t3, 1, exit                 # If $t3 is zero, exit
    move $a0, $t3                    # Move $t3 into $a0
    li $v0, 1                        # Load syscall code for print integer into $v0
    syscall                          # Perform syscall to print $t3
    b exit                           # Go to exit

exit:                                # Exit the program
    li $v0, 10                       # Load syscall code for exit into $v0
    syscall                          # Perform syscall to exit program
   
.data
msg1:  .asciiz "Enter a positive integer: "                         
msg2:  .asciiz " "                       
