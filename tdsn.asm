INCLUDE lib1.asm
.MODEL small                ; Mô hình bộ nhớ cho chương trình dạng small
.STACK 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.DATA                       ; Dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    m1  db 13, 10, 'CAC BAI TAP NGON NGU ASSEMBLY THUAN TUY'
        db 13, 10, '-----------------***-------------------'
        db 13, 10, 13, 10, 'Bai 4: Tong 1 day so nguyen'
        db 13, 10, 13, 10, '---------------------------------------'
        db 13, 10, 13, 10, '------------ CHUONG TRINH -------------'
        db 13, 10, 'Hay vao so luong thanh phan: $'
    m2  db 13, 'a[$'
    m3  db ']=$'
    m4  db 13, 'Day so vua nhap la: $'
    m5  db ' $'
    m6  db 13, 10, 'Tong day so nguyen la: $'
    m6_1 db 13, 10, 'Tong cac thanh phan am cua mang: $'
    m6_2 db 13, 10, 'Tong cac thanh phan duong cua mang: $'
    m6_3 db 13, 10, 'Tong cac thanh phan chan cua mang: $'
    m6_4 db 13, 10, 'Tong cac thanh phan le cua mang: $'
    m7  db 13, 10, '---------------------------------------'
        db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
    slpt dw ?
    i   dw ?
    a dw 100 dup(?)
.CODE
PS:
    mov ax, @data           ; Đưa phần địa chỉ segment vào vùng nhớ
    mov ds, ax              ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai báo biến)
    clrscr
    HienString m1
    call VAO_SO_N           ; Nhận số lượng thành phần
    mov slpt, ax            ; cất giá trị số lượng thành phần vào biến slpt
    ; Vòng lặp nhận các số đưa vào mảng
    mov cx, ax              ; cx bằng số lượng thành phần (chỉ số vòng lắp LOOP)
    lea bx, a               ; bx là con trỏ offset của a[0]
    mov i, 0                ; Gán giá trị biến nhớ i = 0
    L1:
        HienString m2
        mov ax, i ; Hiện giá trị i
        call HIEN_SO_N
        HienString m3
        call VAO_SO_N       ; Nhận các giá trị thành phần a[i]
        mov [bx], ax        ; Đưa giá trị a[i] vào mảng a do bx trỏ đến
        inc i               ; Tăng giá trị i lên 1
        add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng a
        loop L1
    ; Vòng lặp đưa các số của mảng lên màn hình
    HienString m4
    mov cx, slpt            ; cx = so lượng thành phần (chỉ số vòng lặp)
    lea bx, a               ; bx trỏ đến a[0]
    L2:
        mov ax, [bx]        ; ax = a[i]
        call HIEN_SO_N      ; Hiện giá trị a[i] lên màn hình
        HienString m5       ; Hiện hai dấu cách (space)
        add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng
        loop L2
    ; Vòng lặp tính tổng
    HienString m6         ; Hiện thông báo m6, m6_1, m6_2, m6_3, m6_4
    mov cx, slpt            ; cx = số lượng thành phần của mảng (chỉ số vòng lặp)
    lea bx, a               ; bx trỏ đến a[0] (con trỏ offset)
    xor ax, ax              ; ax chứa tổng (lúc đầu = 0)
    ;--------------------------------------------------------------
    ; Tổng các thành phần của mảng
    L3:
        add ax, [bx]        ; ax = ax + a[i]
        add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng a
        loop L3
    ;--------------------------------------------------------------

    ;--------------------------------------------------------------
    ; Tổng các thành phần âm của mảng
    ; L3: 
    ;     mov dx, [bx]        ; dx = a[i]
    ;     and dx, dx          ; Dựng cờ dấu (S = 1 thì dx chứa số âm, S = 0 thì dx chứa số dương)
    ;     jns L4              ; Nếu giá trị a[i] dương thì nhảy đến L4
    ;     add ax, [bx]        ; còn giá trị a[i] âm thì cộng vào tổng nằm ở ax
    ; L4:
    ;     add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng a
    ;     loop L3 
    ;--------------------------------------------------------------

    ;--------------------------------------------------------------
    ; Tổng các thành phần dương của mảng
    ; L3:
    ;     mov dx, [bx]        ; dx = a[i]
    ;     and dx, dx          ; Dựng cờ dấu (S = 1 thì dx chứa số âm, S = 0 thì dx chứa số dương)
    ;     js L4               ; Nếu giá trị a[i] âm thì nhảy
    ;     add ax, [bx]        ; còn giá trị a[i] dương thì cộng vào tổng nằm ở ax
    ; L4:
    ;     add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng
    ;     loop L3 
    ;--------------------------------------------------------------

    ;--------------------------------------------------------------
    ; Tổng các thành phần chẵn của mảng
    ; L3:
    ;     mov dx, [bx]        ; dx = a[i]
    ;     shr dx, 1           ; Bit thấp nhất vào cờ Carry (C = 1 -> a[i] là lẻ, C = 0 -> a[i] là chẵn)
    ;     jc L4               ; Nếu giá trị a[i] là lẻ thì nhảy đến L4
    ;     add ax, [bx]        ; còn giá trị a[i] là chẵn thì cộng vào tổng nằm ở ax
    ; L4:
    ;     add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng
    ;     loop L3
    ;--------------------------------------------------------------

    ;--------------------------------------------------------------
    ; Tổng các thành phần lẻ của mảng
    ; L3:
    ;     mov dx, [bx]        ; dx = a[i]
    ;     shr dx, 1           ; Bit thấp nhất vào cờ Carry (C = 1 -> a[i] là lẻ, C = 0 -> a[i] là chẵn)
    ;     jnc L4              ; Nếu giá trị a[i] là chẵn thì nhảy đến L4
    ;     add ax, [bx]        ; còn giá trị a[i] là lẻ thì cộng vào tổng nằm ở ax
    ; L4:
    ;     add bx, 2           ; bx trỏ đến thành phần tiếp theo của mảng a
    ;     loop L3        
    ;--------------------------------------------------------------

    call HIEN_SO_N          ; Hiện giá trị tổng
    CONTINUE:
        HienString m7           ; Hiện thông báo m7 ('Co tiep tuc chuong trinh khong(c/k)?'
        mov ah, 1               ; Chờ nhận ký tự từ bàn phím
        int 21h
        cmp al, 'c'             ; Ký tự vừa nhận có phải là ký tự 'c'?
        jne Exit                ; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
        jmp PS                  ; Còn không thì quay về đầu (bắt đầu lại chương trình)
    Exit:
        mov ah, 4ch         ; Về DOS
        int 21h
INCLUDE lib2.asm
END PS