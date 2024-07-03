INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	lt1 db 13, 10, 'Ngay, thang, nam hien tai cua may tinh la: $'
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
		mov ah, 2ah ; Chức năng lấy giờ, phút, giây của máy tính 
		int 21h
		mov al, al ; Đưa thứ từ al -> al
		xor ah, ah ; Chuyển ah = 0, al = 0, 1, 2, 3, 4, 5, 6
		call HIEN_SO_N ; Hiện thứ 
		HienString dc
		mov al, dl ; Đưa ngày từ dl -> al 
		xor ah, ah ; ah = 0
		call HIEN_SO_N ; Hiện ngày
		HienString dc
		mov al, dh ; Đưa tháng từ dh -> al 
		xor ah, ah ; ah = 0
		call HIEN_SO_N ; Hiện tháng  
		HienString dc
		mov ax, cx ; Đưa năm từ cx -> al
		call HIEN_SO_N ; Hiện năm
		
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