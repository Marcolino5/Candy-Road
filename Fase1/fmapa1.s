# >Argumentos: posi�ao inicial - s10 (inicio) e s11 (fim)
# Os �nicos registradores que precisam ser salvos ap�s a fun��o s�o s10 e s11
moveCARRO:
	mv a7, ra
	
	add t2, s10, zero # Coloca valor armazenado em s10 em t2
	add a3, t2, zero # Coloca valor armazenado em t2 em a3
	
	lw a1, CARRO
	li a4, 16	# Define largura da imagem
	li a6, 16	# Define altura da imagem
	call printUND
				
	mv ra, a7
	
	#Printa p/ a direita quando aperta d/D
		
	li t5, 0xFF200000 # Carrega endere�o do KDMMIO
	lw t0, 4(t5)      # L� c�digo ASCII da tecla
	sw t0, 12(t5)     # P�e no display
	sw zero, 4(t5)    # Limpa o c�digo ASCII 
	
	li t2, 68         # C�digo ASCII do D
	beq t0, t2, moveCARROR # Se c�digo ASCII = D/d, vai p/ moveCARROR
	li t2, 100        # C�digo ASCII do d
	beq t0, t2, moveCARROR
	
	li t2, 65         # C�digo ASCII do A
	beq t0, t2, moveCARROL # Se c�digo ASCII = A/a, vai p/ moveCARROL
	li t2, 97         # C�digo ASCII do a
	beq t0, t2, moveCARROL
	
	li t2, 87         # C�digo ASCII do W
	beq t0, t2, moveCONT3       # Se c�digo ASCII = W/w, vai p/ CONT
	li t2, 119         # C�digo ASCII do w
	beq t0, t2, moveCONT3
	
	j posMOVE
moveCARROR:
	li t2, 0xFF00FE6C
	beq s10, t2, moveCARROEXPLOSAO
	j moveCARRORcont
moveCARROEXPLOSAO:
	li t3, 3
	blt s11, t3, PRINT_EXIT
	
	la t1, TEMPOEXPLOSAO
	sw a7, (t1)			# Guarda o endere�o de retorno
	
	# Explos�o
	li a7, 31
	li a0, 40
	li a1, 1000
	li a2, 127
	li a3, 63
	ecall				# Toca som de explos�o
	add t2, s10, zero
	la a1, TILE1
	li a4, 16
	li a6, 16
	call printUND
	add t2, s10, zero
	la a1, Explosao1
	li a4, 16
	li a6, 16
	call printUND			# Printa 1 frame
	li a7, 32
	li a0, 200
	ecall
	add t2, s10, zero
	la a1, Explosao2
	li a4, 16
	li a6, 16
	call printUND			# Printa 2 frame
	li a7, 32
	li a0, 200
	ecall
	add t2, s10, zero
	la a1, Explosao3
	li a4, 16
	li a6, 16
	call printUND			# Printa 3 frame
	li a7, 32
	li a0, 500
	ecall
	add t2, s10, zero
	la a1, TILE1
	li a4, 16
	li a6, 16
	call printUND
	li a7, 32
	li a0, 500
	ecall
	li s10, 0xFF00FE28		# Retorna carro � posi��o inicial
	
	lw ra, TEMPOEXPLOSAO		# Coloca o valor anterior de a7 de volta em RA
	ret
moveCARRORcont:
	add t2, s10, zero
	la a1, TILE1
	li a4, 16	# Define largura
	li a6, 16	# Define altura
	
	mv a7, ra
	call printUND	# Remove o rastro
	mv ra, a7
	
	addi s10, s10, 4
	j moveCARRO
moveCARROL:
	li t2, 0xFF00FE18
	beq s10, t2, moveCARROEXPLOSAO
moveCARROLcont:
	add t2, s10, zero
	la a1, TILE1
	li a4, 16	# Define largura
	li a6, 16	# Define altura
	
	mv a7, ra
	call printUND	# Remove o rastro
	mv ra, a7
		
	addi s10, s10, -4
	j moveCARRO
	
