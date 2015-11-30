	.data
	ptr_p: .space 20
	string: .asciiz "Introduza uma string: "
	.text
	.globl main
main:
	la $t2,string
	or $a0,$0,$t2
	ori $v0,$0,4
	syscall
	
	# $t0 -> p
	# $t1 -> *p
	# $t2 -> string
	
	la $a0,ptr_p
	ori $a1,$0,20
	ori $v0,$0,8
	syscall
	
	or $t0,$0,$a0
	
While:	
	lb $t1,0($t0)
	beq $t1,0xa,Endwhile
	beq $t1,0x00,Endwhile
	add $t1,$t1,0x20
	sb $t1,0($t0)
	addi $t0,$t0,1
	j While

Endwhile:
	la $t0,ptr_p
	la $t2,0($t0)
	or $a0,$0,$t2
	ori $v0,$0,4
	syscall
	
	jr $ra
