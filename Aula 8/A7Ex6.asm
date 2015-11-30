	.data
str1:	.asciiz "Arquitetura de "
str2:	.space 50
	.align 2
str3:	.asciiz "Computadores"
	.text
	.globl main
main:	
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str2
	la $a1,str1
	jal strcpy
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	la $a0,str2
	la $a1,str3
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal strcat
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	move $a0,$v0
	li $v0,4
	syscall
	
	li $v0,0
	
	jr $ra


strcat:	
	move $t0,$a0
while:	lb $t1,0($t0)
	beq $t1,'\0',endwhile
	addi $t0,$t0,1
	j while
endwhile:
	addi $sp,$sp,-8
	sw $ra,4($sp)
	sw $a0,0($sp)
	move $a0,$t0
	jal strcpy
	lw $v0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra
	
strcpy:	
	move $t0,$a0
	move $t1,$a1
	lb $t2,0($t1)
do:	sb $t2,0($t0)
	addi $t0,$t0,1
	addi $t1,$t1,1
	lb $t2,0($t1)
	beq $t2,'\0',enddo
	j do
enddo:	move $v0,$a0
	jr $ra