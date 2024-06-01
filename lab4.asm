segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topo_pilha

	mov dx, msgInicio
	mov ah, 9h
	int 21h

	mov ax, 0
	mov bx, 1

L10:
	mov dx, ax
	add dx, bx
	mov ax, bx
	mov bx, dx
	call imprime_numero
	cmp dx, 0x8000
	jb L10 ;jumb if below (if flag C=1)

exit:
	mov dx, msgFim
	mov ah, 9h
	int 21h

quit:
	mov ah, 4ch
	int 21h
	ret 

imprime_numero:
	push ax
	push bx
	push dx

	mov di, saida ;passagem de parâmetro por registrador (di) para a função bin2ascii
	call bin2ascii
	
	mov dx, saida ;passagem de parâmetro por variável global (vetor saida)
	mov ah, 9
	int 21h

	pop dx ;remove uma word da pilha e armazena em dx
	pop bx
	pop ax
	ret

bin2ascii:
	mov ax, dx ;ax guarda o número a ser exibido
	mov bx, 10
	
	mov si, 4 ; si guarda a posição do dígito menos significativo do número a ser exibido no vetor saída
	mov cx, 5; cx guarda a quantidade de dígitos do número, no caso sabemos que o número tem no máximo 5 dígitos

	add di, si
loopLabel:
	mov dx, 0 ;a divisão sem sinal de uma word por uma word é feita preenchendo dx com zero
	
	div bx ; divide o que tá em ax por bx(no caso, por 10)
	;dl guarda o resto da divisão, que é o dígito menos significativo do número a imprimir
	add dl, 30h ;converte o dígito para ascii

	int 3

	mov byte[di], dl ;guarda o dígito no vetor saída	
	dec di ;decrementa si para ir para a próxima posição do vetor saída

	loop loopLabel
	ret

segment dados
	msgInicio: db 'Programa que calcula a Serie de Fibonacci',13,10,'$'
	msgFim: db 'bye',13,10,'$'
	saida: db '00000',13,10,'$'
	terminator: db 13,10,'$'

segment pilha stack
	resb 256

topo_pilha: