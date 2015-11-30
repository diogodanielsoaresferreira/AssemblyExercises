	.data
str1:	.asciiz "\nOperacao desconhecida"
str2:	.asciiz "\nNumero de argumentos errado"
num1:	.space 33
	.align 2
	.text
	.globl main
main:	
	# $t0 -> exit_code
	# $t1 -> val1
	# $t2 -> val2
	# $t3 -> res
	# $t4 -> op

if:	bne $a0,3,else
	lw $t1,0($a1)
	lw $t2,8($a1)
	
	lw $t4,4($a1)
	lb $t4,0($t4)
	
	addi $sp,$sp,-16
	sw $t0,12($sp)
	sw $t2,8($sp)
	sw $t4,4($sp)
	sw $ra,0($sp)
	move $a0,$t1
	jal atoi
	lw $ra,0($sp)
	lw $t4,4($sp)
	lw $t2,8($sp)
	lw $t0,12($sp)
	addi $sp,$sp,16
	move $t1,$v0
	
	addi $sp,$sp,-16
	sw $t0,12($sp)
	sw $t1,8($sp)
	sw $t4,4($sp)
	sw $ra,0($sp)
	move $a0,$t2
	jal atoi
	lw $ra,0($sp)
	lw $t4,4($sp)
	lw $t1,8($sp)
	lw $t0,12($sp)
	addi $sp,$sp,16
	move $t2,$v0
	
inif1:	bne $t4,'x',inelif2
	mul $t3,$t1,$t2
	j endif
inelif2:
	bne $t4,'/',inelif3
	div $t3,$t1,$t2
	j endif
inelif3:
	bne $t4,'%',inelse4
	rem $t3,$t1,$t2
	j endif
inelse4:
	la $a0,str1
	li $v0,4
	syscall
	li $t0,1
	j endif
else:	la $a0,str2
	li $v0,4
	syscall
	li $t0,2
	j endif
endif:	bne $t0,0,endif2
	addi $sp,$sp,-24
	sw $t3,20($sp)
	sw $t2,16($sp)
	sw $t1,12($sp)
	sw $t4,8($sp)
	sw $t0,4($sp)
	sw $ra,0($sp)
	move $a0,$t1
	li $a1,10
	jal print_int_ac1
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t4,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	addi $sp,$sp,24
	
	move $a0,$t4
	li $v0,11
	syscall
	
	addi $sp,$sp,-20
	sw $t3,16($sp)
	sw $t2,12($sp)
	sw $t4,8($sp)
	sw $t0,4($sp)
	sw $ra,0($sp)
	move $a0,$t2
	li $a1,10
	jal print_int_ac1
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t4,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	addi $sp,$sp,20
	
	li $a0,0x3D
	li $v0,11
	syscall
	
	addi $sp,$sp,-16
	sw $t3,12($sp)
	sw $t4,8($sp)
	sw $t0,4($sp)
	sw $ra,0($sp)
	move $a0,$t3
	li $a1,10
	jal print_int_ac1
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t4,8($sp)
	lw $t3,12($sp)
	addi $sp,$sp,16
	
endif2:	move $v0,$t0
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
ifas:	ble $a0,'9',endifas
	addi $a0,$a0,7
endifas:	move $v0,$a0
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

atoi:	
	li $t0,0
	li $t2,0
	li $t3,0
while:	lb $t1,0($a0)
	blt $t1,'0',endwhile
	bgt $t1,'9',endwhile
	sub $t2,$t1,'0'
	mul $t3,$t0,10
	add $t0,$t2,$t3
	addi $a0,$a0,1
	j while
endwhile:
	move $v0,$t0
	jr $ra
