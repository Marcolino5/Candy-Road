.include "MACROSv21.s"
.data

### INTERFACE ###
.include "Imagens/Menu.s"
.include "Imagens/Course1.s"
.include "Imagens/Course2.s"
.include "Imagens/CharacterSelection.s"
.include "Imagens/Lamar.s"
.include "Imagens/Selected.s"
.include "Imagens/Unselected.s"

.include "Imagens/CarroVM.s"
.include "Imagens/CarroSM.s"
.include "Imagens/CarroGM.s"
.include "Imagens/CarroLM.s"
.include "Imagens/Map.s"

.include "Imagens/Acelerador1.s"
.include "Imagens/Acelerador2.s"
.include "Imagens/Acelerador3.s"

.include "Imagens/Fuel.s"
.include "Imagens/Empty.s"

.include "Imagens/Coin.s"
.include "Imagens/Pontos.s"

.include "Imagens/Gameover.s"
.include "Imagens/Checkpoint.s"
.include "Imagens/Goal.s"

### MUSICAS ###
.include "Musicas/MusicaMenu.s"
.include "Musicas/Largada1.s"
.include "Musicas/MusicaLargada1.s"
.include "Musicas/Emotion.s"
.include "Musicas/MusicaVitoria.s"
.include "Musicas/Thousand.s"

### TILES ###
.include "Imagens/TileM.s"
.include "Imagens/Tile1.s"
.include "Imagens/Seta.s"

### MAPAS ###
.include "Imagens/Mapa1Og.s"
.include "Imagens/Mapa1.s"
.include "Imagens/Mapa2.s"
.include "Imagens/Mapa2.5.s"
.include "Imagens/Mapa3.s"
.include "Imagens/Vitoria1.s"
.include "Imagens/Mapa4Og.s"
.include "Imagens/Mapa4.s"
.include "Imagens/Mapa5.s"
.include "Imagens/Mapa6.s"

### CARROS ###
.include "Imagens/CarroV0.data"
.include "Imagens/CarroS0.s"
.include "Imagens/CarroG0.s"
.include "Imagens/CarroL0.s"

### OBST�CULOS ###
.include "Imagens/ColaE.s"
.include "Imagens/Bola1.s"

### MISC ###
.include "Imagens/Explosao1.s"
.include "Imagens/Explosao2.s"
.include "Imagens/Explosao3.s"

TEMPOACELERADOR: .word 0x00000000
PONTUA��O: .word 0x00000000
PONTUA��OMAX: .word 0x00000000
TEMPOGASOLINA: .word 0x00000000
CONTADORGASOLINA: .word 0x00000000
POSI��OCARROM: .word 0xFF011584
CARRO: .word 0x00000000
CARROM: .word 0x00000000
UNLOCKED: .byte 0
N2: .byte 0

NIMAGENS: .word 0x00000000
MAPAATUAL: .word 0x00000000
PARTE: .word 0x00000000
NLOOP: .word 0x00000000
RAPRINT: .word 0x00000000

JAPRINTOU: .byte 0
JAPRINTOUAUX: .byte 0
TEMPOEXPLOSAO: .word 0x00000000
ENDERE�O0: .word 0x00000000	# Endere�o auxiliar
ENDERE�O1: .word 0xFF000918
ENDERE�O2: .word 0x00000000
ENDERE�O3: .word 0xFEFFE3EC

.text
j MENU
.include "SYSTEMv21.s"
# Inclui o Menu, com sele��o de personagens
.include "Menu.s"
	
FASE1:
	# Prepara��o da fase 1
	.include "Fase1/smapa1.s"
	
	la t1, PARTE
	li t2, 1
	sw t2, (t1)			# Define que est� na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 9
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 2
	sw t2, (t1)			# Define que est� na 2 parte
      	la t1, NLOOP
      	li t2, 24
      	sw t2, (t1)			# Define quantas vezes o loop ser� chamado
      	
  	MAPA1.2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa2                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA1.2_LOOP
      	
      	la t1, PARTE
	li t2, 3
	sw t2, (t1)			# Define que est� na 3 parte
      	la t1, MAPAATUAL
	la t2, Mapa2.5                  # Carrega Mapa2.5
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE
      	
      	la t1, PARTE
	li t2, 4
	sw t2, (t1)			# Define que est� na 5 parte
      	la t1, NLOOP
      	li t2, 24
      	sw t2, (t1)			# Define quantas vezes o loop ser� chamado
  	MAPA1.3_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa3                    # Carrega Mapa3
		sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)			# Atualiza o valor de NLOOP
      		bnez t2, MAPA1.3_LOOP
      	
      	la t1, PARTE
	li t2, 5
	sw t2, (t1)			# Define que est� na 6 parte
      	la s3, Vitoria1
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE
      	
      	j VITORIA1
      	
