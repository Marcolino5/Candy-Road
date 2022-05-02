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