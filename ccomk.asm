INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	m1 	db 13, 10, 'CAC BAI TAP LAP TRINH HE THONG'
		db 13, 10, '------------------------------'
		db 13, 10, 13, 10, 'Bai 2: Hay viet chuong trinh biet may tinh ban dung co cong COM khong?'
		db 13, 10, 'Neu co thi bao nhieu cong va cho biet dia chia cac cong cong do'
		db 13, 10, '(dia chi cong phai la HEXA)'
		db 13, 10, 'Cach giai: Chu y byte cua dia chi 0:411h cua vung du lieu ROM BIOS co chua cac'
		db 13, 10, 'thong tin lien quan den thong tin ve so luong cong COM ma may tinh co.'
		db 13, 10, 13, 10, '------------------------------'
		db 13, 10, 13 ,10, '--------------- CHUONG TRINH ---------------'
		db 13, 10, 'May tinh dang dung co cong COM khong? $'
	co db 'Co $'
	khong db 'Khong $'
	m2 db 13, 10, 'So luong cong COM ma may tinh co la: $'
	m3 db 13, 10, 'Dia chi cac cong COM la: $'
	space db ' $'
	m4 	db 13, 10, '------------------------------'
		db 13, 10, 'Co tiep tuc chuong trinh khong (c/k) $'
.CODE
PS:
		mov ax, @data 
		mov ds, ax 
		clrscr
		HienString m1 
		int 11h 				; Ngắt hệ thống thực hiện việc đưa nội dung ô nhớ 0:411h -> ah 
		mov al, ah 				; Đưa nội dung 0:411h -> ah 
		and al, 00001110b 		; Tách 3 bit chứa số lượng cổng COM 
		shr al, 1 				; al = số lượng cổng COM 
		jnz L1 					; Nếu al khác 0 (có cổng COM thì nhảy) 
		HienString khong
		jmp CONTINUE

	L1:
		HienString co 
		mov cl, al 
		xor ch, ch 				; cx = số lượng cổng COM (chỉ số vòng lặp hiện địa chỉ) 
		HienString m2 
		add al, 30h 			; al là mã ASII số lượng cổng COM 
		mov ah, 0eh 			; Chức năng hiện một ký tự ASCII lên màn hình 
		int 10h 
		HienString m3 
		xor ax, ax 
		mov es, ax 
		mov bx, 400h 			; es:bx = 0:400h (nơi chứa địa chỉ cổng COM1)
	
	L2:
		mov ax, es:[bx] 		; ax = địa chỉ COM 
		call HIEN_HEXA 			; Hiện địa chỉ dạng HEXA lên màn hình 
		HienString space 		; Hiện dấu cách 
		add bx, 2 				; bx trỏ đến các byte chứa địa chỉ công COM tiếp theo
		loop L2 
	
	CONTINUE:
		HienString m4 
		mov ah, 1
		int 21h
		cmp al, 'c'
		jnc Exit
		jmp PS
	
	Exit:
		mov ah, 4ch
		int 21h
INCLUDE lib2.asm 
END PS 