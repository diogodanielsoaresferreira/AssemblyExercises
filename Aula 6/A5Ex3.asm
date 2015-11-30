	.data
	.eqv SIZE,10
	lista: .word 0:SIZE
	
	.text
	.globl main
main:	
	# $t0 -> i
	# $t1 -> p
	
	li $t0,0
	la $t1,lista
For:	bge $t0,SIZE,Bubble
	addi $v0,$0,5
	syscall
	sw $v0,0($t1)
	add $t1,$t1,4
	addi $t0,$t0,1
	j For
	
Bubble:	la $a0,lista
	add $a1,$0,SIZE
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal BubbleSort
	lw $ra,0($sp)
	addi $sp,$sp,4

EndBubble:
	add $t0,$0,$0
	la $t1,lista
	
For2:	bge $t0,SIZE,Endfor2
	sll $t2,$t0,2
	add $t2,$t2,$t1
	lw $a0,0($t2)
	addi $v0,$0,1
	syscall
	addi $t0,$t0,1
	j For2
Endfor2:
	jr $ra
	
	
	# $t0 -> i
	# $t1 -> houveTroca
	# $t3 -> size-1
	# $t4 -> lista[i]
	# $t6 -> lista[i+1]
	# $t7 -> ponteiro para lista[i]
	# $a0 -> lista
	# $a1 -> size
	
BubbleSort:
	sub $t3,$a1,1
BubDo:	
	li $t1,0
	li $t0,0
BubFor:
	bge $t0,$t3,EndBubFor
	sll $t7,$t0,2
	add $t7,$t7,$a0
	lw $t4,0($t7)
	lw $t6,4($t7)
	ble $t4,$t6,BubEndIf
	sw $t4,4($t7)
	sw $t6,0($t7)
	addi $t1,$0,1
	
BubEndIf:	
	addi $t0,$t0,1
	j BubFor
EndBubFor:
	beq $t1,1,BubDo
EndBubDo:
	jr $ra
