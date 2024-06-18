INCLUDE lib1.asm 
.MODEL small
.STACK 100h
.DATA
    m1 db 13, 10, 'Hay vao so luong thanh phan: $'
    m2 db 13, 10, 'Hay vao cac so cua day: $'
    m3 db 13, 10, 'a[$'
    m4 db ']=$'
    m5 db 13, 10, 'So lon nhat cua day so nguyen la: $'
.CODE
PS:
        mov ax, @data 
        mov ds, ax 
        clrscr
        HienString m1 
        call VAO_SO_N 
        mov cx, ax ; cx = số lượng thành phần
        xor bx, bx ; bx = chỉ số thứ tự của dãy số khi vào
        mov dx, -32768 ; dx chứa giá trị -32768
        HienString m2 

    L1:
        HienString m3 ; 'a['
        mov ax, bx  
        call HIEN_SO_N ; Hiện i 
        HienString m4 ; ']='
        call VAO_SO_N 
		cmp dx, ax ; So sánh số hiện lớn nhất với số vừa vào
		jg L2 ; Số hiện là lớn nhất với số vừa vào, nhảy
		mov dx, ax ; Còn ngược lại đưa số vừa vào vào dx 

	L2: 
		inc bx ; tăng i lên 1
		loop L1 ; Vòng lặp nhận các số và so sánh 
		HienString m5
		mov ax, dx ; Đưa số lớn nhất vào dx
		call HIEN_SO_N ; Hiện số lớn nhất của dãy

    Exit:
        mov ah, 4ch 
        int 21h 
INCLUDE lib2.asm 
END PS