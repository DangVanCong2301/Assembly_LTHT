INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	lt1 db 13, 10, 'Ngay, thang, nam hien tai cua may tinh la: $'
	mon db 13, 10, 'Thu 2$'
	tue db 13, 10, 'Thu 3$'
	wed db 13, 10, 'Thu 4$'
	thu db 13, 10, 'Thu 5$'
	fri db 13, 10, 'Thu 6$'
	sat db 13, 10, 'Thu 7$'
	sun db 13, 10, 'Chu nhat$'
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
		mov ah, 2ah ; Chức năng lấy thứ, ngày, tháng, năm của máy tính 
		int 21h
		mov al, al ; Đưa thứ từ al -> al
		xor ah, ah ; Chuyển ah = 0, al = 0, 1, 2, 3, 4, 5, 6
		cmp al, 0
		je PRINT_SUN ; Nhảy nếu [Đích] = [Nguồn]; Tương tự như jz; (JF=0)
		cmp al, 1
		je PRINT_MON
		cmp al, 2
		je PRINT_TUE
		cmp al, 3
		je PRINT_WED
		cmp al, 4
		je PRINT_THU
		cmp al, 5
		je PRINT_FRI
		cmp al, 6
		je PRINT_SAT
		;call HIEN_SO_N ; Hiện thứ 
		
	PRINT_MON:
		HienString mon
		jmp L_LT1
		
	PRINT_TUE:
		HienString tue
		jmp L_LT1
		
	PRINT_WED:
		HienString wed
		jmp L_LT1
		
	PRINT_THU:
		HienString thu
		jmp L_LT1
	
	PRINT_FRI:
		HienString fri
		jmp L_LT1
	
	PRINT_SAT:
		HienString sat
		jmp L_LT1
		
	PRINT_SUN:
		HienString sun
		jmp L_LT1
	
	L_LT1:
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
		jmp CONTINUE
		
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