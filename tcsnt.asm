include lib1.asm
.model small ; Mô hình bộ nhớ dành cho chương trình dạng small
.stack 100h ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data   ; Dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    snt1    db 13, 10, 'TIM CAC SO NGUYEN TO'
            db 13, 10, '-------***----------'
            db 13, 10, 13, 10, 'Hay vao so gioi han: $'
    snt2 db 13, 10, 'Cac so nguyen to tu 2 den $'
    snt3 db ' la: $'
    space db ' $'
    tieptuc db 13, 10, 'Co tiep tuc chuong trinh (c/k) ? $'
    so dw ?
.code
PS:
    mov ax, @data ; Đưa phần địa chỉ segement vào vùng nhớ 
    mov ds, ax ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai báo biến)
    L0:
        clrscr
        HienString snt1
        call VAO_SO_N ; Nhận số giới hạn
        HienString snt2
        call HIEN_SO_N ; Hiện số giới hạn
        HienString snt3
        mov bx, ax ; bx chứa số giới hạn
        mov so, 1
    Exit:
        mov ah, 4ch ; Về DOS
        int 21h
include lib2.asm
end PS