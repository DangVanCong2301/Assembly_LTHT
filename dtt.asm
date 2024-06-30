INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
	dtt1 	db 13, 10, 'Hay vao ten tep can dat thuoc tinh: $'
	dtt2 	db 13, 10, 'Vao thuoc tinh cho tep: '
			db 13, 10, '0. Khong dat duoc thuoc tinh!'
			db 13, 10, '1. Read Only'
			db 13, 10, '2. Hidden'
			db 13, 10, '3. Read Only + Hidden'
			db 13, 10, '4. System'
			db 13, 10, '5. Read Only + System'
			db 13, 10, '6. Hidden + System'
			db 13, 10, '7. Read Only + Hidden + System'
			db 13, 10, '8. Archive'
			db 13, 10, '9. Archive + Read Only'
			db 13, 10, '10. Archive + Hidden'
			db 13, 10, '11. Archive + Read Only + Hidden'
			db 13, 10, '12. Archive + System'
			db 13, 10, '13. Archive + Read Only + System'
			db 13, 10, '14. Archive + Hidden + System'
			db 13, 10, '15. Archive + Read Only + Hidden + System'
			db 13, 10, 13, 10, '-> Hay chon: $'
	err_dtt db 13, 10, 'Khong dat duoc thuoc tinh cho tep! $'
	suc_dtt db 13, 10, 'Tep da dat duoc thuoc tinh! $'
	buff db 30
		db ?
	file_name db 30 dup(?)
	tieptuc db 13, 10, 'Co tiep tuc chuong trinh khong(c/k)? $'
.CODE
	PUBLIC @DTT$qv
@DTT$qv PROC
		mov ax, @data 
		mov ds, ax 
		
	L_DTT0:
		CLRSCR
		HienString dtt1
		lea dx, buff 
		call GET_FILE_NAME
		HienString dtt2
		call VAO_SO_N ; Chọn thuộc tính từ 0 -> 15
		mov cx, ax ; Đặt thuộc tính vào cx 
		cmp cx, 8
		jb L_DTT1
		add cx, 24
		
	L_DTT1:
		lea dx, file_name ; Thuộc tính có trong cx 
		mov al, 1 ; Đặt thuộc tính 
		mov ah, 43h
		int 21h 
		jnc L_DTT2
		HienString err_dtt
		jmp CONTINUE
		
	L_DTT2:
		HienString suc_dtt
	
	CONTINUE:
		HienString tieptuc
		mov ah, 1
		int 21h
		cmp al, 'c'
		jne Exit
		jmp L_DTT0
			
	Exit:
		mov ah, 4ch
		int 21h 
		
INCLUDE lib2.asm 
INCLUDE lib4.asm 
@DTT$qv ENDP
	END