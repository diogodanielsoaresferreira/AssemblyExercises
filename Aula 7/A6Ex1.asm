	.eqv SIZE,3
	.data
	str1: .asciiz "Array"
	str2: .asciiz "de"
	str3: .asciiz "ponteiros"
	str4: .asciiz "\n"
	array: .word str1, str2, str3
	.text
	.globl main
main:	
	li $t0,0
	la $t2,array
for:	bge $t0,$t1,endfor
	sll $t1,$t0,2
	add $t1,$t1,$t2
	lw $a0,0($t1)
	li $v0,4
	syscall
	la $a0,str4
	syscall
	addi $t0,$t0,1
	j for
endfor:
	jr $ra