.data
	array: .word 5, 8, 6, 2, 9, 1, 4, 7, 3, 0

.text
	main:
		la $t0, array #(loadAdress) colocando o endereco do vetor em t0
		addi $t1, $zero, 10    #(loadword) colocando o tamanho do array, 10, em t1
		li $s1, 0 # (load immediate) colocando 0 em s1 para representar o i
		li $a0, 1 #(load immediate) guardando 1 em a0 para realizar comparacoes e adicoes posteriormente
		li $t2, 4 #(load immediate) guardando o 4 para percorrer o array de 4 em 4 bits
	primeiroFor:
		bge $s1, $t1, fimPrimeiroFor #(branch if greater or equal) se i for maior ou igual ao tamanho, finaliza o laco for
		move $t3, $s1 #t3 recebe o valor de s1, min = i
		addi $s2, $s1, 1 #j recebe i + 1
		segundoFor:
			bge $s2, $t1, fimSegundoFor #(branch if greater or equal) se j for maior ou igual ao tamanho, finaliza o laco for
			#achando o valor de array[j]
			mul $t5, $s2, $t2 #multiplicando j por 4 para encontrar quandos bits precisamos percorrer
			add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
			lw $t4, 0($t5) #t4 recebe array[j]	
			#achando o valor de array[min]
			mul $t5, $t3, $t2 #multiplicando min por 4 para encontrar quandos bits precisamos percorrer
			add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
			lw $t6, 0($t5) #t6 recebe array[min]	
			
			blt $t4, $t6, if #se j < min, va para o if
			j fimIf #se j >= min, nao entre no if

			if:
				move $t3, $s2 #min = j

			fimIf:
			addi $s2, $s2, 1 #incrementando o j
			j segundoFor

		fimSegundoFor:
		#achando o valor de array[min]
		mul $t5, $t3, $t2 #multiplicando min por 4 para encontrar quandos bits precisamos percorrer
		add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
		lw $s3, 0($t5) #s2 recebe array[min]
		
		#achando o valor de array[i]
		mul $t7, $s1, $t2 #multiplicando i por 4 para encontrar quandos bits precisamos percorrer
		add $t7, $t7, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t7
		lw $s4, 0($t7) #s4 recebe array[i]
		
		#array[i] troca com array[min]
		sw $s3, 0($t7) 
		sw $s4, 0($t5)

		addi $s1, $s1, 1 #incrementa i
		j primeiroFor
	
	fimPrimeiroFor: