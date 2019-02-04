##############    ###############
#								                #
#      Integer Calculation		  #
# 	  Author: Rushabh Patel   	#
#							 	                #
##############    ###############

#---- Features ----#
#1. Prompt user for first operand
#2. Prompt user for second operand
#3. Output the results of addition, subtraction, multiplication, and division, respectively
#		e.g. "The addition result is: "

#---- Start Program ----#
.data
prompt_first_operand: .asciiz "Please enter the first operand: \n"
prompt_second_operand: .asciiz "Please enter the second operand: \n"
prompt_addition: .asciiz "The addition is: "
prompt_subtraction: .asciiz "The subtraction is: "
prompt_multiplication: .asciiz "The multiplication is: "
prompt_division: .asciiz "The division is: "
prompt_line: .asciiz "\n"
first_operand: .word 0
second_operand: .word 0

.text
main:
get_first_integer:
	la $a0, prompt_first_operand
	li $v0, 4
	syscall

	la $a0, first_operand
	li $v0, 6							#$v0, 6 reads input as floating-point
	syscall

	s.s $f0, first_operand

get_second_integer:
	la $a0, prompt_second_operand
	li $v0, 4
	syscall

	la $a0, second_operand
	li $v0, 6
	syscall

	s.s $f0, second_operand

show_addition:
	la $a0, prompt_addition
	li $v0, 4
	syscall

	l.s $f12, first_operand				#load value of first_operand into $a0
	l.s $f0, second_operand
	add.s $f12, $f12, $f0
	li $v0, 2							#print value as floating-point
	syscall

	la $a0, prompt_line
	li $v0, 4
	syscall

show_subtraction:
	la $a0, prompt_subtraction
	li $v0, 4
	syscall

	l.s $f12, first_operand
	l.s $f0, second_operand
	sub.s $f12, $f12, $f0
	li $v0, 2
	syscall

	la $a0, prompt_line
	li $v0, 4
	syscall

show_multiplication:
	la $a0, prompt_multiplication
	li $v0, 4
	syscall

	l.s $f12, first_operand
	l.s $f0, second_operand
	mul.s $f12, $f12, $f0
	li $v0, 2
	syscall

	la $a0, prompt_line
	li $v0, 4
	syscall

show_division:
	la $a0, prompt_division
	li $v0, 4
	syscall

	l.s $f12, first_operand
	l.s $f0, second_operand
	div.s $f12, $f12, $f0
	li $v0, 2
	syscall

	la $a0, prompt_line
	li $v0, 4
	syscall

#-- Exit --#
li $v0, 10
syscall
#---- End of Program ----#
