CREATE DATABASE MOCPHUC
GO

USE MOCPHUC
GO

CREATE TABLE TAIKHOAN(
	IDTK INT PRIMARY KEY IDENTITY,
	TENDN VARCHAR(100) UNIQUE NOT NULL,
	PASS VARCHAR(100) NOT NULL
)

CREATE TABLE KHACHHANG (
	IDKH INT PRIMARY KEY IDENTITY,
	IDTK INT FOREIGN KEY (IDTK) REFERENCES TAIKHOAN(IDTK),
	TEN NVARCHAR(10) NOT NULL,
	TENDEM NVARCHAR(10) ,
	HO NVARCHAR(10) NOT NULL,
	NGAYSINH DATE NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	SDT VARCHAR(12) UNIQUE NOT NULL,
	AVATAR VARCHAR(255),
	EMAIL NVARCHAR(255) UNIQUE
)



CREATE TABLE LOAISP (
	IDLSP INT PRIMARY KEY IDENTITY,
	TENLSP NVARCHAR(50) NOT NULL
)

CREATE TABLE SANPHAM (
	IDSP INT PRIMARY KEY IDENTITY,
	IDLSP INT NOT NULL FOREIGN KEY (IDLSP) REFERENCES LOAISP(IDLSP),
	TENSP NVARCHAR(100) NOT NULL,
	SOLUONG INT NOT NULL,
	IMG VARCHAR(255),
	MOTA NVARCHAR(500),
	GIABAN MONEY
)
CREATE TABLE BINHLUAN(
	IDBL INT PRIMARY KEY IDENTITY,
	IDKH INT NOT NULL FOREIGN KEY (IDKH) REFERENCES KHACHHANG(IDKH),
	IDSP INT NOT NULL FOREIGN KEY (IDSP) REFERENCES SANPHAM(IDSP),
	NOIDUNGBL NVARCHAR(255) NOT NULL
)

CREATE TABLE HOADON (
	IDHD INT PRIMARY KEY IDENTITY,
	IDKH INT NOT NULL FOREIGN KEY (IDKH) REFERENCES KHACHHANG(IDKH),
	NGAYDATHANG DATETIME NOT NULL,
	NGAYGIAOHANG DATE,
	NOIGIAOHANG NVARCHAR(100) NOT NULL,
	DAGIAO BIT NOT NULL,
	DAXACNHAN BIT NOT NULL,
)
CREATE TABLE GIOHANG(
	IDKH INT NOT NULL FOREIGN KEY (IDKH) REFERENCES KHACHHANG(IDKH),
	IDSP INT NOT NULL FOREIGN KEY (IDSP) REFERENCES SANPHAM(IDSP),
	SOLUONG INT NOT NULL,
	DADATMUA BIT NOT NULL,
	PRIMARY KEY(IDKH,IDSP)
)
CREATE TABLE CTHD (
	IDHD INT NOT NULL FOREIGN KEY (IDHD) REFERENCES HOADON(IDHD),
	IDSP INT NOT NULL FOREIGN KEY (IDSP) REFERENCES SANPHAM(IDSP),
	SOLUONG INT NOT NULL,
	PRIMARY KEY(IDHD,IDSP)
)

INSERT INTO LOAISP VALUES
(N'Bàn'),
(N'Ghế'),
(N'Tủ'),
(N'Giường'),
(N'Kệ')

