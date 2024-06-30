INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	ct1 db 13, 10, 'Vao ten tep can chia: $'
	ct2 db 13, 10, 'Vao ten tep con 1: $'
	ct3 db 13, 10, 'Vao ten tep con 2: $'
	err_o db 13, 10, 'Khong mo duoc tep! $'
	err_r db 13, 10, 'Khong doc duoc tep! $'
	err_w db 13, 10, 'Khong ghi duoc tep! $'
	err_s db 13, 10, 'Khong di chuyen duoc con reo tep! $'
	err_c db 13, 10, 'Khong dong duoc tep! $'
	the_tep dw ?
	the_tepc1 dw ?
	the_tepc2 dw ?
	buff db 30
		db ?
	file_name db 30 dup(?)
	dodai_tep dw ?
	dem db 20000 dup(?)
	tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
	PUBLIC @CT$qv
@CT$qv PROC
		mov ax, @data 
		mov ds, ax 
		
	L_CT0:
		CLRSCR
		HienString ct1
		lea dx, buff ; Vào tên tệp cần chia 
		call GET_FILE_NAME
		lea dx, file_name ; Mở tệp đã có để đọc
		mov al, 0
		mov ah, 3dh
		int 21h
		jnc L_CT1 ; Mở tệp tốt (CF = 0) thì nhảy
		HienString err_o ; Mở tệp lỗi
		jmp CONTINUE
		
	L_CT1:
		mov the_tep, ax ; Cất thẻ tệp có trong ax -> biến the_tep
		mov bx, ax ; Đưa con trỏ về cuối tệp để xác định độ dài của tệp
		xor cx, cx ; Khoảng cách so sánh là = 0
		mov dx, cx ; 
		mov al, 2
		mov ah, 42h
		int 21h
		
	
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_CT0
	
	Exit:
		mov ah, 4ch
		int 21h
		
INCLUDE lib4.asm 
@CT$qv ENDP
	END