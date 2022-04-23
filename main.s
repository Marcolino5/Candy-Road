.data

### INTERFACE ###
.include "Imagens/Menu.s"
.include "Imagens/Course1.s"

.include "Imagens/Acelerador1.s"
.include "Imagens/Acelerador2.s"
.include "Imagens/Acelerador3.s"

.include "Imagens/Fuel.s"

.include "Imagens/Empty.s"
.include "Imagens/Gameover.s"

### MUSICAS ###
.include "Musicas/MusicaMenu.s"
.include "Musicas/Largada1.s"
.include "Musicas/MusicaLargada1.s"
.include "Musicas/Naruto.s"

### TILES ###
.include "Imagens/TileM.s"
.include "Imagens/Tile1.s"
.include "Imagens/Seta.s"

### MAPAS ###
.include "Imagens/Mapa1Og.s"
.include "Imagens/Mapa1.s"
.include "Imagens/Mapa2.s"

### CARROS ###
.include "Imagens/CarroV0.data"

TEMPOACELERADOR: .word 0x00000000
PONTUA��O: .word 0x00000000
PONTUA��OFASE1: .word 0x00000000
PONTUA��OFASE2: .word 0x00000000
TEMPOGASOLINA: .word 0x00000000
CONTADORGASOLINA: .word 0x00000000

.text
j MENU	
MENU:						
	la a0, Menu
	call PRINT          # Printa o Menu
	li s10, 0xFF00CC28  # Endere�o de in�cio da impress�o da seta
menuMUSICA:	
	#Parte que toca m�sica
	la s0,notasMENU		# Carrega notas do menu	
	li s7,0			# Inicia contador de notas
	SETA:
		beqz s7, playMUSICA  # Se contador = 0, entra na m�sica direto
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
	
		li t1, 87         # C�digo ASCII do W
		li t2, 119	  # C�digo ASCII do w
 		li t3, 83         # C�digo ASCII do S
		li t4, 115        # C�digo ASCII do s
		li a1, 32         # C�digo ASCII do espa�o
		
		li t5, 0xFF200000 # Carrega endere�o do KDMMIO
		lw t0, 4(t5)      # L� c�digo ASCII da tecla
		sw t0, 12(t5)     # P�e no display
		sw zero, 4(t5)    # Limpa o c�digo ASCII 
		
		beq t0, t1, SETAU # Se aperta em W sobe a seta
		beq t0, t2, SETAU
		
		beq t0, t3, SETAD # Se aperta em S desce a seta
		beq t0, t4, SETAD
		
		li t1, 0xFF00CC28
		beq s10, t1, goMAPA1
		j SETA # Se n�o tiver no endere�o, volta p/ SETA
		
	goMAPA1:beq t0, a1, COURSE1
		
		j SETA # Se n�o tiver apertado, volta p/ SETA
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
	li a7, 10
	ecall
	
COURSE1:
	la a0, Course1
	call PRINT
	
	li a7, 32
	li a0, 2000
	ecall
	
	j MAPA1
MAPA1:
	li s10, 0xFF00FE30       	# Define inicio p/ MoveCARRO - N�O USAR REGISTRADOR EM OUTRAS PARTES
	li s11, 0                       # Contador da acelera��o - N�O USAR REGISTRADOR EM OUTRAS PARTES
	
	li t2, 0xFF100000		# Define in�cio na Frame 1
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
	
	la s9, Fuel			# Define inicio p/ GASOLINA - N�O USAR REGISTRADOR EM OUTRAS PARTES 
	
	la a0, Mapa1Og		        # Carrega Mapa1
	call PRINT                      # Chama a fun��o PRINT
	
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	la a1, CarroV0
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
	
	li t6, 0                        # Define frame como 0
	la s0, notasMLARGADA1           # Carrega notas da largada
	li s7, 0			# Inicia contador de notas
	call LARGADA                    # Chama a fun��o LARGADA
	
	la s3, Mapa1                    # Carrega Mapa1
        li s4, 9                        # Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
	li s8, 2                        # Define quantas vezes o loop ser� chamado
  	MAPA1.2_LOOP:
      		la s3, Mapa2            # Carrega Mapa2
      		li s4, 8    		# Define quantas imagens 320x240 de Mapa2 ser�o printadas 
      		call printSEQUENCE
      		
      		addi s8, s8, -1
      		bnez s8, MAPA1.2_LOOP
      		
      	li a7, 10
      	ecall

