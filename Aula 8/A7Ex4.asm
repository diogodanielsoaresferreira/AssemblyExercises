	.data
	.eqv STR_MAX_SIZE,10
str1:	.asciiz "String too long. Nothing done!\n"
buf:	.space 11
	.text
	.globl main
main:	
if1:	bne $a0,1,endif1
	move $s0,$a0
	move $s1,$a1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	lw $a0,0($s1)
	jal strlen
	lw $ra,0($sp)
	addi $sp,$sp,4
if:	bgt $v0,STR_MAX_SIZE,else
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,buf
	lw $a1,0($s1)
	jal strcpy
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $a0,$v0
	li $v0,4
	syscall
	j endif1
else:	la $a0,str1
	li $v0,4
	syscall
	li $v0,1
	jr $ra
endif1:	li $v0,0
	jr $ra

strcpy:	
	li $t0,0
	add $t2,$t0,$a0
	add $t3,$t0,$a1
	lb $t4,0($t3)
do:	
	sb $t4,0($t2)
	addi $t0,$t0,1
	add $t2,$t0,$a0
	add $t3,$t0,$a1
	lb $t4,0($t3)
	beq $t4,'\0',while
	j do
while:	move $v0,$a0
	jr $ra


strlen:	li $v0,0
	move $t1,$a0
while2:	lb $t2,0($t1)
	beq $t2,'\0',endwhile
	addi $t1,$t1,1
	addi $v0,$v0,1
	j while2
endwhile:
	jr $ra