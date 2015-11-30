	.eqv SIZE,10
	.data
	lista: .word 0:10
	str1: .asciiz "\nInsira um numero: "
			
	.text
	.globl main
main:
	# $t0 -> houveTroca
	# $t1 -> p
	# $t2 -> *p
	# $t3 -> pultimo
	
	
	la $a0,str1
	la $t1,lista
	la $t4,SIZE
	sll $t4,$t4,2
	add $t3,$t4,$t1
	
For:	bge $t1,$t3,Endfor
	
	addi $v0,$0,4
	syscall
	addi $v0,$0,5
	syscall
	sw $v0,0($t1)
	add $t1,$t1,4
	
	j For

Endfor:	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,lista
	move $a1,$t3
	jal Bubble
	lw $ra,0($sp)
	addi $sp,$sp,4
	la $a0,str1
	la $t1,lista
	la $t4,SIZE
	sll $t4,$t4,2
	add $t3,$t4,$t1



For2:	bge $t1,$t3,Endfor2
	
	lw $a0,0($t1)
	addi $v0,$0,1
	syscall
	add $t1,$t1,4
	
	j For2
Endfor2:
	jr $ra



Bubble:	or $t0,$0,$0
	move $t3,$a0
	sub $a1,$a1,1
	
Bubfor:	bge $t3,$a1,BubEndFor
	lw $t1,0($t3)
	lw $t2,4($t3)
	ble $t1,$t2,BubEndIf
	sw $t2,0($t3)
	sw $t1,4($t3)
	addi $t0,$0,1
	
BubEndIf:
	addi $t3,$t3,4
	j Bubfor
BubEndFor:
	bne $t0,$0,Bubble
	jr $ra