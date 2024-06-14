INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA 
	m1 db 13, 10, 'Nhap so 1: $'
	m2 db 13, 10, 'Nhap so 2: $'
	m3 db 13, 10, 'Tong hai so la: $'
	m4 db 13, 10, 'Co tiep tuc chuong trinh khong (c/k)? $'
.CODE 
PS:
	mov ax, @data 
	mov ds, ax 
	clrscr
	HienString m1 
	call VAO_SO_N 
	mov bx, ax 
	HienString m2 
	call VAO_SO_N 
	add ax, bx ; ax = ax + bx 
	HienString m3 
	call HIEN_SO_N 
	
	CONTINUE:
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