# Toca m�sica sem pausar o jogo
# >Argumentos: s1 (n de notas), s0 (endere�o), s7 (n de notas j� tocado), a3 (Volume)<
tocamusicaMENU:
	mv t2, ra
	la t0,numMENU	        # Coloca n de notas em s1	
	lw s1,(t0)	
	li a2,2  		# Instrumento
	li a3,42                # Volume
	tocaMENU:	
		beq s7,s1,menuMUSICA	# Se tiver tocado todas as notas, volta p/ MENU
		lw a0,(s0)		# Coloca nota em a0
		lw a1,4(s0)		# Coloca dura��o em a1
		li a7,31	
		ecall			# Toca a nota
		addi s7,s7,1		# Adiciona um ao contador de notas	
		
		mv t3, a1
		li a7, 30		# Pega quando tocou a nota
		ecall
		add s8,a0,t3		# Define quando vai tocar de novo
		
		mv ra, t2
		ret

# Toca m�sica sem pausar o jogo
# >Argumentos: s1 (n de notas), s0 (endere�o), s7 (n de notas j� tocado), a3 (Volume)<
tocamusicaCS:
	mv t2, ra
	la t0,numMENU	        # Coloca n de notas em s1	
	lw s1,(t0)	
	li a2,2  		# Instrumento
	li a3,42                # Volume
	tocaCS:	
		beq s7,s1,Restart	# Se tiver tocado todas as notas, volta p/ MENU
		lw a0,(s0)		# Coloca nota em a0
		lw a1,4(s0)		# Coloca dura��o em a1
		li a7,31	
		ecall			# Toca a nota
		addi s7,s7,1		# Adiciona um ao contador de notas	
		
		mv t3, a1
		li a7, 30		# Pega quando tocou a nota
		ecall
		add s8,a0,t3		# Define quando vai tocar de novo
		
		mv ra, t2
		ret
Restart:	la s0, notasMENU
		li s7,0			# Reinicia contador de notas
		j ESCOLHA1
		
# Toca a primeira m�sica e um som 4 vezes pausadamente, sendo a largada da corrida
# >Argumentos: s0 (Notas da Largada) e s7 (Contador de Notas)<
LARGADA:
	mv t2, ra
	largadaMUSICA:
		la t0, numMLARGADA1	# Coloca n de notas em s1
		lw s1,(t0)
		li a2, 2		# Instrumento
		li a3, 42		# Volume
		loopMLARGADA:
			beq s7, s1,fimLARGADA	# Se tiver tocado todas as notas, vai p/ o final
			lw a0,(s0)		# Coloca nota em a0
			lw a1,4(s0)		# Coloca dura��o em a1
			li a7, 31
			ecall			# Toca a nota
			addi s7,s7,1		# Adiciona um ao contador de nota
			
			mv a0,a1		# Coloca dura��o em a0
			li a7,32
			ecall			# Realiza Sleep (pausa)
			
			addi s0,s0,8		# Passa o endere�o p/ a pr�xima nota
			j loopMLARGADA
	fimLARGADA:
		la s0,notasLARGADA1 # Carrega notas da largada
		li s7,0	   	    # Inicia contador
		la t0,numLARGADA1   # Carrega n de notas
		lw s1,(t0)
		li a2, 2	    # Instrumento
		li a3, 0	    # Volume
		loopLARGADA:
			addi t3, s1, -1		   # Tira 1 do n de notas
			beq s7, t3, maisvolLARGADA # Se estiver na �ltima nota, aumenta mais o volume
			bnez s7, mvolLARGADA	   # Se n�o estiver na primeira nota, aumenta o volume
		contloopLARGADA:
			beq s7,s1, retLARGADA	# Se tiver tocado todas as notas, vai p/ retLARGADA
			lw a0,(s0)		# Coloca a nota em a0
			lw a1,4(s0)		# Coloca a dura��o em a1
			li a7,31
			ecall			# Toca a nota
			addi s7,s7,1		# Adiciona um ao contador de nota
			
			xori t6, t6, 1		# Faz xori para alternar os valores
			li a0,0xFF200604
			sw t6,0(a0)
			
			li t5, 2                # Coloca 2 p/ usar em contas
			mv a0,a1		# Coloca a dura��o em a0
			div a0,a0,t5		# Divide a dura��o por dois
			
			li a7,32
			ecall			# Realiza sleep(Pausa)
			
			xori t6, t6, 1		# Faz xori para alternar os valores
			li a0,0xFF200604
			sw t6,0(a0)
			
			mv a0,a1		# Coloca a dura��o em a0
			div a0,a0,t5		# Divide a dura��o por dois
			
			li a7,32
			ecall			# Realiza sleep(Pausa)
			
			addi s0,s0,8
			j loopLARGADA
	retLARGADA:
		mv ra,t2
		ret
	mvolLARGADA:
		li a3,70
		j contloopLARGADA
	maisvolLARGADA:
		li a3,100
		j contloopLARGADA
		
