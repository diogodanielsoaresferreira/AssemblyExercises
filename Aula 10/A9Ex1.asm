	.data
s:	.asciiz "10 espaços"
	.text
	.globl main
main:	
	la $a0,s
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal strlen
	
	move $a0,$v0
	li $v0,1
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra



strlen:	lb $t0,0($a0)
	beq $t0,'\0',else
	addi $sp,$sp,-4
	sw $ra,0($sp)
	addi $a0,$a0,1
	
	jal strlen
	
	addi $v0,$v0,1
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
else:	li $v0,0
	jr $ra