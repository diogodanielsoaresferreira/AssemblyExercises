.data
.text
.globl main
main:

	ori $t0,$0,0xffffffff
	
	andi $a0,$t0,0x0000000f
	ori $v0,$0,34
	syscall

	
	andi $a0,$t0,0x000000f0
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0x00000f00
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0x0000f000
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0x000f0000
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0x00f00000
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0x0f000000
	ori $v0,$0,34
	syscall
	
	andi $a0,$t0,0xf0000000
	ori $v0,$0,34
	syscall
	
	
	
	
	jr $ra