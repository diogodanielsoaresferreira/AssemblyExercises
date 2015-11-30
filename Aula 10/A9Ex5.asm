	.data
	.text
	.globl main
main:	la $a0,5
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal fact
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $a0,$v0
	li $v0,1
	syscall
	jr $ra	
	
fact:	ble $a0,12,endif
	li $v0,1
	jr $ra
endif:	ble $a0,1,endif2
	addi $sp,$sp,-8
	sw $a0,4($sp)
	sw $ra,0($sp)
	
	addi $a0,$a0,-1
	jal fact
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	addi $sp,$sp,8
	
	mul $v0,$v0,$a0
	jr $ra
	
	
endif2:	li $v0,1
	jr $ra