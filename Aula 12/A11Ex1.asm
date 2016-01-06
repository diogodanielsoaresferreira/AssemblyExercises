	.data
	.text
	.globl main
main:	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	li $t0,2
	mtc1 $t0,$f12
	cvt.d.w $f12,$f12
	li $a0,3
	jal xtoy
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
xtoy:	addi $sp,$sp,-32
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	s.d $f20,16($sp)
	sw $a0,12($sp)
	s.d $f12,24($sp)
	
	li $s0,1
	mtc1 $s0,$f20
	cvt.d.w $f20,$f20
	addi $s0,$s0,-1
	
xtoyfor:jal fabs
	lw $a0,12($sp)
	mtc1 $s0,$f4
	bge $s0,$v0,xtoyendfor
	ble $a0,$zero,xtoyelse
	mul.d $f20,$f20,$f12
	j xtoyendif
xtoyelse:
	div.d $f20,$f20,$f12
xtoyendif:
	addi $s0,$s0,1
	j xtoyfor
xtoyendfor:
	mov.d $f0,$f20
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	l.d $f20,16($sp)
	addi $sp,$sp,32
	jr $ra



fabs:	bge $a0,0,absendif
	mul $t0,$a0,-1
	or $a0,$0,$t0
absendif:
	move $v0,$a0
	jr $ra
