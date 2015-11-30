	.data
str1: .asciiz "Introduza dois numeros: "
str2: .asciiz "Resultado: "

	.text
	.globl main
main:
	la $a0, str1
	ori $v0,$0,4
	syscall
	
	ori $v0,$0,5
	syscall
	
	# $t0 -> Mdor
	or $t0,$v0,$0
	
	ori $v0,$0,5
	syscall
	
	# $t1 -> Mdo
	or $t1,$v0,$0
	
	# $t2 -> i=0
	li $t2,0
While:
	beq $t0,$0,EndWhile
	bge $t2,16,EndWhile
	addi $t2,$t2,1
	
	# $t3 -> mdor & 0x00000001
	and $t3,$t0,0x00000001
	beq $t3,$0,Endif
	
	# $t4 -> res
	addu $t4,$t4,$t1
Endif:
	sll $t1,$t1,4
	srl $t0,$t0,4
	j While

EndWhile:
	la $a0,str2
	ori $v0,$0,4
	syscall
	
	or $a0,$t4,$0
	ori $v0,$0,36
	syscall
	
	jr $ra