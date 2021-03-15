	;===========================================================
	; require: Buffer CAT with cat symbols
	;
	; return:  Printing cat on a screen
	;
	; damage:  ax, cx, si, di
	;===========================================================
	DRAW_CAT proc
		push es
		mov ax, vid_addr
 		mov es, ax               
 		xor ax, ax

	    	mov si, offset CAT
	    	mov di, (80 * 4 + 2) * 2
	    	mov cx, 17

		CAT_LAYERS:	push cx
				mov cx, 30
			
				CAT_DOTS:	mov ax, [si]
						inc si
						inc si
						stosw
						stosw
						loop CAT_DOTS
						add di, 20 * 2
						pop cx

				loop CAT_LAYERS


		pop es
	ret
	endp



	;===========================================================
	; require: Nothing
	;
	; return:  Opening a cage
	;
	; damage:  ax, cx, di
	;===========================================================
	OPEN_CAGE proc
		push es

		mov ax, vid_addr
		mov es, ax
		mov di, (80 * 3 + 1) * 2
		add di, (80 * (y - 3)) * 2
		mov ax, W
		mov cx, y - 1
		DESTROY:     	;call WAITING
				mov es:[di], ax
				sub di, 80 * 2
			        loop DESTROY
		pop es	

			


	ret
	endp

	;===========================================================
	; require: Nothing
	;
	; return:  Moving all the bytes left (until border)
	;
	; damage:  ax, cx, di
	;===========================================================
	MOVE_CAT proc
		push es

		mov ax, vid_addr
		mov es, ax 
		mov di, (80 * 2 + 2) * 2

		mov cx, 17

		MOVE_LAYER:	push cx
				mov cx, 59
	     	 		MOVE_PIX:	mov ax, es:[di + 2]
	       					stosw
	       					loop MOVE_PIX
	       			pop cx
	       			add di, 21 * 2
	       			loop MOVE_LAYER


		pop es
	ret
	endp

	;===========================================================
	; require: Nothing
	;
	; return:  Waiting for some time (that specified in (cx,dx))
	;
	; damage:  dx
	;===========================================================
	WAITING proc
		push cx ax

		mov cx, 0007h
		mov dx, 0A120h
		
		mov ah, 86h
		int 15h

		pop ax cx
	ret
	endp