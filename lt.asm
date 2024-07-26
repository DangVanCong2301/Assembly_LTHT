INCLUDE lib1.asm
.MODEL small
.STACK 100h 				; Mô hình bộ nhớ dành cho chương trình dạng small
.DATA 						; Dành một vùng nhớ để cấp phát biến
	m1 	db 13, 10, 'CAC BAI TAP NGON NGU ASSEMBLY THUAN TUY'
		db 13, 10, '---------------------------------------'
		db 13, 10, 13, 10, 'Bai 1: Tinh a luy thua n (a la so nguyen va n la so nguyen duong'
		db 13, 10, 13, 10, '---------------------------------------'
		db 13, 10, 13, 10, '------------------- CHUONG TRINH --------------------'
		db 13, 10, 'Hay vao a: $'
	m2 db 13, 10, 'Hay vao n: $'
	ctlf db 13, 10, '$'
	m3 db ' luy thua $'
	m4 db ' la: $'
	m5 db 13, 10, 'Co tiep tuc chuong trinh (c/k) khong? $'
	m6 db 13, 10, 'So a phai khac 0! $'
	buff 	dw 8
			dw ?
			dw 8 dup(?)
	m7 db 13, 10, 'Hay vao lai a: $'
.CODE
PS:
		mov ax, @data 			; Đưa phần địa chỉ segment vùng nhó dành cho dữ liệu
		mov ds, ax 				; vào ds (chỉ có khi có .data, có khai báo biến) 
	
	L_CT0:
		clrscr
		HienString m1 
	L_CT1:
		call VAO_SO_N 			; Nhận giá trị a
		cmp ax, 0
		je L_CT2
		mov bx, ax 				; bx = a
		HienString m2 			; Hiện thông báo m2 
		call VAO_SO_N 			; Nhận giá trị n 
		mov cx, ax 				; cx = n 
		HienString ctlf 		; Quay đầu dòng và xuống hàng 
		mov ax, bx 				; ax = a
		call HIEN_SO_N 			; Hiện giá trị a lên màn hình
		HienString m3 
		mov ax, cx 				; ax = n
		call HIEN_SO_N 			; Hiện giá trị n lên màn hình
		HienString m4
		mov ax, 1 				; Gán ax = 1
		and cx, cx 				; Liệu giá trị n (cx = n) có bằng 0?
		jz HIEN 				; Nếu bằng 0 thì nhảy đến nhãn HIEN 
	
	LAP: 					; còn không thì thực hiện vòng lặp tính a lũy thừa n 
		mul bx ; ax = ax * bx 
		loop LAP
	
	HIEN:
		call HIEN_SO_N 		; Hiện giá trị a lũy thừa n (giá trị có trong ax)
		jmp CONTINUE
		
	L_CT2:
		HienString m6
		HienString m7
		jmp L_CT1
		
	CONTINUE:
		HienString m5 
		mov ah, 1 
		int 21h 
		cmp al, 'c'
		jne Exit;
		jmp L_CT0
	
	Exit:
		mov ah, 4ch ; Về DOS
		int 21h
INCLUDE LIB5.asm 
END PS
