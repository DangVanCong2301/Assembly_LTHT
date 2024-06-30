INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	m1 	db 13, 10, '	LAP TRINH TREN MOI TRUONG DOS'
		db 13, 10, '	-----------------------------'
		db 13, 10, 13, 10, '	Bai 3: Hay viet chuong trinh cho biet may tinh ban dang dung'
		db 13, 10, '	co cong LPT nao khong? Neu co thi co bao nhieu cong va'
		db 13, 10, '	cho biet dia chi cac cong do (dia chi cong phai la HEXA).'
		db 13, 10, 13, 10, '	-----------------------------'
		db 13, 10, 13, 10, '	-------------- CHUONG TRINH ---------------'
		db 13, 10, '	May tinh dang dung co cong LPT khong? $'
    co db 'Co $'
    khong db 'Khong $'
    m2 db 13, 10, '	So luong cong LPT ma may tinh co la: $'
    m3 db 13, 10, '	Dia chi cac cong LPT la: $'
    space db ' $' 
	tieptuc db 13, 10, '	-----------------------------'
			db 13, 10, '	Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
        mov ax, @data 
        mov ds, ax 
	L_LPT0:
        clrscr
        HienString m1
        int 11h ; Ngắt hệ thống thực hiện đưa nội dung ô nhớ 0:411h -> ah
        mov al, ah ; Đưa nội dung 0:411h -> al
        and al, 11000000b
        shr al, 6
        jnz L1 ; Nếu al # 0 (có cổng LPT thì nhảy)
        HienString khong ; Còn không thì hiện thông báo 'Khong'
        jmp Exit

    L1:
        HienString co
        mov cl, al 
        xor ch, ch ; cx = số lượng công LPT (chỉ số vòng lặp hiện địa chỉ)
        HienString m2 
        mov dl, al 
        add dl, '0'
        mov ah, 2 
        int 21h
        HienString m3 
        xor ax, ax 
        mov es, ax 
        mov bx, 408h ; es:bx = 0:408h (nơi chứa địa chỉ cổng LPT1)

    L2:
        mov ax, es:[bx] ; ax = địa chỉ LPT
        call HIEN_HEXA
        HienString space
        add bx, 2 
        loop L2 
		
	CONTINUE:
		HienString tieptuc 
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_LPT0

    Exit:
        mov ah, 4ch
        int 21h
INCLUDE lib2.asm 
END PS