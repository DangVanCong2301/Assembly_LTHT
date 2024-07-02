INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	dd1 db 13, 10, 'Hay vao ten tep can dat lai time: $'
	dd2 db 13, 10, 'Vao gio, phut, giay moi: $'
	hc db ':$'
	err_o db 13, 10, 'Khong mo duoc tep!!! $'
	err_lt db 13, 10, 'Khong lay duoc thoi gian cua tep!!! $'
	err_dd db 13, 10, 'Khong dat duoc thoi gian!!! $'
	err_c db 13, 10, 'Khong dong duoc tep!!! $'
	the_tep dw ?
	buff db 30
		db ?
	file_name db 30 dup(?)
	tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
PS:
		mov ax, @data
		mov ds, ax

	L_DD0:
		CLRSCR
		HienString dd1
		lea dx, buff ; Vào tên tệp
		call GET_FILE_NAME
		lea dx, file_name ; Mở tệp đã có 
		mov al, 2 ; Đọc và ghi 
		mov ah, 3dh ; Chức năng mở tệp đã có 
		int 21h 
		jnc L_DD1
		HienString err_o
		jmp CONTINUE
		
	L_DD1:
		mov the_tep, ax ; Cất thẻ tệp vào biến the_tep
	; Lấy time và date hiện có của tệp 
		mov bx, ax ; Đưa thẻ tệp vào thanh ghi bx 
		mov al, 0 ; Chức năng láy time và date của tệp 
		mov ah, 57h ; Nếu lấy tốt thì cx chứa giờ, phút, giây
		int 21h ; Và dx chứa ngày, tháng và năm 
		jnc L_DD2
		HienString err_lt
		jmp DONG_TEP
		
	L_DD2:
		push cx ; Cất time cũ của tệp để sau còn đặt lại 
	; Phần vào ngày, tháng, năm mới cho tệp
		HienString dd2 
		xor dx, dx ; dx sẽ chứa ngày, tháng và năm 
		call VAO_2_SO ; Nhận hai chữ số của ngày 
		xor ah, ah 
		or dx, ax ; Đưa vào phần ngày của thanh ghi dx 
		HienString hc ; Hiện dấu 2 chấm 
		call VAO_2_SO
		xor ah, ah 
		mov cl, 5 ; Số lần dịch sang trái 
		shl ax, cl ; Dịch sang trái 5 lần giá trị tháng 
		or dx, ax ; Đưa vào phần tháng của thanh ghi dx 
		HienString hc ; Hiện dấu 2 chấm 
		call VAO_SO_N ; Nhận 4 chữ số của năm 
		sub ax, 1980 ; Hiệu chỉnh năm 
		mov cl, 9 ; Số lần dịch sang trái 
		shl ax, cl ; Dịch sang trái 9 lần 
		or dx, ax ; Đưa phần năm của thanh ghi dx		
	; Đặt lại time và date của tệp (CN57h của int 21h với al = 1)
		pop cx ; Lấy lại time cũ của tệp 
		mov bx, the_tep ; Thẻ tệp vào bx 
		mov al, 1 ; Set time và date (CN 57h)
		mov ah, 57h
		int 21h 
		jnc DONG_TEP
		HienString err_dd
		
	DONG_TEP:
		mov bx, the_tep ; Thẻ tệp vào bx 
		mov ah, 3eh ; Chức năng đóng tệp 
		int 21h 
		jnc CONTINUE
		HienString err_c
		
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit 
		jmp L_DD0
		
	Exit:
		mov ah, 4ch
		int 21h
		
INCLUDE lib2.asm 
INCLUDE lib4.asm 
END PS