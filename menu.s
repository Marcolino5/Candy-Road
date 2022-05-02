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
COURSE2:
	la a0, Course2
	call PRINT
	
	li a7, 32
	li a0, 2000
	ecall
	
	j FASE2
