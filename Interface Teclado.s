.text
	li s0, 0
CONTA:  jal TECLA
	addi s0, s0, 1
	j CONTA
	
TECLA:  li t1, 0xFF200000
	lw t0,(t1)
	andi t0,t0,0x0001
	beq t0,zero, FIM
	lw t2,4(t1) 
	sw t2,12(t1) 
FIM:    ret
