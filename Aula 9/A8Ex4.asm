	.data
num1:	.space 33
	.align 2
	
	.text
	.globl main
main:	li $a0,10
	li $a1,2
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	jal print_int_ac1
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	li $a0,10
	li $a1,8
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	jal print_int_ac1
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	li $a0,10
	li $a1,16
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	jal print_int_ac1
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra


print_int_ac1:
	la $a2,num1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal itoa
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $v0,$a0
	li $v0,4
	syscall
	jr $ra

itoa:	
	# $t0 -> *p
	move $t4,$a2
	move $t0,$a2
do:	rem $t1,$a0,$a1
	divu $a0,$a0,$a1
	
	addi $sp,$sp,-20
	sw $t4,16($sp)
	sw $t0,12($sp)
	sw $t1,8($sp)
	sw $a0,4($sp)
	sw $ra,0($sp)
	
	move $a0,$t1
	jal toascii
	
	lw $t4,16($sp)
	lw $t0,12($sp)
	lw $t1,8($sp)
	lw $a0,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,20
	
	sb $v0,0($t0)
	addi $t0,$t0,1
	ble $a0,0,enddo
	j do
enddo:	li $t2,'\0'
	sb $t2,0($t0)
	move $a0,$t4
	
	addi $sp,$sp,-8
	sw $t4,4($sp)
	sw $ra,0($sp)
	jal strrev
	lw $t4,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,8
	
	move $v0,$t4
	jr $ra
	
	
toascii:
	addi $a0,$a0,'0'
if:	ble $a0,'9',endif
	addi $a0,$a0,7
endif:	move $v0,$a0
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
