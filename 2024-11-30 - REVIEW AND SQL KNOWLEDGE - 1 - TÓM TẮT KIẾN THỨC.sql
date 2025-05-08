/* 
1. CÚ PHÁP TRUY VẤN CƠ BẢN:
- Chọn database và lấy toàn bộ dữ liệu:
 USE database_name
 SELECT * FROM table_name

- Lấy cột cụ thể với giới hạn:
 SELECT TOP n
     column1,
     column2
 FROM table_name
*/

/* 
2. ĐẶT TÊN CỘT (ALIAS) - 4 CÁCH:
- Ngoặc vuông:    column AS [Tên Mới]
- Nháy đôi:       column AS "Tên Mới" 
- Nháy đơn:       column AS 'Tên Mới'
- Dùng dấu =:     [Tên Mới] = column
*/

/*
3. ĐẶT TÊN BẢNG (ALIAS) - 3 CÁCH:
- Alias thường:   FROM table X1
- Dùng số:        FROM table [1]  
- Tên đầy đủ:     FROM database..table
*/

/*
4. MỆNH ĐỀ WHERE:
- Với chuỗi:
 WHERE column = N'Giá trị'           -- Tìm chính xác
 WHERE column IN ('A', 'B')          -- Tìm trong danh sách
 WHERE column LIKE '%text%'          -- Tìm kiếm mẫu
 
- Với số:
 WHERE number > value                -- So sánh đơn giản
 WHERE number BETWEEN min AND max    -- Khoảng giá trị

- Với ngày:
 WHERE MONTH(date) = m              -- Theo tháng
 WHERE YEAR(date) = y               -- Theo năm
 WHERE DATEPART(QUARTER,date) = q   -- Theo quý
*/

/*
5. TOÁN TỬ SO SÁNH:
=    -- Bằng
!=   -- Khác (cách 1)
<>   -- Khác (cách 2)
>    -- Lớn hơn
<    -- Nhỏ hơn
>=   -- Lớn hơn hoặc bằng
<=   -- Nhỏ hơn hoặc bằng
!>   -- Không lớn hơn
!<   -- Không nhỏ hơn
*/

/*
6. TOÁN TỬ LOGIC:
AND  -- Cả hai điều kiện đúng
OR   -- Một trong hai điều kiện đúng
NOT  -- Phủ định điều kiện
*/

/*
7. TOÁN TỬ KHÁC:
( )  -- Dấu ngoặc (độ ưu tiên)
*    -- Nhân
/    -- Chia
%    -- Chia lấy dư
+    -- Cộng/nối chuỗi
-    -- Trừ
*/

/*
8. HÀM XỬ LÝ NGÀY THÁNG:
MONTH()    -- Lấy tháng
YEAR()     -- Lấy năm
DATEPART() -- Lấy phần cụ thể
*/

/*
9. ĐỊNH DẠNG SỐ:
FORMAT(number,'#,##0;(#,##0)') -- Định dạng có dấu phẩy
*/

/*
10. SẮP XẾP:
ORDER BY column ASC  -- Tăng dần (mặc định)
ORDER BY column DESC -- Giảm dần
*/

/*
11. ĐỘ ƯU TIÊN TOÁN TỬ (cao xuống thấp):
1. ( )     -- Dấu ngoặc
2. *, /    -- Nhân, chia
3. +, -    -- Cộng, trừ
4. =,>,<   -- So sánh
5. NOT
6. AND
7. BETWEEN, IN, LIKE, OR
8. =       -- Gán
*/

/*
LƯU Ý QUAN TRỌNG:
1. Dùng N cho Unicode: N'Chuỗi có dấu'
2. LIKE với wildcard %:
  %text%  -- Chứa 'text'
  text%   -- Bắt đầu bằng 'text'
  %text   -- Kết thúc bằng 'text'
3. Nên chọn cột cụ thể thay vì SELECT *
4. BETWEEN bao gồm cả giá trị đầu và cuối
5. Mặc định ORDER BY là ASC (tăng dần)
*/

/* 
THỨ TỰ CÂU LỆNH SQL CHUẨN:
SELECT    -- Chọn cột
FROM      -- Từ bảng
WHERE     -- Điều kiện
ORDER BY  -- Sắp xếp
*/