# Printa uma imagem 320x240
PRINT:		
	li t1,0xFF000000	       # Define in�cio
	li t2,0xFF012C00               # Define fim
			
	PRINT_LOOP: 	
		beq t1,t2,PRINT_EXIT   # Checa se final � igual ao inicial
		lw t3,0(a0)	       # L� 4 pixels
		sw t3,0(t1)	       # Escreve a word na mem�ria
		addi t1,t1,4           # Soma 4 ao inicial
		addi a0,a0,4           # Soma 4 ao endere�o da imagem
		j PRINT_LOOP

	PRINT_EXIT: ret

# Printa imagens 320x240 em sequ�ncia, apresenta fun��o MOVE dentro
# >Argumentos: a1 (n de imagens)<
printSEQUENCE: 
	mv s0, ra                               # Salva endere�o de retorno
			
	printSEQUENCE_LOOP:
		li t2,0xFF00001C
		li a4,216
		li a6,240
		mv a1,s3
		call printUND			# Printa a imagem no endere�o atual, que sai no processo +76800 (320 x 240)
		mv s3,a1
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
			addi s11, s11, 1
			addi s4, s4, -1
			bnez s4, printSEQUENCE_LOOP  	# Loop enquanto s1 != a1
				
			mv ra, s0
			ret
		
# Printa imagem com dimens�es definidas fora da fun��o
# >Argumentos: a1 (Endere�o da imagem), t2 (Endere�o de in�cio da impress�o), a4 (Largura), a6 (Altura)
# a2 = Endere�o final da impress�o (� � argumento)
printUND:
	add a5, t2, zero        # Guarda valor do endere�o inicial em a5
	
	li t5,1                  # Inicializa contador
	li t6,320                # 320 p/ usar em contas
	
	# Conta p/ conseguir o endere�o final
	addi a2,a6,-1
	mul a2,a2,t6
	add a2,a2,a4
	add a2,a2,t2
	
	printUND_LOOP1:
		add t4,a5,zero           # Guarda valor do endere�o inicial em t4	
		mul t0,t6,t5             # Faz 320 * contador
		add t4,t4,t0             # Define qual ser� o pr�ximo endere�o
	
		add a3,t2,zero           # Guarda valor do endere�o inicial em a3
		add a3,a3,a4             # Soma o endere�o inicial � largura
	
	printUND_LOOP2:
		beq t2,a3,printUND_EXIT # Sai quando tiver printado valor correspondente � largura
		lw t1,0(a1)              # L� 4 pixels
		sw t1,0(t2)              # Escreve a word na mem�ria
		addi t2,t2,4             # Soma 4 ao inicial
		addi a1,a1,4             # Soma 4 ao endere�o da imagem
		j printUND_LOOP2
	
	printUND_EXIT:	
		addi t5,t5,1              # Adiciona 1 ao contador	
		add t2,t4,zero            # Coloca o pr�ximo endere�o
		blt t2,a2,printUND_LOOP1 # Faz branch enquanto n�o alcan�a o endere�o final
		ret

# >Argumentos: posi�ao inicial - s10 (inicio) e s11 (fim)
# Os �nicos registradores que precisam ser salvos ap�s a fun��o s�o s10 e s11
moveCARRO:
	mv a7, ra
	
	add t2, s10, zero # Coloca valor armazenado em s10 em t2
	
	add a3, t2, zero # Coloca valor armazenado em t2 em a3
	
	la a1, CarroV0
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
	li t2, 0xFF00FE18
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
	
		li a7, 30		# Pega quando tocou a nota
		ecall
		add s8,a0,a1		# Define quando vai tocar de novo
		addi s8,s8,-210
		
		mv ra, t2
		ret
		
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
	li t3, 0x000036B0
	add t4, a0, t3
	la t1, TEMPOGASOLINA
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
	
	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	li t2, 0xFF00633C
	la a1, Gameover
	li a4, 40
	li a6, 16
	call printUND			# Coloca imagem de final de jogo
	
	la t1,numNARUTO			
	lw t2,0(t1)		
	la t1,notasNARUTO		
	li t0,0				# Inicia o contador
	li a2,76 			# Instrumento
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
	
fimNA:	li a0, 2000
	li a7, 32
	ecall				# Pausa o jogo
	
	j MENU