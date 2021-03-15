	;===========================================================
	; require: Defined constants
	;
	; return:  Cleaning hole screen for game with cat
	;
	; damage:  ax, cx, di
	;===========================================================
	CLEAN_SPACE proc
		xor di, di
 		mov cx, y_full
 		mov al, 20h

 		CLEAN_Y:
 			push cx
 			mov cx, x_full	
 			CLEAN_X:       	stosw
 					loop CLEAN_X
 			pop cx
 			add di, (80 - x_full) * 2
 			loop CLEAN_Y
	ret
	endp



	;===========================================================
	; require: Nothing
	;
	; return:  Drawing a frame for cat and number  
	;
	; damage:  all except segment
	;===========================================================
	DRAW_FRAME proc
		push es
		mov ax, vid_addr
 		mov es, ax               
 		xor ax, ax

	        call CLEAN_SPACE

	        mov di, (80 * 3 + 1) * 2
	        mov ah, 30h
	        call DRAW_LINE
	        call DRAW_COLUMN

	        mov di, (80 * 3 + 1) * 2
	        call DRAW_COLUMN
		call DRAW_LINE

		mov al, angle_c
		mov es:[di], ax
	
	        mov al, angle_d
		mov es:[di - x * 2], ax

		mov al, angle_b
		mov es:[di - (80 * y) * 2], ax

		mov al, angle_a
		mov es:[di - (80 * y + x) * 2], ax

		mov di, (80 * 3 + 62) * 2
		call DRAW_COLUMN
		mov al, connector_down
		mov es:[di], ax
		mov al, connector_up
		mov es:[di - 80 * y  * 2], ax

		pop es
	ret
	endp	



	;===========================================================
	; require: Pointer to current place in video memory in di. 
	;	   Frame colour in ah.
	;
	; return:  Drawing a horizontal line
	;
	; damage:  al, cx
	;===========================================================
	DRAW_LINE proc
	        mov cx, x
	        mov al, line
 		
		rep stosw
	ret
	endp



	;===========================================================
	; require: Pointer to current place in video memory in di. 
	;	   Frame colour in ah.
	;
	; return:  Drawing a column
	;
	; damage:  al, cx
	;===========================================================
	DRAW_COLUMN proc
	        mov cx, y
	        mov al, column

 	NEXT_COLUMN:
 	 		mov es:[di], ax
 			add di, 80*2
 			loop NEXT_COLUMN	
	ret
	endp	