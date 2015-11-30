	.eqv SIZE,10
	.data
	lista: .word 0:SIZE
	str1: .asciiz "\nIntroduza o numero: "
	.text
	.globl main
main:	
	# $t0 -> i
	# $t1 -> p
	# $t2 -> size-1
	
	li $t0,0
	la $t2,SIZE
	la $t1,lista
	subi $t2,$t2,1
for1:	bgt $t0,$t2,endfor1
	la $a0,str1
	addi $v0,$0,4
	syscall
	addi $v0,$0,5
	syscall
	sw $v0,0($t1)
	
	addi $t1,$t1,4
	addi $t0,$t0,1
	j for1
	
	
endfor1:la $a0,lista
	add $a1,$t2,1
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal SeqSort
	lw $ra,0($sp)
	addi $sp,$sp,4
	li $t0,0
	la $t2,SIZE
	la $t1,lista
	subi $t2,$t2,1
for2:	bgt $t0,$t2,endfor2
	lw $a0,0($t1)
	addi $v0,$0,1
	syscall
	
	addi $t1,$t1,4
	addi $t0,$t0,1
	j for2
endfor2:jr $ra


SeqSort:subi $t4,$a1,1
	li $t0,0
ForSeqSort:bge $t0,$t4,EndForSeqSort
	addi $t1,$t0,1
For2SeqSort:
	bge $t1,$a1,End2ForSeqSort
	sll $t2,$t0,2
	sll $t3,$t1,2
	add $t2,$t2,$a0
	add $t3,$t3,$a0
	lw $t5,0($t2)
	lw $t6,0($t3)
	blt $t5,$t6,Endif
	sw $t5,0($t3)
	sw $t6,0($t2)
	
Endif:	addi $t1,$t1,1
	j For2SeqSort
End2ForSeqSort:
	addi $t0,$t0,1
	j ForSeqSort
EndForSeqSort:
	jr $ra