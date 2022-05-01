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
PONTUAÇÃO: .word 0x00000000
PONTUAÇÃOFASE1: .word 0x00000000
PONTUAÇÃOFASE2: .word 0x00000000
TEMPOGASOLINA: .word 0x00000000
CONTADORGASOLINA: .word 0x00000000
POSIÇÃOCARROM: .word 0xFF011584
CARRO: .word 0x00000000
CARROM: .word 0x00000000
UNLOCKED: .byte 0

NIMAGENS: .word 0x00000000
MAPAATUAL: .word 0x00000000
NLOOP: .word 0x00000000
RAPRINT: .word 0x00000000

.text
j MENU	
MENU:						
	la a0, Menu
	call PRINT          # Printa o Menu
	li s10, 0xFF00CC28  # Endereço de início da impressão da seta
menuMUSICA:	
	#Parte que toca música
	la s0,notasMENU		# Carrega notas do menu	
	li s7,0			# Inicia contador de notas
	SETA:
		beqz s7, playMUSICA  # Se contador = 0, entra na música direto
		li a7, 30	     
		ecall		     # Chama syscall TIME
		blt a0, s8, setaCONT # Compara os dois tempos
		addi s0,s0,8	     # Se a0 >= s8, continua a tocar
	playMUSICA:
		call tocamusicaMENU
	setaCONT:
		la a1, Seta
		li a4, 20           # Largura da seta
		li a6, 16	    # Altura da seta

		add t2, s10, zero
		
		call printUND     # Printa a seta
	
		li t1, 87         # Código ASCII do W
		li t2, 119	  # Código ASCII do w
 		li t3, 83         # Código ASCII do S
		li t4, 115        # Código ASCII do s
		li a1, 32         # Código ASCII do espaço
		
		li t5, 0xFF200000 # Carrega endereço do KDMMIO
		lw t0, 4(t5)      # Lê código ASCII da tecla
		sw t0, 12(t5)     # Põe no display
		sw zero, 4(t5)    # Limpa o código ASCII 
		
		beq t0, t1, SETAU # Se aperta em W sobe a seta
		beq t0, t2, SETAU
		
		beq t0, t3, SETAD # Se aperta em S desce a seta
		beq t0, t4, SETAD
		
		li t1, 0xFF00CC28
		beq s10, t1, goMAPA1
		j SETA # Se não tiver no endereço, volta p/ SETA
		
	goMAPA1:li s11, 0xFF002E71
		beq t0, a1, CHARACTERSELECTION1
		
		j SETA # Se não tiver apertado, volta p/ SETA
	SETAU:  
		li t1, 0xFF00CC28
		beq s10, t1, SETA
		
		add t2, s10, zero
		la a1, TileM
		li a4, 20
		li a6, 16
		call printUND
		
		li t6, -9600
		add s10, s10, t6
		j SETA
	SETAD:
		li t1, 0xFF00F1A8
		beq s10, t1, SETA
		
		add t2, s10, zero
		la a1, TileM
		li a4, 20
		li a6, 16
		call printUND
		
		li t6, 9600
		add s10, s10, t6
		j SETA
	
COURSE1:
	la t1, TEMPOACELERADOR
	li a7, 30
	ecall
	sw a0, (t1)			# Coloca tempo inicial no TEMPOACELERADOR
	
	la a0, Course1
	call PRINT
	
	li a7, 32
	li a0, 2000
	ecall
	
	j FASE1
