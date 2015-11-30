	.data
	.text
	.globl main
main:	
	li $a0,8
	li $a1,2
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal udiv
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

udiv:		
	# $t0 -> divisor
	# $t1 -> dividendo
	# $t2 -> quociente
	# $t3 -> resto
	# $t4 -> i
	# $t5 -> bit
	
	sll $t0,$a1,16
	andi $t1,$a0,0xFFFF
	sll $t1,$t1,1
	
	li $t4,0
for:	bge $t4,16,endfor
	li $t5,0
if:	blt $t1,$t0,endif
	sub $t1,$t1,$t0
	li $t5,1
endif:	sll $t1,$t1,1
	or $t1,$t1,$t5
	addi $t4,$t4,1
	j for
endfor:	
	srl $t3,$t1,1
	andi $t3,$t3,0xFFFF0000
	andi $t2,$t1,0xFFFF
	or $v0,$t3,$t2
	jr $ra