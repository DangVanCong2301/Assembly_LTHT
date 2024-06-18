INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA 
	m1 db 13, 10, 'Hay nhap so luong thanh phan: $'
	m2 db 13, 10, 'a[$'
	m3 db ']=$'
	m4 db 13, 10, 'Day so vua nhap la: $'
	m5 db ' $'
	m6 db 13, 10, 'Tong day so nguyen la: $'
	m7 db 13, 10, 'So lon nhat trong day la: $'
	a dw 100 DUP(?) 		; phần từ ko khởi tạo, không quá 100
	i dw ?
	sltp dw ? 				; int sltp 
.CODE
PS:	
		mov ax, @data 
		mov ds, ax 
		clrscr
		HienString m1 
		call VAO_SO_N 		; ax = sltp 
		mov sltp, ax 
		
		; Vòng lặp nhập các số vào mảng 
		mov cx, ax 			; cx = sltp 
		mov i, 0 			; a[0]=
		lea bx, a 			; mov bx, offset a, bx trỏ đến offset của mảng a 
		mov dx, -32768
	L1:
		HienString m2 		; a[
		mov ax, i 			; 
		call HIEN_SO_N
		HienString m3 		; ]=
		call VAO_SO_N 		; Vào các số của dãy

	;-----------------------------------------------
	; Tìm số lớn nhất trong dãy
	; 	cmp dx, ax 			; So sánh số hiện lớn nhất với số vừa vào
	; 	jg L2 				; Số hiện là lớn nhất với số vừa vào, nhảy
	; 	mov dx, ax 			; Còn ngược lại đưa số vừa vào vào dx 

	; L2: 
	; 	inc i 				; tăng i lên 1
	; 	loop L1 			; Vòng lặp nhận các số và so sánh 
	; 	HienString m7 
	; 	mov ax, dx 			; Đưa số lớn nhất vào ax
	; 	call HIEN_SO_N 		; Hiện số lớn nhất của dãy
	;-----------------------------------------------------

		mov [bx], ax 
		add bx, 2 			; bx trỏ đến thành phần tiếp theo của mảng (chứa 2 byte cho 1 phân vùng của mảng a)
		inc i 
		loop L1 
	
		; Vòng lặp hiển thị mảng a lên màn hình
		HienString m4 
		mov cx, sltp
		lea bx, a 			; trỏ bx vào vị trí đầu tiên của mảng a 
	
	L2:
		mov ax, [bx]
		call HIEN_SO_N
		add bx, 2
		HienString m5
 		loop L2 
	
		; Vòng lặp tính tổng
		HienString m6 
		mov cx, sltp
		lea bx, a 
		xor ax, ax 			; ax = tổng và lúc đầu = 0
	
	;----------------------------------
	L3:
		add ax, [bx] ; ax = ax + a[i] 
		add bx, 2 
		loop L3 
	;-----------------------------------
		
		call HIEN_SO_N
	
	Exit:
		mov ah, 4ch
		int 21h
INCLUDE lib2.asm 
END PS 