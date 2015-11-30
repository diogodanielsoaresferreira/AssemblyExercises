	.data
str1:	.asciiz " - "
	.text
	.globl main
main:	li $s0,0
	move $s1,$a0
	move $s2,$a1
for:	bge $s0,$s1,endfor
	li $v0,11
	li $a0,0x0A
	syscall
	li $v0,4
	sll $s3,$s0,2
	addu $s3,$s3,$s2
	lw $s4,0($s3)
	move $a0,$s4
	syscall
	la $a0,str1
	li $v0,4
	syscall
	move $a0,$s4
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal strlen
	move $a0,$v0
	lw $ra,0($sp)
	addi $sp,$sp,4
	li $v0,1
	syscall
	addi $s0,$s0,1
	j for
endfor:	
	jr $ra


strlen:	li $t4,0
	move $t1,$a0
while:	lb $t2,0($t1)
	beq $t2,'\0',endwhile
	addi $t1,$t1,1
	addi $t4,$t4,1
	j while
endwhile:
	move $v0,$t4
	jr $ra