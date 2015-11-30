	.eqv TRUE,1
	.eqv FALSE,0
	.eqv SIZE,10
	.data
array:	.space 80
	.text
	.globl main
main:	
	li $t0,0
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t3,array
for:	bge $t0,SIZE,endfor
	li $v0,7
	syscall
	
	s.d $f0,0($t3)
	addi $t3,$t3,8
	
	addi $t0,$t0,1
	j for
	

endfor:	
	la $a0,array
	la $a1,SIZE
	jal sort
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	li $t0,0
	la $t3,array
for2:	bge $t0,SIZE,endfor2
	
	l.d $f12,0($t3)
	li $v0,3
	syscall
	
	addi $t3,$t3,8
	addi $t0,$t0,1
	j for2
endfor2:
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
sort:	
sortdo:	
	li $t0,FALSE
	li $t1,0
sortfor:
	move $t2,$a1
	addi $t2,$t2,-1
	bge $t1,$t2,endsortfor
	sll $t5,$t1,3
	add $t5,$t5,$a0
	l.d $f4,0($t5)
	l.d $f6,8($t5)
sortif:	c.lt.d $f6,$f4
	bc1f endsortif
	s.d $f6,0($t5)
	s.d $f4,8($t5)
	li $t0,TRUE
	
endsortif:
	addi $t1,$t1,1
	j sortfor
endsortfor:
	bne $t0,TRUE,endsortdo
	j sortdo
endsortdo:
	li $t1,2
	div $t0,$a1,$t1
	sll $t0,$t0,3
	add $t0,$t0,$a0
	l.d $f0,0($t0)
	jr $ra