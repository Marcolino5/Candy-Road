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

### MUSICAS ###
.include "Musicas/MusicaMenu.s"
.include "Musicas/Largada1.s"
.include "Musicas/MusicaLargada1.s"
.include "Musicas/Emotion.s"
.include "Musicas/MusicaVitoria.s"

### TILES ###
.include "Imagens/TileM.s"
.include "Imagens/Tile1.s"
.include "Imagens/Seta.s"

### MAPAS ###
.include "Imagens/Mapa1Og.s"
.include "Imagens/Mapa1.s"
.include "Imagens/Mapa2.s"
.include "Imagens/Mapa2.5.s"
.include "Imagens/Mapa2.55.s"
.include "Imagens/Mapa3.s"
.include "Imagens/Vitoria1.s"

### CARROS ###
.include "Imagens/CarroV0.data"
.include "Imagens/CarroS0.s"
.include "Imagens/CarroG0.s"
.include "Imagens/CarroL0.s"

TEMPOACELERADOR: .word 0x00000000
PONTUA��O: .word 0x00000000
PONTUA��OFASE1: .word 0x00000000
PONTUA��OFASE2: .word 0x00000000
TEMPOGASOLINA: .word 0x00000000
CONTADORGASOLINA: .word 0x00000000
POSI��OCARROM: .word 0xFF011584
CARRO: .word 0x00000000
CARROM: .word 0x00000000
UNLOCKED: .byte 0

NIMAGENS: .word 0x00000000
MAPAATUAL: .word 0x00000000
NLOOP: .word 0x00000000
RAPRINT: .word 0x00000000

.text
j MENU

# Inclui o Menu, com sele��o de personagens
.include "Menu.s"
	
FASE1:
	# Prepara��o da fase 1
	.include "Fase1/smapa1.s"
	
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 9
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
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
      	
      	la t1, MAPAATUAL
	la t2, Mapa2.5                  # Carrega Mapa2.5
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE
      	
      	la t1, MAPAATUAL
	la t2, Mapa2.55                 # Carrega Mapa2.55
	sw t2, (t1)			# Coloca endere�o de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 7
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE
      	
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
      	
      	la s3, Vitoria1
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE
      	
      	j VITORIA1
      	
# Inclui fun��es de print
.include "print.s"

# Printa imagens 320x240 em sequ�ncia, apresenta fun��o MOVE dentro
# >Argumentos: a1 (n de imagens)<
printSEQUENCE:
	la t1, RAPRINT
	sw ra, (t1) 				# Salva endere�o de retorno
			
	printSEQUENCE_LOOP:
		li t2,0xFF00001C
		li a4,216
		li a6,240
		lw a1,MAPAATUAL			# Carrega endere�o que est� em MAPAATUAL
		call printUND			# Printa a imagem no endere�o atual, que sai no processo +76800 (320 x 240)
		la t1, MAPAATUAL
		sw a1, (t1)			# Atualiza o endere�o em MAPAATUAL
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
		moveCONT2:
			# Move verticalmente
	   		li t4, 0xFF200000  		# Carrega endere�o do KDMMIO
			lw t0, 4(t4)	   		# l� codigo ASCII da tecla
			sw t0, 12(t4)      		# p�e no display
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