CHARACTERSELECTION1:
	la a0, CharacterSelection
	call PRINT
	ESCOLHA1:
		beqz s7, playMUSICA2  # Se contador = 0, entra na música direto
		li a7, 30	     
		ecall		     # Chama syscall TIME
		blt a0, s8, escolha1CONT # Compara os dois tempos
		addi s0,s0,8	     # Se a0 >= s8, continua a tocar
	playMUSICA2:
		call tocamusicaCS
	escolha1CONT:
		add t2, s11, zero
		la a1, Selected
		li a4, 72			# Define largura da imagem
		li a6, 88			# Define altura da imagem
		call printUND
	
		li t5, 0xFF200000 # Carrega endereço do KDMMIO
		lw t0, 4(t5)      # Lê código ASCII da tecla
		sw t0, 12(t5)     # Põe no display
		sw zero, 4(t5)    # Limpa o código ASCII
	
		li t1, 87         # Código ASCII do W
		beq t1, t0, SELECTEDW1
		li t1, 119	  # Código ASCII do w
		beq t1, t0, SELECTEDW1
	
 		li t1, 83         # Código ASCII do S
 		beq t1, t0, SELECTEDS1
		li t1, 115        # Código ASCII do s
		beq t1, t0, SELECTEDS1
	
		li t1, 65	  # Código ASCII do A
		beq t1, t0, SELECTEDA1
		li t1, 97	  # Código ASCII do a
		beq t1, t0, SELECTEDA1
	
		li t1, 68	  # Código ASCII do D
		beq t1, t0, SELECTEDD1
		li t1, 100	  # Código ASCII do d
		beq t1, t0, SELECTEDD1
	
		li t1, 32         # Código ASCII do espaço
		beq t1, t0, SELECTEDSPACE1
	
		j ESCOLHA1
		SELECTEDW1:
			li t1, 0xFF002E71
			beq t1, s11, ESCOLHA1
			li t1, 0xFF002EF9
			beq t1, s11, ESCOLHA1		# Limita a movimentação
			
			add t2, s11, zero
			la a1, Unselected
			li a4, 72			# Define largura da imagem
			li a6, 88			# Define altura da imagem
			call printUND			# Limpa rastro
			
	   		li t1, -31680
	   		add s11, t1, s11
	   		j ESCOLHA1
		SELECTEDS1:
			li t1, 0xFF00AA31
			beq t1, s11, ESCOLHA1
			li t1, 0xFF00AAB9
			beq t1, s11, ESCOLHA1		# Limita a movimentação
		
			add t2, s11, zero
			la a1, Unselected
			li a4, 72			# Define largura da imagem
			li a6, 88			# Define altura da imagem
			call printUND			# Limpa rastro
			
			li t1, 31680
			add s11, t1, s11
			j ESCOLHA1	
		SELECTEDA1:
			li t1, 0xFF002E71
			beq t1, s11, ESCOLHA1
			li t1, 0xFF00AA31
			beq t1, s11, ESCOLHA1		# Limita a movimentação
			
			add t2, s11, zero
			la a1, Unselected
			li a4, 72			# Define largura da imagem
			li a6, 88			# Define altura da imagem
			call printUND			# Limpa rastro
			
			addi s11, s11, -136
			j ESCOLHA1
		SELECTEDD1:
			li t1, 0xFF002EF9
			beq t1, s11, ESCOLHA1
			li t1, 0xFF00AAB9
			beq t1, s11, ESCOLHA1           # Limita a movimentação
			
			add t2, s11, zero
			la a1, Unselected
			li a4, 72			# Define largura da imagem
			li a6, 88			# Define altura da imagem
			call printUND			# Limpa rastro
			
			addi s11, s11, 136
			j ESCOLHA1
		SELECTEDSPACE1:
			li t1, 0xFF002E71
			beq s11, t1, VANELLOPE1		# Escolheu Vanellope
			li t1, 0xFF002EF9
			beq s11, t1, GLOYD1		# Escolheu Gloyd
			li t1, 0xFF00AA31
			beq s11, t1, SNOWANNA1		# Escolheu Snowanna
			lb t1, UNLOCKED
			beqz t1, ESCOLHA1
			li t1, 0xFF00AAB9
			beq s11, t1, LAMAR1		# Escolheu Lamar	
