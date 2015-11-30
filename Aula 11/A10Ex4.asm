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
	jal max
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
max:	
	li $t0,0
	mtc1 $t0,$f0
maxfor:	bge $t0,$a1,maxendfor
	l.d $f2,0($a0)
	c.le.d $f2,$f0
maxif:	bc1t maxendif
	mov.d $f0,$f2
maxendif:
	addi $t0,$t0,8
	addi $t0,$t0,1
	j maxfor
maxendfor:
	jr $ra
	
