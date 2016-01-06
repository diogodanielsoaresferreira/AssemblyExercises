	.eqv FALSE,0
	.eqv TRUE,1
	.data
array:	.space 88
num1:	.double 0.5
strmax:	.asciiz "\nMáximo: "
strmediana:	.asciiz "\nMediana: "
strmedia:	.asciiz "\nMédia: "
strvar:	.asciiz "\nVariância: "
strdes:	.asciiz "\nDesvio-padrão: "
	.text
	.globl main

# Desvio-padrão mal calculado

main:	
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	li $s0,0
	li $s1,11
	la $s2,array
mainfor:bge $s0,$s1,mainendfor
	
	li $v0,7
	syscall
	
	mov.d $f12,$f0
	jal f2c
	
	sll $t3,$s0,3
	add $t3,$t3,$s2
	
	s.d $f0,0($t3)
	
	addi $s0,$s0,1
	j mainfor
mainendfor:
	
	la $a0,array
	li $a1,11
	jal sort
	
	li $s0,0
	li $s1,11
mainfor2:
	bge $s0,$s1,endmainfor2
	l.d $f12,0($s2)
	
	li $v0,3
	syscall
	
	addi $s2,$s2,8
	
	addi $s0,$s0,1
	j mainfor2
endmainfor2:
	
	li $v0,4
	la $a0,strmax
	syscall
	
	la $a0,array
	li $a1,11
	jal max
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	li $v0,4
	la $a0,strmedia
	syscall
	
	la $a0,array
	la $a1,11
	jal average
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	li $v0,4
	la $a0,strmediana
	syscall
	
	
	li $t0,11
	div $t0,$t0,2
	
	sll $t0,$t0,3
	la $t1,array
	add $t0,$t1,$t0
	l.d $f12,($t0)
	li $v0,3
	syscall
	
	li $v0,4
	la $a0,strvar
	syscall
	
	la $a0,array
	li $a1,11
	jal var
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	la $a0,strdes
	li $v0,4
	syscall
	
	la $a0,array
	li $a1,11
	jal stdev
	
	mov.d $f12,$f0
	li $v0,3
	syscall
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addi $sp,$sp,16
	jr $ra

f2c:	li $t0,5
	li $t1,9
	li $t2,32
	mtc1 $t0,$f6
	mtc1 $t1,$f2
	mtc1 $t2,$f4
	
	cvt.d.w $f6,$f6
	cvt.d.w $f2,$f2
	cvt.d.w $f4,$f4
	
	div.d $f6,$f6,$f2
	sub.d $f2,$f12,$f4
	mul.d $f0,$f2,$f6
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
	addi $a0,$a0,8
	addi $t0,$t0,1
	j maxfor
maxendfor:
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



stdev:	addi $sp,$sp,-8
	sw $ra,0($sp)
	
	jal var
	
	mov.d $f12,$f0
	
	jal sqrt
	
	lw $ra,0($sp)
	addi $sp,$sp,8
	jr $ra
	
var:	addi $sp,$sp,-52
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,16($sp)
	s.d $f20,8($sp)
	sw $s0,20($sp)
	sw $s1,24($sp)
	sw $s2,28($sp)
	s.d $f22,32($sp)
	s.d $f24,40($sp)
	
	lw $a1,16($sp)
	lw $a0,4($sp)
	
	mov.d $f20,$f0
	li $s0,0
	mtc1 $s0,$f24
	cvt.d.w $f24,$f24
varfor:	bge $s0,$a1,endvarfor
	lw $a1,16($sp)
	lw $a0,4($sp)
	
	sll $s2,$s0,3
	add $s2,$s2,$a0
	
	l.d $f22,0($s2)
	sub.d $f22,$f22,$f20
	mov.d $f12,$f22
	li $a0,2
	
	jal xtoy
	
	add.d $f24,$f24,$f0
	
	addi $s0,$s0,1
	j varfor
endvarfor:
	lw $a1,16($sp)
	mtc1 $a1,$f22
	cvt.d.w $f22,$f22
	div.d $f0,$f24,$f22
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,16($sp)
	l.d $f20,8($sp)
	lw $s0,20($sp)
	lw $s1,24($sp)
	lw $s2,28($sp)
	l.d $f22,32($sp)
	l.d $f24,40($sp)
	addi $sp,$sp,52
	jr $ra
	
average:
	li $t0,0
	mtc1 $t0,$f6
	cvt.d.w $f6,$f6
avfor2:	bge $t0,$a1,avendfor2
	l.d $f4,0($a0)
	
	add.d $f6,$f4,$f6
	
	addi $a0,$a0,8
	addi $t0,$t0,1
	j avfor2
avendfor2:	
	mtc1 $a1,$f2
	cvt.d.w $f2,$f2
	div.d $f0,$f6,$f2
	jr $ra



sqrt:	li $t0,1
	mtc1 $t0,$f4
	cvt.d.w $f4,$f4
	subi $t0,$t0,1
	mtc1 $t0,$f6
	
	c.le.d $f12,$f6
	bc1f sqrtdo
	mov.d $f0,$f6
	jr $ra
sqrtdo:	mov.d $f6,$f4
	div.d $f8,$f12,$f4
	add.d $f8,$f8,$f4
	l.d $f10,num1
	mul.d $f4,$f10,$f8
	addi $t0,$t0,1
	bge $t0,25,sqrtenddo
	c.eq.d $f4,$f6
	bc1t sqrtenddo
	
	j sqrtdo
sqrtenddo:
	mov.d $f0,$f4
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
