INCLUDE lib1.asm 
.MODEL small 
.STACK 100h
.DATA
    m1 db 13, 10, 'Loai card dieu khien man hinh ma may tinh co la: $'
    color db 'Color $'
    mono db 'Mono $'
.CODE
PS:
        mov ax, @data 
        mov ds, ax 
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

    Exit: 
        mov ah, 1
        int 21h
        mov ah, 4ch 
        int 21h
END PS