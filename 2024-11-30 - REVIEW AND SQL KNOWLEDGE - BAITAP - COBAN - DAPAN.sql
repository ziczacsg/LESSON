
USE RISK_PORTFOLIO

--CHỈ SỬ DỤNG BẢNG DỮ LIỆU: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]


--1. Tìm khách hàng có khoản vay trên 200 triệu

--LOAN_AMOUNT: DISBURSED_AMOUNT (KHOẢN GIẢI NGÂN) 

SELECT
       *
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE LOAN_AMOUNT > 200 * POWER(10,6)

--2. Tìm khách hàng có thu nhập trên 100 triệu và là nhân viên văn phòng (cột collar worker).


SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,INCOME
	  ,OCCUPATION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE INCOME > 100 * POWER(10,6) AND OCCUPATION LIKE '%Collar%' --TRONG SQL PHÂN BIỆT CHỮ IN HOA VÀ CHỮ THƯỜNG 

--3. Tìm khách hàng có DTI dưới 30% và thu nhập trên 50 triệu (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)

--DTI: DEBT TO INCOME --> TỶ LỆ NỢ TRÊN THU NHẬP 
--LTV: LOAN TO VALUE  --> VÍ DỤ - GIÁ TRỊ ĐỊNH GIÁ CĂN NHÀ LÀ 2 TỶ / TRÊN GIÁ BÁN LÀ 2 TỶ 4 --> CHO VAY MAX 70% TRÊN GIÁ TRỊ ĐỊNH GIÁ LÀ 2 TỶ

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,DTI          AS DEBT_AMT 
	   ,DTI / INCOME AS DTI
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE (DTI / INCOME) < 0.3 AND INCOME > 50 * POWER(10,6)

--4. Tìm khách hàng có khoản vay từ 100-200 triệu ở miền Nam


SELECT
       LOAN_ACCOUNT_NUMBER
	  ,LOAN_AMOUNT
	  ,REGION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND LOAN_AMOUNT BETWEEN (100 * POWER(10,6)) AND (200 * POWER(10,6)) -- >= AND <= 
	  AND REGION = 'South'

--5. Tìm khách hàng có lãi suất trên 40% và thời hạn trên 24 tháng

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,INTEREST_RATE
	  ,TENOR
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND INTEREST_RATE > 40
	  AND TENOR > 24
ORDER BY INTEREST_RATE

--6. Tìm khách hàng có thu nhập dưới 15 triệu và khoản vay dưới 100 triệu

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,LOAN_AMOUNT
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND LOAN_AMOUNT < 100 * POWER(10,6) --khoản vay dưới 100 triệu
	  AND INCOME < 15 * POWER(10,6) --thu nhập dưới 15 triệu

--7. Tìm khách hàng có trình độ đại học và thu nhập trên 30 triệu

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,EDUCATION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND EDUCATION LIKE '%Univer%' --có trình độ đại học 
	  AND INCOME > 30 * POWER(10,6) --thu nhập trên 30 triệu

--8. Tìm khách hàng nam ở Hồ Chí Minh có khoản vay trên 300 triệu

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,LOAN_AMOUNT
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND LOAN_AMOUNT > 100 * POWER(10,6) --khoản vay trên 300 triệu
	  AND GENDER = 'Nam' --khách hàng nam
	  AND PROVINCE LIKE N'Hồ Chí Minh'

--9. Tìm khách hàng có sản phẩm VAY_PLUS và thời hạn 36 tháng

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,TENOR
	   ,PRODUCT_NAME
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND PRODUCT_NAME LIKE '%VAY%PLUS%'
	  AND TENOR = 36

--10. Tìm khách hàng có ngày giải ngân trong tháng 6/2023

--CÁCH 1

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,CAST(DISBURSEMENT_DATE AS DATE)           AS DISBURSEMENT_DATE --CHUYỂN YYYY-MM-DD hh:mm:ss thành YYYY-MM-DD
	   ,CONVERT(NVARCHAR(7),DISBURSEMENT_DATE,23) AS DISB_PERIOD --CHUYỂN YYYY-MM-DD hh:mm:ss thành YYYY-MM
	   ,FORMAT(DISBURSEMENT_DATE,'yyyy-MM')       AS DISB_PERIOD_FORMAT  --CHUYỂN YYYY-MM-DD hh:mm:ss thành YYYY-MM
	   ,LOAN_AMOUNT
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE CONVERT(NVARCHAR(7),DISBURSEMENT_DATE,23) = '2023-06'

