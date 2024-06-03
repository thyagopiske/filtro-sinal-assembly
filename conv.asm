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

	mov bx, y ;apenas para fins de debug
	int 3
l1:
	push cx

	mov ax, cx
	dec ax
	mov [n], ax

	; só precisaria disso se em dados eu fiz y resb 0 (mas isso nem funciona n sei pq)
	; mov bx, [n]
	; mov byte[y+bx], 0

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
		mov al, byte[h+si]

		mov si, bx
		mov bl, byte[x+si]
		mul bx

		mov si, [n]
		add byte[y+si], al

		skipl2:
			dec cx
			jnz l2

	pop cx
	loop l1

	int 3;
	mov ax, 4c00h
	int 21h

; indiceMenorQueZero:
; 	loop l2
; 	ret

segment dados
; xn = [1 5 10 4 5]
; hn = [2 1 4 7]
	x db 1,5,10,4,5
	h db 2,1,4,7
	; y resb 0 assim n funciona n sei pq
	y db 0,0,0,0,0,0,0,0
	n db 0
	k db 0
	kmin db 0
	kmax db 0
	tamanhoX equ 5
	tamanhoH equ 4

segment pilha stack
	resb 256

topopilha: