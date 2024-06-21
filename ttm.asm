INCLUDE lib1.asm 
.MODEL small 
.STACK 100h
.DATA
    tm db 13, 10, 'Hay vao ten thu muc can tao: $'
    err_msg db 13, 10, 'Khong tao duoc thu muc! $'
    suc_msg db 13, 10, 'Thu muc da duoc tao! $'
    tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong (c/k)? $'
    buff db 30
        db ?
    dir_name db 30 dup(?)
.CODE
PS:
        mov ax, @data 
        mov ds, ax 

    L1:
        CLRSCR 
        HienString tm
        lea dx, buff ; Vào tên thư mục cần tạo
        call GET_DIR_NAME
        lea dx, dir_name ; Chức năng tạo thư mục
        mov ah, 39h
        int 21h 
        jnc L2 ; Nếu Bit cờ CF = 0 thì nhảy đến L1 
        HienString err_msg ; Còn CF = 1 thì hiện thông báo lỗi
        jmp CONTINUE

    L2:
        HienString suc_msg ; Hiện thông báo thành công 

    CONTINUE:
        HienString tieptuc
        mov ah, 1
        int 21h 
        cmp al, 'c'
        jne Exit
        jmp L1

    Exit:
        mov ah, 4ch
        int 21h 
INCLUDE lib3.asm 
END PS 