INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	lt1 db 13, 10, 'Gio, phut, giay va % giay hien tai cua may tinh la: $'
	hc db ':$'
	dc db '.$'
	tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
	PUBLIC @TIME@qv
@TIME@qv PROC
		mov ax, @data 
		mov ds, ax

	L_LT0:
		CLRSCR
		HienString lt1
		mov ah, 2ch ; Chức năng lấy giờ, phút, giây của máy tính 
		int 21h
		mov al, ch ; Đưa giờ từ ch -> al 
		xor ah, ah ; ah = 0
		call HIEN_SO_N
		HienString hc
		mov al, cl ; Đưa phút từ cl -> al 
		xor ah, ah ; ah = 0
		call HIEN_SO_N ; Hiện phút 
		HienString hc
		mov al, dh ; Đưa giây từ dh -> al
		xor ah, ah 
		call HIEN_SO_N ; Hiện giây 
		HienString hc
		mov al, dl ; Đưa % giây từ dl -> al
		xor ah, ah 
		call HIEN_SO_N ; Hiện % giây 
		
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_LT0
		
	Exit:
		mov ah, 4ch
		int 21h 

INCLUDE lib2.asm 
@TIME@qv ENDP
	END