	.data
s1:	.asciiz "Copiar string"
s2:	.space 80
	.text
	.globl main
main:	
	la $a0,s2
	la $a1,s1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal strcpy
	
	move $a0,$v0
	li $v0,4
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
strcpy:	lb $t0,0($a1)
	sb $t0,0($a0)
	beq $t0,'\0',endif
	addi $sp,$sp,-8
	sw $a0,4($sp)
	sw $ra,0($sp)
	addi $a0,$a0,1
	addi $a1,$a1,1
	jal strcpy
	lw $a0,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,8
	
endif:	move $v0,$a0
	jr $ra