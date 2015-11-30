	.eqv SIZE,3
	.data
	str1: .asciiz "Array"
	str2: .asciiz "de"
	str3: .asciiz "ponteiros"
	str4: .asciiz "\n"
	array: .word str1, str2, str3	
	.text
	.globl main
main:	la $t0,array
	add $t1,$0,SIZE
	sll $t1,$t1,2
	addu $t1,$t1,$t0
for:	bgeu $t0,$t1,endfor
	lw $a0,0($t0)
	li $v0,4
	syscall
	la $a0,str4
	syscall
	addi $t0,$t0,4
	j for
endfor:		
	
	jr $ra