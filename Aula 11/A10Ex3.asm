	.data
array:	.space 88
	.text
	.globl main
main:	li $t0,0
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t3,array
for:	bge $t0,11,endfor
	li $v0,7
	syscall
	
	s.d $f0,0($t3)
	addi $t3,$t3,8
	
	addi $t0,$t0,1
	j for
	

endfor:	
	la $a0,array
	la $a1,11
	jal average
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
average:
	li $t0,0
	mtc1 $t0,$f6
for2:	bge $t0,$a1,endfor2
	l.d $f4,0($a0)
	
	add.d $f6,$f4,$f6
	
	addi $a0,$a0,8
	addi $t0,$t0,1
	j for2
endfor2:	
	mtc1 $a1,$f2
	cvt.d.w $f2,$f2
	div.d $f0,$f6,$f2
	jr $ra