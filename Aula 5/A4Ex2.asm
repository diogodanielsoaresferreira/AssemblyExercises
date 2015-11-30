	.data
	ptr_p: .space 20
	
	.text
	.globl main
main:
	# $t0 -> num
	# $t1 -> p
	# $t2 -> *p
	
	or $t0,$0,$0
	
	la $a0,ptr_p
	li $a1, 20
	ori $v0,$0,8
	syscall
	
	or $t1,$a0,$0

While:
	lb $t2,0($t1)
	beq $t2,0x00,Endwhile
If:
	blt $t2,0x30,Endif
	bgt $t2,0x39,Endif
	addi $t0,$t0,1

Endif:
	addi $t1,$t1,1
	j While

Endwhile:
	or $a0,$0,$t0
	ori $v0,$0,1
	syscall
	
	jr $ra