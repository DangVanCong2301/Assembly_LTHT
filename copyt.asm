INCLUDE lib1.asm 
.MODEL small 
.STACK 100h
.DATA
    ct1 db 13, 10, 'Hay vao ten tep can copy di: $'
    ct2 db, 13, 10, 'Hay vao ten tep can copy den: $'
    err_o db, 13, 10, 'Khong mo duoc tep! $'
    err_r db 13, 10, 'Khong doc duoc tep! $'
    err_w db 13, 10, 'Khong ghi duoc tep! $'
    err_c db 13, 10, 'Khong dong duoc tep! $'
    buff db 30
        db ?
    file_name db 30 dup(?)
    the_tep1 dw ?
    the_tep2 dw ?
    dem db 512 dup(?)
    tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
        mov ax, @data
        mov ds, ax 
    L_CT0:
        CLRSCR  
        HienString ct1
        lea dx, buff 
        call GET_FILE_NAME ; Vào tên tệp cần copy đi
        lea dx, file_name ; Mở tệp đã có thể đọc
        mov al, 0
        mov ah, 3dh
        int 21h 
        jnc L_CT1
        HienString err_o ; Hiện thông báo err_0 nếu mở tệp bị lỗi (CF = 1)
        jmp CONTINUE

    L_CT1:
        mov the_tep1, ax ; Mở tệp tốt thì đưa thẻ tệp có trong ax -> biến thetep1
        HienString ct2
        lea dx, buff 
        call GET_FILE_NAME ; Vào tên tệp cần copy đến
        lea dx, file_name ; Tạo tệp mới và mở 
        mov cx, 0 ; Không đặt thuộc tính nào cho tệp
        mov ah, 3ch 
        int 21h
        jnc L_CT2
        HienString err_o ; Hiện thông báo err_o nếu tạo vào mở tệp bị lỗi (CF = 1)
        jmp DONG_TEP1

    L_CT2:
        mov the_tep2, ax ; Nếu mở tệp tốt thì đưa thẻ tệp có trong ax -> biến thetep2

    L_CT3:
        mov bx, the_tep1 ; Đọc 512 byte từ tệp copy đi -> vùng nhớ đệm
        mov cx, 512 
        lea dx, dem 
        mov ah, 3fh 
        int 21h 
        jnc L_CT4
        HienString err_r ; Hiện thông báo nếu tệp đọc bị lỗi
        jmp DONG_TEP2

    L_CT4:
        and ax, ax ; Số lượng byte thực tế đã đọc được = 0?
        jz DONG_TEP1 ; Đúng = 0 (hết tệp) thì nhảy đén đóng các tệp và kết thúc
        mov bx, the_tep2 ; Còn không bằng 0 thì tiến hành ghi tệp
        mov cx, ax ; Đưa số lượng byte đọc được vào cx
        lea dx, dem ; Trỏ dến vùng đệm chứa số liệu cần gi
        mov ah, 40h
        int 21h
        jnc L_CT5
        HienString err_w ; Hiện thông báo err_w nếu không ghi được tệp (CF = 1)
        jmp DONG_TEP2

    L_CT5:
        jmp L_CT4 ; Ghi tệp tốt thì nhảy về tiếp tục đọc và ghi

    DONG_TEP2:
        mov bx, the_tep2 ; Chức năng đóng tệp
        mov ah, 3eh
        int 21h 
        jnc DONG_TEP1
        HienString err_c 

    DONG_TEP1:
        mov bx, the_tep1 ; Chức năng đóng tệp
        mov ah, 3eh
        int 21h
        jnc CONTINUE
        HienString err_c

    CONTINUE:
        HienString tieptuc
        mov ah, 1
        int 21h 
        cmp al, 'c'
        jne Exit
        jmp L_CT0

    Exit:
        mov ah, 4ch 
        int 21h
INCLUDE lib4.asm 
END PS