INSERT INTO SANPHAM(IDLSP,TENSP,SOLUONG,IMG,MOTA,GIABAN) VALUES
(1,N'Bàn làm viêc A',20,'https://cf.shopee.vn/file/d64043bc8380fbaaaaabd0bdfd8f6dae',N'Bàn là một loại nội thất, với cấu tạo của nó hàm chứa một mặt phẳng nằm ngang (gọi là mặt bàn) có tác dụng dùng để nâng đỡ cho những vật dụng hay vật thể mà người dùng muốn đặt lên mặt bàn đó.',600000),
(1,N'Bàn làm viêc B',20,'https://cf.shopee.vn/file/d64043bc8380fbaaaaabd0bdfd8f6dae',N'Bàn là một loại nội thất, với cấu tạo của nó hàm chứa một mặt phẳng nằm ngang (gọi là mặt bàn) có tác dụng dùng để nâng đỡ cho những vật dụng hay vật thể mà người dùng muốn đặt lên mặt bàn đó.',600000),
(1,N'Bàn làm viêc C',20,'https://cf.shopee.vn/file/d64043bc8380fbaaaaabd0bdfd8f6dae',N'Bàn là một loại nội thất, với cấu tạo của nó hàm chứa một mặt phẳng nằm ngang (gọi là mặt bàn) có tác dụng dùng để nâng đỡ cho những vật dụng hay vật thể mà người dùng muốn đặt lên mặt bàn đó.',600000),
(1,N'Bàn ăn A',20,'https://cf.shopee.vn/file/d64043bc8380fbaaaaabd0bdfd8f6dae',N'Bàn là một loại nội thất, với cấu tạo của nó hàm chứa một mặt phẳng nằm ngang (gọi là mặt bàn) có tác dụng dùng để nâng đỡ cho những vật dụng hay vật thể mà người dùng muốn đặt lên mặt bàn đó.',500000),
(2,N'Ghế làm việc A',20,'https://cf.shopee.vn/file/d3e13bebaa20adc46dc1c22cd4ec069c',N'Thông thường ghế có bốn chân. Ngoài ra có ghế ba chân và cũng có thể có ghế nhiều chân hơn nữa, nhưng hiếm. Có các loại ghế "một chân" hay "hai chân" nếu "chân ghế" có hình dạng đủ để tạo thành chân đế bền vững chống đỡ cho cấu trúc không bị đổ.',400000),
(2,N'Ghế làm việc B',20,'https://cf.shopee.vn/file/d3e13bebaa20adc46dc1c22cd4ec069c',N'Thông thường ghế có bốn chân. Ngoài ra có ghế ba chân và cũng có thể có ghế nhiều chân hơn nữa, nhưng hiếm. Có các loại ghế "một chân" hay "hai chân" nếu "chân ghế" có hình dạng đủ để tạo thành chân đế bền vững chống đỡ cho cấu trúc không bị đổ.',400000),
(2,N'Ghế làm việc C',20,'https://cf.shopee.vn/file/d3e13bebaa20adc46dc1c22cd4ec069c',N'Thông thường ghế có bốn chân. Ngoài ra có ghế ba chân và cũng có thể có ghế nhiều chân hơn nữa, nhưng hiếm. Có các loại ghế "một chân" hay "hai chân" nếu "chân ghế" có hình dạng đủ để tạo thành chân đế bền vững chống đỡ cho cấu trúc không bị đổ.',400000),
(2,N'Ghế cổ điển A',20,'https://cf.shopee.vn/file/d3e13bebaa20adc46dc1c22cd4ec069c',N'Thông thường ghế có bốn chân. Ngoài ra có ghế ba chân và cũng có thể có ghế nhiều chân hơn nữa, nhưng hiếm. Có các loại ghế "một chân" hay "hai chân" nếu "chân ghế" có hình dạng đủ để tạo thành chân đế bền vững chống đỡ cho cấu trúc không bị đổ.',300000),
(3,N'Tủ quần áo A',20,'https://cf.shopee.vn/file/aeb1afae03521ff1135f3982b9cb6b69',N'Tủ là đồ dùng để đựng đồ vật, có hình khối chữ nhật, thường được làm bằng gỗ, hoặc kim loại hay nhựa có cánh cửa và mỗi cánh cửa hay có khóa để giữ an toàn. Có nhiều loại tủ như tủ thờ, tủ quần áo, tủ đựng hàng, tủ đựng tài liệu, tủ đựng đồ dùng, v.v...',250000),
(3,N'Tủ quần áo B',20,'https://cf.shopee.vn/file/aeb1afae03521ff1135f3982b9cb6b69',N'Tủ là đồ dùng để đựng đồ vật, có hình khối chữ nhật, thường được làm bằng gỗ, hoặc kim loại hay nhựa có cánh cửa và mỗi cánh cửa hay có khóa để giữ an toàn. Có nhiều loại tủ như tủ thờ, tủ quần áo, tủ đựng hàng, tủ đựng tài liệu, tủ đựng đồ dùng, v.v...',250000),
(3,N'Tủ quần áo C',20,'https://cf.shopee.vn/file/aeb1afae03521ff1135f3982b9cb6b69',N'Tủ là đồ dùng để đựng đồ vật, có hình khối chữ nhật, thường được làm bằng gỗ, hoặc kim loại hay nhựa có cánh cửa và mỗi cánh cửa hay có khóa để giữ an toàn. Có nhiều loại tủ như tủ thờ, tủ quần áo, tủ đựng hàng, tủ đựng tài liệu, tủ đựng đồ dùng, v.v...',250000),
(3,N'Tủ quần áo D',20,'https://cf.shopee.vn/file/aeb1afae03521ff1135f3982b9cb6b69',N'Tủ là đồ dùng để đựng đồ vật, có hình khối chữ nhật, thường được làm bằng gỗ, hoặc kim loại hay nhựa có cánh cửa và mỗi cánh cửa hay có khóa để giữ an toàn. Có nhiều loại tủ như tủ thờ, tủ quần áo, tủ đựng hàng, tủ đựng tài liệu, tủ đựng đồ dùng, v.v...',250000),
(4,N'Giường ngủ A',20,'https://cf.shopee.vn/file/20b10dabc9c207cd8e8ba1b7fe1f0f8a',N'Giường là một đồ vật hay nơi chốn với cấu tạo chính bằng gỗ hay kim loại, bên trên có trải nệm mút, nệm lò xo hay vạc giường và chiếu. Giường được sử dụng làm nơi ngủ, nằm nghỉ ngơi. Trên giường thường có gối kê, gối ôm, chăn.',600000),
(4,N'Giường ngủ B',20,'https://cf.shopee.vn/file/20b10dabc9c207cd8e8ba1b7fe1f0f8a',N'Giường là một đồ vật hay nơi chốn với cấu tạo chính bằng gỗ hay kim loại, bên trên có trải nệm mút, nệm lò xo hay vạc giường và chiếu. Giường được sử dụng làm nơi ngủ, nằm nghỉ ngơi. Trên giường thường có gối kê, gối ôm, chăn.',600000),
(4,N'Giường ngủ C',20,'https://cf.shopee.vn/file/20b10dabc9c207cd8e8ba1b7fe1f0f8a',N'Giường là một đồ vật hay nơi chốn với cấu tạo chính bằng gỗ hay kim loại, bên trên có trải nệm mút, nệm lò xo hay vạc giường và chiếu. Giường được sử dụng làm nơi ngủ, nằm nghỉ ngơi. Trên giường thường có gối kê, gối ôm, chăn.',600000),
(4,N'Giường ngủ D',20,'https://cf.shopee.vn/file/20b10dabc9c207cd8e8ba1b7fe1f0f8a',N'Giường là một đồ vật hay nơi chốn với cấu tạo chính bằng gỗ hay kim loại, bên trên có trải nệm mút, nệm lò xo hay vạc giường và chiếu. Giường được sử dụng làm nơi ngủ, nằm nghỉ ngơi. Trên giường thường có gối kê, gối ôm, chăn.',600000),
(5,N'Kệ sách A',20,'https://cf.shopee.vn/file/21e475a8edd1d252c63badce33a2e619',N'Kệ là một mặt phẳng ngang phẳng được sử dụng trong nhà, doanh nghiệp, cửa hàng hoặc nơi khác để giữ các mặt hàng đang được trưng bày, lưu trữ hoặc chào bán. Nó được nâng lên khỏi mặt đất và thường được neo.',200000),
(5,N'Kệ sách B',20,'https://cf.shopee.vn/file/21e475a8edd1d252c63badce33a2e619',N'Kệ là một mặt phẳng ngang phẳng được sử dụng trong nhà, doanh nghiệp, cửa hàng hoặc nơi khác để giữ các mặt hàng đang được trưng bày, lưu trữ hoặc chào bán. Nó được nâng lên khỏi mặt đất và thường được neo.',200000),
(5,N'Kệ sách C',20,'https://cf.shopee.vn/file/21e475a8edd1d252c63badce33a2e619',N'Kệ là một mặt phẳng ngang phẳng được sử dụng trong nhà, doanh nghiệp, cửa hàng hoặc nơi khác để giữ các mặt hàng đang được trưng bày, lưu trữ hoặc chào bán. Nó được nâng lên khỏi mặt đất và thường được neo.',200000),
(5,N'Kệ sách D',20,'https://cf.shopee.vn/file/21e475a8edd1d252c63badce33a2e619',N'Kệ là một mặt phẳng ngang phẳng được sử dụng trong nhà, doanh nghiệp, cửa hàng hoặc nơi khác để giữ các mặt hàng đang được trưng bày, lưu trữ hoặc chào bán. Nó được nâng lên khỏi mặt đất và thường được neo.',200000)
/*
select * 
from sanpham sp join loaisp lsp on sp.IDLSP=lsp.IDLSP
order by sp.IDLSP ASC*/

