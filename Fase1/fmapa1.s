# >Argumentos: posiçao inicial - s10 (inicio) e s11 (fim)
# Os únicos registradores que precisam ser salvos após a função são s10 e s11
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
		
	li t5, 0xFF200000 # Carrega endereço do KDMMIO
	lw t0, 4(t5)      # Lê código ASCII da tecla
	sw t0, 12(t5)     # Põe no display
	sw zero, 4(t5)    # Limpa o código ASCII 
	
	li t2, 68         # Código ASCII do D
	beq t0, t2, moveCARROR # Se código ASCII = D/d, vai p/ moveCARROR
	li t2, 100        # Código ASCII do d
	beq t0, t2, moveCARROR
	
	li t2, 65         # Código ASCII do A
	beq t0, t2, moveCARROL # Se código ASCII = A/a, vai p/ moveCARROL
	li t2, 97         # Código ASCII do a
	beq t0, t2, moveCARROL
	
	li t2, 87         # Código ASCII do W
	beq t0, t2, moveCONT3       # Se código ASCII = W/w, vai p/ CONT
	li t2, 119         # Código ASCII do w
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
	sw a7, (t1)			# Guarda o endereço de retorno
	
	# Explosão
	li a7, 31
	li a0, 40
	li a1, 1000
	li a2, 127
	li a3, 63
	ecall				# Toca som de explosão
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
	li s10, 0xFF00FE28		# Retorna carro à posição inicial
	
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
	
# Toca música sem pausar o jogo
# >Argumentos: s1 (n de notas), s0 (endereço), s7 (n de notas já tocado), a3 (Volume)<
tocamusicaMENU:
	mv t2, ra
	la t0,numMENU	        # Coloca n de notas em s1	
	lw s1,(t0)	
	li a2,2  		# Instrumento
	li a3,42                # Volume
	tocaMENU:	
		beq s7,s1,menuMUSICA	# Se tiver tocado todas as notas, volta p/ MENU
		lw a0,(s0)		# Coloca nota em a0
		lw a1,4(s0)		# Coloca duração em a1
		li a7,31	
		ecall			# Toca a nota
		addi s7,s7,1		# Adiciona um ao contador de notas	
		
		mv t3, a1
		li a7, 30		# Pega quando tocou a nota
		ecall
		add s8,a0,t3		# Define quando vai tocar de novo
		
		mv ra, t2
		ret

# Toca música sem pausar o jogo
# >Argumentos: s1 (n de notas), s0 (endereço), s7 (n de notas já tocado), a3 (Volume)<
tocamusicaCS:
	mv t2, ra
	la t0,numMENU	        # Coloca n de notas em s1	
	lw s1,(t0)	
	li a2,2  		# Instrumento
	li a3,42                # Volume
	tocaCS:	
		beq s7,s1,Restart	# Se tiver tocado todas as notas, volta p/ MENU
		lw a0,(s0)		# Coloca nota em a0
		lw a1,4(s0)		# Coloca duração em a1
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
		
# Toca a primeira música e um som 4 vezes pausadamente, sendo a largada da corrida
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
			lw a1,4(s0)		# Coloca duração em a1
			li a7, 31
			ecall			# Toca a nota
			addi s7,s7,1		# Adiciona um ao contador de nota
			
			mv a0,a1		# Coloca duração em a0
			li a7,32
			ecall			# Realiza Sleep (pausa)
			
			addi s0,s0,8		# Passa o endereço p/ a próxima nota
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
			beq s7, t3, maisvolLARGADA # Se estiver na última nota, aumenta mais o volume
			bnez s7, mvolLARGADA	   # Se não estiver na primeira nota, aumenta o volume
		contloopLARGADA:
			beq s7,s1, retLARGADA	# Se tiver tocado todas as notas, vai p/ retLARGADA
			lw a0,(s0)		# Coloca a nota em a0
			lw a1,4(s0)		# Coloca a duração em a1
			li a7,31
			ecall			# Toca a nota
			addi s7,s7,1		# Adiciona um ao contador de nota
			
			xori t6, t6, 1		# Faz xori para alternar os valores
			li a0,0xFF200604
			sw t6,0(a0)
			
			li t5, 2                # Coloca 2 p/ usar em contas
			mv a0,a1		# Coloca a duração em a0
			div a0,a0,t5		# Divide a duração por dois
			
			li a7,32
			ecall			# Realiza sleep(Pausa)
			
			xori t6, t6, 1		# Faz xori para alternar os valores
			li a0,0xFF200604
			sw t6,0(a0)
			
			mv a0,a1		# Coloca a duração em a0
			div a0,a0,t5		# Divide a duração por dois
			
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
	la t1, TEMPOGASOLINA		# Altera o tempo de mudança da gasolina
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
	
	la t1, PONTUAÇÃO
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, PONTUAÇÃO1
	li t3, 0x00000000
	sw t3, (t1)
	
	derrotaCONT:
	la t1, POSIÇÃOCARROM
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

tocaNA:	beq t0,t2, fimNA		# Termina se alcançar o n de notas
	lw a0,0(t1)			# Coloca nota
	lw a1,4(t1)			# Coloca duração	
	li a7,31		
	ecall			
	addi t0,t0,1	
	
	mv a0,a1		
	li a7,32		
	ecall				# Pausa o jogo pela duração
	
	addi t1,t1,8			# Próx nota/num
	j tocaNA			# Volta o loop
	
fimNA:	li a0, 1000
	li a7, 32
	ecall				# Pausa o jogo
	
	j MENU

VITORIA1:
	li a0, 500
	li a7, 32
	ecall				# Pausa o jogo
	
	lw t1, PONTUAÇÃOMAX
	lw t2, PONTUAÇÃO
	blt t2, t1, derrotaCONT
	la t3, PONTUAÇÃOMAX
	sw t2, (t3)
	
	la t1, PONTUAÇÃO
	li t2, 0
	sw t2, (t1)			# Reseta a pontuação
	
	la t1, PONTUAÇÃO1
	lw t2, PONTUAÇÃO
	sw t2, (t1)			# Guarda a pontuação em PONTUAÇÃO1
	
	la t1, CONTADORGASOLINA
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, POSIÇÃOCARROM
	li t3, 0xFF011584
	sw t3, (t1)
	
	lb t2, N2			# Desbloqueia o nível 2
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

tocaVY1:beq t0,t2, fimVY1		# Termina se alcançar o n de notas
	lw a0,0(t1)			# Coloca nota
	lw a1,4(t1)			# Coloca duração	
	li a7,31		
	ecall			
	addi t0,t0,1			
	
	mv t3, a1
	li a7, 30
	ecall
	add s1, t3, a0			# Atualiza com a nova duração
	
	addi t1,t1,8			# Próx nota/num
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
	
	lw t1, PONTUAÇÃO
	addi t1, t1, 100
	la t2, PONTUAÇÃO
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
	
	lw t1, PONTUAÇÃO
	addi t1, t1, 100
	la t2, PONTUAÇÃO
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
	
	lw t1, PONTUAÇÃO
	addi t1, t1, 100
	la t2, PONTUAÇÃO
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
	
	lw t1, PONTUAÇÃO
	addi t1, t1, 100
	la t2, PONTUAÇÃO
	sw t1, (t2)
	j moveCONT5
