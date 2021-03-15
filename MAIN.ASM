.model tiny
.code
org 100h


str_size equ 30

W equ 7700h
B equ 070fh
M equ 7d0fh

x_full equ 80
y_full equ 24

x equ 77
y equ 18
vid_addr equ 0b800h

line equ 0cdh
column equ 0bah

angle_a equ 0c9h
angle_b equ 0bbh
angle_c equ 0bch
angle_d equ 0c8h

connector_up equ 0cbh
connector_down equ 0cah



START:
	call DRAW_FRAME
	call GET_STR
	call MAKE_NUM
	call PRINT_NUM
	call PRINT_MESSAGE_1
	call DRAW_CAT
	call CHANGE_INT_FUNC
	call SAVE_PROGRAM

	include resident.asm
	include draw_c.asm
	include messages.asm
	include num_in.asm

counter dw 0

num_moves dw 0

MESSAGE_2: db 38, 'CAGE IS CLOSED... OPEN THE CAGE FIRST!'
MESSAGE_3: db 26, 'CAT IS FREE AND HAPPY NOW!'

END_PROGRAM:


	include draw_f.asm

INPUT:	db str_size dup (?)

OUTPUT: db str_size dup (?)

CAT:	dw W, W, W, W, W, B, W, W, W, W, W, W, B, W, W, W, W, W, W, W, W, W, W, B, B, W, W, W, W, W
	dw W, W, W, W, B, M, B, W, W, W, W, B, M, B, W, W, W, W, W, W, W, W, B, M, M, B, W, W, W, W
	dw W, W, W, W, B, M, B, B, B, B, B, B, M, B, W, W, W, W, W, W, W, W, W, B, M, M, B, W, W, W
	dw W, W, W, B, M, M, B, M, M, M, M, B, M, M, B, B, W, W, W, W, W, W, W, W, B, M, M, B, W, W
	dw W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, B, B, W, W, W, W, W, W, B, M, M, B, W, W
	dw W, B, B, B, B, M, B, M, M, M, B, M, B, B, B, M, M, B, B, B, B, B, B, B, B, M, B, W, W, W
	dw W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W
	dw W, B, B, B, B, M, M, M, B, M, M, M, B, B, B, M, M, M, M, M, M, M, B, B, B, B, W, W, W, W
	dw W, W, W, W, W, B, M, B, M, B, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, B, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, B, M, M, B, B, B, M, M, M, B, B, B, B, B, B, B, B, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, B, M, B, W, W, W, B, M, B, W, W, W, B, M, B, W, B, M, B, W, W, W, W, W, W, W
	dw W, W, W, W, W, B, W, W, W, W, W, B, W, W, W, W, W, B, W, W, W, B, W, W, W, W, W, W, W, W


MESSAGE_1: db 26,  'CAT IS TRAPPED!!! TAP "O" '
MESSAGE_1_2: db 24, ' TIMES TO OPEN THE CAGE!'

end START