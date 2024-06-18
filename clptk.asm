INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
    m1 db 13, 10, 'May tinh dang dung co cong LPT khong? $'
    co db 'Co $'
    khong db 'Khong $'
    m2 db 13, 10, 'So luong cong LPT ma may tinh co la: $'
    m3 db 13, 10, 'Dia chi cac cong LPT la: $'
    space db ' $' 
.CODE
PS:
        mov ax, @data 
        mov ds, ax 
        clrscr
        HienString m1
        int 11h ; Ngắt hệ thống thực hiện đưa nội dung ô nhớ 0:411h -> ah
        mov al, ah ; Đưa nội dung 0:411h -> al
        mov cl, 6 
        shr al, cl ; al = số lượng cổng LPT
        jnz L1 ; Nếu al # 0 (có cổng LPT thì nhảy)
        HienString khong ; Còn không thì hiện thông báo 'Khong'
    
    L1:
        HienString co
        mov cl, al 
        xor ch, ch ; cx = số lượng công LPT (chỉ số vòng lặp hiện địa chỉ)
        HienString m2 
        add al, 30h ; al là mã ASCII số lượng cổng LPT
        mov ah, 0eh ; Chức năng hiện một ký tự ASCII lên màn hình
        int 10h 
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

    Exit:
        mov ah, 4ch
        int 21h
INCLUDE lib2.asm 
END PS