# Inclui fun��es de print
.include "print.s"

# Printa imagens em sequ�ncia - Fase 1
# >Argumentos: a1 (n de imagens)<
printSEQUENCE:
	la t1, RAPRINT
	sw ra, (t1) 				# Salva endere�o de retorno
	
	printSEQUENCE_LOOP:
		la t1, JAPRINTOU
		li t2, 0
		sw t2, (t1)			# Faz com que o obst�culo possa mudar de endere�o novamente
		la t1, JAPRINTOUAUX
		li t2, 0
		sw t2, (t1)			# Faz com que obst�culos possam mudar o endere�o novamente em conjunto
	
		li t2,0xFF00001C
		li a4,216
		li a6,240
		lw a1,MAPAATUAL			# Carrega endere�o que est� em MAPAATUAL
		call printUND			# Printa a imagem no endere�o atual, que sai no processo +76800 (320 x 240)
		la t1, MAPAATUAL
		sw a1, (t1)			# Atualiza o endere�o em MAPAATUAL
		
		# Inclus�o dos obst�culos ao mapa
	OBST1:
		lw t3, PARTE
		li t4, 2
		bne t3, t4, OBST2		# Define parte onde ser� impresso
		lw t2, NLOOP
		li t3, 24
		bne t2, t3, OBST2		# Especifica parte onde ser� impresso
		
		lw t2, NIMAGENS
		li t3, 0
		li t4, 8
		
		blt t2, t3, OBST2		# Define come�o das impress�es
		bgt t2, t4, OBST2		# Define final das impress�es
		
		lw t2, ENDERE�O1		# Define endere�o
		la a1, ColaE		
		li a4, 16			# Define largura da imagem
		li a6, 16			# Define altura da imagem
		call printUND
		lw t2, ENDERE�O1		# Define endere�o
		call GASOLINAE			# Faz processos relacionados ao tipo de obst�culo
		la t1, ENDERE�O1
		sw t2, (t1)
		
		li t1, 0
		lb t1, JAPRINTOU
		bnez t1, OBST2				# Verifica se � a primeira vez
			
		lw t2, ENDERE�O3
		li t4, 320
		li t5, 30
		mul t6, t4, t5
		add t2, t2, t6
		la t4, ENDERE�O3
		sw t2, (t4)				# Atualiza endere�o
			
		la t1, JAPRINTOU
		li t2, 1
		sb t2, (t1)				# Modifica JAPRINTOU para que n�o repita
	OBST2:
		lw t3, PARTE
		li t4, 2
		bne t3, t4, moveCONT2		# Define parte onde ser� impresso
		lw t2, NLOOP
		li t3, 24
		bne t2, t3, moveCONT2		# Especifica parte onde ser� impresso
		
		lw t2, NIMAGENS
		li t3, 0
		li t4, 8
		
		blt t2, t3, moveCONT2		# Define come�o das impress�es
		bgt t2, t4, moveCONT2		# Define final das impress�es
		lw t2, ENDERE�O3		# Define endere�o
		la a1, Bola1		
		li a4, 16			# Define largura da imagem
		li a6, 16			# Define altura da imagem
		call printUND
		lw t2, ENDERE�O3		# Define endere�o
		call BOLAE			# Faz processos relacionados ao tipo de obst�culo	
		
		# Gasolina, acelera��o, etc
	MOVE:
		attGASOLINA:
			li a7, 30
			ecall
			lw t1, TEMPOGASOLINA
			beqz t1, PRINTAGASOLINA
			blt a0, t1, attACELERACAO
			j PRINTAGASOLINA
			
		attACELERACAO:
			beqz s11,ACELERADOR1
			li t1,1
			beq s11,t1,ACELERADOR2
			bgt s11,t1,ACELERADOR3
			
		moveCONT1:
			call moveCARRO
			
		# INCLUS�O DOS OBST�CULOS AO MAPA
		posMOVE:
			
		moveCONT2:
			# Move verticalmente
	   		li t4, 0xFF200000  		# Carrega endere�o do KDMMIO
			lw t0, 4(t4)	   		# l� codigo ASCII da tecla
			sw t0, 12(t4)      		# P�e no display
			sw zero, 4(t4)    		# Limpa o c�digo ASCII
			
			li t1, 87          		# C�digo ASCII do W
			beq t0, t1, moveCONT3  		# Se c�digo == W, pula e continua
			li t1, 119          		# C�digo ASCII do w
			beq t0, t1, moveCONT3		# Se c�digo == w, pula e continua
			
			li a7, 30			# Checa se j� passou o tempo
			ecall
			lw t1,TEMPOACELERADOR
			blt a0,t1,MOVE
			
			# Define novo tempo
			li t2, 0x000003E8
			add t2, a0, t2			# Adiciona 1 segundo ao tempo
			la t1,TEMPOACELERADOR
			sw t2,(t1)
			
			add s11, zero, zero
		
			j MOVE
		moveCONT3:
			lw t2, POSI��OCARROM
			li t4, 2
			lw t6, NIMAGENS
			rem t5, t6, t4
			bnez t5, moveCONT4		# Move s� a cada 2 passos

			li t2, 0xFF000000
			la a1, MapINTER
			li a4, 20			# Define largura da imagem
			li a6, 240			# Define altura da imagem
			call printUND			# Printa o mapa da interface de novo p/ retirar rastro

			lw t2, POSI��OCARROM
			li t1, -320
			add t2, t2, t1			# Coloca nova posi��o do carro da interface
		moveCONT4:
			add a7, t2, zero
			lw a1, CARROM
			li a4, 8			# Define largura da imagem
			li a6, 16			# Define altura da imagem
			call printUND
			la t3, POSI��OCARROM
			sw a7, (t3)			# Guarda a nova posi��o
			
			
			
			lw t1, PONTUA��O
			addi t1, t1, 100
			la t2, PONTUA��O
			sw t1, (t2)
			
			li t3, 8000
			beq t1, t3, MOEDA1
			li t3, 16000
			beq t1, t3, MOEDA2
			li t3, 24000
			beq t1, t3, MOEDA3
			li t3, 40000
			beq t1, t3, MOEDA4
		moveCONT5:
			addi s11, s11, 1
			la t1, NIMAGENS
			lw t2, NIMAGENS
			addi t2, t2, -1			# Diminui 1 de t2 na contagem
			sw t2, (t1)
			bnez t2, printSEQUENCE_LOOP  	# Loop enquanto s1 != a1
				
			lw ra, RAPRINT
			ret

