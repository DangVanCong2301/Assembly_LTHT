# Lập trình hệ thống với Assembly
## Vì các các tệp assembly có giới hạn ký tự đặt tên nên ta sẽ viết tắt
### Lệnh dịch
- B1: mount c c:\
- B2: c:
- B3: cd asm 
- B4: tasm ten_tep (ten_tep.asm)
- B5: tlink ten_tep (ten_tep.obj) (Nếu trong thư mục có liên kết với C++ thì đổi tlink1)
- B6: ten_tep (ten_tep.exe)
### Thực hành trên lớp
- demo2.asm -> tổng hai số nguyên 
- demo3.asm -> Tổng các thành phần của một mảng
- demo4.asm -> Tìm số lớn nhất của dãy số
- demo5.asm -> Vị trí giá trị lớn nhất của dãy số nguyên
### Các bài tập Assembly thuần tuý
- lt.asm 		-> tính lũy thừa (Bài 1) 
- gt.asm  		-> tính giai thừa (Bài 2)
- tbc.asm     	-> trung bình cộng (Bài 3 (Hai bài còn lại code trong ổ C:\))
- tdsn.asm    	-> tổng dãy số nguyên của một mảng (Bài 4)
- chs.asm     	-> chia hai số (Bài 5)
- tcsc.asm    	-> tổng cấp số cộng (Bài 6)
- tcsn.asm    	-> tổng cấp số nhân (Bài 7)
- tds.asm     	-> tổng dãy số (Bài 8)
- tcsnt.asm   	-> tìm các số nguyên tố (Bài 9)
- main.asm, sub.asm -> tính giai thừa (chương trình đa tệp thuần tuý)
## Liên kết ngôn ngữ bậc cao
### Tệp lô (đuôi .bat): e:\tc\bin\tcc -ms -Ie:\tc\include -Le:\tc\lib %1 %2
## Các bài tập lập trình hệ thống 
- comk.asm -> Có ổ mềm không (Bài 1) 
- ccomk.asm -> Có cổng COM không (Bài 2) 
- clptk.asm -> Có cổng LPT nào không (Bài 3)
- cdkmh.asm -> Có card điều kiển màn hình loại gì (Bài 4)
- ttm.asm -> Tạo thư mục (Bài 5)
- copyt.asm, ct1.txt(tệp tạo) -> Copy 1 tệp (Bài 6)
- more.asm -> Hiện nội dung tệp dạng ASCII lên màn hình (Bài 7)
- doiten.asm -> Đổi tên 1 tệp (Bài 8)
- ltt.asm -> Lấy thuộc tính của tệp (Bài 9)
- dtt.asm -> Đặt thuộc tính cho tệp (Bài 10)
- ct.asm -> Chia tệp thành 2 tệp bằng nhau (Bài 11)
- dd.asm -> Đặt ngày, tháng, năm date và giữ nguyên giờ, phút, giây cho tệp 
- time.asm -> Lấy giờ, phút, giây hiện tại của máy tính 
- date.asm -> Lấy ngày, tháng, năm của máy tính
