	.data
	.eqv SIZE,10
	lista: .word 8,-4,3,5,124,-15,87,9,27,15
	str1: .asciiz "\nConteudo do array:\n"
	str2: .asciiz "-"
	.text
	.globl main
main:	
	# $t0 -> i
	# $t1 -> p
	# $t2 -> *P
	
	la $t1,lista
	la $a0,str1
	addi $v0,$0,4
	syscall
	
For:	bge $t0,SIZE,Endfor
	lw $t2,0($t1)
	or $a0,$0,$t2
	ori $v0,$0,1
	syscall
	la $a0,str2
	ori $v0,$0,4
	syscall
	addi $t1,$t1,4
	addi $t0,$t0,1
	j For
	
Endfor:	jr $ra