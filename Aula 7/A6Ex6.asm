	.eqv SIZE,3
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ":"
str6:	.asciiz "-"
array:	.word str1,str2,str3
	.text
	.globl main
main:	
	# $t0 -> p
	# $t1 -> pultimo
	# $t2 -> i
	
	la $t0,array
	li $t1,SIZE
	sll $t1,$t1,2
	addu $t1,$t1,$t0
	li $t2,0
for:	bge $t0,$t1,endfor
	la $a0,str4
	li $v0,4
	syscall
	move $a0,$t2
	li $v0,1
	syscall
	la $a0,str5
	li $v0,4
	syscall
	addi $t2,$t2,1
	lw $t5,0($t0)
	li $t3,0
while:	add $t4,$t3,$t5
	lb $a0,0($t4)
	beq $a0,'\0',endwhile
	li $v0,11
	syscall
	la $a0,str6
	li $v0,4
	syscall
	
	addi $t3,$t3,1
	j while
endwhile:
	addi $t0,$t0,4
	j for
endfor:	jr $ra
	