INCLUDE lib1.asm 
.MODEL small 
.STACK 100h
.DATA
    m1	db 13, 10, '	LAP TRINH TREN MOI TRUONG DOS'
		db 13, 10, '	-----------------------------'
		db 13, 10, 13, 10, '	Bai 4: Hay viet chuong trinh co biet may tinh ban dang dung'
		db 13, 10, 'co card dieu khien man hinh loai gi (mono hay color)?'
		db 13, 10, 13, 10, '	-----------------------------'
		db 13, 10, 13, 10, '	--------------- CHUONG TRINH --------------'
		db 13, 10, '	Loai card dieu khien man hinh ma may tinh co la: $'
    color db 'Color $'
    mono db 'Mono $'
	tieptuc db 13, 10, '	-----------------------------'
			db 13, 10, '	Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
        mov ax, @data 
        mov ds, ax 
	
	L_CARD0:
        clrscr
        HienString m1
        int 11h ; Ngắt hệ thống thực hiện việc đưa nội dung ô nhớ 0:410h -> al
        and al, 00110000b ;Tách 2 bit có thông tin liên quan đến loại card đồ hoạ màn hình
        cmp al, 00110000b ; Liệu có card điều khiển màn hình loại Mono
        jne L1 ; Không phải card Mono thì nhảy dến L1 
        HienString Mono
        jmp Exit

    L1:
        HienString Color
		
	CONTINUE:
		HienString tieptuc 
		mov ah, 1
		int 21h 
		cmp al, 'c'
		jne Exit
		jmp L_CARD0

    Exit: 
        mov ah, 4ch 
        int 21h
END PS