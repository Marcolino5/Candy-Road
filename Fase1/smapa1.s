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