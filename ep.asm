
segment code
..start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,stacktop

; salvar modo corrente de video(vendo como está o modo de video da maquina)
	mov  ah,0Fh
	int  10h
	mov  [modo_anterior],al   

; alterar modo de video para gráfico 640x480 16 cores
	mov al,12h
	mov ah,0
	int 10h

	;inicializa mouse
	mov ax, 0
	int 33h
	;para mostrar o mouse
	mov ax, 1
	int 33h
	
	mov		ax,0 
	push		ax
	mov		ax,0
	push		ax
	mov		ax,0 
	push		ax
	mov		ax, limite_vertical
	push		ax
	call		line

	mov		ax, limite_horizontal
	push		ax
	mov		ax,0
	push		ax
	mov		ax, limite_horizontal
	push		ax
	mov		ax, limite_vertical
	push		ax
	call		line		

	mov		ax, 0
	push		ax
	mov		ax,0
	push		ax
	mov		ax, limite_horizontal
	push		ax
	mov		ax, 0
	push		ax
	call		line		

	mov		ax, 0
	push		ax
	mov		ax, limite_vertical
	push		ax
	mov		ax, limite_horizontal
	push		ax
	mov		ax, limite_vertical
	push		ax
	call		line		

	mov		ax,64
	push		ax
	mov		ax,0
	push		ax
	mov		ax,64
	push		ax
	mov		ax, limite_vertical
	push		ax
	call		line

	mov cx, 5
	mov bx, 79
menu_esquerda:
	mov ax, 0
	push ax

	cmp cx, 5
	je primeira_iteracao
	
	add bx, 80
primeira_iteracao:
	push bx
	mov ax, 64
	push ax
	push bx 
	call line
	loop menu_esquerda

	mov		ax,64
	push		ax
	mov		ax,249
	push		ax
	mov		ax, limite_horizontal
	push		ax
	mov		ax, 249
	push		ax
	call		line

	mov		ax,64
	push		ax
	mov		ax,79
	push		ax
	mov		ax, limite_horizontal
	push		ax
	mov		ax, 79
	push		ax
	call		line

	mov		ax,384
	push		ax
	mov		ax,79
	push		ax
	mov		ax, 384
	push		ax
	mov		ax, limite_vertical
	push		ax
	call		line


; ;escrever uma mensagem
; 	mov cx,14			;número de caracteres
; 	mov bx,0
; 	mov dh,0			;linha 0-29
; 	mov dl,30			;coluna 0-79
; 	mov	byte[cor],azul
; l4:
; 	call cursor
; 	mov  al,[mens + bx]
; 	call	caracter
; 	inc  bx	;proximo caracter
; 	inc	dl	;avanca a coluna
; 	inc	byte [cor] ;mudar a cor para a seguinte
; 	loop   l4

	mov dh,27			;linha 0-29
	mov dl,30			;coluna 0-79
	call cursor
	mov ah, 09h
	mov dx, nome
	int 21h
	
	mov byte[cor], branco
	call escreve_menu_lateral


check_mouse:
	mov ax, 3
	int 33h

	; test bx, 1
	; jz check_mouse
	cmp bx, 1 ; verifica se o botão esquerdo do mouse foi pressionado
	jne check_mouse

	cmp cx, 64
	jg check_mouse

	cmp dx, 80
	jl selecionar_abrir
	cmp dx, 160
	jl selecionar_FIR3
	cmp dx, 240
	jl selecionar_FIR2
	cmp dx, 320
	jl selecionar_FIR1
	cmp dx, 400
	jl selecionar_histogramas

	jmp quit

selecionar_abrir:
	mov byte[cor], branco
	call escreve_menu_lateral
	mov byte[cor], amarelo
	call escreve_abrir
	jmp check_mouse

selecionar_FIR3:
	mov byte[cor], branco
	call escreve_menu_lateral
	mov byte[cor], amarelo
	call escreve_FIR3
	jmp check_mouse

selecionar_FIR2:
	mov byte[cor], branco
	call escreve_menu_lateral
	mov byte[cor], amarelo
	call escreve_FIR2
	jmp check_mouse

selecionar_FIR1:
	mov byte[cor], branco
	call escreve_menu_lateral
	mov byte[cor], amarelo
	call escreve_FIR1
	jmp check_mouse

selecionar_histogramas:
	mov byte[cor], branco
	call escreve_menu_lateral
	mov byte[cor], amarelo
	call escreve_histogramas
	jmp check_mouse

quit:
	; mov  ah,08h
	; int  21h
	mov  ah,0   			; set video mode
	mov  al,[modo_anterior]   	; modo anterior
	int  10h

	mov     ax, 4c00h
	int     21h

escreve_sair:
	mov cx,4			;número de caracteres
	mov bx,0
	mov dh,27			;linha 0-29
	mov dl,2			;coluna 0-79
lsair:
	call cursor
	mov  al,[sair + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lsair
	ret

escreve_histogramas:
	mov cx,5			;número de caracteres
	mov bx,0
	mov dh,22			;linha 0-29
	mov dl,1			;coluna 0-79
lhisto:
	call cursor
	mov  al,[histo + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lhisto

	mov cx,6			;número de caracteres
	mov bx,0
	mov dh,23			;linha 0-29
	mov dl,1			;coluna 0-79
lgramas:
	call cursor
	mov  al,[gramas + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lgramas
	ret

escreve_FIR1:
	mov cx,4			;número de caracteres
	mov bx,0
	mov dh,17			;linha 0-29
	mov dl,2			;coluna 0-79
lfir1:
	call cursor
	mov  al,[FIR1 + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lfir1
	ret

escreve_FIR2:
	mov cx,4			;número de caracteres
	mov bx,0
	mov dh,12			;linha 0-29
	mov dl,2			;coluna 0-79
lfir2:
	call cursor
	mov  al,[FIR2 + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lfir2
	ret

escreve_FIR3:
	mov cx,4			;número de caracteres
	mov bx,0
	mov dh,7			;linha 0-29
	mov dl,2			;coluna 0-79
lfir3:
	call cursor
	mov  al,[FIR3 + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  lfir3
	ret
	

escreve_abrir:
	mov cx,5			;número de caracteres
	mov bx,0
	mov dh,2			;linha 0-29
	mov dl,2			;coluna 0-79
labrir:
	call cursor
	mov  al,[abrir + bx]
	call	caracter
	inc  bx	;proximo caracter
	inc	dl	;avanca a coluna
	loop  labrir
	ret

escreve_menu_lateral:
	call escreve_abrir
	call escreve_FIR1
	call escreve_FIR2
	call escreve_FIR3
	call escreve_histogramas
	call escreve_sair
	ret
;***************************************************************************
;
;   função cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
	pushf
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	push	bp
	mov   ah,2
	mov   bh,0
	int   10h
	pop		bp
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	ret
;_____________________________________________________________________________
;
;   função caracter escrito na posição do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
	pushf
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	push	bp
	mov   ah,9
	mov   bh,0
	mov   cx,1
	mov   bl,[cor]
  int   10h
	pop		bp
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	ret
;_____________________________________________________________________________
;
;   função plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
	push		bp
	mov		bp,sp
	pushf
	push 		ax
	push 		bx
	push		cx
	push		dx
	push		si
	push		di
	mov   ah,0ch
	mov     	al,[cor]
	mov     	bh,0
	mov     	dx,479
	sub		dx,[bp+4]
	mov     	cx,[bp+6]
	int     	10h
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		4
;_____________________________________________________________________________
;    fun��o circle
;	 push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	
	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov 	dx,bx	
	add		dx,cx       ;ponto extremo superior
	push    ax			
	push	dx
	call plot_xy
	
	mov		dx,bx
	sub		dx,cx       ;ponto extremo inferior
	push    ax			
	push	dx
	call plot_xy
	
	mov 	dx,ax	
	add		dx,cx       ;ponto extremo direita
	push    dx			
	push	bx
	call plot_xy
	
	mov		dx,ax
	sub		dx,cx       ;ponto extremo esquerda
	push    dx			
	push	bx
	call plot_xy
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:				;loop
	mov		si,di
	cmp		si,0
	jg		inf       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar:	
	mov		si,dx
	add		si,ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si,cx
	add		si,bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do s�timo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante
	
	cmp		cx,dx
	jb		fim_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;    fun��o full_circle
;	 push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor					  
full_circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov		si,bx
	sub		si,cx
	push    ax			;coloca xc na pilha			
	push	si			;coloca yc-r na pilha
	mov		si,bx
	add		si,cx
	push	ax		;coloca xc na pilha
	push	si		;coloca yc+r na pilha
	call line
	
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:				;loop
	mov		si,di
	cmp		si,0
	jg		inf_full       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar_full
inf_full:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar_full:	
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call 	line
	
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call	line
	
	cmp		cx,dx
	jb		fim_full_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay_full		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_full_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;
;   fun��o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
		push		bp
		mov		bp,sp
		pushf                        ;coloca os flags na pilha
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		mov		ax,[bp+10]   ; resgata os valores das coordenadas
		mov		bx,[bp+8]    ; resgata os valores das coordenadas
		mov		cx,[bp+6]    ; resgata os valores das coordenadas
		mov		dx,[bp+4]    ; resgata os valores das coordenadas
		cmp		ax,cx
		je		line2
		jb		line1
		xchg		ax,cx
		xchg		bx,dx
		jmp		line1
line2:		; deltax=0
		cmp		bx,dx  ;subtrai dx de bx
		jb		line3
		xchg		bx,dx        ;troca os valores de bx e dx entre eles
line3:	; dx > bx
		push		ax
		push		bx
		call 		plot_xy
		cmp		bx,dx
		jne		line31
		jmp		fim_line
line31:		inc		bx
		jmp		line3
;deltax <>0
line1:
; comparar m�dulos de deltax e deltay sabendo que cx>ax
	; cx > ax
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		ja		line32
		neg		dx
line32:		
		mov		[deltay],dx
		pop		dx

		push		ax
		mov		ax,[deltax]
		cmp		ax,[deltay]
		pop		ax
		jb		line5

	; cx > ax e deltax>deltay
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx

		mov		si,ax
line4:
		push		ax
		push		dx
		push		si
		sub		si,ax	;(x-x1)
		mov		ax,[deltay]
		imul		si
		mov		si,[deltax]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar1
		add		ax,si
		adc		dx,0
		jmp		arc1
ar1:		sub		ax,si
		sbb		dx,0
arc1:
		idiv		word [deltax]
		add		ax,bx
		pop		si
		push		si
		push		ax
		call		plot_xy
		pop		dx
		pop		ax
		cmp		si,cx
		je		fim_line
		inc		si
		jmp		line4

line5:		cmp		bx,dx
		jb 		line7
		xchg		ax,cx
		xchg		bx,dx
line7:
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx



		mov		si,bx
line6:
		push		dx
		push		si
		push		ax
		sub		si,bx	;(y-y1)
		mov		ax,[deltax]
		imul		si
		mov		si,[deltay]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar2
		add		ax,si
		adc		dx,0
		jmp		arc2
ar2:		sub		ax,si
		sbb		dx,0
arc2:
		idiv		word [deltay]
		mov		di,ax
		pop		ax
		add		di,ax
		pop		si
		push		di
		push		si
		call		plot_xy
		pop		dx
		cmp		si,dx
		je		fim_line
		inc		si
		jmp		line6

fim_line:
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		8
;*******************************************************************
segment data

cor		db		branco_intenso

;	I R G B COR
;	0 0 0 0 preto
;	0 0 0 1 azul
;	0 0 1 0 verde
;	0 0 1 1 cyan
;	0 1 0 0 vermelho
;	0 1 0 1 magenta
;	0 1 1 0 marrom
;	0 1 1 1 branco
;	1 0 0 0 cinza
;	1 0 0 1 azul claro
;	1 0 1 0 verde claro
;	1 0 1 1 cyan claro
;	1 1 0 0 rosa
;	1 1 0 1 magenta claro
;	1 1 1 0 amarelo
;	1 1 1 1 branco intenso

preto		equ		0
azul		equ		1
verde		equ		2
cyan		equ		3
vermelho	equ		4
magenta		equ		5
marrom		equ		6
branco		equ		7
cinza		equ		8
azul_claro	equ		9
verde_claro	equ		10
cyan_claro	equ		11
rosa		equ		12
magenta_claro	equ		13
amarelo		equ		14
branco_intenso	equ		15

modo_anterior	db		0
linha   	dw  		0
coluna  	dw  		0
deltax		dw		0
deltay		dw		0	
mens    	db  		'Funcao Grafica'
nome db 'Thyago Vieira Piske$'
sair db 'Sair$'
histo db 'Histo$'
gramas db 'gramas$'
FIR1 db 'FIR1$'
FIR2 db 'FIR2$'
FIR3 db 'FIR3$'
abrir db 'Abrir$'
limite_horizontal equ 639
limite_vertical equ 479
;*************************************************************************
segment stack stack
    		resb 		512
stacktop:

