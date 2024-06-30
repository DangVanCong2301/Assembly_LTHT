INCLUDE lib1.asm 
.MODEL small
.STACK 100h
.DATA
	ltt1 db 13, 10, 'Hay vao ten tep can lay thuoc tinh: $'
	ltt2 db 13, 10, 'Tep co thuoc tinh la: $'
	err_ltt db 13, 10, 'Khong lay duoc thuoc tinh! $'
	buff db 30
		db ?
	file_name db 30 dup(?)
	tt0 db 'Khong co thuoc tinh nao! $'
	tt1 db 'Read Only $'
	tt2 db ' + Hidden $'
	tt3 db ' + System $'
	tt4 db ' + Archive $'
	tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
		mov ax, @data 
		mov ds, ax 
	
	L_LTT0:
		CLRSCR
		HienString ltt1 
		lea dx, buff
		call GET_FILE_NAME ; Vào tên tệp cần lấy thuộc tính 
		mov al, 0 ; Chức năng lấy thuộc tính 
		lea dx, file_name ; thuộc tính có trong cx (thực chất nằm ở cl)
		mov ah, 43h
		int 21h 
		jnc L_LTT1 
		HienString err_ltt
		jmp CONTINUE
		
	L_LTT1:
		HienString ltt2
		and cl, 00100111b ; Tách các bit thuộc tính của tệp 
		jnz L_LTT2 
		HienString tt0 ; Còn không thì hiện tt0 
		jmp CONTINUE
		
	L_LTT2:
		shr cl, 1 ; Bit Read Only -> Bit cờ CF 
		jnc L_LTT3 
		HienString tt1
		
	L_LTT3:
		shr cl, 1 ; Bit Hidden -> Bit cờ CF 
		jnc L_LTT4
		HienString tt2
	
	L_LTT4:
		shr cl, 1 ; Bit System -> Bit cờ CF 
		jnc L_LTT5
		HienString tt3
		
	L_LTT5:
		shr cl, 1 
		shr cl, 1
		shr cl, 1 ; Bit Archive -> Bit cờ CF 
		jnc CONTINUE ; CF = 0 (Không có thuộc tính Archive) thì nhảy
		HienString tt4
		
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_LTT0
		
	Exit:
		mov ah, 4ch
		int 21h

INCLUDE lib4.asm	
END PS