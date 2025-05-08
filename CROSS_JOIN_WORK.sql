


----------------------------------------------------DƯ NỢ TÍN DỤNG----------------------------------------------------

-- Create table

IF OBJECT_ID ('[RISK_PORTFOLIO].[dbo].[ENR]','U') IS NOT NULL DROP TABLE [RISK_PORTFOLIO].[dbo].[ENR]


CREATE TABLE [RISK_PORTFOLIO].[dbo].[ENR]  (
														    BALANCE_DATE DATE,
														    POS_EOM DECIMAL(18,2)
														)

-- Insert data
INSERT INTO [RISK_PORTFOLIO].[dbo].[ENR] (BALANCE_DATE, POS_EOM)
VALUES 
    ('2024-01-31', 315245678912345.67),
    ('2024-02-29', 328976543210987.89),
    ('2024-03-31', 337654321098765.43),
    ('2024-04-30', 345678912345678.90),
    ('2024-05-31', 356789123456789.12),
    ('2024-06-30', 367891234567890.23),
    ('2024-07-31', 378912345678901.34),
    ('2024-08-31', 383123456789012.45),
    ('2024-09-30', 389234567890123.56),
    ('2024-10-31', 392345678901234.67),
    ('2024-11-30', 396456789012345.78),
    ('2024-12-31', 399567890123456.89);



----------------------------------------------------TỶ LỆ CẤP TÍN DỤNG----------------------------------------------------

-- Create table

IF OBJECT_ID ('[RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT]','U') IS NOT NULL DROP TABLE [RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT]

CREATE TABLE [RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT] (
    [DESCRIPTION] NVARCHAR(255),
    CREDIT_LIMIT DECIMAL(5,2)
);

/*
RAND(): Đây là hàm tích hợp sẵn trong SQL, trả về một số thập phân ngẫu nhiên nằm trong khoảng từ 0.0 đến 1.0.

RAND() * (5): Nhân giá trị ngẫu nhiên (từ 0.0 đến 1.0) với 5, kết quả sẽ nằm trong khoảng từ 0.0 đến 5.0.

+ 1: Thêm 1 vào giá trị trên, làm cho kết quả cuối cùng nằm trong khoảng từ 1.0 đến 6.0.

*/




-- Insert data with random credit limits
INSERT INTO [RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT] ([DESCRIPTION], CREDIT_LIMIT)
VALUES 
    (N'1.Tỷ lệ nợ xấu (gồm cho vay và thẻ tín dụng)', ROUND(RAND() * (5) + 1, 2)),
    (N'2.Tỷ lệ cấp tín dụng xấu Bad debt ratio', ROUND(RAND() * (2.99), 2)),
    (N'3.Tỷ lệ tăng BC - Tăng trưởng tín dụng/Credit growth', ROUND(RAND() * (15) + 5, 2)),
    (N'4.Tỷ lệ mức dư nợ cấp tín dụng đối với một khách hàng', ROUND(RAND() * (20) + 5, 2)),
    (N'5.Tỷ lệ dư nợ cấp tín dụng đối với một khách hàng và người có liên quan', ROUND(RAND() * (25) + 5, 2)),
    (N'6.Tỷ lệ cấp tín dụng để đầu tư, kinh doanh cổ phiếu', ROUND(RAND() * (15) + 5, 2)),
    (N'7.Tỷ lệ cấp tín dụng để đầu tư, kinh doanh trái phiếu doanh nghiệp', ROUND(RAND() * (15) + 5, 2)),
    (N'8.Tỷ lệ dư nợ cấp tín dụng đối với một công ty con, công ty liên kết', ROUND(RAND() * (20) + 5, 2)),
    (N'9.Tỷ lệ dư nợ cấp tín dụng đối với tất cả các công ty con, công ty liên kết', ROUND(RAND() * (25) + 5, 2)),
    (N'10.Tỷ lệ dư nợ cấp tín dụng đối với các đối tượng hạn chế cấp tín dụng', ROUND(RAND() * (15) + 5, 2)),
    (N'11.Tỷ lệ giới hạn trong cho vay lĩnh vực bất động sản, xây dựng', ROUND(RAND() * (20) + 5, 2)),
    (N'12.Tỷ lệ lĩnh vực bất động sản Total real estate lendings', ROUND(RAND() * (20) + 5, 2)),
    (N'13.Tỷ lệ cho vay mua nhà/ Mortgages', ROUND(RAND() * (20) + 5, 2)),
    (N'14.Tỷ lệ dư nợ cho vay kinh doanh bất động sản', ROUND(RAND() * (20) + 5, 2)),
    (N'15.Tỷ lệ dư nợ cho vay doanh nghiệp ngành xây dựng', ROUND(RAND() * (20) + 5, 2)),
    (N'16.Tỷ lệ cho vay tài trợ thi công xây lắp', ROUND(RAND() * (20) + 5, 2)),
    (N'17.Tỷ lệ cho vay lĩnh vực BOT, BT Total BOT and BT project financing', ROUND(RAND() * (20) + 5, 2)),
    (N'18.Tỷ lệ vay ngành thép Total lendings in steel industry', ROUND(RAND() * (20) + 5, 2)),
    (N'19.Tỷ lệ vay ngành dệt may, da giày Total lendings in textile and footwear industry', ROUND(RAND() * (20) + 5, 2)),
    (N'20.Tỷ lệ vay ngành gỗ Total lendings in wood industry', ROUND(RAND() * (20) + 5, 2)),
    (N'21.Tỷ lệ cho vay cho vay sản phẩm thẻ chấp lô hàng', ROUND(RAND() * (20) + 5, 2)),
    (N'22.Tỷ lệ tài sản đảm bảo đất nông nghiệp', ROUND(RAND() * (20) + 5, 2)),
    (N'23.Tỷ lệ tài sản đảm bảo đất nông nghiệp đơn lẻ', ROUND(RAND() * (20) + 5, 2)),
    (N'24.Tỷ lệ Giới hạn cho vay tín chấp đối với KHCN', ROUND(RAND() * (15) + 5, 2)),
    (N'25.Tỷ lệ giới hạn cho vay tín chấp đối với KHDN', ROUND(RAND() * (15) + 5, 2)),
    (N'26.Tỷ lệ dư nợ giới hạn cho vay Đặt Thương Mại KV Hà Nội', ROUND(RAND() * (20) + 5, 2));


-----------------------------------------CÁCH SỬ DỤNG CROSS JOIN--------------------------------------------

SELECT
        X1.BALANCE_DATE
	   ,X2.[DESCRIPTION]
	   --,X1.POS_EOM
	   --,X2.CREDIT_LIMIT
	   ,X1.POS_EOM * X2.CREDIT_LIMIT AS CREDIT_LIMIT_PER_ITEM
FROM [RISK_PORTFOLIO].[dbo].[ENR] X1
CROSS JOIN [RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT] X2
ORDER BY X1.BALANCE_DATE

GO 


SELECT 
        [DESCRIPTION]
FROM [RISK_PORTFOLIO].[dbo].[CREDIT_LIMIT]
ORDER BY CAST(LEFT([DESCRIPTION],CHARINDEX('.',[DESCRIPTION])-1) AS INT)

