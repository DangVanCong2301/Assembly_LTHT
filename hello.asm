.model small
.stack 100h
.data
    message db "Hello World! $"
.code
PS:
    mov ax, @data   ; Dua phan dia chi segment vao vung nho
    mov ds, ax      ; chua du lieu vao ds
    lea dx, message    ; Hien mot xau ket thuc bang $
    mov ah, 9
    int 21h
    Exit:
        mov ah, 4ch ; Tro ve DOS
        int 21h
end PS