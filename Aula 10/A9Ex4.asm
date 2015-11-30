	.data
	.text
	.globl main

main:	la $a0,120
	la $a1,10
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal print_int_ac1
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra


print_int_ac1:
	div $t0,$a0,$a1
	beq $t0,0,endif
	addi $sp,$sp,-12
	sw $a0,8($sp)
	sw $a1,4($sp)
	sw $ra,0($sp)
	move $a0,$t0
	
	jal print_int_ac1
	
	lw $a0,8($sp)
	lw $a1,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,12
endif:	addi $sp,$sp,-4
	sw $ra,0($sp)
	rem $a0,$a0,$a1
	
	jal toascii
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	move $a0,$v0
	li $v0,11
	syscall
	jr $ra

toascii:
	addi $a0,$a0,'0'
	ble $t0,'9',end
	addi $a0,$a0,7
end:	move $v0,$a0
	jr $ra
