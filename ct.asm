INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	ct1 db 13, 10, 'LAP TRINH TREN MOI TRUONG DOS'
		db 13, 10, '-----------------------------'
		db 13, 10, 13, 10, 'Bai 11: Hay viet chuong trinh chia 1 tep (khong qua 64kb)'
		db 13, 10, 'thanh 2 tep bang nhau.'
		db 13, 10, 13, 10,  '-----------------------------'
		db 13, 10, 13, 10, '-------------- CHUONG TRINH ---------------'
		db 13, 10, 'Vao ten tep can chia: $'
	ct2 db 13, 10, 'Vao ten tep con 1: $'
	ct3 db 13, 10, 'Vao ten tep con 2: $'
	err_o db 13, 10, 'Khong mo duoc tep! $'
	err_r db 13, 10, 'Khong doc duoc tep! $'
	err_w db 13, 10, 'Khong ghi duoc tep! $'
	err_s db 13, 10, 'Khong di chuyen duoc con reo tep! $'
	err_c db 13, 10, 'Khong dong duoc tep! $'
	the_tep dw ?
	the_tepc1 dw ?
	the_tepc2 dw ?
	buff db 30
		db ?
	file_name db 30 dup(?)
	dodai_tep dw ?
	dem db 20000 dup(?)
	tieptuc db 13, 10, '-----------------------------'
			db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
	PUBLIC @CT$qv
@CT$qv PROC
		mov ax, @data 
		mov ds, ax 
		
	L_CT0:
		CLRSCR
		HienString ct1
		lea dx, buff ; Vào tên tệp cần chia 
		call GET_FILE_NAME
		lea dx, file_name ; Mở tệp đã có để đọc
		mov al, 0
		mov ah, 3dh
		int 21h
		jnc L_CT1 ; Mở tệp tốt (CF = 0) thì nhảy
		HienString err_o ; Mở tệp lỗi
		jmp CONTINUE
		
	L_CT1:
		mov the_tep, ax ; Cất thẻ tệp có trong ax -> biến the_tep
		mov bx, ax ; Đưa con trỏ về cuối tệp để xác định độ dài của tệp
		xor cx, cx ; Khoảng cách so sánh là = 0
		mov dx, cx ; 
		mov al, 2
		mov ah, 42h
		int 21h
		jnc L_CT2 ; Chuyển con trỏ tệp tốt thì nhảy 
		HienString err_s 
		jmp DONG_TEP
		
	L_CT2:
		mov dodai_tep, ax ; Chuyển về cuối tệp tốt thì ax là độ dài tệp -> biến dodai_tep
		mov bx, the_tep ; Đưa con trỏ tệp trở về đầu tệp
		mov al, 0 ; So với đầu tệp
		xor cx, cx ; Khoảng cách so sánh là 0
		mov dx, cx 
		mov ah, 42h ; Chức năng di chuyển con trỏ tệp
		int 21h
		jnc L_CT3 ; Chuyển con trỏ tệp tốt thì nhảy
		HienString err_s
		jmp DONG_TEP
		
	L_CT3:
		mov bx, the_tep ; Đọc toàn bộ tệp -> vùng đệm
		mov cx, dodai_tep
		lea dx, dem
		mov ah, 3fh ; Chức năng đọc tệp 
		int 21h
		jnc L_CT4 ; Đọc tệp tốt thì nhảy 
		HienString err_r
		jmp DONG_TEP
		
	L_CT4:
		HienString ct2
		lea dx, buff ; Vào tên tệp con 1
		call GET_FILE_NAME
		lea dx, file_name ; Chức năng tạo tệp mới và mở
		mov cx, 0 ; Không đặt thuộc tính nào cho tệp 
		mov ah, 3ch 
		int 21h
		jnc L_CT5
		HienString err_o
		jmp DONG_TEP
		
	L_CT5:
		mov the_tepc1, ax ; Thẻ tệp ở ax -> biến the_tepc1
		mov bx, ax ; Ghi 1/2 dữ liệu từ vùng đệm (chứa dữ liệu đọc được) -> tệp con 1 
		mov cx, dodai_tep 
		shr cx, 1 ; 1/2 độ dài tệp 
		lea dx, dem 
		mov ah, 40h
		int 21h
		jnc L_CT6
		HienString err_w
		jmp DONG_TEPC1
	
	L_CT6:
		HienString ct3 
		lea dx, buff ; Vào tên tệp con 2
		call GET_FILE_NAME
		lea dx, file_name ; Chức năng tạo tệp mới và mở 
		mov cx, 0 ; Không đặt thuôc tính nào cho tệp 
		mov ah, 3ch 
		int 21h 
		jnc L_CT7
		HienString err_o 
		jmp DONG_TEPC1
		
	L_CT7:
		mov the_tepc2, ax ; Thẻ tệp ở ax -> biến the_tepc2
		mov bx, ax ; Ghi 1/2 dữ liệu còn lại vào tệp con 2
		mov cx, dodai_tep
		mov ax, cx
		shr ax, 1 
		sub cx, ax ; Số lượng byte còn lại cho tệp con 2
		lea dx, dem 
		add ax, dx ; Trỏ đến đầu vùng nhớ chứa dữ liệu còn lại
		mov ah, 40h
		int 21h 
		jnc DONG_TEPC2
		HienString err_w
		
	DONG_TEPC2:
		mov bx, the_tepc2
		mov ah, 3eh
		int 21h 
		jnc DONG_TEPC1
		HienString err_c
		
	DONG_TEPC1:
		mov bx, the_tepc1 ; Đóng tệp con 1
		mov ah, 3eh 
		int 21h 
		jnc DONG_TEP
		HienString err_c
			
	DONG_TEP:
		mov bx, the_tep ; Đóng tệp cần chia 
		mov ah, 3eh
		int 21h
		jnc CONTINUE
		HienString err_c
	
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_CT0
	
	Exit:
		mov ah, 4ch
		int 21h
		
INCLUDE lib4.asm 
@CT$qv ENDP
	END