insert TAIKHOAN(TENDN,PASS) values
('phucdeptrai','12345678')

insert KHACHHANG(IDTK,TEN,TENDEM,HO,NGAYSINH,DIACHI,SDT,AVATAR,EMAIL) values
(1,N'Phúc',N'Trần Hữu',N'Phan','10/22/2001',N'40 Ngọc Sơn, Vũng Đình, Hòn Nghê 2','0708488401','/img/avatar.jpg',N'phucpth2001@gmail.com')

select IDKH,IDTK,HO+' '+TENDEM+' '+TEN AS 'TEN', NGAYSINH, DIACHI, SDT, EMAIL
FROM KHACHHANG

select * 
from sanpham sp join loaisp lsp on sp.IDLSP=lsp.IDLSP 
where idsp = 1
/*
update SANPHAM
set TENSP = N'Bàn làm việc AB',
	GIABAN = 300000
where IDSP = 1*/

----------------------------------------------------------------------------
CREATE PROC SP_THEMGIOHANG
	@IDKH INT,
	@IDSP INT,
	@SOLUONG INT,
	@DADATMUA BIT = 0
AS
BEGIN
	INSERT INTO GIOHANG(IDKH,IDSP,SOLUONG,DADATMUA) VALUES
	(@IDKH,@IDSP,@SOLUONG,@DADATMUA)
