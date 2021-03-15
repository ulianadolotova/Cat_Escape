 	;===============================================================
 	; require: Number of taps in ax
 	;
 	; return:  Puting message about number of taps to free cat to video memory
 	;
 	; damage:  ax, bx, cx, si, di
  	;===============================================================
     	PRINT_MESSAGE_1 proc

     		mov di, (80 * 23) * 2
     		mov si, offset MESSAGE_1
     		inc si
     		push ax
     		call STR_TO_VID
     		pop ax
     		push di

     	    	mov bx, 10
     		call NUM_TO_STR
     		pop di
     		dec byte ptr [si - 1]
     		call STR_TO_VID

     		mov si, offset MESSAGE_1_2
     		inc si
     		call STR_TO_VID
     	ret
     	endp



 	;==========================================================================
 	; require: Offset of message in si. Start of message in video memory in di
 	;
 	; return:  Puting message from si to video memory
 	;
 	; damage:  Nothing 
  	;==========================================================================
     	PRINT_MESSAGE proc

     		inc si
     		push ax
     		call CLEAR_LINE
     		call STR_TO_VID
     		pop ax
      	ret
     	endp


 	;===============================================================
 	; require: Offset of string in di
 	;
 	; return:  Clearing one line, but not moving di
 	;
 	; damage:  Nothing 
  	;===============================================================
	CLEAR_LINE proc

	    	push es di ax cx
		
		mov ax, vid_addr
		mov es, ax

		mov cx, 80
		xor ax, ax

		rep stosw

	    	pop cx ax di es
	ret
	endp