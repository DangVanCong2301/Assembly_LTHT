;---------------------------------
; NHAN MOT SO NGUYEN TU BAN PHIM  |
; Ket thuc so bang ENTER (0dh)    |
; So nhan duoc nam trong AX       |
; (duoc danh sai va sua)	  	  |
;---------------------------------
VAO_SO_N PROC
	push BX CX DX SI DI 
	lea DX, buff 		; DX chỉ vào đầu xâu buff 
	mov AH, 0Ah 		; Chức năng 0Ah của int 21h cho phép nhập
	int 21h 			; 1 xâu ký tự vào vùng đệm trỏ bởi DS:DX
	mov SI, DX 			; SI trỏ đến đầu vùng đệm 
	xor CX, CX 			; CX = 0
	mov DI, CX 			; giả sử di là biến dấu, khởi tạo DI = 0 ban đầu là dương 
	mov CL, [SI + 1] 	; CL chứa số lượng ký tự thật sự đã nhập 
	add SI, 2 			; SI trỏ đến byte chứa ký tự đầu tiên đã nhập 
	mov DL, [SI] 		; Đưa ký tự đầu tiên vào DL 
	cmp DL, '-' 		; Ký tự đầu tiên có phải là dấu '-'
	jne VN1 			; Không phải dấu '-' thì nhảy 
	inc DI 				; Nếu là dấu '-' thì cờ dấu di = 1
	inc SI 				; SI trỏ đến ký tự tiếp theo
	dec CX 				; Giảm chỉ số vòng lặp đi 1 
  VN1:
	xor AX, AX 			; AX = phần số đã vào trước (lúc đầu = 0)
	mov BX, 10 			; Một xâu ký tự vào vùng đệm trỏ bởi DS:DX
  VN2:
	mul BX 				; Nhân phần số đã vào trước với 10 	
	mov DL, [SI] 		; Lấy ký tự tiếp theo trong buff vào DL
	sub DL , 30h 		; Chuyển ký tự số dạng ASCII sang dạng số 
	xor DH, DH 			; DH = 0 để DX = DL số vừa vào 
	add AX, DX 			; Cộng phần số vừa vào đã nhận với 10 với số vào sau 
	inc SI 				; Trỏ đến ký tự tiếp theo trong buff 
	loop VN2
	and DI, DI 			; Xét trạng thái cờ dấu 
	jz VN3 				; Nếu số vào là dương (DI = 0) thì nhảy 
	neg AX 				; còn nếu số âm thì đổi dấu
  VN3:
	pop  DI SI DX CX BX 
	ret
VAO_SO_N ENDP

;----------------------------
; HIEN NOI DUNG THANH GHI AX |
; RA MAN HINH DANG CO SO 10  |
;----------------------------

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

;------------------------------------------
; Chuong trinh con hien 1 so nguyen trong  |
; thanh ghi AX ra man hinh dang co so HEXA |
;------------------------------------------

HIEN_HEXA PROC
	push ax bx cx dx
	mov  bx,16	; BX=so chia
	xor  cx,cx	; CX=so lan cat vao stack (luc dau=0)
   HSH1:
	xor  dx,dx	; DX=0
	div  bx		; DX:AX chia cho 16 (DX luon=0)
	cmp  dx,10	; Lieu so du nho hon 10 (tu 0 den 9) ?
	jb   HSH2	; Dung thi nhay
 	add  dx,7	; Con khon thi dx=dx+7
   HSH2:
	add  dx,30h	; Chuyen so du dang so ra dang ASCII
	push dx		; Cat vao stack
	inc  cx		; So lan cat vao stack tang len 1
	and  ax,ax	; Lieu thuong da bang 0 ?
	jnz  HSH1	; Chua bang khong thi tiep tuc thuat toan chia
   HSH3:		; con khong thi tao vong lap lay tu stack cac gia 
	pop  ax		; tri da cat va hien ra man hinh
	mov  ah,0eh
	int  10h
	loop HSH3
	mov  al,'h'	; Hien them chu 'h' phia sau so hexa vua hien
	mov  ah,0eh
	int  10h
	pop  dx cx bx ax
	ret
HIEN_HEXA ENDP

;-------------------------------------------
; Chuong trinh con hien gia tri co trong AX |
; ra man hinh dang co so 2 (BINARY)	    |
;-------------------------------------------
HIEN_BINARY PROC
	push ax bx cx
	mov  bx,ax	; Dua gia tri can hien vao BX
	mov  cx,16	; CX=chi so vong lap
    HB:			; Vong lap 16 lan
	xor  al,al	; AL=0
	shl  bx,1	; Quay trai, bit cao nhat vao CF
	adc  al,30h	; Dua CF vao AL va chuyen sang dang ASCII
	mov  ah,0eh	; va hien ra man hinh
	int  10h
	loop HB
	mov  al,'b'	; Hien them chu 'b'
	mov  ah,0eh
	int  10h
	pop  cx bx ax
	ret
HIEN_BINARY ENDP