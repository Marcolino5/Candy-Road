.include "MACROSv21.s"

.data
.include "Imagens/Menu.s"
### MUSICAS ###
.include "Musicas/MusicaMenu.s"

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
	call PRINT           # Printa o Menu
	li s10, 0xFF00CC28  # Endere�o de in�cio da impress�o
	li s11, 0xFF00DDBC  # Endere�o final
	SETA:
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
	li s11, 0xFF010FC0       	# Define fim p/ moveCARRO - N�O USAR REGISTRADOR EM OUTRAS PARTES 
	
	la a0, Mapa1		        # Carrega Mapa1
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
# >Argumentos: largura (a4) e endere�o de onde vai printar (s6 - inicio e a2 - fim)<
# Os �nicos registradores que precisam ser salvos ap�s a fun��o s�o s10 e s11
printUND:
	add a5, s6, zero        # Guarda valor do endere�o inicial em a5
	
	li t5,0                  # Inicializa contador
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
	
#Testando
tocamusicaMENU: 
	la s0,numMENU		
	lw s1,(s0)		
	la s0,notasMENU		
	li t0,0			
	li a2,99		# instrumento
	li a3,32		# volume

TOCA:	beq t0,s1, RET
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
RET:    ret
