
USE RISK_PORTFOLIO 
/*
    Chỉ sử dụng 2 bảng dữ liệu [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] và [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] 
	để thực hiện các bài tập theo yêu cầu bên dưới.  
	Lưu ý: Nếu đề bài chỉ yêu cầu lấy "Tỷ lệ quá hạn" thì chỉ lấy 30+ thôi nhé.

*/

--1. Tỷ lệ nợ quá hạn 10+, 30+, 60+, 90+ theo theo 5 DTI_SEGMENT mà Analyst tự phân ra bằng cách dùng CASE WHEN. Phân khúc DTI nào đang có tỷ lệ 10+, 30+, 60+, 90+ cao ?. Lấy DTI_SEGMENT, DEL_POS_10+ đến DEL_POS_90+ (DELINQUENCY POS). Lưu ý chốt REPORT_DATE = '2023-12-31'

--MAX: 1.05463215298396
--MIN: 0.0409957970213776


	SELECT  
			DTI_SEGMENT = CASE WHEN (DTI / INCOME) <= 0.2 THEN 'DTI: 0.2'
			                   WHEN (DTI / INCOME) <= 0.4 THEN 'DTI: 0.4'
							   WHEN (DTI / INCOME) <= 0.6 THEN 'DTI: 0.6'
							   WHEN (DTI / INCOME) <= 0.8 THEN 'DTI: 0.8'
							   WHEN (DTI / INCOME) <= 1.1 THEN 'DTI: 1.1' END 
		   ,[10+]       = SUM(CASE WHEN DPD > 10 AND DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) / SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END)  ---LOẠI NHỮNG KHOẢN VAY CÓ DPD > 180 THEO KIỂU FINTECH / BÊN NGÂN HÀNG THƯƠNG MAI KHÔNG PHÂN LOẠI WO THEO CÁCH NÀY
		   ,[30+]       = SUM(CASE WHEN DPD > 30 AND DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) / SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END)  ---LOẠI NHỮNG KHOẢN VAY CÓ DPD > 180 THEO KIỂU FINTECH / BÊN NGÂN HÀNG THƯƠNG MAI KHÔNG PHÂN LOẠI WO THEO CÁCH NÀY
		   ,[60+]       = SUM(CASE WHEN DPD > 60 AND DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) / SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END)  ---LOẠI NHỮNG KHOẢN VAY CÓ DPD > 180 THEO KIỂU FINTECH / BÊN NGÂN HÀNG THƯƠNG MAI KHÔNG PHÂN LOẠI WO THEO CÁCH NÀY
		   ,[90+]       = SUM(CASE WHEN DPD > 90 AND DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) / SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END)  ---LOẠI NHỮNG KHOẢN VAY CÓ DPD > 180 THEO KIỂU FINTECH / BÊN NGÂN HÀNG THƯƠNG MAI KHÔNG PHÂN LOẠI WO THEO CÁCH NÀY
		   ,[POS]       = SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) 
	FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] X1 
	LEFT JOIN [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] X2 ON X1.LOAN_ACCOUNT_NUMBER = X2.LOAN_ACCOUNT_NUMBER
	WHERE REPORT_DATE = (SELECT MAX(REPORT_DATE) FROM [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT])
	GROUP BY CASE WHEN (DTI / INCOME) <= 0.2 THEN 'DTI: 0.2'
			                   WHEN (DTI / INCOME) <= 0.4 THEN 'DTI: 0.4'
							   WHEN (DTI / INCOME) <= 0.6 THEN 'DTI: 0.6'
							   WHEN (DTI / INCOME) <= 0.8 THEN 'DTI: 0.8'
							   WHEN (DTI / INCOME) <= 1.1 THEN 'DTI: 1.1' END 


--2. Trích xuất ra 5 tỉnh có tỷ lệ nợ xấu cao nhất. Lấy POS, Số khoản vay, Số tiền vay kèm theo. ORDER BY theo tỷ lệ NPL. Lưu ý chốt REPORT_DATE = '2023-12-31'

			SELECT TOP 5
				   X1.PROVINCE 
				  ,[NPL]       = SUM(CASE WHEN X2.DPD > 90 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END) / SUM(X2.OUTSTANDING_AMOUNT) 
				  ,[POS]       = SUM(X2.OUTSTANDING_AMOUNT) 
				  ,[ACCTNO]    = COUNT(X2.LOAN_ACCOUNT_NUMBER)
				  ,[DISB_AMT]  = SUM(X1.LOAN_AMOUNT)
			FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] X1 
			LEFT JOIN [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] X2 ON X1.LOAN_ACCOUNT_NUMBER = X2.LOAN_ACCOUNT_NUMBER
			WHERE REPORT_DATE = (SELECT MAX(REPORT_DATE) FROM [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT])
			GROUP BY X1.PROVINCE
			ORDER BY SUM(CASE WHEN X2.DPD > 90 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END) / SUM(X2.OUTSTANDING_AMOUNT)  DESC 


--3. Trích xuất POS, OD3, WO trong 6 tháng gần nhất theo khu vực. Có phải khu vực có POS lớn nhất thì có OD3 và WO lớn nhất ?. Lưu ý 6 tháng gần nhất điều sử dụng EOMONTH chốt cuối tháng.

