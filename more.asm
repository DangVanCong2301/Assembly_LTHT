INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
    hx  db 13, 10, 'CAC BAI TAP LAP TRINH HE THONG'
        db 13, 10, '------------------------------'
        db 13, 10, 13, 10, 'Bai 7: Hay viet chuong trinh thay cho tep type|more cua DOS'
        db 13, 10, '(hien noi dung tep dang ASCII len man hinh).'
        db 13, 10, 13, 10, '------------------------------'
        db 13, 10, 13, 10, '--------------- CHUONG TRINH ---------------'
        db 13, 10, 'Hay vao ten tep can hien: $'
    err_o db 13, 10, 'Khong mo duoc tep! $'
    err_r db 13, 10, 'Khong doc duoc tep! $'
    err_w db 13, 10, 'Khong ghi duoc tep! $'
    err_c db 13, 10, 'Khong dong duoc tep! $'
    buff db 30
        db ?
    file_name db 30 dup(?)
    the_tep dw ?
    dem db 512 dup(?)
    more db 13, 10, 'More... $'
    tieptuc db 13, 10, '------------------------------'
            db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
        mov ax, @data
        mov ds, ax 
    L_CT0:
        CLRSCR
        HienString hx
        lea dx, buff 
        call GET_FILE_NAME
        lea dx, file_name       ; Mở tệp đã có để đọc
        mov al, 0 
        mov ah, 3dh 
        int 21h
        jnc L_CT1
        HienString err_o 
        jmp CONTINUE

    L_CT1:
        mov the_tep, ax         ; Nếu mở tệp tốt thì đưa thẻ tệp có trong ax -> biến the_tep

    L_CT2:
        mov bx, the_tep         ; Đọc 512 byte từ tệp copy đi -> vùng nhớ đệm (dem)
        mov cx, 512
        lea dx, dem
        mov ah, 3fh 
        int 21h 
        jnc L_CT3
        HienString err_r
        jmp DONG_TEP

    L_CT3:
        and ax, ax              ; Số lượng byte thực tế đã đọc được = 0
        jz DONG_TEP             ; Đúng = 0 (hết tệp) thì nhảy đến đóng các tệp và kết thúc
        mov bx, 1               ; Còn không = 0 thì tiến hành đưa ra màn hình với thẻ tệp = 1
        mov cx, ax              ; Đưa số lượng byte đọc được vào cx 
        lea dx, dem             ; Trỏ đến vùng đệm chứa số liệu cần đưa ra màn hình 
        mov ah, 40h             ; Chức năng hiện (ghi tệp với thẻ tệp = 1)
        int 21h 
        jnc L_CT4               ; Ghi tệp tốt thì nhảy
        HienString err_w
        jmp DONG_TEP

    L_CT4:
        HienString more         ; Hiện chữ 'More' lên màn hình
        mov ah, 1
        int 21h
        jmp L_CT2

    DONG_TEP:
        mov bx, the_tep
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