ACELERADOR1:
	li t2, 0xFF006A08
	la a1, Acelerador1
	li a4, 40			# Define largura da imagem
	li a6, 24			# Define altura da imagem
	call printUND
	j moveCONT1
ACELERADOR2:
	li t2, 0xFF006A08
	la a1, Acelerador2
	li a4, 40			# Define largura da imagem
	li a6, 24			# Define altura da imagem
	call printUND
	j moveCONT1
ACELERADOR3:
	li t2, 0xFF006A08
	la a1, Acelerador3
	li a4, 40			# Define largura da imagem
	li a6, 24			# Define altura da imagem
	call printUND
	j moveCONT1
	
PRINTAGASOLINA:
	li t2, 0xFF00D948
	
	add a1, s9, zero
	li a4, 24			# Define largura da imagem
	li a6, 40			# Define altura da imagem
	call printUND
	add s9, a1, zero
	
	lw t1, CONTADORGASOLINA
	addi t1, t1, 0x00000001
	la t5, CONTADORGASOLINA
	sw t1, (t5)
	
	lw t1, CONTADORGASOLINA
	li t5, 8
	bge t1, t5, DERROTA
	
	li a7, 30
	ecall
	li t3, 0x00001D4C
	add t4, a0, t3
	la t1, TEMPOGASOLINA		# Altera o tempo de mudan�a da gasolina
	sw t4, (t1)
	j attACELERACAO
	
DERROTA:
	li t2, 0xFF00633C
	la a1, EMPTY
	li a4, 40
	li a6, 8
	call printUND			# Coloca imagem de tanque vazio
	
	la t1, CONTADORGASOLINA
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, PONTUA��O
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, PONTUA��O1
	li t3, 0x00000000
	sw t3, (t1)
	
	derrotaCONT:
	la t1, POSI��OCARROM
	li t3, 0xFF011584
	sw t3, (t1)
	
	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	li t2, 0xFF00633C
	la a1, Gameover
	li a4, 40
	li a6, 16
	call printUND			# Coloca imagem de final de jogo
	
	la t1,numEMOTION			
	lw t2,0(t1)		
	la t1,notasEMOTION		
	li t0,0				# Inicia o contador
	li a2,2 			# Instrumento
	li a3,60			# Volume

tocaNA:	beq t0,t2, fimNA		# Termina se alcan�ar o n de notas
	lw a0,0(t1)			# Coloca nota
	lw a1,4(t1)			# Coloca dura��o	
	li a7,31		
	ecall			
	addi t0,t0,1	
	
	mv a0,a1		
	li a7,32		
	ecall				# Pausa o jogo pela dura��o
	
	addi t1,t1,8			# Pr�x nota/num
	j tocaNA			# Volta o loop
	
fimNA:	li a0, 1000
	li a7, 32
	ecall				# Pausa o jogo
	
	j MENU

VITORIA1:
	li a0, 500
	li a7, 32
	ecall				# Pausa o jogo
	
	lw t1, PONTUA��OMAX
	lw t2, PONTUA��O
	blt t2, t1, derrotaCONT
	la t3, PONTUA��OMAX
	sw t2, (t3)
	
	la t1, PONTUA��O
	li t2, 0
	sw t2, (t1)			# Reseta a pontua��o
	
	la t1, PONTUA��O1
	lw t2, PONTUA��O
	sw t2, (t1)			# Guarda a pontua��o em PONTUA��O1
	
	la t1, CONTADORGASOLINA
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, POSI��OCARROM
	li t3, 0xFF011584
	sw t3, (t1)
	
	lb t2, N2			# Desbloqueia o n�vel 2
	bnez t2, continuaai
	la t1, N2
	lb t2, N2
	xori t2, t2, 1
	sb t2, (t1)
	
