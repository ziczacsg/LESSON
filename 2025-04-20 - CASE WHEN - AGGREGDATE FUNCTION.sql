
USE RISK_PORTFOLIO 

/*----------------------------------------------------------
  AGGREGATE FUNCTION (HÀM TỔ HỢP): SUM, MIN, MAX, COUNT, AVG 
------------------------------------------------------------*/

--VD1:
/*
   Viết gọn trong 1 câu truy vấn các yêu cầu sau:
   1. Lấy tổng số giải ngân qua các tháng.
   2. Lấy tồng số khoản vay qua các tháng.
   3. Giá trị giải ngân lớn nhất.
   4. Giá trị giải ngân nhỏ nhất.
   5. Lấy giá trị giải ngân trung bình.
*/

--VD2: 

/*
   Viết gọn trong 1 câu truy vấn các yêu cầu sau:
   1. Lấy tổng số giải ngân 6 tháng gần nhất.
   2. Lấy tồng số khoản vay 6 tháng gần nhất.
   3. Lấy tổng số giải ngân tháng gần nhất.
   4. Lấy tồng số khoản vay tháng gần nhất.
*/









/*----------------------------------------------------------------------------------

CASE
     WHEN condition1 THEN result1 (kết quả cột, giá trị kiểu số, giá trị kiểu chuỗi)
     WHEN condition2 THEN result2
     WHEN conditionN THEN resultN
     ELSE result
END;
----------------------------------------------------------------------------------*/


--VÍ DỤ 1 

SELECT 
		 LOAN_ACCOUNT_NUMBER
		,LOAN_AMOUNT	
		,CASE WHEN LOAN_AMOUNT < (50 * POWER(10,6))   THEN '< 50M'
			  WHEN LOAN_AMOUNT < (100 * POWER(10,6))  THEN '< 100M'
			  WHEN LOAN_AMOUNT < (150 * POWER(10,6))  THEN '< 150M'
			  WHEN LOAN_AMOUNT < (200 * POWER(10,6))  THEN '< 200M' END AS DISB_SEGMENT
FROM RISK_PORTFOLIO..DIM_CUSTOMER_PROFILE


--VÍ DỤ 2

SELECT 
       LOAN_ACCOUNT_NUMBER
	  ,INCOME
	  ,CASE WHEN INCOME < (10 * POWER(10,6))  THEN '< 10M'
	        WHEN INCOME < (50 * POWER(10,6))  THEN '< 50M'
			WHEN INCOME < (100 * POWER(10,6)) THEN '< 100M'
			WHEN INCOME < (200 * POWER(10,6)) THEN '< 200M'
			WHEN INCOME < (300 * POWER(10,6)) THEN '< 300M' END AS INCOME_SEGMENT
FROM RISK_PORTFOLIO..DIM_CUSTOMER_PROFILE


--VÍ DỤ 3


SELECT 
       LOAN_ACCOUNT_NUMBER
	  ,TENOR 
	  ,LOAN_AMOUNT
	  ,CASE WHEN TENOR < 24 THEN '< 24 - TENOR'
	        WHEN TENOR < 36 THEN '< 36 - TENOR'
			WHEN TENOR < 48 THEN '< 48 - TENOR' END TENOR_SEGMENT 
FROM RISK_PORTFOLIO..DIM_CUSTOMER_PROFILE


--TẤT CẢ CÁC BÀI BÊN DƯỚI ĐỚI VỚI BẢNG FACT_LOAN_MANAGEMENT VÀ FACT_LOAN_COLLECTION CHỐT VỀ THÁNG BÁO CÁO LÀ 2023-12-31

-- Bài 1: Phân tích chất lượng giải ngân theo vùng từ bảng DIM_CUSTOMER_PROFILE
-- Yêu cầu: Thống kê số lượng khoản vay, tổng giải ngân, lãi suất trung bình, và số lượng khoản vay có bảng lương ngân hàng theo từng vùng
--AGGREGATE FUNCTION

-- Bài 2: Phân tích khoản vay theo độ tuổi từ bảng DIM_CUSTOMER_PROFILE 
-- Yêu cầu: Phân nhóm khách hàng theo độ tuổi và thống kê phân nhóm thu nhập, tổng số tiền vay, lãi suất trung bình


/*
  Sử dụng bảng RISK_PORTFOLIO..FACT_LOAN_MANAGEMENT --> CHỐT VỀ "WHERE REPORT_DATE = '2023-12-31'"
  Bài 3: Tổng dư nợ (OUTSTANDING ~ PRINCIPAL AMOUNT ~ ENR (ENDING NET RECEIVABLE)) 
       , Tổng nợ xấu (OUTSTANDING với DPD > 90), Ticket Size (SUM(LOAN_AMOUNT) / COUNT(LOAN_ACCOUNT_NO))
	   , Tổng số tiền WO (OUTSTANDING với DPD > 180), Tổng khoản vay (LOAN_ACCOUNT_NO) 
	   , Tổng khoản vay bị nợ xấu (Những LOAN_ACCOUNT_NO có DPD > 90) 
	   , Tổng khoản vay bị WO (DPD > 180) 
	   
*/