END

EXEC SP_THEMGIOHANG 1,5,2


-------------------------------------------------------------------------------------
alter PROC SP_THEMKHACHHANG
	@TENDN VARCHAR(100),
	@PASS VARCHAR(100),
	@TEN NVARCHAR(10),
	@TENDEM NVARCHAR(10) ,
	@HO NVARCHAR(10) ,
	@NGAYSINH DATE,
	@DIACHI NVARCHAR(100),
	@SDT VARCHAR(12),
	@EMAIL NVARCHAR(255),
	@AVATAR VARCHAR(255) = '/img/avatar.jpg'
AS
BEGIN
	IF @TENDN IS NOT NULL
	BEGIN
		INSERT INTO TAIKHOAN(TENDN,PASS) VALUES
		(@TENDN,@PASS)
		INSERT INTO KHACHHANG(TEN,TENDEM,HO,NGAYSINH,DIACHI,SDT,AVATAR,EMAIL) VALUES
		(@TEN,@TENDEM,@HO,@NGAYSINH,@DIACHI,@SDT,@AVATAR,@EMAIL)
		UPDATE KHACHHANG
		SET IDTK = (SELECT IDKH FROM KHACHHANG where idtk is null)
		where idtk is null
	END
	ELSE
		PRINT('KHONG CO TENDN')
END
-----------------------------------------------------------------------------------------------
select * from TAIKHOAN
select * from KHACHHANG


select GH.IDKH,GH.IDSP, gh.SOLUONG, TENSP, IMG, gh.SOLUONG*GIABAN as 'TONGGIA'
from GIOHANG gh join SANPHAM sp on gh.IDSP=sp.IDSP

EXEC SP_THEMGIOHANG 1,2,2

select * from HOADON where idkh = 1
select * from CTHD
select * from SANPHAM

update SANPHAM
set SOLUONG = SOLUONG - (select SOLUONG from CTHD where idsp = 15) 
where idsp = 15

delete HOADON

--------------------------------------------------------------------------------------------
CREATE PROC SP_THEMHOADON
	@IDKH INT,
	@NOIGIAOHANG NVARCHAR(100),
	@DAGIAO BIT = 0,
	@DAXACNHAN BIT = 0
AS
BEGIN
	
	DECLARE CURGIOHANG CURSOR
	FOR SELECT IDKH, IDSP, SOLUONG FROM GIOHANG

	DECLARE @IDK INT
	DECLARE @IDSP INT
	DECLARE @SOLUONG INT

	INSERT INTO HOADON(IDKH,NGAYDATHANG,NGAYGIAOHANG,NOIGIAOHANG,DAGIAO,DAXACNHAN) VALUES
	(@IDKH,GETDATE(),GETDATE()+2,@NOIGIAOHANG,@DAGIAO,@DAXACNHAN)
	
	OPEN CURGIOHANG
	FETCH NEXT FROM CURGIOHANG INTO @IDK,@IDSP,@SOLUONG
	WHILE (@@FETCH_STATUS = 0) --KHI TRO THANH CONG
	BEGIN
		IF @IDKH = @IDK
		begin
			INSERT INTO CTHD(IDHD,IDSP,SOLUONG)	VALUES
			((SELECT TOP(1) IDHD FROM HOADON ORDER BY IDHD DESC),@IDSP,@SOLUONG)
			
			update SANPHAM
			set SOLUONG = SOLUONG - (select SOLUONG from GIOHANG where idsp = @IDSP and IDKH = @IDKH) 
			where idsp = @IDSP
		end
		FETCH NEXT FROM CURGIOHANG INTO @IDK,@IDSP,@SOLUONG
	END
	
	-- DONG CON TRO
	CLOSE CURGIOHANG
	-- HUY CON TRO
	DEALLOCATE CURGIOHANG
	
	DELETE GIOHANG
	WHERE IDKH = @IDKH
