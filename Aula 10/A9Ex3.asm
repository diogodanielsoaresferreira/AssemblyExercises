	.data
arr:	.word 1,2,3,4,5,6
	.text
	.globl main
main:	
	la $a0,arr
	li $a1,6
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal soma
	
	move $a0,$v0
	li $v0,1
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
soma:	beq $a1,0,end
	lw $t0,0($a0)
	addi $sp,$sp,-8
	sw $t0,4($sp)
	sw $ra,0($sp)
	
	addi $a0,$a0,4
	addi $a1,$a1,-1
	jal soma
	
	lw $t0,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,8
	
	add $v0,$v0,$t0
	jr $ra
	
end:	li $v0,0
	jr $ra