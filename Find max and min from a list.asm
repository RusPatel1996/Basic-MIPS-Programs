##############    ###############
#								                #
# Find max and min from a list	#
# Author: Rushabh Patel			    #
#								                #
##############    ###############

#---- Features ----#
#Prompt size of list
#Prompt integers for the list
#Display list
#Display max
#Display min


#---- Program ----#
.data								#Data declaration for declaring variable names used in the program
prompt_size: .asciiz "Please declare a size for the array:\n"
prompt_input: .asciiz "Please enter a element:\n"
prompt_output: .asciiz "The element(s) in the array is/are:\n"
prompt_space: .asciiz " "
prompt_line: .asciiz "\n"
prompt_max: .asciiz "The maximum in the array is: "
prompt_min: .asciiz "The minimum in the array is: "
ray_size: .word 0
array: .space 100

.text								#Contains program code (instructions)
main:								#starting point for code
	#-- Prompt for size --#
	la $a0, prompt_size
	li $v0, 4
	syscall

	#-- Store size --#
	li $v0, 5						#load syscall read_int into $v0.
	syscall

	la $t0, array					#load the address of array into $t0
	move $t1, $v0					#copy size into $t1
	move $t2, $v0					#copy size into $t2

	#-- Input array elements --#
	input_loop:
		beq $t1, 0, exit_input_loop	#if size == 0 then exit the loop

		#-- Prompt for input --#
		la $a0, prompt_input
		li $v0, 4
		syscall

		#-- Store input --#
		li $v0, 5
		syscall

		add $t4, $t0, $t3			#add offset (value of $t3) to address of array
		sw $v0, ($t4)				#stores the integer to the beginning address of the array
		addi $t3, $t3, 4			#add 4 bits to the offset

		subu $t1, $t1, 1			#size = size - 1
		j input_loop				#jump back to stxart of the loop
	exit_input_loop:

	#-- Prompt output message --#
	la $a0, prompt_output
	li $v0, 4
	syscall

	#-- Output array elements --#
	addi $t1, $zero, 0				#intialize $t1
	lw $a0, 0($t0)
	add $t1, $zero, $a0  			#add the first element of the array to $t1
	addi $t3, $zero, 0
	addi $t6, $zero, 0
	output_loop:
		#if size = 0 then exit loop
		beq $t2, $zero, exit_output_loop

		add $t4, $t0, $t3			#$t4 = offset + array address
		lw $a0, ($t4)				#load index element into $a0
		li $v0, 1
		syscall

		la $a0, prompt_space
		li $v0, 4
		syscall

		#-- Find Max --#
		lw $a0, ($t4)				#load index element into $a0
		slt $t7, $t6, $a0			#if current maximum is less than element: ($t7 is a bool value)
		beq $t7, $zero, else		#if bool value of $t7 == 0 then go to else
			move $t6, $a0				#make new element the maximum
		j endif						#jump to endif
		else:
		#-- Find Min --#
			slt $t8, $a0, $t1		#if element is less than current minimum:
			beq $t8, $zero, endif
				move $t1, $a0		#make new element to minimum
		endif:


		addi $t3, $t3, 4			#increase offset by 4 bytes

		subu $t2, $t2, 1			#size = size - 1
		j output_loop				#jump back to start of the loop
	exit_output_loop:

	la $a0, prompt_line
	li $v0, 4
	syscall

	#-- Print max --#
	la $a0, prompt_max
	li $v0, 4
	syscall
	la $a0, ($t6)					#load the value at address of $t6 into $a0
	li $v0, 1
	syscall

	la $a0, prompt_line
	li $v0, 4
	syscall

	#-- Print min --#
	la $a0, prompt_min
	li $v0, 4
	syscall
	la $a0, ($t1)
	li $v0, 1
	syscall

	#-- Exit --#
	li $v0, 10
	syscall
	#-- End of program --#
