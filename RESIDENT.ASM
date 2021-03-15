 	;======================================================
	; require: Nothing
	;
	; return:  Processing ports like in normal interrupt
	;
	; damage:  al	
 	;======================================================
 	CHANGE_INT_FUNC proc

		xor ax, ax
		mov es, ax
		mov di, 9 * 4

		cli

		mov ax, es:[di]
		mov old_offset, ax
		mov ax, es:[di + 2]
		mov old_segment, ax

		mov es:[di], offset FUNCTION
		mov ax, cs
		mov es:[di + 2], ax

		sti
	ret
	endp

 	;==================================
	; require: END_PROGRAM label
	;
	; return:  Make program resident
	;
	; damage:  ax, dx
 	;==================================
	SAVE_PROGRAM proc

		mov ax, 3100h
		mov dx, offset END_PROGRAM
		shr dx, 4
		inc dx
		int 21h
	ret
	endp

 	;================================================================
 	; require: Nothing
	;
	; return:  Processing keypress instead of normal int 09h function
	;
	; damage:  all except ax, bx and segment
 	;================================================================
 	FUNCTION proc

		push ax es ds
		mov ax, cs
		mov es, ax
		mov ds, ax
		 
		in al, 60h
		
		cmp al, 24
		je PROC_OPENING
		cmp al, 75
		je PROC_LEAVING
		jmp NORMAL_END

	        PROC_OPENING:	mov ax, counter
	                        or ax, ax
	                        jz NORMAL_END

	        		dec ax
	        		mov si, offset counter
	        		mov [si], ax
	        		or ax, ax
	        		jz OPEN
	        		jmp SPECIAL_END

		OPEN:	call OPEN_CAGE
			jmp SPECIAL_END


	        PROC_LEAVING:	mov bx, counter
	        		or bx, bx
	        		jnz CAGE_CLOSED

	        		mov ax, num_moves
	        		cmp ax, 57
	        		je NORMAL_END

	        		inc ax
	        		mov si, offset num_moves
	        		mov [si], ax
	        		cmp ax, 56
	        		je CAT_IS_FREE

	        		call MOVE_CAT
	        		jmp SPECIAL_END	

	        CAGE_CLOSED:	mov di, (80 * 22) * 2
     				mov si, offset MESSAGE_2
	        		call PRINT_MESSAGE
	                        jmp SPECIAL_END

	        CAT_IS_FREE:	call MOVE_CAT
	        		mov di, (80 * 21) * 2
	        		call CLEAR_LINE
	        		mov di, (80 * 22) * 2
     				mov si, offset MESSAGE_3
	        		call PRINT_MESSAGE
	        		jmp NORMAL_END


	SPECIAL_END:	call SETTING_PORTS

			pop ds es ax
			iret

 	NORMAL_END:	pop ds es ax
 			db 0eah
	old_offset	dw 0 
	old_segment     dw 0


	endp

 	;========================================================
	; require: Nothing
	;
	; return:  Processing ports like in normal interrupt
	;
	; damage:  al
 	;========================================================
 	SETTING_PORTS proc

		in al, 61h
		or al, 80h
		and al, 7Fh
		out 61h, al

	      	mov al, 20h
	      	out 20h, al
	ret
	endp