FASE1:
	li s10, 0xFF00FE30       	# Define inicio p/ MoveCARRO - NÃO USAR REGISTRADOR EM OUTRAS PARTES
	li s11, 0                       # Contador da aceleração - NÃO USAR REGISTRADOR EM OUTRAS PARTES
	
	li t2, 0xFF100000		# Define início na Frame 1
	la a1, Mapa1Og		
	li a4, 320			# Define largura da imagem
	li a6, 240			# Define altura da imagem
	call printUND
	
	li t2, 0xFF106A08
	la a1, Acelerador1
	li a4, 40			# Define largura da imagem
	li a6, 24			# Define altura da imagem
	call printUND
	
	li t2, 0xFF10D948
	la a1, Fuel
	li a4, 24			# Define largura da imagem
	li a6, 40			# Define altura da imagem
	call printUND
	
	li t2, 0xFF111584
	lw a1, CARROM
	li a4, 8			# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND
	
	li t2, 0xFF102F3C
	la a1, Pontos
	li a4, 60
	li a6, 12
	call printUND
	
	la s9, Fuel			# Define inicio p/ GASOLINA - NÃO USAR REGISTRADOR EM OUTRAS PARTES 
	
	la a0, Mapa1Og		        # Carrega Mapa1
	call PRINT                      # Chama a função PRINT
	
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	lw a1, CARRO
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND
	
	li t2, 0xFF006A08
	la a1, Acelerador1
	li a4, 40			# Define largura da imagem
	li a6, 24			# Define altura da imagem
	call printUND
	
	li t2, 0xFF00D948
	la a1, Fuel
	li a4, 24			# Define largura da imagem
	li a6, 40			# Define altura da imagem
	call printUND
	
	li t2, 0xFF011584
	lw a1, CARROM
	li a4, 8			# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND
	
	li t2, 0xFF002F3C
	la a1, Pontos
	li a4, 60
	li a6, 12
	call printUND
	
	li t6, 0                        # Define frame como 0
	la s0, notasMLARGADA1           # Carrega notas da largada
	li s7, 0			# Inicia contador de notas
	call LARGADA                    # Chama a função LARGADA
	
	la t1, MAPAATUAL
	la t2, Mapa1                    # Carrega Mapa1
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
	la t1, NIMAGENS
	li t2, 9
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE	        # Chama função PRINT-SEQUENCE
      	
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
      	
      	la t1, MAPAATUAL
	la t2, Mapa2.5                  # Carrega Mapa2.5
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE
      	
      	la t1, MAPAATUAL
	la t2, Mapa2.55                 # Carrega Mapa2.55
	sw t2, (t1)			# Coloca endereço de Mapa1 em MAPAATUAL
      	la t1, NIMAGENS
	li t2, 7
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE
      	
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
      	
      	la s3, Vitoria1
      	la t1, NIMAGENS
	li t2, 8
	sw t2, (t1)			# Define quantas imagens 320x240 de Mapa1 serão printadas
      	call printSEQUENCE
      	
      	j VITORIA1

COURSE2:
	la a0, Course2
	call PRINT
	
	li a7, 32
	li a0, 2000
	ecall
	
	j MENU
      	

# Printa uma imagem 320x240
PRINT:		
	li t1,0xFF000000	       # Define início
	li t2,0xFF012C00               # Define fim
			
	PRINT_LOOP: 	
		beq t1,t2,PRINT_EXIT   # Checa se final é igual ao inicial
		lw t3,0(a0)	       # Lê 4 pixels
		sw t3,0(t1)	       # Escreve a word na memória
		addi t1,t1,4           # Soma 4 ao inicial
		addi a0,a0,4           # Soma 4 ao endereço da imagem
		j PRINT_LOOP

	PRINT_EXIT: ret

# Printa imagens 320x240 em sequência, apresenta função MOVE dentro
# >Argumentos: a1 (n de imagens)<
printSEQUENCE:
	la t1, RAPRINT
	sw ra, (t1) 				# Salva endereço de retorno
			
	printSEQUENCE_LOOP:
		li t2,0xFF00001C
		li a4,216
		li a6,240
		lw a1,MAPAATUAL			# Carrega endereço que está em MAPAATUAL
		call printUND			# Printa a imagem no endereço atual, que sai no processo +76800 (320 x 240)
		la t1, MAPAATUAL
		sw a1, (t1)			# Atualiza o endereço em MAPAATUAL
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
	   		li t4, 0xFF200000  		# Carrega endereço do KDMMIO
			lw t0, 4(t4)	   		# lê codigo ASCII da tecla
			sw t0, 12(t4)      		# põe no display
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
		