END

EXEC SP_THEMHOADON 1,N'40 Ngọc Sơn, Vũng Đình, Hòn Nghê 2'

DROP PROC SP_THEMHOADON

----------------------------------------------------------------------------------
CREATE PROC SP_XEMGIOHANG
	@IDKH INT
AS
BEGIN
	select gh.IDSP, gh.SOLUONG, TENSP, IMG, gh.SOLUONG*GIABAN as 'TONGGIA'
    from GIOHANG gh join SANPHAM sp on gh.IDSP=sp.IDSP
    where idkh = @IDKH and dadatmua = 0

	SELECT SUM(gh.SOLUONG*GIABAN) AS 'TONGGIAGH'
	from GIOHANG gh join SANPHAM sp on gh.IDSP=sp.IDSP
    where idkh = @IDKH and dadatmua = 0
END

EXEC SP_XEMGIOHANG 1

-----------------------------------------------------------
alter PROC SP_XEMHOADON
	@IDHD INT
AS
BEGIN
	select CTHD.IDSP, CTHD.SOLUONG, TENSP, IMG, CTHD.SOLUONG*GIABAN as 'TONGGIA'
    from CTHD join SANPHAM sp on CTHD.IDSP=sp.IDSP
	WHERE IDHD = @IDHD
    
	SELECT SUM(CTHD.SOLUONG*GIABAN) AS 'TONGGIAHD'
	from CTHD join SANPHAM sp on CTHD.IDSP=sp.IDSP
	WHERE IDHD = @IDHD 
END


--------------------------------------------------------------
select bl.IDKH, ho+ ' '+tendem+' '+ten as 'TEN', IDSP, NOIDUNGBL
from BINHLUAN bl join KHACHHANG kh on bl.IDKH=kh.IDKH
where idsp = 1


insert into BINHLUAN(IDKH,IDSP,NOIDUNGBL) values
(1,1,N'Mọi người nên mua dùng thử nhé !!!')

--------------------------------------------------------------------------
alter PROC SP_XEMSP
	@IDSP INT
AS
BEGIN
	select * from sanpham where idsp = @idsp

	select bl.IDKH, ho+ ' '+tendem+' '+ten as 'TEN', NOIDUNGBL
	from BINHLUAN bl join KHACHHANG kh on bl.IDKH=kh.IDKH
	where idsp = @idsp
	order by IDBL DESC
END
-------------------------------------------------------------------------------------------
select TENSP, ho+ ' '+tendem+' '+ten as 'TEN', NOIDUNGBL
	from BINHLUAN bl join KHACHHANG kh on bl.IDKH=kh.IDKH
		join SANPHAM sp on bl.IDSP=sp.IDSP
	where bl.idsp = 1
	order by IDBL DESC

select IDHD, ho+ ' '+tendem+' '+ten as 'TEN', NGAYDATHANG, NGAYGIAOHANG, NOIGIAOHANG, DAGIAO
from HOADON hd join KHACHHANG kh on hd.IDKH=kh.IDKH
------------------------------------------------------------------------------------------------



alter PROC SP_THONGKE
	@MONTH INT,
	@YEAR INT
AS
BEGIN
	select CTHD.IDSP, TENSP, TENLSP, IMG, SUM(CTHD.SOLUONG) as 'SOLUONG', SUM(CTHD.SOLUONG*GIABAN) as 'TONGGIA'
	from CTHD join HOADON hd on CTHD.IDHD=hd.IDHD
		join SANPHAM sp on CTHD.IDSP=sp.IDSP
		join LOAISP lsp on sp.IDLSP=lsp.IDLSP
	where month(NGAYDATHANG) = @MONTH and year(NGAYDATHANG) = @YEAR
	group by CTHD.IDSP, TENSP, IMG, TENLSP

	select SUM(cthd.SOLUONG*GIABAN) as 'DOANHTHU'
	from CTHD join HOADON hd on CTHD.IDHD=hd.IDHD
		join sanpham sp on cthd.IDSP=sp.IDSP
	where month(NGAYDATHANG) = @MONTH and year(NGAYDATHANG) = @YEAR

	select count(idhd) as 'TONGSOHD', count(DISTINCT idkh) as 'TONGSOKH'
	from HOADON
	where month(NGAYDATHANG) = @MONTH and year(NGAYDATHANG) = @YEAR
END

EXEC SP_THONGKE 12,2021