	.data
str1:	.asciiz "10101100, o ano do fim das PPP"
	.text
	.globl main
	
main:	
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str1
	jal atoi
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $a0,$v0
	li $v0,1
	syscall
	
	jr $ra



atoi:	
	li $t0,0
while:	lb $t1,0($a0)
	blt $t1,'0',endwhile
	bgt $t1,'1',endwhile
	sub $t2,$t1,'0'
	mul $t3,$t0,10
	add $t0,$t2,$t3
	addi $a0,$a0,1
	j while
endwhile:
	move $v0,$t0
	jr $ra
