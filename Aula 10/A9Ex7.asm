	.data
str1:	.asciiz "\n"
str2:	.asciiz " - Mover disco de topo de "
str3:	.asciiz " para "
str4:	.asciiz "Introduza o numero de discos: "
	.text
	.globl main
main:	
	la $a0,str4
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	ble $v0,0,endmain
	addi $sp,$sp,-4
	move $a0,$v0
	li $a1,1
	li $a2,3
	li $a3,2
	
	jal tohanoi
	
	addi $sp,$sp,4
	
endmain:
	li $v0,0
	jr $ra

tohanoi:
	li $t0,0
	beq $a0,1,elsehanoi
	addi $sp,$sp,-24
	sw $a0,20($sp)
	sw $a1,16($sp)
	sw $a2,12($sp)
	sw $a3,8($sp)
	sw $t0,4($sp)
	sw $ra,0($sp)
	
	addi $a0,$a0,-1
	move $a2,$a3
	move $a3,$a2
	jal tohanoi
	
	lw $a0,16($sp)
	lw $a1,12($sp)
	lw $a3,4($sp)
	addi $a3,$a3,1
	sw $a3,4($sp)
	
	jal print_msg
	
	lw $a0,20($sp)
	addi $a0,$a0,-1
	lw $a1,8($sp)
	lw $a2,12($sp)
	lw $a3,16($sp)
	
	jal tohanoi
	
	lw $ra,0($sp)
	addi $sp,$sp,24
	
	jr $ra
	
elsehanoi:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	move $a0,$a1
	move $a1,$a2
	addi $t0,$t0,1
	move $a2,$t0
	
	jal print_msg
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
print_msg:
	la $a0,str1
	li $v0,4
	syscall
	
	addi $sp,$sp,-16
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	sw $ra,12($sp)
	
	move $a0,$a2
	li $a1,10
	
	jal print_int_ac1
	
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $a2,8($sp)
	lw $ra,12($sp)
	addi $sp,$sp,16
	
	la $a0,str2
	li $v0,4
	syscall
	
	addi $sp,$sp,-16
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	sw $ra,12($sp)
	
	move $a0,$a0
	li $a1,10
	
	jal print_int_ac1
	
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $a2,8($sp)
	lw $ra,12($sp)
	addi $sp,$sp,16
	
	la $a0,str3
	li $v0,4
	syscall
	
	addi $sp,$sp,-16
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	sw $ra,12($sp)
	
	move $a0,$a1
	li $a1,10
	
	jal print_int_ac1
	
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $a2,8($sp)
	lw $ra,12($sp)
	addi $sp,$sp,16
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
