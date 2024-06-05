;Código de exemplo para testar o comportamento de 
;operações com números com sinal

segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topopilha

    mov al, byte[numero]
    mov bl, 3
    mul bl

    mov al, byte[numero2]
    mov bl, 2
    mul bl

    mov al, byte[numero2]
    mov bl, -1
    mul bl



segment dados
	numero db 11110110b ; -> isso ele salva como f6
    numero2 db 0xce

segment pilha stack
	resb 64
topopilha: