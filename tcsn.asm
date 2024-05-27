include lib1.asm
.model small                ; Mô hình bộ nhớ dành cho chương trình dạng small
.stack 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                       ; dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    m1 db 13, 10, 'Hay vao n: $'
    m2 db 13, 10, 'Hay vao q: $'
    m3 db 13, 10, 'Hay vao u1: $'
    m4 db 13, 10, 'Tong cap so nhan la: $'
    m5 db 13, 10, 'Co tiep tuc chuong trinh(c/k)? $'
.code
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment vào vùng nhớ
    mov ds, ax              ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai báo biến)
    clrscr                  ; Xoá màn hình
    HienString m1
    call VAO_SO_N           ; Nhận giá trị n
    mov cx, ax              ; cx = n
    HienString m2 
    call VAO_SO_N           ; Nhận giá trị q
    mov bx, ax              ; bx = q
    HienString m3
    call VAO_SO_N           ; Nhận giá trị u1
    mov si, ax              ; si = ax = u1 (si = tổng = u1; ax = ui và lúc đầu bằng u1)
    dec cx                  ; Giảm cx đi 1 (n - 1)
    L1:
        mul bx              ; ax = ax * bx = ui
        add si, ax          ; si = tổng
        loop L1
        HienString m4
        call HIEN_SO_N      ; Hiện tổng cấp số nhân
        HienString m5       ; Hiện dòng nhắc m5
        mov ah, 1           ; Chờ nhận một ký tự từ bàn phím
        int 21h 
        cmp al, 'c'         ; Ký tự vừa nhận có phải là ký tự 'c'
        jne Exit            ; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
        jmp PS              ; Còn không thì quay về đầu (bắt đâu lại chương trình)
    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
include lib2.asm
end PS