--2023-06-30

--23: LẤY ĐỊNH DẠNG YYYY-MM-DD 
--NVARCHAR(7): LẤY 7 KÝ TỰ TỪ TRÁI QUA PHẢI 


--11. Tìm khách hàng có thu nhập từ kinh doanh và DTI trên 40% (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)


SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME_TYPE
	   ,DTI          AS DEBT_AMT 
	   ,DTI / INCOME AS DTI
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND (DTI / INCOME) > 0.4  --DTI trên 40%
	  AND INCOME_TYPE LIKE '%Business%' --thu nhập từ kinh doanh

--12. Tìm khách hàng có địa chỉ ở đường Nguyễn Huệ

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,[ADDRESS] 
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE [ADDRESS] LIKE '%Nguy_n%Hu_%'


--13. Tìm khách hàng có lãi suất từ 25%-30% và là nữ

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,INTEREST_RATE
	  ,GENDER
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND INTEREST_RATE BETWEEN 25 AND 30 --lãi suất từ 25%-30%
	  AND GENDER = N'Nữ'


--14. Tìm khách hàng có sản phẩm B-BROWN và thu nhập trên 40 triệu

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,PRODUCT_NAME
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND PRODUCT_NAME LIKE '%B%BROWN%' --sản phẩm B-BROWN
	  AND INCOME > 40 * POWER(10,6) --thu nhập trên 40 triệu

--15. Tìm khách hàng có ngày thanh toán đầu tiên trong tháng 7/2023 (ngày thanh toán đầu tiên: FIRST_PAYMENT_DATE)

SELECT  TOP 1
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,FIRST_PAYMENT_DATE
	   ,LOAN_AMOUNT
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND CONVERT(NVARCHAR(7),FIRST_PAYMENT_DATE,23) = '2023-07' --tháng 7/2023
ORDER BY FIRST_PAYMENT_DATE ASC 

--16. Tìm khách hàng có thu nhập từ lương và khoản vay trên 150 triệu
SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME_TYPE
	   ,LOAN_AMOUNT
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND LOAN_AMOUNT > 150 * POWER(10,6) --khoản vay trên 150 triệu
	  AND INCOME_TYPE IN ('Bank Statement','Payslip') --thu nhập từ lương

--SELECT DISTINCT INCOME_TYPE FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]

--17. Tìm khách hàng có thời hạn vay 12 tháng và lãi suất dưới 30% (Nhớ kiểm tra kỹ cột dữ liệu đã đổi ra % hoặc chưa đổi ra % để áp dụng điều kiện cho đúng)

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INTEREST_RATE
	   ,TENOR
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND TENOR = 12 --khách hàng có thời hạn vay 12 tháng 
	  AND INTEREST_RATE < 30 --lãi suất dưới 30%


--18. Tìm khách hàng có thu nhập trên 70 triệu ở miền Trung

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
	   ,REGION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND INCOME > 70 * POWER(10,6) --thu nhập trên 70 triệu
	  AND REGION = 'CENTRAL' --ở miền Trung

--19. Tìm khách hàng có khoản vay dưới 50 triệu và DTI dưới 20% (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)


SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,LOAN_AMOUNT
	   ,DTI AS DEBT_AMOUNT 
	   ,DTI / INCOME AS DTI 
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND LOAN_AMOUNT < 50 * POWER(10,6) --khoản vay dưới 50 triệu
	  AND (DTI / INCOME) < 0.2 --DTI dưới 20%

--20. Tìm khách hàng có tên họ Nguyễn và thu nhập trên 60 triệu

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,INCOME
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND CUSTOMER_NAME LIKE 'Nguy_n%' --khách hàng có tên họ Nguyễn
	  AND INCOME > 60 * POWER(10,6) --thu nhập trên 60 triệu

