	.data
str1: .asciiz "\nIntroduza um numero: "
str2: .asciiz "\nO valor em binario: "
	
	.text
	.globl main
main:
	la $a0,str1
	ori $v0,$0,4
	syscall
	
	ori $v0,$0,5
	syscall
	or $t0,$0,$v0
	
	la $a0,str2
	ori $v0,$0,4
	syscall
	
	# $t2 -> i
	# $t0 -> value
	# $t1 -> bit
	# $t3 -> variável de controlo para espaços
	
	li $t3,0
	
	li $t2,0
Loop:	
	bge $t2,32,Exit
	andi $t1,$t0,0x80000000
	bne $t1,$0,Else
	ori $a0,$0,0x00000030
	ori $v0,$0,11
	syscall
	j Endif
Else:	ori $a0,$0,0x00000031
	ori $v0,$0,11
	syscall
Endif:	addi $t3,$t3,1
	bne $t3, 4, endif2
	ori $a0,$0,0x00000020
	ori $v0,$0,11
	syscall
	li $t3, 0
endif2:	
	
	sll $t0,$t0,1
	addi $t2,$t2,1
	j Loop
	
Exit:	jr $ra

	
