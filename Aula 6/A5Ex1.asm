	.data
	.eqv SIZE,5
	lista: .word 0:SIZE
	str1: .asciiz "\nIntroduza um numero: "
	.text
	.globl main
	
main:	
	# $t0 -> i
	# $t1 -> lista
	# $t2 -> lista[i]
	# $v0 -> teclado
	
	li $t0,0
	la $t1,lista
for:	
	bge $t0,SIZE,endFor
	
	la $a0,str1
	addi $v0,$0,4
	syscall
	
	sll $t2,$t0,2
	add $t2,$t2,$t1
	
	la $a0,0($t2)
	addi $v0,$0,5
	syscall
	
	sw $v0,0($t2)
	
	addi $t0,$t0,1
	j for
endFor:
	jr $ra