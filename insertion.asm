.data
	array: .word 5, 8, 6, 2, 9, 1, 4, 7, 3, 0
.text
	main:
		li $a0, 1 #(load immediate) guardando 1 em a0 para realizar comparacoes e adicoes posteriormente
    		la $t0, array #(loadAdress) colocando o endereco do vetor em t0
    		li $t1, 10 #(loadword) colocando o tamanho do array, 10, em t1
    		li $s0, 0 #(load immediate) inicializando s0 para representar o j
    		li $s1, 1 # (load immediate) colocando 1 em s1 para representar o i
    		li $t2, 4 #(load immediate) guardando o 4 para percorrer o array de 4 em 4 bits
	for:
		bge $s1, $t1, fim #(branch if greater or equal) se i for maior ou igual ao tamanho, finaliza o laco for
		subi $s0, $s1, 1 #(subtracao com valor imediato) j deve ser inicializado dentro do for como sendo i - 1
		
		#achando o valor de array[j]
		mul $t5, $s0, $t2 #multiplicando j por 4 para encontrar quandos bits precisamos percorrer
		add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
		lw $t6, 0($t5) #(load word) t6 recebe array[j]

		#achando o valor de array[i]
		mul $t5, $s1, $t2 #multiplicando j por 4 para encontrar quandos bits precisamos percorrer
		add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
		lw $t8, 0($t5) #t7 recebe array[i]
		move $s6, $t8 #copiando o valor de array[i] em s6, pois ele sera usado ao sair do while

		while:
			bge $t8, $t6, fim_while #(branch if greater than) se o valor do conteudo na pos i for maior ou igual a j, finaliza while
			blt $s0, $zero, fim_while #(branch if less than) se j for menor que 0, finaliza while
			
			add $s3, $s0, 1 #achando j + 1
			mul $t5, $s3, $t2 #multiplicando j por 4 para encontrar quandos bits precisamos percorrer
			add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
			sw $t6, 0($t5) #(storeWord) o conteudo do array[j] vai para a posicao [j+1]
		
			subi $s0, $s0, 1 # j = j - 1
			subi $s4, $t5, 8 # achando endereco de j-1
			lw $t6, 0($s4)  #o valor na pos j é atualizado pra quando voltar pro while
			
			j while # volta pro while
			
		fim_while:
		add $s3, $s0, 1 #achando j + 1
		mul $t5, $s3, $t2 #multiplicando j + 1 por 4 para encontrar quandos bits precisamos percorrer
		add $t5, $t5, $t0 #somando os bits ao endereco da primeira pos do vetor e colocando em t5
		sw $s6, 0($t5) #arr [j+1] = key
		addi $s1, $s1, 1 #incrementando i
		j for
		
		fim: