	li s10, 0xFF00FE30       	# Define inicio p/ MoveCARRO - NÃO USAR REGISTRADOR EM OUTRAS PARTES
	li s11, 0                       # Contador da aceleração - NÃO USAR REGISTRADOR EM OUTRAS PARTES
	la s9, Fuel			# Define inicio p/ GASOLINA - NÃO USAR REGISTRADOR EM OUTRAS PARTES 
	
	la a0, Mapa1Og		        # Carrega Mapa1
	call PRINT                      # Chama a função PRINT
	
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
	
	la a1, Mapa4Og
	li t2,0xFF00001C
	li a4,216
	li a6,240
	call printUND
	
	add t2, s10, zero  		# Coloca valor armazenado em s10 em t2
	add a3, t2, zero  		# Coloca valor armazenado em t2 em a3
	lw a1, CARRO
	li a4, 16        		# Define largura da imagem
	li a6, 16			# Define altura da imagem
	call printUND
	
	li a7, 32
	li a0, 500
	ecall