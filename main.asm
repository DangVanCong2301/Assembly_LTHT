INCLUDE lib1.asm
.MODEL small 
.STACK 100h                 ; Xác lập vùng nhớ 256 byte cho STACK 
.DATA
    gt1 db 13, 10,  '--CHUONG TRINH DA TEP THUAN TUY ASSEMBLY--'
        db 13, 10, 13, 10,  'Viet chuong trinh tinh n! (0 <= n <= 7)'
        db 13, 10, 13, 10,  '------------------------------------------'
        db 13, 10, 'Hay vao n: $'
    gt2 db 13, 'Giai thua cua $' ; 13 là xống dòng, 10 là cách dòng 
    gt3 db ' la: $'
    gt4 db 13, 10, 'Co tiep tuc(c/k)? $'
PUBLIC n 
n dw ?
EXTRN FV: word
.CODE
    EXTRN GIAITHUA: PROC 
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment của vùng nhớ 
    mov ds, ax              ; cấp phát cho biến vào ds
    clrscr                  ; Xoá màn hình
    HienString gt1          ; Hiện xâu gt1
    call VAO_SO_N           ; Vào số n (số vừa vào để ở ax)
    HienString gt2
    call HIEN_SO_N          ; Hiện số n
    HienString gt3          ; Hiện xâu gt3
    mov n, ax               ; Đưa giá trị n (ax) vào biến n
    call GIAITHUA           ; Gọi hàm tính n! (ở tệp sub.asm)
    mov ax, FV              ; Đưa kết quả từ FV vào ax
    call HIEN_SO_N          ; Hiện kết quả lên màn hình
    CONTINUE:
        HienString gt4
        mov ah, 1           ; Chờ nhận một ký tự từ bàn phím
        int 21h
        cmp al, 'c'         ; Liệu al = 'c' (tiếp tục chương trình)
        jne Exit            ; Không tiếp tục chương trình nhảy đến Exit
        jmp PS              ; còn tiếp tục chương trình trở về PS
    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
INCLUDE lib2.asm
END PS