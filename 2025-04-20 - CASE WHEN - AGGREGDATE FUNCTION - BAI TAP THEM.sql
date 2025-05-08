
USE RISK_PORTFOLIO 

/*Không sử dụng set điều kiện bằng tay, thiết kế câu Query sao cho tự động theo thời gian mà không phải chỉnh tay*/

--1. Lấy TOP 10 khoản vay có số tiền giải ngân lớn nhất của 2 tháng trước kể từ tháng gần nhất - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE].

--2. Sản phẩm nào có số tiền giải ngân lớn nhất của tháng gần nhất - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE].

--3. Thống kê số tiền giải ngân của mỗi sáng phẩm trong 6 tháng gần nhất - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] (Gợi ý sử dụng SUM(CASE WHEN....) cho từng sản phẩm và GROUP BY theo tháng với FORMAT YYYY-MM của DISBURSEMENT_DATE)

--4. Tỉnh nào có nhiều khoản vay nhất vào năm ngoái - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE].

--5. Lấy TOP 10 tỉnh có số tiền giải ngân vào Quý 1 và Quý 2 năm ngoái - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE].

--6. Lấy ENR và WO amount theo tháng (chốt cuối tháng: REPORT_DATE = EOMONTH(REPORT_DATE)) - Sử dụng bảng: [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] (Gợi ý sử dụng SUM(CASE WHEN....) cho từng điều kiện ENR và WO theo tháng với chốt cuối tháng của REPORT_DATE)
			/*
			   ENR: DPD <= 180 
			   WO: DPD < 180 
			*/
--7. Lập báo cáo giải ngân theo tuần - theo dõi SẢN PHẨM, GIỚI TÍNH, TỈNH THÀNH, KHU VỰC, LOẠI THU NHẬP - Sử dụng bảng: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE].




