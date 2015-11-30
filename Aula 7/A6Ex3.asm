	.eqv SIZE,3
	.data
	str1: .asciiz "Array"
	str2: .asciiz "de"
	str3: .asciiz "ponteiros"
	array: .word str1,str2,str3
	str4: .asciiz "\nString #"
	str5: .asciiz ": "
	str6: .asciiz "-"
	.text
	.globl main
main:	li $t0,0
	la $t7,array
for:	bge $t0,SIZE,endfor
	la $a0,str4
	li $v0,4
	syscall
	move $a0,$t0
	li $v0,1
	syscall
	la $a0,str5
	li $v0,4
	syscall
	li $t1,0
while:	sll $t2,$t0,2
	addu $t2,$t7,$t2
	lw $t4,0($t2)
	addu $t4,$t4,$t1
	lb $t5,0($t4)
	beq $t5,'\0',endwhile
	li $v0,11
	move $a0,$t5
	syscall
	li $v0,4
	la $a0,str6
	syscall
	addi $t1,$t1,1
	j while
endwhile:
	addi $t0,$t0,1
	j for
endfor:	
	jr $ra