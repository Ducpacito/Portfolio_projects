Tableau dashboard: https://public.tableau.com/views/Onlineretailsales/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link

link to the dataset used for this project: https://www.kaggle.com/tunguz/online-retail 

-- Queries used for Tableau Project --

--standardize InvoiceDate Format
SELECT
InvoiceDate, CONVERT(date,InvoiceDate)
FROM
Online_Retail

UPDATE Online_Retail
SET InvoiceDate = CONVERT(date,InvoiceDate)

-- remove faulty orders
DELETE FROM Online_Retail
WHERE Description IS NULL

SELECT
TRIM(description)
FROM Online_Retail

UPDATE Online_Retail
SET Description = TRIM(description)

-- add TotalAmount column
ALTER TABLE Online_retail
ADD TotalAmount money

Update Online_Retail
SET TotalAmount = Quantity*UnitPrice

-- Total revenue per product

WITH rev 
AS
(
SELECT
		StockCode,
		SUM(totalamount) AS TotalRevenue
	FROM Online_Retail
	GROUP BY StockCode
		)
SELECT DISTINCT(ret.Description), rev.StockCode, rev.TotalRevenue
FROM rev JOIN Online_Retail ret
	ON rev.StockCode = ret.StockCode
	ORDER BY 3 DESC,2
