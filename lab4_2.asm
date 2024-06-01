; msm coisa que o lab4 mas em vez de passar o endereço da string por registrador
; para bin2ascii, passa-se pela pilha

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
	jb L10 

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

	mov di, saida 
	push di ;passar parâmetro di pela pilha para a função bin2ascii
	call bin2ascii
	
	mov dx, saida 
	mov ah, 9
	int 21h

	pop dx 
	pop bx
	pop ax
	ret

bin2ascii:
	;procedimento padrão para acessar parâmetros passados pela pilha
	push bp
	mov bp, sp
	;

	mov ax, dx 
	mov bx, 10
	
	mov si, 4 
	mov cx, 5

	mov di, [bp+4] ;di recebe o endereço do primeiro byte da string saida
	add di, si
loopLabel:
	mov dx, 0 
	
	div bx 
	add dl, 30h 

	int 3

	mov byte[di], dl
	dec di

	loop loopLabel

	;procedimento padrão para acessar parâmetros passados pela pilha
	pop bp 
	ret 2 ;retira o parâmetro di (2 bytes) passados pela pilha

segment dados
	msgInicio: db 'Programa que calcula a Serie de Fibonacci',13,10,'$'
	msgFim: db 'bye',13,10,'$'
	saida: db '00000',13,10,'$'
	terminator: db 13,10,'$'

segment pilha stack
	resb 256

topo_pilha: