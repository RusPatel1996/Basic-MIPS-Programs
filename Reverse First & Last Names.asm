##############    ###############
#								                #
#   Reverse First & Last Names	#
# 	  Author: Rushabh Patel 	  #
#								                #
##############    ###############

#---- Features ----#
#1. Prompt User for name
#2. Get length of string
#3. Loop in reverse to get reverse first name and reverse last name
#5. Print reversed first name and last name

#---- Start Program ----#
.data
    full_name: .space 100
	first_name: .space 50
	last_name: .space 50
    prompt_name: .asciiz "@Enter your name@\n"
	prompt_reverse_name:.asciiz "\n@Your name reversed@\n"
	prompt_space: .asciiz " "

.text
main:
la $a1, full_name				#$a1 = address of array

input_name:
    la $a0, prompt_name
    li $v0, 4
    syscall

	la $a0, full_name
    li $v0, 8
	syscall

jal full_name_length

reverse_first_and_last_name:
	addi $t0, $0, 1					#bool value
	lbu $t1, prompt_space
	addi $t2, $0, 0					#last_name index
	addi $t3, $0, 0					#first_name index
	loop:
		bltz $a2, xloop

		lbu $a1, full_name($a2)		#retrieve charater

		beq $t0, $0, else			#if bool == 0 else
			beq $a1, $t1, bool_zero		#if char == " "
				j bool_not_zero
				bool_zero:
					addi $t0, $0, 0
					sub $a2, $a2, 1
					j loop
				bool_not_zero:
					sb $a1, last_name($t2)
					addi $t2, $t2, 1
					j endif

		else:
			sb $a1, first_name($t3)
			addi $t3, $t3, 1

		endif:
		sub $a2, $a2, 1
		j loop
	xloop:

la $a0, prompt_reverse_name
li $v0, 4
syscall

show_reverse_first_name:
	add $a2, $0, 0
	add $t1, $0, 0
	la $a1, first_name
	jal first_name_size
	add $t1, $0, 0

	output_first_name:
		beq $t1, $a2, xoutput_first_name

		lbu $a0, first_name($t1)
		li $v0, 11
		syscall

		addi $t1, $t1, 1
		j output_first_name
	xoutput_first_name:

la $a0, prompt_space
li $v0, 4
syscall

show_reverse_last_name:
	add $a2, $0, 0
	add $t1, $0, 0
	la $a1, last_name
	jal last_name_size
	add $t1, $0, 0

	output_last_name:
		beq $t1, $a2, xoutput_last_name

		lbu $a0, last_name($t1)
		li $v0, 11
		syscall

		addi $t1, $t1, 1
		j output_last_name
	xoutput_last_name:

#---- End Program ----#
end_program:
	li $v0, 10
	syscall

#---- Functions ----#
full_name_length:
	move $t0, $a1
	loop1:
		lb $t1, 2($t0)
		beq $t1, $zero, xloop1

		addi $t0, $t0, 1

		j loop1
	xloop1:
	la $t1, full_name
	sub $t3, $t0, $t1
	move $a2, $t3
	j $ra

last_name_size:
	move $t0, $a1
	loop2:
		lb $t1, 1($t0)
		beq $t1, $zero, xloop2

		addi $t0, $t0, 1

		j loop2
	xloop2:
	la $t1, last_name
	sub $t3, $t0, $t1
	move $a2, $t3
	addi $a2, $a2, 1
	j $ra

first_name_size:
	move $t0, $a1
	loop3:
		lb $t1, 1($t0)
		beq $t1, $zero, xloop3

		addi $t0, $t0, 1

		j loop3
	xloop3:
	la $t1, first_name
	sub $t3, $t0, $t1
	move $a2, $t3
	addi $a2, $a2, 1
	j $ra
