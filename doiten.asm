INCLUDE lib1.asm 
.MODEL small 
.STACK 100h
.DATA
    dt1 db 13, 10, 'Hay vao ten tep cu: $'
    dt2 db 13, 10, 'Hay vao ten tep moi: $'
    err_ren db 13, 10, 'Khong doi duoc ten tep! $'
    err_suc db 13, 10, 'Tep da duoc doi ten! $'
    buffc db 30
            db ?
    file_namec db 30 dup(?)
    buffm db 30
            db ?
    file_namem db 30 dup(?)
    tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
        mov ax, @data 
        mov ds, ax 

    L_REN0:
        CLRSCR 
        HienString dt1
        lea dx, buffc
        call GET_FILE_NAME ; Vào tên tệp cần copy đi
        lea dx, file_namec ; ds:dx <- seg:offset xâu chứa tên tệp cũ
        HienString dt2 
        lea dx, buffm
        call GET_FILE_NAME ; Vào tên tệp cần copy đi 
        lea di, file_namem ; di <- offset xâu chứa tên tệp mới
        push ds  
        pop es ; es = ds
        mov ah, 56h ; Chức năng đổi tên tệp
        int 21h
        jnc L_REN1
        HienString err_ren
        jmp CONTINUE

    L_REN1:
        HienString err_suc

    CONTINUE:
        HienString tieptuc
        mov ah, 1
        int 21h
        cmp al, 'c'
        jne Exit
        jmp L_REN0

    Exit:
        mov ah, 4ch 
        int 21h
INCLUDE lib4.asm 
END PS 