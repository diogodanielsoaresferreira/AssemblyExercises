	.data
	str1: .asciiz "\nCaracteres: "
	str2: .asciiz "\nLetras maisuculas: "
	str3: .asciiz "\nLetras minusculas: "
	str4: .asciiz "\nMaior string: "
	.text
	.globl main
main:	
	# $t0 -> i
	# $t1 -> j
	# $t2 -> k
	# $t3 -> max
	# $t4 -> min
	# $t5 -> *str[]
	
	li $t0,0
	li $t2,0
	move $t5,$a1
	move $s0,$a0
	move $s1,$a1
for:	bge $t0,$s0,Endfor
	li $t1,0
	li $t3,0
	li $t4,0
	sll $t6,$t0,2
	add $t6,$s1,$t6
	lw $t7,0($t6)
while:	add $t9,$t7,$t1
	lb $t8,0($t9)
	beq $t8,'\0',endwhile
	addi $t1,$t1,1
if:	ble $t8,0x40,else
	bge $t8,0x5B,else
	addi $t3,$t3,1
	j endif
else:	ble $t8,0x60,endif
	bge $t8,0x7B,endif
	addi $t4,$t4,1
	j endif
	addi $t1,$t1,1
endif:	j while
endwhile:
	la $a0,str1
	li $v0,4
	syscall
	move $a0,$t1
	li $v0,1
	syscall
	la $a0,str2
	li $v0,4
	syscall
	move $a0,$t3
	li $v0,1
	syscall
	la $a0,str3
	li $v0,4
	syscall
	move $a0,$t4
	li $v0,1
	syscall
if2:	blt $t1,$t2,endif2
	move $t2,$t1
	move $t5,$t7
	
endif2:	addi $t0,$t0,1
	j for
Endfor:	
	la $a0,str4
	li $v0,4
	syscall
	move $a0,$t5
	li $v0,4
	syscall
	jr $ra