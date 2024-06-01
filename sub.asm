.MODEL small 
.DATA
PUBLIC FV
    FV dw ?
    EXTRN n: word
    Fac dw ?
.CODE
PUBLIC GIAITHUA             ; Cho phép tệp khác dùng chương trình con
    ;description
    GIAITHUA PROC
        mov cx, n           ; Đưa giá trị n vào cx, chỉ số vòng lặp
        mov FV, 1           ; Fv = 1
        mov Fac, 2          ; Fac = 2
        cmp cx, 2           ; So sánh giá trị n(cx) với 2
        jb L2               ; Nếu n < 2 ( n = 0 hoặc n = 1) thì nhảy đến L2
        dec cx              ; Giảm cx đi 1
        L1:
            mov ax, FV      ; ax = FV
            mul Fac         ; ax * Fac -> dx:ax (trường hợp dx = 0)
            mov FV, ax      ; FV = ax
            inc Fac         ; Tăng Fac lên 1
            loop L1         ; cx = cx - 1 ? 0
        L2:
            ret
    GIAITHUA ENDP
END