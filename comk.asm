INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	m1 	db 13, 10, 'CAC BAI TAP LAP TRINH HE THONG'
		db 13, 10, '------------------------------'
		db 13, 10, 13, 10, 'Bai 1: Hay viet chuong trinh cho biet may tinh ban dang dung '
		db 13, 10, 'co o mem nao hay khong? Neu co thi bao nhieu o?'
		db 13, 10, 'Cach giai: Chu y byte co dia chi 0:410h cua vung du lieu ROM BIOS co '
		db 13, 10, 'chua cac thong tin lien quan den thong tin ve o dia mem.'
		db 13, 10, 13, 10, '------------------------------'
		db 13, 10, 13, 10, '-------------- CHUONG TRINH ----------------'
		db 13, 10, 'May tinh dang dung co o mem khong? $'
	co db 'Co'
	khong db 'Khong'
	m2 db 13, 10, 'So luong o mem ma may tinh co la: $'
	m3 	db 13, 10, '------------------------------'
		db 13, 10, 'Co tiep tuc chuong trinh khong (c/k)? $'
.CODE
PS:
		mov ax, @data 
		mov ds, ax 
		clrscr
		HienString m1 
		int 11h 				; Ngắt hệ thống thực hiện việc đưa nội dung ô nhớ 0:41h -> al 
		shr al, 1 				; Đưa bit thấp nhất vào bit cờ Carry
		jc L1 					; Nếu bit cờ Carry = 1 thì nhảy đến L1 
		HienString khong 		; Còn không thì thực hiện thông báo 'Khong'
		jmp CONTINUE
	
	L1:
		HienString co
		HienString m2 			; Hiện thông báo 'So luong o mem'
		mov cl, 5 				; Chuyển 2 bit (số lượng ổ mềm - 1) sang phải 5 lần 
		shr al, cl 
		inc al 					; al = số lượng ổ mềm 
		add al, 30h 			; al là mã ASCII số lượng ổ mềm 
		mov ah, 0eh 			; Chức năng hiện 1 ký tự ASII lên màn hình 
		int 10h
		
	CONTINUE:
		HienString m3 
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp PS
	
	Exit:
		mov ah, 4ch
		int 21h
END PS