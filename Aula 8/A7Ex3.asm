	.data
str1:	.asciiz " - "
	.text
	.globl main
main:	
	li $s0,0
	move $s1,$a0
	move $s2,$a1
whilem:	bge $s0,$s1,endwhilem
	li $v0,11
	li $a0,0x0A
	syscall
	li $v0,4
	sll $s3,$s0,2
	add $s3,$s3,$s2
	lw $s4,0($s3)
	move $a0,$s4
	syscall
	la $a0,str1
	li $v0,4
	syscall
	move $a0,$s4
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal strrev
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	move $a0,$v0
	li $v0,4
	syscall
	
	addi $s0,$s0,1
	j whilem

endwhilem:
	jr $ra
	

strrev:	
	move $v0,$a0
	move $t0,$a0
	move $t1,$a0
while1:	lb $t2,0($t1)
	beq $t2,'\0',endwhile1
	addiu $t1,$t1,1
	j while1
endwhile1:
	addiu $t1,$t1,-1
while2:	
	bge $t0,$t1,endwhile2
	addi $sp,$sp,-12
	sw $t0,8($sp)
	sw $t1,4($sp)
	sw $ra,0($sp)
	move $a0,$t0
	move $a1,$t1
	jal exchange
	lw $ra,0($sp)
	lw $t1,4($sp)
	lw $t0,8($sp)
	addi $sp,$sp,12
	addiu $t0,$t0,1
	addiu $t1,$t1,-1
	
	j while2
	
endwhile2:
	
	jr $ra

exchange:
	lb $t0,0($a0)
	lb $t1,0($a1)
	sb $t0,0($a1)
	sb $t1,0($a0)
	jr $ra