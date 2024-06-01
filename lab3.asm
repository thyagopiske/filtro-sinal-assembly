segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topopilha
	mov bx, three_chars
	
	;Le um caractere e joga o resultado em al
	mov ah, 1h
	int 21h
	
	dec al ;decrementa o valor de al, ou seja: 'h' vira 'g'
	mov [bx], al ;guarda o valor de al em [three_chars + 0]
	inc bx ;incrementa bx, ou seja, agora ele aponta para [three_chars + 1]
	int 21h ;le o proximo caractere (ah ainda tem o valor 1h então qualquer chamada de int 21h vai ler um caractere)

	dec al ;decrementa novamente o valor de al
	mov [bx], al ;guarda o valor de al em [three_chars + 1]
	inc bx ;incrementa bx, ou seja, agora ele aponta para [three_chars + 2]
	int 21h 

	dec al
	mov [bx], al

	mov dx, display_string ;coloca em dx o valor do offset display_string
	mov ah, 9h ;função para imprimir os bytes até encontrar o caractere '$'
	int 21h ;chama a função acima
sair: 
	mov ah, 4ch
	int 21h
	
segment dados
	CR: equ 0dh
	LF: equ 0ah
	display_string db CR, LF ;array de bytes que contem os caracteres de nova linha e carriage return
	three_chars resb 3 ;aloca 3 bytes para guardar os 3 caracteres digitados no array de bytes three_chars
							db '$'
segment pilha stack
    resb 256
topopilha: