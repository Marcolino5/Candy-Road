.data
.include "Imagens/Menu.data"




.text

FORA:	li t1,0xFF000000	
	li t2,0xFF012C00
	la s1,Menu	
	addi s1,s1,8		
LOOP1: 	beq t1,t2,FIM
	lw t3,0(s1)		
	sw t3,0(t1)		
	addi t1,t1,4		
	addi s1,s1,4
	j LOOP1			

FIM:	li a7,10		
	ecall
