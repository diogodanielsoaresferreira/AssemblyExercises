	.data
	str1: .asciiz "Nr. de parametros: "
	str2: .asciiz "\nP"
	str3: .asciiz ": "
	.text
	.globl main
main:	
	move $t0,$a0
	move $t1,$a1
	la $a0,str1
	li $v0,4
	syscall
	move $a0,$t0
	li $v0,1
	syscall
	li $t2,0
for:	bge $t2,$t0,endfor
	la $a0,str2
	la $v0,4
	syscall
	move $a0,$t2
	li $v0,1
	syscall
	move $a0,$t2
	li $v0,1
	la $a0,str3
	la $v0,4
	syscall
	sll $t3,$t2,2
	add $t3,$t1,$t3
	lw $a0,0($t3)
	la $v0,4
	syscall
	addi $t2,$t2,1
	j for
endfor:		
	jr $ra
