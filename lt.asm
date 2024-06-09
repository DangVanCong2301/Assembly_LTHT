INCLUDE lib1.asm
.MODEL small
.STACK 100h ; Mô hình bộ nhớ dành cho chương trình dạng small
.DATA ; Dành một vùng nhớ để cấp phát biến
	m1 db 13, 10, 'Hay vao a: $'
	m2 db 13, 10, 'Hay vao n: $'
	ctlf db 13, 10, '$'
	m3 db ' luy thua $'
	m4 db ' la: $'
	m5 db 13, 10, 'Co tiep tuc chuong trinh (c/k) khong? $'
.CODE
PS:
	mov ax, @data ; Đưa phần địa chỉ segment vùng nhó dành cho dữ liệu
	mov ds, ax ; vào ds (chỉ có khi có .data, có khai báo biến) 
	clrscr
	HienString m1 
	call VAO_SO_N ; Nhận giá trị a
	mov bx, ax ; bx = a
	HienString m2 ; Hiện thông báo m2 
	call VAO_SO_N ; Nhận giá trị n 
	mov cx, ax ; cx = n 
	HienString ctlf ; Quay đầu dòng và xuống hàng 
	mov ax, bx ; ax = a
	call HIEN_SO_N ; Hiện giá trị a lên màn hình
	HienString m3 
	mov ax, cx ; ax = n
	call HIEN_SO_N ; Hiện giá trị n lên màn hình
	HienString m4
	mov ax, 1 ; Gán ax = 1
	and cx, cx ; Liệu giá trị n (cx = n) có bằng 0?
	jz HIEN ; Nếu bằng 0 thì nhảy đến nhãn HIEN 
	
	LAP: ; còn không thì thực hiện vòng lặp tính a lũy thừa n 
		mul bx ; ax = ax * bx 
		loop LAP
	
	HIEN:
		call HIEN_SO_N ; Hiện giá trị a lũy thừa n (giá trị có trong ax)
		HienString m5 
		mov ah, 1 
		int 21h 
		cmp al, 'c'
		jne Exit;
		jmp PS
	
	Exit:
		mov ah, 4ch ; Về DOS
		int 21h
INCLUDE lib2.asm 
END PS