# Printa imagem com dimensões definidas fora da função
# >Argumentos: a1 (Endereço da imagem), t2 (Endereço de início da impressão), a4 (Largura), a6 (Altura)
# a2 = Endereço final da impressão (ñ é argumento)
printUND:
	add a5, t2, zero        # Guarda valor do endereço inicial em a5
	
	li t5,1                  # Inicializa contador
	li t6,320                # 320 p/ usar em contas
	
	# Conta p/ conseguir o endereço final
	addi a2,a6,-1
	mul a2,a2,t6
	add a2,a2,a4
	add a2,a2,t2
	
	printUND_LOOP1:
		add t4,a5,zero           # Guarda valor do endereço inicial em t4	
		mul t0,t6,t5             # Faz 320 * contador
		add t4,t4,t0             # Define qual será o próximo endereço
	
		add a3,t2,zero           # Guarda valor do endereço inicial em a3
		add a3,a3,a4             # Soma o endereço inicial à largura
	
	printUND_LOOP2:
		beq t2,a3,printUND_EXIT # Sai quando tiver printado valor correspondente à largura
		lw t1,0(a1)              # Lê 4 pixels
		sw t1,0(t2)              # Escreve a word na memória
		addi t2,t2,4             # Soma 4 ao inicial
		addi a1,a1,4             # Soma 4 ao endereço da imagem
		j printUND_LOOP2
	
	printUND_EXIT:	
		addi t5,t5,1              # Adiciona 1 ao contador	
		add t2,t4,zero            # Coloca o próximo endereço
		blt t2,a2,printUND_LOOP1 # Faz branch enquanto não alcança o endereço final
		ret

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
	
	j moveCONT2
moveCARROR:
	li t2, 0xFF00FE70
	beq s10, t2, PRINT_EXIT
	
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
	li t2, 0xFF00FE70
	beq s10, t2, PRINT_EXIT

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
	
fimNA:	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	j MENU

VITORIA1:
	li a0, 1000
	li a7, 32
	ecall				# Pausa o jogo
	
	la t1, PONTUAÇÃO
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, CONTADORGASOLINA
	li t3, 0x00000000
	sw t3, (t1)
	
	la t1, POSIÇÃOCARROM
	li t3, 0xFF011584
	sw t3, (t1)
	
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
	
	
	
	
VANELLOPE1:
	la t1, CARRO
	la t2, CarroV0
	sw t2, (t1)		# Coloca carro da Vanellope em CARRO
	
	la t1, CARROM
	la t2, CarroVM
	sw t2, (t1)		# Coloca carro da Vanellope na interface
	
	li a7, 31
	li a0, 67
	li a1, 1000
	li a2, 3
	li a3, 72
	ecall		#Toca única nota
	j COURSE1
GLOYD1:
	la t1, CARRO
	la t2, CarroG0
	sw t2, (t1)		# Coloca carro do Gloyd em CARRO
	
	la t1, CARROM
	la t2, CarroGM
	sw t2, (t1)		# Coloca carro do Gloyd na interface
	
	li a7, 31
	li a0, 67
	li a1, 1000
	li a2, 3
	li a3, 72
	ecall		#Toca única nota
	j COURSE1
SNOWANNA1:
	la t1, CARRO
	la t2, CarroS0
	sw t2, (t1)
	
	la t1, CARROM
	la t2, CarroSM
	sw t2, (t1)
	
	li a7, 31
	li a0, 67
	li a1, 1000
	li a2, 3
	li a3, 72
	ecall		#Toca única nota
	j COURSE1
LAMAR1:
	la t1, CARRO
	la t2, CarroL0
	sw t2, (t1)
	
	la t1, CARROM
	la t2, CarroLM
	sw t2, (t1)
	
	li a7, 31
	li a0, 67
	li a1, 1000
	li a2, 3
	li a3, 72
	ecall		#Toca única nota
	j COURSE1
