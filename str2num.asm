segment code
..start:
	mov ax, dados
	mov ds, ax
	mov ax, pilha
	mov ss, ax
	mov sp, topopilha

	mov si, 0
	mov di, 0

	;DEBUG
	; mov ax, num
	; int 3;

	l1:

	mov al, byte[array_string + si]

	cmp al, '-'
	je negativo

	cmp al, 10
	je fimNumero
	
	cmp al, '$'
	je fim

	sub al, '0'
	mov [num + di], al
	inc di
	
	; int 3;

	inc si
	jmp l1

negativo:
	mov byte[EhNegativo], 1
	inc si
	jmp l1

fimNumero:
	mov dx, di
	;dx = quantidade de dígitos do número

	push si
	mov si, 0
praCadaDigito:
	mov al, [num + si]

	;dx = vezes que tem q multiplicar o digito por 10
	dec dx

	cmp dx, 0
	je soma ;(chegou no ultimo digito)

	mov cx, dx
multiplicaPor10:
	mov bl, 10
	mul bl
	loop multiplicaPor10

	mov [num + si], al ;??????????

	inc si
	jmp praCadaDigito

soma:
	mov cx, di

	mov al, 0
lsoma:
	mov bx, cx
	dec bx

	add al, [num + bx]
	loop lsoma

	cmp byte[EhNegativo], 0
	je salvaNumero

	neg al

salvaNumero:
  int 3;

	mov bx, 0 
	mov bl, byte[indice_array_inteiros]
	mov byte[array_inteiros + bx], al
	inc bx
	mov byte[indice_array_inteiros], bl
	mov byte[EhNegativo], 0
	

	mov di, 0
	
	pop si
	inc si
	jmp l1

fim:
	int 3
	mov ah, 4Ch
	int 21h

segment dados
	array_string db '-100',10,'100',10,'$'
	array_inteiros resb 300
	indice_array_inteiros db 0
	EhNegativo db 0
	num db 0,0,0

segment pilha stack
	resb 64
topopilha: