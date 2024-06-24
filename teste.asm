segment code
..start:
	; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,dados
	mov ds,ax
	mov ax,minha_pilha
	mov ss,ax
	mov sp,topopilha

	int 3
	mov ax, 0xff29
	cwd
	mov bx, 6
	idiv bx
; Terminar o programa e voltar para o sistema operacional
fim:
	mov ah,4ch
	int 21h
	
segment dados
	menos100 db 9Ch
	mais100 db 64h
	
segment minha_pilha stack
    resb 256
topopilha: