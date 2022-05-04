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

### OBSTÁCULOS ###
.include "Imagens/ColaE.s"
.include "Imagens/Bola1.s"

### MISC ###
.include "Imagens/Explosao1.s"
.include "Imagens/Explosao2.s"
.include "Imagens/Explosao3.s"

TEMPOACELERADOR: .word 0x00000000
PONTUAÇÃO: .word 0x00000000
PONTUAÇÃOMAX: .word 0x00000000
TEMPOGASOLINA: .word 0x00000000
CONTADORGASOLINA: .word 0x00000000
POSIÇÃOCARROM: .word 0xFF011584
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
ENDEREÇO0: .word 0x00000000	# Endereço auxiliar
ENDEREÇO1: .word 0xFF000918
ENDEREÇO2: .word 0x00000000
ENDEREÇO3: .word 0xFEFFE3EC

.text
j MENU
.include "SYSTEMv21.s"
# Inclui o Menu, com seleção de personagens
.include "Menu.s"
	
FASE1:
	# Preparação da fase 1
	.include "Fase1/smapa1.s"
	
	la t1, PARTE
	li t2, 1
	sw t2, (t1)			# Define que está na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 9
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE	        # Chama função PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 2
	sw t2, (t1)			# Define que está na 2 parte
      	la t1, NLOOP
      	li t2, 24
      	sw t2, (t1)			# Define quantas vezes o loop será chamado
      	
  	MAPA1.2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa2                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 serão printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA1.2_LOOP
      	
      	la t1, PARTE
	li t2, 3
	sw t2, (t1)			# Define que está na 3 parte
      	la t1, MAPAATUAL
	la t2, Mapa2.5                  # Carrega Mapa2.5
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE
      	
      	la t1, PARTE
	li t2, 4
	sw t2, (t1)			# Define que está na 5 parte
      	la t1, NLOOP
      	li t2, 24
      	sw t2, (t1)			# Define quantas vezes o loop será chamado
  	MAPA1.3_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa3                    # Carrega Mapa3
		sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)			# Atualiza o valor de NLOOP
      		bnez t2, MAPA1.3_LOOP
      	
      	la t1, PARTE
	li t2, 5
	sw t2, (t1)			# Define que está na 6 parte
      	la s3, Vitoria1
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE
      	
      	j VITORIA1
      	
# Inclui funções de print
.include "print.s"

# Printa imagens em sequência - Fase 1
# >Argumentos: a1 (n de imagens)<
printSEQUENCE:
	la t1, RAPRINT
	sw ra, (t1) 				# Salva endereço de retorno
	
	printSEQUENCE_LOOP:
		la t1, JAPRINTOU
		li t2, 0
		sw t2, (t1)			# Faz com que o obstáculo possa mudar de endereço novamente
		la t1, JAPRINTOUAUX
		li t2, 0
		sw t2, (t1)			# Faz com que obstáculos possam mudar o endereço novamente em conjunto
	
		li t2,0xFF00001C
		li a4,216
		li a6,240
		lw a1,MAPAATUAL			# Carrega endereço que está em MAPAATUAL
		call printUND			# Printa a imagem no endereço atual, que sai no processo +76800 (320 x 240)
		la t1, MAPAATUAL
		sw a1, (t1)			# Atualiza o endereço em MAPAATUAL
		
		# Inclusão dos obstáculos ao mapa
	OBST1:
		lw t3, PARTE
		li t4, 2
		bne t3, t4, OBST2		# Define parte onde será impresso
		lw t2, NLOOP
		li t3, 24
		bne t2, t3, OBST2		# Especifica parte onde será impresso
		
		lw t2, NIMAGENS
		li t3, 0
		li t4, 8
		
		blt t2, t3, OBST2		# Define começo das impressões
		bgt t2, t4, OBST2		# Define final das impressões
		
		lw t2, ENDEREÇO1		# Define endereço
		la a1, ColaE		
		li a4, 16			# Define largura da imagem
		li a6, 16			# Define altura da imagem
		call printUND
		lw t2, ENDEREÇO1		# Define endereço
		call GASOLINAE			# Faz processos relacionados ao tipo de obstáculo
		la t1, ENDEREÇO1
		sw t2, (t1)
		
		li t1, 0
		lb t1, JAPRINTOU
		bnez t1, OBST2				# Verifica se é a primeira vez
			
		lw t2, ENDEREÇO3
		li t4, 320
		li t5, 30
		mul t6, t4, t5
		add t2, t2, t6
		la t4, ENDEREÇO3
		sw t2, (t4)				# Atualiza endereço
			
		la t1, JAPRINTOU
		li t2, 1
		sb t2, (t1)				# Modifica JAPRINTOU para que não repita
	OBST2:
		lw t3, PARTE
		li t4, 2
		bne t3, t4, moveCONT2		# Define parte onde será impresso
		lw t2, NLOOP
		li t3, 24
		bne t2, t3, moveCONT2		# Especifica parte onde será impresso
		
		lw t2, NIMAGENS
		li t3, 0
		li t4, 8
		
		blt t2, t3, moveCONT2		# Define começo das impressões
		bgt t2, t4, moveCONT2		# Define final das impressões
		lw t2, ENDEREÇO3		# Define endereço
		la a1, Bola1		
		li a4, 16			# Define largura da imagem
		li a6, 16			# Define altura da imagem
		call printUND
		lw t2, ENDEREÇO3		# Define endereço
		call BOLAE			# Faz processos relacionados ao tipo de obstáculo	
		
		# Gasolina, aceleração, etc
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
			
		# INCLUSÃO DOS OBSTÁCULOS AO MAPA
		posMOVE:
			
		moveCONT2:
			# Move verticalmente
	   		li t4, 0xFF200000  		# Carrega endereço do KDMMIO
			lw t0, 4(t4)	   		# lê codigo ASCII da tecla
			sw t0, 12(t4)      		# Põe no display
			sw zero, 4(t4)    		# Limpa o código ASCII
			
			li t1, 87          		# Código ASCII do W
			beq t0, t1, moveCONT3  		# Se código == W, pula e continua
			li t1, 119          		# Código ASCII do w
			beq t0, t1, moveCONT3		# Se código == w, pula e continua
			
			li a7, 30			# Checa se já passou o tempo
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
			lw t2, POSIÇÃOCARROM
			li t4, 2
			lw t6, NIMAGENS
			rem t5, t6, t4
			bnez t5, moveCONT4		# Move só a cada 2 passos

			li t2, 0xFF000000
			la a1, MapINTER
			li a4, 20			# Define largura da imagem
			li a6, 240			# Define altura da imagem
			call printUND			# Printa o mapa da interface de novo p/ retirar rastro

			lw t2, POSIÇÃOCARROM
			li t1, -320
			add t2, t2, t1			# Coloca nova posição do carro da interface
		moveCONT4:
			add a7, t2, zero
			lw a1, CARROM
			li a4, 8			# Define largura da imagem
			li a6, 16			# Define altura da imagem
			call printUND
			la t3, POSIÇÃOCARROM
			sw a7, (t3)			# Guarda a nova posição
			
			
			
			lw t1, PONTUAÇÃO
			addi t1, t1, 100
			la t2, PONTUAÇÃO
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
	sw t2, (t1)			# Define que está na 2 parte
      	la t1, NLOOP
      	li t2, 46
      	sw t2, (t1)			# Define quantas vezes o loop será chamado
      	
  	MAPA2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa4                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 serão printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA2_LOOP
      		
      	la t1, PARTE
	li t2, 2
	sw t2, (t1)			# Define que está na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa5                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE	        # Chama função PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 3
	sw t2, (t1)			# Define que está na 2 parte
      	la t1, NLOOP
      	li t2, 2
      	sw t2, (t1)			# Define quantas vezes o loop será chamado
      	
  	MAPA2.2_LOOP:
      		la t1, MAPAATUAL
		la t2, Mapa2                    # Carrega Mapa2
		sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      		la t1, NIMAGENS
		li t2, 8
		sw t2, (t1)		# Define quantas imagens 320x240 de Mapa1 serão printadas
      		call printSEQUENCE
      		
      		la t1, NLOOP
      		lw t2, NLOOP
      		addi t2, t2, -1
      		sw t2, (t1)		# Atualiza o valor de NLOOP
      		bnez t2, MAPA2.2_LOOP
      		
      	la t1, PARTE
	li t2, 4
	sw t2, (t1)			# Define que está na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa6                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE	        # Chama função PRINT-SEQUENCE
      	
      	la t1, PARTE
	li t2, 5
	sw t2, (t1)			# Define que está na 1 parte
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE	        # Chama função PRINT-SEQUENCE
      	
	j VITORIA2

.include "obstaculos.s"

VITORIA2:
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
	sw t2, (t1)			# Zera a pontuação
	
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

tocaVY2:beq t0,t2, fimVY2		# Termina se alcançar o n de notas
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
