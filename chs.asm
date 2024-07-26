include lib1.asm
.model small                ; Mô hình bộ nhớ cho chương trình dạng small
.stack 100h                 ; Dành một vùng nhớ 256 byte cho ngăn xếp
.data                       ; Dành một vùng nhớ để cấp phát cho biến (chỉ có khi chương trình có khai báo biến)
    m1 db 10, 13, 'Hay vao so bi chia: $'
    m2 db 10, 13, 'Hay vao so chia: $'
	nhaplai db 13, 10, 'Hay vao lai so chia: $'
    m3 db 10, 13, 'Thuong la: $'
	khac0 db 13, 10, 'So chia phai khac 0! $'
    dautru db '-$'
    daucham db '.$'
    m4 db 10, 13, 'Co tiep tuc (c/k)? $'
	buff 	dw 8				; Không nên khỏi tạo ban đầu (dấu ?)
			dw ?
			dw 8 dup(?)
.code 
PS:
		mov ax, @data           ; Đưa phần địa chỉ segment vào vùng nhớ
		mov ds, ax				; dành cho dữ liệu vào ds ( chỉ có khi có .data, có khai báo biến)
	L_CT0:
		clrscr                  ; Xoá màn hình
		HienString m1
		call VAO_SO_N  
		mov bx, ax              ; bx = số bị chia
		HienString m2           ; Hiện thông báo m2 ('Hay vao so chia')
	L_CT1:
		call VAO_SO_N           ; Nhận giá trị số chia (ax = số chia)
		cmp ax, 0
		je L_CT2
		xchg ax, bx             ; Đổi chéo (ax = số bị chia, bx = số chia)
		HienString m3           ; Hiện thông báo m3 ('Thuong la: ')
		and ax, ax              ; Dựng cờ dấu của số bị chia (dấu thương cùng dấu số bị chia)
		jns CHIA1               ; Nếu dấu số bị chia là dương thì nhảy đến nhãn CHIA1
		HienString dautru       ; còn nếu là số bị âm thì hiệ dấu '-' lên màn hình (dấu âm)
		neg ax                  ; Đổi dấu số bị chia
    CHIA1:
        xor dx, dx          	; dx = 0
        div bx              	; dx : ax chia cho bx (ax = thương còn dx dư)
        call HIEN_SO_N      	; Hiện giá trị của thương lên màn hình
        and dx, dx          	; Dựng cờ của phần dư (Z = 1 thì dư = 0, còn Z = 0 thì dư # 0)
        jz KT               	; Dư = 0 thì nhảy đến kết thúc quá trình chia
        HienString daucham  	; còn không thì hiện dấu chấm ('.') và tiếp tục chia
        mov cx, 2           	; số chữ số sau số thập phân
        mov si, 10          	; si = 10
    CHIA2:
        mov ax, dx          	; Đưa phần dư vào ax
        mul si              	; Nhân phần dư cho 10
        div bx              	; dx:ax chia cho bx
        call HIEN_SO_N      	; Hiện giá trị của thương lên màn hình
        and dx, dx          	; Dựng cờ của phần dư (Z = 1 thì dư 0, còn Z = 0 thì dư # 0)
        jz KT               	; Phần dư bằng 0 thì nhảy đến kết thúc quá trình chia
        loop CHIA2
		jmp KT
		
	L_CT2:
		HienString khac0
		HienString nhaplai
		jmp L_CT1
		
    KT:
        HienString m4       	; Hiện thông báo m4 'Co tiep tuc chuong trinh(c/k)?'
        mov ah, 1           	; Chờ nhận một ký tự từ bàn phím
        int 21h
        cmp al, 'c'         	; Ký tự vừa nhận có phải là ký tự 'c'
        jne Exit            	; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
        jmp PS              	; còn không thì quay về đầu (bắt đầu lại chương trình)
    Exit:
        mov ah, 4ch         	; Về DOS
        int 21h
include LIB5.asm
end PS