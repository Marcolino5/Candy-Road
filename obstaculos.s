GASOLINAE:
	mv t3, ra
	
	addi t6, t2, -4480		# Posição do carro
	addi t4, t6, 0
	addi t5, t6, 4
	blt s10, t4, gasolinaeCONT
	bgt s10, t5, gasolinaeCONT	# Verifica se o carro pegou
	
	la t4, ENDEREÇO0
	sw t2, (t4)			# Guarda posição da gasolina
	
	lw t1, PONTUAÇÃO
	addi t1, t1, 100
	la t2, PONTUAÇÃO
	sw t1, (t2)			# Adiciona 100 à pontuação
	
	lw t2, ENDEREÇO1
	la a1, TILE1
	li a4, 16
	li a6, 16
	call printUND			# Apaga a cola
	
	lw t1, CONTADORGASOLINA
	li t2, 1
	beqz t1, gasolinaeCONT2
	beq t1, t2, gasolinaeCONT2	# Verifica se ainda está no primeiro estado
	addi t1, t1, -1
	la t5, CONTADORGASOLINA
	sw t1, (t5)			# Retorna gasolina ao estado anterior
	
	addi s9, s9, -1920
	add a1, s9, zero
	li t2, 0xFF00D948
	li a4, 24			# Define largura da imagem
	li a6, 40			# Define altura da imagem
	call printUND
	add s9, a1, zero
	
gasolinaeCONT2:	
	li a7, 30
	ecall
	li t2, 0x00001D4C
	add t4, a0, t2
	la t1, TEMPOGASOLINA		# Altera o tempo de mudança da gasolina
	sw t4, (t1)

	li a7, 31
	li a0, 62
	li a1, 1000
	li a2, 2
	li a3, 60
	ecall				# Toca único som
	
	lw t2, ENDEREÇO0
gasolinaeCONT:
	addi t2, t2, 9600		# Modifica a posição no mapa
	mv ra, t3
	ret

BOLAE:
	mv t3, ra
	
	addi t6, t2, 5120		# Posição do carro
	addi t4, t6, -12
	addi t5, t6, 12
	blt s10, t4, bolaeCONT2
	bgt s10, t5, bolaeCONT2		# Verifica se o carro acertou
	la t1, BLOQUEADO
	li t4, 1
	sb t4, (t1)			# Não permite que passe pela bola
	li t4, 3
	blt s11, t4, bolaeCONT		# Verifica a velocidade do carro
	
	la t4, ENDEREÇO0
	sw t2, (t4)			# Guarda posição da bola
	
	# Explosão
	li a7, 31
	li a0, 40
	li a1, 1000
	li a2, 127
	li a3, 63
	ecall				# Toca som de explosão
	add t2, s10, zero
	la a1, Explosao1
	li a4, 16
	li a6, 16
	call printUND
	li a7, 32
	li a0, 200
	ecall
	add t2, s10, zero
	la a1, Explosao2
	li a4, 16
	li a6, 16
	call printUND
	li a7, 32
	li a0, 200
	ecall
	add t2, s10, zero
	la a1, Explosao3
	li a4, 16
	li a6, 16
	call printUND
	li a7, 32
	li a0, 500
	ecall
	add t2, s10, zero
	la a1, TILE1
	li a4, 16
	li a6, 16
	call printUND
	li a7, 32
	li a0, 1000
	ecall
	li s10, 0xFF00FE28		# Retorna carro à posição inicial
	
	lw t2, ENDEREÇO0
bolaeCONT:
	mv ra, t3
	ret
bolaeCONT2:
	la t1, BLOQUEADO
	li t4, 0
	sw t4, (t1)
	mv ra, t3
	ret