continuaai:
	la t1,numVICTORY			
	lw t2,0(t1)		
	la t1,notasVICTORY		
	li t0,0				# Inicia o contador
	li a2,3 			# Instrumento
	li a3,60			# Volume
	
	li a7, 30
	ecall
	add s1, a0, zero
	add s2, a0, zero
	li s4, 0
looptocaVY1:
	mv s11, t2
	mv s9, t1
	mv s8, t0
	mv s7, a2
	mv s6, a3
	
	li a7, 30
	ecall
	bge a0, s2, movecarroVY1
	j looptocaVY1CONT
movecarroVY1:
	li t1, 0xFF000140
	ble s10, t1, removeCARRO1
	
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	la a1, TILE1
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND			# Remove rastro
	
	li t1, -320
	add s10, s10, t1
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	lw a1, CARRO
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND			# Move o carro
	
	li a7, 30
	addi s2, a0, 5		# Demarca velocidade de um pixel por segundo
looptocaVY1CONT:	
	beqz s4, looptocaVY1CONT2
	li t2, 0xFF006330
	la a1, Checkpoint
	li a4, 56
	li a6, 8
	call printUND			# Coloca imagem de checkpoint
looptocaVY1CONT2:
	mv t2, s11
	mv t1, s9
	mv t0, s8
	mv a2, s7
	mv a3, s6
	
	li a7, 30
	ecall
	bge a0, s1, tocaVY1
	j looptocaVY1

tocaVY1:beq t0,t2, fimVY1		# Termina se alcan�ar o n de notas
	lw a0,0(t1)			# Coloca nota
	lw a1,4(t1)			# Coloca dura��o	
	li a7,31		
	ecall			
	addi t0,t0,1			
	
	mv t3, a1
	li a7, 30
	ecall
	add s1, t3, a0			# Atualiza com a nova dura��o
	
	addi t1,t1,8			# Pr�x nota/num
	j looptocaVY1			# Volta o loop
	
fimVY1:	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	j COURSE2
	
removeCARRO1:
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	la a1, TILE1
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND			# Remove rastro
	li s4, 1
	j looptocaVY1CONT
	
MOEDA1:	li t2, 0xFF002F3C
	la a1, Coin
	li a4, 12
	li a6, 12
	call printUND
	
	li a7, 31
	li a0, 84
	li a1, 1000
	li a2, 3
	li a3, 60
	ecall
	
	lw t1, PONTUA��O
	addi t1, t1, 100
	la t2, PONTUA��O
	sw t1, (t2)
	j moveCONT5
MOEDA2:	li t2, 0xFF002F48
	la a1, Coin
	li a4, 12
	li a6, 12
	call printUND
	
	li a7, 31
	li a0, 84
	li a1, 1000
	li a2, 3
	li a3, 60
	ecall
	
	lw t1, PONTUA��O
	addi t1, t1, 100
	la t2, PONTUA��O
	sw t1, (t2)
	j moveCONT5
MOEDA3:	li t2, 0xFF002F54
	la a1, Coin
	li a4, 12
	li a6, 12
	call printUND
	
	li a7, 31
	li a0, 84
	li a1, 1000
	li a2, 3
	li a3, 60
	ecall
	
	lw t1, PONTUA��O
	addi t1, t1, 100
	la t2, PONTUA��O
	sw t1, (t2)
	j moveCONT5
MOEDA4:	li t2, 0xFF002F60
	la a1, Coin
	li a4, 12
	li a6, 12
	call printUND
	
	li a7, 31
	li a0, 84
	li a1, 1000
	li a2, 3
	li a3, 60
	ecall
	
	lw t1, PONTUA��O
	addi t1, t1, 100
	la t2, PONTUA��O
	sw t1, (t2)
	j moveCONT5
