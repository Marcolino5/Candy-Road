.include "MACROSv21.s"

.data
.include "Imagens/Menu.s"
### MUSICAS ###
.include "Musicas/MusicaMenu.s"
.include "Musicas/Largada1.s"
.include "Musicas/MusicaLargada1.s"

### TILES ###
.include "Imagens/TileM.s"
.include "Imagens/Tile1.s"
.include "Imagens/Seta.s"

### MAPAS ###
.include "Imagens/Mapa1.s"
.include "Imagens/Mapa2.s"

### CARROS ###
.include "Imagens/CarroV0.data"

.text
j MENU
.include "SYSTEMv21.s"		
MENU:						
	la a0, Menu
	call PRINT          # Printa o Menu
	li s10, 0xFF00CC28  # Endere�o de in�cio da impress�o
	li s11, 0xFF00DDBC  # Endere�o final
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
		la s5, Seta
		li a4, 20           # Largura da seta

		add s6, s10, zero
		add a2, s11, zero
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
		
	goMAPA1:beq t0, a1, MAPA1
		
		j SETA # Se n�o tiver apertado, volta p/ SETA
	SETAU:  
		li t1, 0xFF00CC28
		beq s10, t1, SETA
		
		add s6, s10, zero
		add a2, s11, zero
		la s5, TileM
		call printUND
		
		li t6, -9600
		add s10, s10, t6
		add s11, s11, t6
		j SETA
	SETAD:
		li t1, 0xFF00F1A8
		beq s10, t1, SETA
		
		add s6, s10, zero
		add a2, s11, zero
		la s5, TileM
		call printUND
		
		li t6, 9600
		add s10, s10, t6
		add s11, s11, t6
		j SETA
	li a7, 10
	ecall

MAPA1:
	li s10, 0xFF00FE30       	# Define inicio p/ MoveCARRO - N�O USAR REGISTRADOR EM OUTRAS PARTES
	li s11, 0xFF011100       	# Define fim p/ moveCARRO - N�O USAR REGISTRADOR EM OUTRAS PARTES 
	
	li s6, 0xFF100000		# Define in�cio na Frame 1
	li a2, 0xFF112C00		# Define final na Frame 1
	la s5, Mapa1		
	li a4, 320			# Define largura da imagem
	call printUND
	
	la a0, Mapa1		        # Carrega Mapa1
	call PRINT                      # Chama a fun��o PRINT
	
	add s6, s10, zero  		# Coloca valor armazenado em s10 em s6
	add a2, s11, zero  		# Coloca valor armazenado em s11 em a2
	add a3, s6, zero  		# Coloca valor armazenado em s6 em a3
	la s5, CarroV0
	li a4, 16        		# Define largura da imagem
	call printUND
	
	li t6, 0                        # Define frame como 0
	la s0, notasMLARGADA1           # Carrega notas da largada
	li s7, 0			# Inicia contador de notas
	call LARGADA                    # Chama a fun��o LARGADA
	
	la a0, Mapa1                    # Carrega Mapa1
        li a1, 9                        # Define quantas imagens 320x240 de Mapa1 ser�o printadas
      	call printSEQUENCE	        # Chama fun��o PRINT-SEQUENCE
      	
	li s8, 2                        # Define quantas vezes o loop ser� chamado
	li s7, 0                        # Inicializa contador
  	MAPA1.2_LOOP:
      		la a0, Mapa2            # Carrega Mapa2
      		li a1, 8        
      		call printSEQUENCE
      		
      		addi s7, s7, 1
      		bne s7, s8, MAPA1.2_LOOP
      		
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
	li s1, 0			        # Inicializa contador
			
	printSEQUENCE_LOOP:
		call PRINT                      # Printa a imagem no endere�o atual, que sai no processo +76800 (320 x 240)
		addi s1, s1, 1                  # Atualiza n de vzs que printou
	MOVE:	
		call moveCARRO
		
		# Move verticalmente
		li t1, 87          		# C�digo ASCII do W
        	li t2, 119        		# C�digo ASCII do w
        	
	   	li t4, 0xFF200000  		# Carrega endere�o do KDMMIO
 		lw t0, 0(t4)
		andi t0, t0, 1	  		# Coloca em t0 o bit menos significativo p/ compara��o
		beq t0, zero, MOVE 		# Se n�o pressionar tecla, vai p/ MOVE
		lw t0, 4(t4)	   		# l� codigo ASCII da tecla
		sw t0, 12(t4)      		# p�e no display
	
		beq t0, t1, CONT  		# Se c�digo == w, pula e continua
		bne t0, t2, MOVE 		# Se c�digo != W, volta pro come�o
		
	CONT:	bne s1, a1, printSEQUENCE_LOOP  # Loop enquanto s1 != a1
				
		mv ra, s0
		ret

# Printa imagem com dimens�es definidas fora da fun��o
# >Argumentos: Largura (a4) e Endere�o da impress�o (s6 - inicio e a2 - fim)<
printUND:
	add a5, s6, zero        # Guarda valor do endere�o inicial em a5
	
	li t5,1                  # Inicializa contador
	li t6,320                # 320 p/ usar em contas
	
	printUND_LOOP1:
		add t4,a5,zero           # Guarda valor do endere�o inicial em t4	
		mul t0,t6,t5             # Faz 320 * contador
		add t4,t4,t0             # Define qual ser� o pr�ximo endere�o
	
		add a3,s6,zero           # Guarda valor do endere�o inicial em a3
		add a3,a3,a4             # Soma o endere�o inicial � largura
	
	printUND_LOOP2:
		beq s6,a3,printUND_EXIT  # Sai quando tiver printado valor correspondente � largura
		lw s2,0(s5)              # L� 4 pixels
		sw s2,0(s6)              # Escreve a word na mem�ria
		addi s6,s6,4             # Soma 4 ao inicial
		addi s5,s5,4             # Soma 4 ao endere�o da imagem
		j printUND_LOOP2
	
	printUND_EXIT:	
		addi t5,t5,1            # Adiciona 1 ao contador	
		add s6,t4,zero          # Coloca o pr�ximo endere�o
		blt s6,a2,printUND_LOOP1 # Faz branch enquanto n�o alcan�a o endere�o final
		ret

# >Argumentos: posi�ao inicial - s10 (inicio) e s11 (fim)
# Os �nicos registradores que precisam ser salvos ap�s a fun��o s�o s10 e s11
moveCARRO:
	mv s4, ra
	
	add s6, s10, zero  # Coloca valor armazenado em s10 em s6
	add a2, s11, zero  # Coloca valor armazenado em s11 em a2
	
	add a3, s6, zero  # Coloca valor armazenado em s6 em a3
	
	la s5, CarroV0
	li a4, 16         # Define largura da imagem
	call printUND
	
	mv ra, s4
	
	#Printa p/ a direita quando aperta d/D
	
	li t6, 87         # C�digo ASCII do W
	li s6, 119        # C�digo ASCII do w
	
	li t1, 68         # C�digo ASCII do D
	li t2, 100        # C�digo ASCII do d
	li t3, 65         # C�digo ASCII do A
	li t4, 97         # C�digo ASCII do a
	
	li t5, 0xFF200000 # Carrega endere�o do KDMMIO
	lw t0, 4(t5)      # L� c�digo ASCII da tecla
	sw t0, 12(t5)     # P�e no display
	sw zero, 4(t5)    # Limpa o c�digo ASCII 
	
	beq t0, t1, moveCARROR # Se c�digo ASCII = D/d, vai p/ moveCARROR
	beq t0, t2, moveCARROR
	
	beq t0, t3, moveCARROL # Se c�digo ASCII = A/a, vai p/ moveCARROL
	beq t0, t4, moveCARROL
	
	beq t0, t6, CONT       # Se c�digo ASCII = W/w, vai p/ CONT
	beq t0, s6, CONT
	
	ret
moveCARROR:
	li t1, 0xFF00FE70
	beq s10, t1, PRINT_EXIT

	add s6, s10, zero
	add a2, s11, zero
	
	la s5, TILE1
	li a4, 16
	
	mv s4, ra
	call printUND		# Remove o rastro
	mv ra, s4
	
	addi s10, s10, 4
	addi s11, s11, 4
	j moveCARRO
moveCARROL:
	li t1, 0xFF00FE18
	beq s10, t1, PRINT_EXIT

	add s6, s10, zero
	add a2, s11, zero
	
	la s5, TILE1
	li a4, 16
	
	mv s4, ra
	call printUND		# Remove o rastro
	mv ra, s4
		
	addi s10, s10, -4
	addi s11, s11, -4
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
