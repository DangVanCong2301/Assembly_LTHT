include lib1.asm
.model small                ; Mô hình bộ nhớ cho chương trình dạng small 
.stack 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                       ; Dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    m1 db 13, 10, 'Hay vao n: $'
    m2 db 13, 10, 'Hay vao d: $'
    m3 db 13, 10, 'Hay vao u1: $'
    m4 db 13, 10, 'Tong cap so cong la: $'
    m5 db 13, 10, 'Co tiep tuc chuong trinh(c/k)? $'
.code
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment vào vùng nhớ 
    mov ds, ax              ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai bào biến)
    clrscr                  ; Xoá màn hình
    HienString m1           ; Hiện thông báo m1
    call VAO_SO_N           ; Nhận giá trị n
    mov cx, ax              ; cx = n
    HienString m2           ; Hiện thông báo m2
    call VAO_SO_N           ; Nhận giá trị d
    mov bx, ax              ; bx = d
    HienString m3
    call VAO_SO_N           ; Nhận giá trị u1
    mov dx, ax              ; dx = ax = u1 (ax = tổng = u1; dx = ui và lúc đầu = u1)
    dec cx                  ; Giảm cx đi 1 (n - 1)
    L1:
        add dx, bx          ; dx = ui
        add ax, dx          ; ax = tổng
        loop L1
        HienString m4
        call HIEN_SO_N
        HienString m5       ; Hiện dòng nhắc m5
        mov ah, 1           ; Chờ nhận một ký tự từ bàn phím
        int 21h 
        cmp al, 'c'         ; Ký tự vừa nhận có phải là ký tự 'c'
        jne Exit            ; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
        jmp PS              ; Còn không thì quay về đầu (bắt đầu lại chương trình)
    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
include lib2.asm
end PS

; Lý thuyết về cấp số cộng, nguồn: https://loigiaihay.com/ly-thuyet-cap-so-cong-c46a5085.html