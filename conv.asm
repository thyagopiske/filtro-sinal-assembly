segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topopilha

	mov ax, tamanhoX
	add ax, tamanhoH
	dec ax

	mov cx, ax

	int 3
	mov bx, y ;apenas para fins de debug
l1:
	push cx

	mov ax, cx
	dec ax
	mov [n], ax

	mov bx, [n]
	mov byte[y+bx], 0
	mov word[acumulador], 0

	mov cx, [n]
	inc cx
	; int 3
	l2:
		;k (índice de x)
		mov bx, cx
		dec bx


		; 0 <= k < tamanhoX
		cmp bx, 0
		jl skipl2
		cmp bx, tamanhoX
		jge skipl2


		;n - k (índice de h)
		mov dx, [n]
		sub dx, bx

		;0 <= n - k < tamanhoH
		cmp dx, 0
		jl skipl2
		cmp dx, tamanhoH
		jge skipl2

		; faz h[n-k]*x[k] e soma em y[n]
		mov si, dx
		mov ax, 0
		mov al, byte[h+si]

		mov si, bx
		mov bl, byte[x+si]
		imul bl ;N ERA PRA SER IMUL?

		mov si, [n]
		; n posso acumular direto assim, pq o somatorio pode ser de 16bits, antes de dividir por 6
		; add byte[y+si], al
		add [acumulador], ax
		; EXEMPLO: add [acumulador], al

		skipl2:
			dec cx
			jnz l2

	mov ax, [acumulador]
; 	cmp ah, 00h
; 	jne NoSignExtend
	cwd
; NoSignExtend:
	; mov dx, 0
	; mov al, [y+si]
	; cbw
	mov bx, 6
	idiv bx
	int 3
	mov [y+si], al

	pop cx
	loop l1

	int 3;
	mov ax, 4c00h
	int 21h

segment dados
; xn = [1 5 10 4 5]
; hn = [2 1 4 7]
	x db 1,5,-100,-120,5
	h db 1,1,1,1
	y resb 8
	n dw 0
	tamanhoX equ 5
	tamanhoH equ 4
	acumulador dw 0

segment pilha stack
	resb 256

topopilha: