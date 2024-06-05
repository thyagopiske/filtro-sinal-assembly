segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topopilha

	;FALTA TRATAR ERRO

	;abrir arquivo sinalep1.txt
	mov ah, 3Dh
	mov al, 0 ;modo de leitura
	mov dx, nomearquivo
	int 21h
	mov [handle], ax

	;ler arquivo7
	mov si, 0
le:
	mov ah, 3Fh
	mov bx, [handle]
	mov cx, 1 ;quantidade de bytes a serem lidos
	mov dx, buffer
	int 21h

	cmp ax, 0
	je fim

	mov ah, [buffer]
	mov byte[arquivo_array + si], ah
	inc si

	jmp le

fim:
	int 3

	;fecha o arquivo
	mov ah, 3Eh
	mov bx, [handle]
	int 21h

	mov byte[arquivo_array + si], 10
	inc si
	mov byte[arquivo_array + si], 13
	inc si
	mov byte[arquivo_array + si], '$'

	mov ah, 9h
	mov dx, arquivo_array
	int 21h

	;transformar em inteiros
	;EU JÁ SEI QUE SÃO 300 NUMEROS


	;termina o programa
	mov ah, 4Ch
	int 21h

segment dados
	nomearquivo db 'sinalep1.txt'
	handle dw 0
	buffer resb 1
	arquivo_array resb 2048
	; buffer db 256 dup(0)
	; handle dw ?
	; bytesread dw ?
	; byteswritten dw ?
	; buffer2 db 256 dup(0)

segment pilha stack
    resb 256
topopilha: