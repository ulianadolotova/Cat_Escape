	;===================================================================================
	; require: Buffer for the string. Length is str_size. (MAX LENGTH is 255).
	;
	; return:  Pointer to the size of entered string in si. Next symbol is the begining
	;  	   of entered string.
	;
	; damage:  ah, cx, dx, si
	;===================================================================================
	GET_STR proc

		mov ah, 0ah
		mov cx, str_size
		mov dx, offset INPUT		
		mov si, dx
		mov byte ptr [si], str_size
		int 21h
		inc si		
 	ret
 	endp	


 	;====================================================================================
 	; require: Pointer to the size of the string (in si). Si + 1 contains begining of the
 	;          string with the symbols of number.
 	;
 	; return:  Number in di.  
 	;
 	; damage:  bx, dx, si, cx, di
 	;====================================================================================
 	MAKE_NUM proc
 	    	
 		xor cx, cx
		mov cl, [si]
		add si, cx
		mov bx, 1
		xor di, di

		SYMB_PROC:      xor ax, ax
				mov al, [si]
				sub al, '0'
				mul bx
				add di, ax	

				mov ax, 10
				mul bx
				mov bx, ax
				dec si

				loop SYMB_PROC

 	ret
 	endp

 	;===============================================================
 	; require: Number in di
 	;
 	; return:  Converting number in 4 systems and printing results
 	;
 	; damage:  ax, dx, cx, di
 	;===============================================================
 	PRINT_NUM proc

		mov ax, di

		mov si, offset counter
 		mov [si], ax

		push ax
     	
	     	mov bx, 10
     		call NUM_TO_STR
     		mov di, (80 * 5 + 64) * 2
     		call STR_TO_VID

     		pop ax
     		push ax 
     	
     		mov bx, 2 
     		call NUM_TO_STR
     		mov di, (80 * 7 + 64) * 2
     		call STR_TO_VID

     		pop ax
     		push ax 
     	
     		mov bx, 8 
     		call NUM_TO_STR
     		mov di, (80 * 8 + 64) * 2
     		call STR_TO_VID

    		pop ax
     		push ax 
     	
     		mov bx, 16 
     		call NUM_TO_STR
     		mov di, (80 * 9 + 64) * 2
     		call STR_TO_VID	

     		pop ax

     	ret
     	endp


	
 	;====================================================================================
 	; require: Number in ax. Number of symbols in cx. Base of the number system in bx. 
 	;
 	; return:  Adress of string in si. Number of symbols in [si - 1]
 	;
 	; damage:  ax, dx, bx, si, cx 
 	;====================================================================================
 	NUM_TO_STR proc

 		xor cx, cx

		MAKE_SYMB:	xor dx, dx
				div bx
				push dx

				inc cx	
				or ax, ax
				
				jnz MAKE_SYMB

		mov di, offset OUTPUT
		mov [di], cl
		inc byte ptr [di]
		inc di
		mov si, di
		
		cld
		TAKE_SYMB:	pop ax
				cmp ax, 9
				ja LETTER_CASE
				add al, '0'
				jmp FORWARD 

		LETTER_CASE:	add al, 'A' - 10

		FORWARD: 	stosb	
				loop TAKE_SYMB

	       	cmp bx, 2
	       	je BIN_CASE
		cmp bx, 8
		je OCT_CASE
		cmp bx, 10
		je DEC_CASE
		cmp bx, 16
		je HEX_CASE

		BIN_CASE:	mov byte ptr [di], 'b'
				jmp CONTINUE
		OCT_CASE:	mov byte ptr [di], 'o'
				jmp CONTINUE
		DEC_CASE:	mov byte ptr [di], 'd'
				jmp CONTINUE
		HEX_CASE:	mov byte ptr [di], 'h'
				jmp CONTINUE

		CONTINUE:
 	ret
 	endp


 	;===============================================================
  	; require: Adress of string in si. Number of symbols in [si - 1]
 	;	   Offset of message in vide memory in di
 	;
 	; return:  Put string to the video memory
 	;
 	; damage:  ax, dx, cx, di
 	;===============================================================
  	STR_TO_VID proc

 		push es si
 		mov ax, 0b800h
 		mov es, ax               
 		mov ah, 30h
 		
 		mov cl, [si - 1]
 		xor ch, ch
 		cld

 		PRINT_SYMB:     lodsb
 				stosw
 				loop PRINT_SYMB
 		pop si es
 	ret
 	endp