# Inclui partes adicionais do mapa1
.include "Fase1/fmapa1.s"

FASE2:
	.include "Fase2/smapa2.s"
	
	la t1, PARTE
	li t2, 1
	sw t2, (t1)			# Define que est� na 2 parte
      	la t1, NLOOP
      	li t2, 46
      	sw t2, (t1)			# Define quantas vezes o loop ser� chamado
      	
  	MAPA2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa4                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA2_LOOP
      		
      	la t1, PARTE
	li t2, 2
	sw t2, (t1)			# Define que est� na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa5                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 3
	sw t2, (t1)			# Define que est� na 2 parte
      	la t1, NLOOP
      	li t2, 2
      	sw t2, (t1)			# Define quantas vezes o loop ser� chamado
      	
  	MAPA2.2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa2                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA2.2_LOOP
      		
      	la t1, PARTE
	li t2, 4
	sw t2, (t1)			# Define que est� na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa6                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 5
	sw t2, (t1)			# Define que est� na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
	j VITORIA2

.include "obstaculos.s"

VITORIA2:
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
	sw t2, (t1)			# Zera a pontua��o
	
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
looptocaVY2:
	mv s11, t2
	mv s9, t1
	mv s8, t0
	mv s7, a2
	mv s6, a3
	
	li a7, 30
	ecall
	bge a0, s2, movecarroVY2
	j looptocaVY2CONT
movecarroVY2:
	li t1, 0xFF000140
	ble s10, t1, removeCARRO2
	
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
looptocaVY2CONT:	
	beqz s4, looptocaVY2CONT2
	li t2, 0xFF006330
	la a1, Goal
	li a4, 48
	li a6, 16
	call printUND			# Coloca imagem de checkpoint
looptocaVY2CONT2:
	mv t2, s11
	mv t1, s9
	mv t0, s8
	mv a2, s7
	mv a3, s6
	
	li a7, 30
	ecall
	bge a0, s1, tocaVY2
	j looptocaVY2

tocaVY2:beq t0,t2, fimVY2		# Termina se alcan�ar o n de notas
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
	j looptocaVY2			# Volta o loop
	
fimVY2:	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	la t1, UNLOCKED
	li t2, 1
	sb t2, (t1)			# Desbloqueia Lamar
	
	j MENU
	
removeCARRO2:
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	la a1, TILE1
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND			# Remove rastro
	li s4, 1
	j looptocaVY2CONT
