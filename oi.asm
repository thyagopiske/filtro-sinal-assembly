segment code
..start:
	; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
	mov ax,dados
	mov ds,ax
	mov ax,minha_pilha
	mov ss,ax
	mov sp,topopilha
	mov ah, 9h
	mov dx,mensagem
	int 21h
	; Terminar o programa e voltar para o sistema operacional
	mov ah,4ch
	int 21h
segment dados
	CR	equ 0dh
	LF	equ 0ah
	mensagem db 'Oi, olha eu aqui',CR,LF,'$'; CR + LF = enter. $ é terminador de string
segment minha_pilha stack
    resb 256
topopilha: