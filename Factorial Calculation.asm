##############    ###############
#								                #
#     Factorial Calculation		  #
# 	  Author: Rushabh Patel 	  #
#								                #
##############    ###############

#---- Features ----#
#1. Ask user for N (0 < N < 12)
#2. Calculate the factorial of N (N!)
#		- This is same as (N)(N-1)(N-2)...(1)
#		- Ex: 3! = (3)(2)(1)
#3. Output the factorial value

#---- Start Program ----#
.data
prompt_input: .asciiz "Please enter a number to calculate the factorial:\n"
prompt_output: .asciiz "The factorial of the input is:\n"
prompt_invalid: .asciiz "Please enter number between 0 and 12 (not inclusive)\n"
N: .word 0
index: .word 1
total: .word 1

.text
main:
input_value:
	la $a0, prompt_input
	li $v0, 4
	syscall

	li $v0, 5
	syscall

check_N:
	addi $t0, $zero, 0
	addi $t1, $zero, 12
	slt $a0, $v0, $t1
	beq $a0, $zero, N_restrictions
	sgt $a0, $v0, $t0
	beq $a0, $zero, N_restrictions
	sw $v0, N
	j calculate_factorial

N_restrictions:
	la $a0, prompt_invalid
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	j check_N

calculate_factorial:
	lw $t0, N
	lw $t1, index
	lw $a0, total
	addi $t0, $t0, 1

	loop:
		beq $t1, $t0, xloop

		mul $a0, $a0, $t1

		add $t1, $t1, 1
		j loop
	xloop:
	sw $a0, total

print:
	la $a0, prompt_output
	li $v0, 4
	syscall

	lw $a0, total
	li $v0, 1
	syscall

#---- End Program ----#
li $v0, 10
syscall
