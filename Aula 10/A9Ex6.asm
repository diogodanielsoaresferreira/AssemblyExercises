	.data
	.text
	.globl main
main:	la $a0,2
	la $a1,5
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal xtoy
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $a0,$v0
	li $v0,1
	syscall
	jr $ra	

xtoy:	beq $a1,0,endif
	addi $sp,$sp,-8
	sw $a0,4($sp)
	sw $ra,0($sp)
	
	addi $a1,$a1,-1
	jal xtoy
	
	lw $a0,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,8
	mul $v0,$v0,$a0
	jr $ra
	
endif:	li $v0,1
	jr $ra