	.data
	p: .word 7692,23,5,234
	.text
	.globl main
	
main:
	# $t0 -> p
	# $t1 -> pultimo
	# $t2 -> *p
	# $t3 -> soma
	
	la $t0,p
	addi $t1,$t0,12
	
While:	
	bgt $t0,$t1,Endwhile
	lw $t2,0($t0)
	add $t3,$t3,$t2
	addi $t0,$t0,4
	j While

Endwhile:
	or $a0,$0,$t3
	ori $v0,$0,1
	syscall
	
	jr $ra