--21. Tìm khách hàng có sản phẩm INSURANCE và thời hạn trên 24 tháng

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,TENOR
	   ,PRODUCT_NAME
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
      AND PRODUCT_NAME LIKE '%INSURANCE%' --khách hàng có sản phẩm INSURANCE
	  AND TENOR > 24 --thời hạn trên 24 tháng

--22. Tìm khách hàng giới tính Nam có thu nhập trên 80 triệu ở Hà Nội

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,GENDER
	   ,INCOME
	   ,REGION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
	  AND GENDER = 'Nam' --giới tính Nam
      AND INCOME > 80 * POWER(10,6) --thu nhập trên 80 triệu
	  AND PROVINCE = N'Hà Nội' --ở Hà Nội

--23. Tìm khách hàng có ngày giải ngân trong quý 1/2023

SELECT
        LOAN_ACCOUNT_NUMBER
	   ,CUSTOMER_NAME
	   ,DISBURSEMENT_DATE
	   ,CONCAT(N'Qúy',' ',DATEPART(QUARTER,DISBURSEMENT_DATE),'/',YEAR(DISBURSEMENT_DATE)) AS [QUÝ]
	   ,CONCAT(N'Dữ liệu thay đổi theo tháng, cần lưu ý',' - ',YEAR(DISBURSEMENT_DATE)) AS [NOTE]
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1 
	  AND DATEPART(QUARTER,DISBURSEMENT_DATE) = 1 --quý 1
	  AND YEAR(DISBURSEMENT_DATE) = 2023 --ngày giải ngân trong quý 1/2023

--24. Tìm khách hàng có khoản vay từ 200-300 triệu và lãi suất dưới 35% (Nhớ kiểm tra kỹ cột dữ liệu đã đổi ra % hoặc chưa đổi ra % để áp dụng điều kiện cho đúng)

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,LOAN_AMOUNT
	  ,INTEREST_RATE
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND LOAN_AMOUNT BETWEEN (50 * POWER(10,6)) AND (100 * POWER(10,6)) --khách hàng có khoản vay từ 200-300 triệu
     --DO BÊN TRONG DỮ LIỆU KHOẢN VAY MAXIMUM CHỈ CÓ 198TR NÊN OLIVER CÓ YÊU CẦU MN ĐỔI TỪ 50TR - 100TR ĐỂ TEST KẾT QUẢ ĐÚNG HOẶC SAI 
	  AND INTEREST_RATE < 35 --lãi suất dưới 35%

--25. Tìm khách hàng có địa chỉ ở đường Lê Lợi và khoản vay trên 100 triệu

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,LOAN_AMOUNT
	  ,[ADDRESS]
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND LOAN_AMOUNT > (100 * POWER(10,6)) --khoản vay trên 100 triệu
	  AND [ADDRESS] LIKE '%L_%L_i%'

--26. Tìm khách hàng có thu nhập từ kinh doanh và khoản vay dưới 80 triệu

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,LOAN_AMOUNT
	  ,INCOME_TYPE
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND INCOME_TYPE LIKE '%Business%'
	  AND LOAN_AMOUNT < (80 * POWER(10,6)) --khoản vay dưới 80 triệu


--27. Tìm khách hàng có lãi suất trên 45% và thu nhập dưới 25 triệu

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,INCOME
	  ,INTEREST_RATE
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND INTEREST_RATE > 45 --lãi suất trên 45%
	  AND INCOME < (25 * POWER(10,6)) --thu nhập dưới 25 triệu

--28. Tìm khách hàng nữ có khoản vay từ 150-250 triệu ở miền Nam

SELECT
       LOAN_ACCOUNT_NUMBER
	  ,CUSTOMER_NAME
	  ,INCOME
	  ,GENDER
	  ,REGION
FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]
WHERE 1=1
      AND GENDER = N'Nữ' --khách hàng nữ
      AND LOAN_AMOUNT BETWEEN (150 * POWER(10,6)) AND (250 * POWER(10,6)) --khoản vay từ 150-250 triệu
	  AND REGION = 'South'



