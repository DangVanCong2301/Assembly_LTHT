include lib1.asm
.model small                ; Mô hình bộ nhớ cho chương trình dạng small
.stack 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                       ; Dành một vùng nhớ đề cấp phát cho biến
    m1 db 13, 10, 'Hay vao so thu 1: $'
    m2 db 13, 10, 'Hay vao so thu 2: $'
    m3 db 13, 10, 'Trung binh cong hai so nguyen la: $'
    dautru db '-$'
    m4 db '.5$'
    m5 db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.code
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment vùng nhớ dành cho dữ liệu
    mov ds, ax              ; vào ds (chỉ có khi có .data, có khai báo biến)
    clrscr
    HienString m1           ; Hiện thông báo m1 ('Hay vao so thu 1')
    call VAO_SO_N           ; Nhận giá trị số thứ 1
    mov bx, ax              ; bx = giá trị số thứ 1
    HienString m2           ; Hiện thông báo m2 ('Hay vao so thu 2')
    call VAO_SO_N           ; Nhận giá trị số thứ 2
    HienString m3           ; Hiện thông báo m3 ('Trung binh cong hai so nguyen la: ')
    add ax, bx              ; Tổng hai số (ax = ax + bx)
    and ax, ax              ; Giá trị tổng là âm hay dương
    jns L1                  ; Tổng là dương thì nhảy đến L1
    HienString dautru       ; còn âm thì hiện dấu '-'
    neg ax                  ; và đổi dấu số bị chia
    L1:
        shr ax, 1           ; Chia đôi làm tròn dưới
        pushf               ; Cất giá trị vào cờ stack (thực chất là giá trị cờ Carry)
        call HIEN_SO_N      ; Hiện giá trị trung bình cộng làm tròn dưới
        popf                ; Lấy lại giá trị cờ từ stack (lấy lại trạng thái bit cờ Carry)
        jnc L2              ; Nếu cờ Cary = 0 (giá trị tổng là chẵn) thì nhảy
        HienString m4       ; còn Carry # 0 thì hiện '.5' lên màn hình
    L2:
        HienString m5       ; Hiện thông báo có tiếp tục
        mov ah,             ; Chờ nhận một ký tự từ bàn phí
        int 21h
        cmp al, 'c'         ; Ký tự vừa nhận có phải là 'c'
        jne Exit            ; Nếu không phải thì nhảy đến nhãn Exit
        jmp PS              ; Còn không thì quay về đầu (bắt đầu lạ chương trình)

    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
include lib2.asm
end PS