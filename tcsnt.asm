include lib1.asm
.model small                    ; Mô hình bộ nhớ dành cho chương trình dạng small
.stack 100h                     ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                           ; Dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    snt1    db 13, 10, 'TIM CAC SO NGUYEN TO'
            db 13, 10, '-------***----------'
            db 13, 10, 13, 10, 'Hay vao so gioi han: $'
    snt2 db 13, 10, 'Cac so nguyen to tu 2 den $'
    snt3 db ' la: $'
    space db '  $'
    tieptuc db 13, 10, 'Co tiep tuc chuong trinh (c/k) ? $'
    so dw ?
.code
PS:
    mov ax, @data               ; Đưa phần địa chỉ segement vào vùng nhớ 
    mov ds, ax                  ; dành cho dữ liệu vào ds (chỉ có khi có .data, có khai báo biến)
    L0:
        clrscr
        HienString snt1
        call VAO_SO_N           ; Nhận số giới hạn
        HienString snt2
        call HIEN_SO_N          ; Hiện số giới hạn
        HienString snt3
        mov bx, ax              ; bx chứa số giới hạn
        mov so, 1
    L1:
        inc so                  ; Liệu số đang xét có phải là số nguyên tố
        mov ax, so              ; hay không ?
        cmp ax, bx              ; So sánh số đang xét với số giới hạn
        jg Continue             ; Nếu số đang xét lớn hơn số giới hạn thì kết thúc
        mov cx, ax              ; trái lại thì xét liệu có phải là số nguyên tố
        shr cx, 1               ; Phần nguyên dương của so/2
    L2:
        cmp cx, 1               ; Số chia đã nhỏ hơn 1 hay chưa
        jle L3                  ; Nếu <= 1 thì số đang xét là số nguyên tố (nhảy đến L3)
        xor dx, dx              ; Còn không thì chia số đang xét (DX:AX) cho cx 
        div cx                  ; số hạng chia sẽ chạy từ so/2 đến 2
        and dx, dx              ; dx chứa phần dư (dựng cờ ZF)
        jz L1                   ; Nếu ZF = 0 (số đang xét không phải là số nguyên tố, bỏ qua
                                ; số đó, nhảy về xét số tiếp)
        mov ax, so 
        loop L2
    L3:
        call HIEN_SO_N          ; Hiện số nguyên tố lên màn hình
        HienString space        ; Hiện hai dấu cách
        jmp L1
    Continue:
        HienString tieptuc      ; Hiện dòng nhắc
        mov ah, 1               ; Chờ nhận một ký tự từ bàn phím
        int 21h
        cmp al, 'c'             ; Ký tự vừa nhận có phải là 'c'
        jne Exit                ; Nếu không phải thì thoát chương trình
        jmp PS                  ; Còn không thì quay về đầu, bắt đầu lại chương trình
    Exit:
        mov ah, 4ch             ; Về DOS
        int 21h
include lib2.asm
end PS