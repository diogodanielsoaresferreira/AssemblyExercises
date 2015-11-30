	.data
str1: .asciiz "So para chatear"
str2: .asciiz "AC1 - aulas praticas"

	.text
	.globl main
main: 
	la $a0,str2
	ori $v0,$0,4
	
	syscall
	jr $ra