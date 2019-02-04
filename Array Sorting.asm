##############    ###############
#								                #
#      	  Array Sorting 		    #
# 	  Author: Rushabh Patel 	  #
#								                #
##############    ###############

#---- Features ----#
#Prompt size of list
#Prompt integers for the array
#sort array
#Display sorted array
#Display max (last value in sorted array)

.data
prompt_size: .asciiz "please enter the size of the array:\n"
prompt_input: .asciiz "please enter a integer:\n"
prompt_sorted_array: .asciiz "your array sorted is:\n"
prompt_max: .asciiz "The maximum element is: \n"
prompt_space: .asciiz " "
prompt_line: .asciiz "\n"
array_size: .word 0
array: .space 100

.text
main:
la $t0, array

input_size:
	la $a0, prompt_size
	li $v0, 4
	syscall

	li $v0, 5
	syscall

	sw $v0, array_size

input_array_elements:
	lw $t1, array_size
	addi $a1, $zero, 0
	loop1:
		beq  $a1, $t1, xloop1

		la $a0, prompt_input
		li $v0, 4
		syscall

		li $v0, 5
		syscall

		add $t3, $t0, $t2
		sw $v0, ($t3)
		addi $t2, $t2, 4

		addi $a1, $a1, 1
		j loop1
	xloop1:

jal sort_array

output_array_elements:
	lw $t1, array_size
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	addi $t6, $zero, 0
	output_loop:
		beq $t1, $zero, exit_output_loop

		add $t4, $t0, $t3			#$t4 = offset + array address
		lw $a0, ($t4)				#load index element into $a0
		li $v0, 1
		syscall

		la $a0, prompt_space
		li $v0, 4
		syscall

		addi $t3, $t3, 4			#increase offset by 4 bytes

		subu $t1, $t1, 1			#size = size - 1
		j output_loop				#jump back to start of the loop
	exit_output_loop:
	la $a0, prompt_line
	li $v0, 4
	syscall

jal output_max

end_program:
	li $v0, 10
	syscall

sort_array:
	la $a0, prompt_sorted_array
	li $v0, 4
	syscall
	lw $t1, array_size
	addi $t2, $zero, 0
	addi $a1, $zero, 0					#i = 0
	loop2:
		beq $a1, $t1, xloop2			#until i = size
		add $t3, $t0, $t2				#address + offset for array[i]

		addi $a2, $zero, 0				#j = 0
		addi $t4, $zero, 0
		loop3:
			beq $a2, $a1, xloop3		#until j = i
			add $t5, $t0, $t4			#address + offset for array[j]

										#i($t3), j(t5) are used for array access
			lw $t6, ($t3)				#$t6 = array[i]
			lw $t7,	($t5)				#$t7 = array[j]

			sgt $t8, $t7, $t6			#if a[j] > a[i]
			beq $t8, $zero, endif1
				move $t9, $t7			#temp = a[j]
				sw $t6, ($t5)			#a[j] = a[i]
				sw $t9, ($t3)			#a[i] = temp
			endif1:

			addi $t4, $t4, 4
			addi $a2, $a2, 1			#j++
			j loop3
		xloop3:

		addi $t2, $t2, 4
		addi $a1, $a1, 1				#i++
		j loop2
	xloop2:
	j $ra

output_max:
	la $a0, prompt_max
	li $v0, 4
	syscall
	lw $a0, ($t4)
	li $v0, 1
	syscall
	j $ra
