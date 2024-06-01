segment code
..start:
	; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,dados
	mov ds,ax
	mov ax,minha_pilha
	mov ss,ax
	mov sp,topopilha
    mov ax, 20
    mov bx, 20
    int 3
    add ax, bx

	; Terminar o programa e voltar para o sistema operacional
	mov ah,4ch
	int 21h
segment dados
	
segment minha_pilha stack
    resb 256
topopilha: