.data #LER INSTRUÇÕES EM ? > SYSCALLS > USING MIDI OUTPUT
NUM: .word 13 # num de notas
# nota, duração, nota, duração... (duração em ms)
NOTAS: 69,500,76,500,74,500,76,500,79,600, 76,1000,0,1200,69,500,76,500,74,500,76,500,81,600,76,1000 

.text
DEFINE:	la s0,NUM		
	lw s1,(s0)		
	la s0,NOTAS		
	li t0,0			
	li a2,68		# instrumento
	li a3,63		# volume

TOCA:	beq t0,s1, FIM		
	lw a0,(s0)		
	lw a1,4(s0)		
	li a7,31		
	ecall			
	mv a0,a1		
	li a7,32	
	ecall			
	addi s0,s0,8		
	addi t0,t0,1		
	j TOCA			
	
FIM:    # estrutura básica para um único efeito sonoro
	li a0,40		# nota
	li a1,1500		# duração
	li a2,127		# instrumento
	li a3,63		# volume
	li a7,33		
	ecall			
	
	li a7,10		
	ecall	