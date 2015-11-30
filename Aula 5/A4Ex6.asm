	.data
	p: .word 7692,23,5,234
	.text
	.globl main
	
main:
	# $t0 -> array
	# $t1 -> ultimo
	# $t2 -> i
	# $t4 -> Conteúdo de i
	# $t3 -> soma
	# $t5 -> Posição i + array
	
	la $t0,p
	addi $t1,$0,3
	sll $t1,$t1,2
	
While:	
	
	bgt $t2,$t1,Endwhile
	add $t5,$t0,$t2
	lw $t4,0($t5)
	add $t3,$t3,$t4
	addi $t2,$t2,4
	j While

Endwhile:
	or $a0,$0,$t3
	ori $v0,$0,1
	syscall
	
	jr $ra