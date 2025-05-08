
USE RISK_PORTFOLIO

--CHỈ SỬ DỤNG BẢNG DỮ LIỆU: [RISK_PORTFOLIO]..[DIM_CUSTOMER_PROFILE]


--1. Tìm khách hàng có khoản vay trên 200 triệu

--2. Tìm khách hàng có thu nhập trên 100 triệu và là nhân viên văn phòng (cột collar worker).

--3. Tìm khách hàng có DTI dưới 30% và thu nhập trên 50 triệu (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)

--4. Tìm khách hàng có khoản vay từ 100-200 triệu ở miền Nam

--5. Tìm khách hàng có lãi suất trên 40% và thời hạn trên 24 tháng

--6. Tìm khách hàng có thu nhập dưới 15 triệu và khoản vay dưới 100 triệu

--7. Tìm khách hàng có trình độ đại học và thu nhập trên 30 triệu

--8. Tìm khách hàng nam ở Hồ Chí Minh có khoản vay trên 300 triệu

--9. Tìm khách hàng có sản phẩm VAY_PLUS và thời hạn 36 tháng

--10. Tìm khách hàng có ngày giải ngân trong tháng 6/2023

--11. Tìm khách hàng có thu nhập từ kinh doanh và DTI trên 40% (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)

--12. Tìm khách hàng có địa chỉ ở đường Nguyễn Huệ

--13. Tìm khách hàng có lãi suất từ 25%-30% và là nữ

--14. Tìm khách hàng có sản phẩm B-BROWN và thu nhập trên 40 triệu

--15. Tìm khách hàng có ngày thanh toán đầu tiên trong tháng 7/2023 (ngày thanh toán đầu tiên: FIRST_PAYMENT_DATE)

--16. Tìm khách hàng có thu nhập từ lương và khoản vay trên 150 triệu

--17. Tìm khách hàng có thời hạn vay 12 tháng và lãi suất dưới 30% (Nhớ kiểm tra kỹ cột dữ liệu đã đổi ra % hoặc chưa đổi ra % để áp dụng điều kiện cho đúng)

--18. Tìm khách hàng có thu nhập trên 70 triệu ở miền Trung

--19. Tìm khách hàng có khoản vay dưới 50 triệu và DTI dưới 20% (cột DTI được hiểu là DEBT AMOUNT ~ DTI = DEBT AMOUNT / INCOME)

--20. Tìm khách hàng có tên họ Nguyễn và thu nhập trên 60 triệu

--21. Tìm khách hàng có sản phẩm INSURANCE và thời hạn trên 24 tháng

--22. Tìm khách hàng giới tính Nam có thu nhập trên 80 triệu ở Hà Nội

--23. Tìm khách hàng có ngày giải ngân trong quý 1/2023

--24. Tìm khách hàng có khoản vay từ 200-300 triệu và lãi suất dưới 35% (Nhớ kiểm tra kỹ cột dữ liệu đã đổi ra % hoặc chưa đổi ra % để áp dụng điều kiện cho đúng)

--25. Tìm khách hàng có địa chỉ ở đường Lê Lợi và khoản vay trên 100 triệu

--26. Tìm khách hàng có thu nhập từ kinh doanh và khoản vay dưới 80 triệu

--27. Tìm khách hàng có lãi suất trên 45% và thu nhập dưới 25 triệu

--28. Tìm khách hàng nữ có khoản vay từ 150-250 triệu ở miền Nam

