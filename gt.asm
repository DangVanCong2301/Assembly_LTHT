INCLUDE lib1.asm
.MODEL small 
.STACK 100h
.DATA
	m1 db 13, 10, 'Hay vao n: $'
	m2 db 13, 10, 'Giai thua cua $'
	m3 db ' la: $'
	m4 db 13, 10, 'Co tiep tuc chuong trinh khong (c/k)? $'
.CODE
PS:
	mov ax, @data
	mov ds, ax 
	clrscr
	HienString m1 
	call VAO_SO_N 
	mov cx, ax ; cx = n
	HienString m2 
	call HIEN_SO_N
	HienString m3 
	mov ax, 1 ; ax = 1
	cmp cx, 2 ; Liệu n <= 2
	jb HIEN ; Đúng là n <= 2 thì nhảy đến nhãn HIEN
	
	LAP: ; còn không thì thực hiện vòng lặp tính n!
		mul cx ; ax = ax * cx 
		loop LAP
	
	HIEN:
		call HIEN_SO_N ; Hiện giá trị n! (có trong ax)
		HienString m4 
		mov ah, 1
		int 21h 
		cmp al, 'c'
		jne Exit 
		jmp PS 
	
	Exit:
		mov ah, 4ch
		int 21h
INCLUDE lib2.asm
END PS