segment code
..start:
	; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,dados
	mov ds,ax
	mov ax,minha_pilha
	mov ss,ax
	mov sp,topopilha

	int 3
	mov ax, [numeroFloat];
	; Terminar o programa e voltar para o sistema operacional
fim:
	mov ah,4ch
	int 21h
	
segment dados
	meuDado: dw 0x4fac
	numeroNegativo: db 0x9C ;-100
	numeroFloat: dd 0.1
	
segment minha_pilha stack
    resb 256
topopilha: