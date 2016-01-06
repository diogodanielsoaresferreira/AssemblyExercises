	.eqv MAX_STUDENTS,4
	.data
	.align 2
# Alinhamento de Student
#student:
#	.space 4
#	.space 18
#	.space 15
#	.space 3
#	.space 4
st_array:
	.space 176 # 4*44
media:	.space 4
strmed:	.asciiz "\nMédia: "
strmec:	.asciiz "\nN. Mec: "
strnome:.asciiz "\nPrimeiro Nome: "
strunome:.asciiz "\nIltimo Nome: "
strnota:.asciiz "\nNota: "
	.text
	.globl main
main:	
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,st_array
	li $a1,MAX_STUDENTS
	jal read_data
	
	la $a0,st_array
	li $a1,MAX_STUDENTS
	la $a2,media
	jal max
	
	move $t0,$v0
	
	la $a0,strmed
	li $v0,4
	syscall
	
	l.s $f12,media
	li $v0,2
	syscall
	
	move $a0,$t0
	jal print_student
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
read_data:
	li $t0,0
	move $t1,$a0
	move $t2,$a1
readfor:bge $t0,$t2,readendfor
	
	la $a0,strmec
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	sw $v0,0($t1)
	
	la $a0,strnome
	li $v0,4
	syscall
	
	addi $t1,$t1,4
	
	add $a0,$t1,$0
	li $a1,18
	li $v0,8
	syscall
	
	la $a0,strunome
	li $v0,4
	syscall
	
	addi $t1,$t1,18
	
	add $a0,$t1,$0
	li $a1,15
	li $v0,8
	syscall
	
	la $a0,strnota
	li $v0,4
	syscall
	
	addi $t1,$t1,18
	
	li $v0,6
	syscall
	s.s $f0,0($t1)
	
	addi $t1,$t1,4
	
	addi $t0,$t0,1
	j readfor
readendfor:	
	jr $ra
	
max:	
	li $t0,-20
	mtc1 $t0,$f4
	cvt.s.w $f4,$f4
	li $t0,0
	mtc1 $t0,$f5
	cvt.s.w $f5,$f5
	move $t0,$a0
	mul $t1,$a1,44
	add $t1,$a0,$t1
	li $t2,0
maxfor:	bge $t0,$t1,maxendfor
	
	l.s $f0,40($t0)
	add.s $f5,$f5,$f0
	
	c.lt.s $f4,$f0
	bc1f endif
	
	mov.s $f4,$f5
	move $t2,$t0
	
endif:	
	addi $t0,$t0,44
	j maxfor
maxendfor:
	mtc1 $a1,$f6
	cvt.s.w $f6,$f6
	
	div.s $f0,$f5,$f6
	
	s.s $f0,0($a2)
	
	move $v0,$t2
	jr $ra
	
print_student:
	move $t0,$a0
	lw $a0,0($t0)
	li $v0,1
	syscall
	
	la $a0,4($t0)
	li $v0,4
	syscall
	
	
	la $a0,22($t0)
	li $v0,4
	syscall
	
	l.s $f12,40($t0)
	li $v0,2
	syscall
	
	jr $ra