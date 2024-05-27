include lib1.asm
.model small                ; Mô hình bộ nhớ dành cho chương trình dạng small
.stack 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                       ; Dành một vùng nhớ để cấp phát cho biến ( chỉ có khi chương trình có khai báo biến)
    m1 db 13, 10, 'Hay vao N: $'
    m2 db 13, 10, 'Tong tu 1 den $'
    m3 db ' la: $'
    m4 db 13, 10, 'Co tiep tuc (c/k) ? $'
.code
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment vào vùng nhớ
    mov ds, ax              ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai báo biến)
    clrscr                  ; Xoá màn hình
    HienString m1
    call VAO_SO_N           ; Nhận giá trị N
    mov cx, ax              ; cx = N (chỉ số vòng lặp)
    HienString m2           ; Hiện thông báo m2
    call HIEN_SO_N          ; Hiện giá trị N
    HienString m3 
    dec cx                  ; Giảm cx đi 1 (n - 1)
    L1:
        add ax, cx          ; ax = ax + cx
        loop L1 
        call HIEN_SO_N      ; Hiện giá trị biểu thức
    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
include lib2.asm 
end PS  