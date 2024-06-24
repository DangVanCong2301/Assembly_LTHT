;----------------------------
;   Chuong trinh con nhan    |
;  ten tep vao tu ban phim   |
; Yeu cau : dx=offset buf    |
; Phai khai bao trong data : |
;   buff      db 50	     |
;	      db ?	     |
;   file_name db 50 dup(?)   |
;----------------------------
GET_FILE_NAME PROC
	push ax bx cx dx
	mov  ah,0ah	; Chuc nang nhan 1 xau tu
	int  21h	; ban phim va de vao buff
	mov  bx,dx	; bx tro den dau buf
	inc  bx		; bx tro den byte chua so luong ky tu da vao
	mov  cl,[bx]	; cl=so luong ky tu thuc te da vao
	xor  ch,ch	; ch=0 de cx=cl
	inc  bx		; bx tro den byte dau tien chua ky tu da vao
	add  bx,cx	; bx tro den byte chua 0dh (Enter)
	mov  [bx],ch	; Cho byte do bang \0
	pop  dx cx bx ax
	ret
GET_FILE_NAME ENDP

HIEN_SO_N PROC
	push AX BX CX DX
	mov  BX,10	; BX chua so chia la 10
	xor  CX,CX	; So lan cat vao stack (luc dau = 0)
	and  AX,AX	; Dung co dau SF
	jns  HSN1	; Neu so can hien la duong thi nhay
	push AX		; con khong thi cat AX vao stack
	mov  AL,'-'	; Hien dau '-' ra man hinh
	mov  AH,0eh
	int  10h
	pop  AX		; Hoi phuc lai so can hien tu stack vao AX
	neg  AX		; Bu 2 de lay gia tri tuyet doi
   HSN1:
	xor  DX,DX	; DX=0
	div  BX		; DX:AX chia cho BX (10)
	add  DX,30h	; Chuyen so du tu dang so ra dang ASCII
	push DX		; Cat vao stack
	inc  CX		; Tang so lan cat vao stack len 1
	and  AX,AX	; Dung co ZF (lieu thuong = 0)
	jnz  HSN1	; Thuong # 0 thi nhay den tiep tuc qua trinh chia
   HSN2:		; Vong lap lay cac gia tri co trong stack hien 
	pop  AX		
	mov  AH,0eh	; Chuc nang hien 1 ky tu dang ASCII o AL ra man hinh
	int  10h
	loop HSN2
	pop  DX CX BX AX
	ret
HIEN_SO_N ENDP
	  
