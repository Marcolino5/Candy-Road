.data
.include "Imagens/Menu.data"
.include "Imagens/Seta.data"

.text

MENU:		li t1,0xFF000000	
		li t2,0xFF012C00
		la s1, Menu	
		addi s1,s1,8
			
LOOP_MENU: 	beq t1,t2,SETA
		lw t3,0(s1)		
		sw t3,0(t1)		
		addi t1,t1,4		
		addi s1,s1,4
		j LOOP_MENU	

SETA:		li t1, 0xFF016523
		li t2, 0xFF0196B6
		la s1, Seta
		addi s1, s1, 8
		lw t4, 0(s1)
		lw t5, 4(s1)
	
LOOP_SETA:	beq t1,t2,FIM
		lw t3,0(s1)		
		sw t3,0(t1)		
		addi t1,t1,4		
		addi s1,s1,4
		j LOOP_SETA

FIM:		li a7,10		
		ecall