--CÁCH 1 

            IF OBJECT_ID ('TEMPDB..[#TEMPDB]','U') IS NOT NULL DROP TABLE [#TEMPDB]

			--ĐẦU TIÊN PHẢI CHỐT DỮ LIỆU VỀ CUỐI THÁNG
            SELECT
				    X1.REGION
				   ,X2.REPORT_DATE
				   ,[POS] = SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) --LẤY THEO KIỂU FINTECH 
				   ,[OD3] = SUM(CASE WHEN DPD > 90 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END) --90+ LÀ NỢ XẤU - OD3: OVERDUE3 LÀ NỢ NHÓM 3
				   ,[WO]  = SUM(CASE WHEN DPD > 180 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END)
			INTO [#TEMPDB]
			FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] X1 
			LEFT JOIN [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] X2 ON X1.LOAN_ACCOUNT_NUMBER = X2.LOAN_ACCOUNT_NUMBER 
			WHERE X2.REPORT_DATE = EOMONTH(X2.REPORT_DATE) 
			GROUP BY X1.REGION,X2.REPORT_DATE


			--SAU KHI CHỐT DỮ LIỆU VỀ CUỐI THÁNG, THÌ MỚI THỰC VIỆC LÙI THỜI ĐIỂM VỀ 6 THÁNG TRƯỚC TRỞ VỀ HIỆN TẠI 

			SELECT
			      REGION
				 ,POS = SUM(POS)
				 ,OD3 = SUM(OD3)
				 ,WO  = SUM(WO)
			FROM [#TEMPDB]
			WHERE REPORT_DATE >= EOMONTH(DATEADD(MONTH,-6,(SELECT MAX(REPORT_DATE) FROM [#TEMPDB])))
			GROUP BY REGION

--CÁCH 2 

SELECT
      	 REGION
		,POS = SUM(POS)
		,OD3 = SUM(OD3)
		,WO  = SUM(WO)
FROM 
         (
            SELECT
				    X1.REGION
				   ,X2.REPORT_DATE
				   ,[POS] = SUM(CASE WHEN DPD <= 180 THEN OUTSTANDING_AMOUNT ELSE 0 END) --LẤY THEO KIỂU FINTECH 
				   ,[OD3] = SUM(CASE WHEN DPD > 90 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END) --90+ LÀ NỢ XẤU - OD3: OVERDUE3 LÀ NỢ NHÓM 3
				   ,[WO]  = SUM(CASE WHEN DPD > 180 THEN X2.OUTSTANDING_AMOUNT ELSE 0 END)
			FROM [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE] X1 
			LEFT JOIN [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT] X2 ON X1.LOAN_ACCOUNT_NUMBER = X2.LOAN_ACCOUNT_NUMBER 
			WHERE X2.REPORT_DATE = EOMONTH(X2.REPORT_DATE)
			GROUP BY X1.REGION,X2.REPORT_DATE
		 ) X 
WHERE X.REPORT_DATE >= EOMONTH(DATEADD(MONTH,-6,(SELECT MAX(REPORT_DATE) FROM [RISK_PORTFOLIO]..[FACT_LOAN_MANAGEMENT])))
GROUP BY X.REGION




--4. Trích xuất ENR theo từng Bucket từ B1 đến B13 theo khu vực. Phân tích tỷ lệ ENR cho từng Bucket theo khu vực và cho nhận xét. Lưu ý lấy dữ liệu 3 tháng gần nhất và chốt cuối tháng.

--5. So sánh giá trị giải ngân tăng/giảm, giá trị ENR tăng/giảm, giá trị NPL tăng giảm của Quý 1 và Quý 2 năm 2023. Lưu ý: Giải ngân theo ngày, thường xuyên thì gather toàn bộ các ngày trong tháng lại, còn ENR là dư nợ chốt theo tháng, cụ thể là cuối tháng (HINT). 

--6. Có phải lãi suất càng cao thì NPL càng cao ? . Sử dụng SQL trích xuất dữ liệu dùng con số để chứng minh cho luận điểm này. Lưu ý chốt dữ liệu cuối tháng của các tháng trong năm 2023

--7. Loại thu nhập nào có tỷ lệ NPL cao và nợ xấu tập trung nhiều nhất vào Quý nào của năm 2023 ? . Lưu ý chốt dữ liệu cuối tháng của các tháng trong năm 2023

--8. Phân khúc kỳ hạn vay nào đang có nhiều khoản vay đăng ký trong 4 quý của năm 2023. Thống kê ra theo segment và giải thích cho luận điểm "Kỳ hạn vay càng ngắn tỷ lệ nợ xấu và quá hạn 30+ càng cao"

--9. Có phải tuổi càng trẻ thì thì tỷ lệ nợ xấu càng nhiều ? Lấy dữ liệu và làm rõ quan điểm này. Analyst tự phân tuổi theo segment, lấy thêm các trường POS, NPL.

--10. So sánh tỷ lệ nợ xấu của 6 tháng gần nhất và 6 tháng đầu năm theo vùng của 2023.









