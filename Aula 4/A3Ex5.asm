	.data
str1: .asciiz "\nIntroduza um numero: "
str2: .asciiz "\nO valor em octal: "
	.text
	.globl main
main:
	la $a0, str1
	ori $v0,$0,4
	syscall
	
	# $t0 -> value
	ori $v0,$0,5
	syscall
	or $t0,$0,$v0
	
	la $a0,str2
	ori $v0,$0,4
	syscall
	
	# $t1 -> i=10
	li $t1,8
	
	# $t2 -> value & 0xF0000000
While:
	andi $t2,$t0,14680064
	bne $t2,$0,Do
	ble $t1,$0,Do
	sll $t0,$t0,3
	subi $t1,$t1,1
	j While
	
Do:	# $t3 -> Digito
	andi $t2,$t0,14680064
	srl $t3,$t2,21
	bge $t3,8,Else
	
	add $a0,$t3,0x30
	ori $v0,$0,11
	syscall
	j Endif

Else:	add $a0,$t3,0x30
	add $a0,$a0,7
	ori $v0,$0,11
	syscall
	
Endif:	sll $t0,$t0,3
	subi $t1,$t1,1
	bgt $t1,0,Do
	
	jr $ra

	
