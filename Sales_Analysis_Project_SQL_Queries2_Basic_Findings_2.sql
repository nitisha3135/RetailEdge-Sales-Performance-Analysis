-- Monthly Sales Trend
CREATE TABLE MonthlySalesTrend AS
SELECT TO_CHAR(SaleDate, 'YYYY-MM') AS Month,
SUM(S.QuantitySold * P.Price) AS MonthlySales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY Month
ORDER BY Month;

COPY MonthlySalesTrend TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_6_Result_Monthly_Sales_Trend' WITH CSV HEADER; 


-- Top 5 Salespersons By Revenue
CREATE TABLE Top5Salespersons AS
SELECT SP.SalespersonName, SUM(S.QuantitySold * P.Price) AS Revenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Salespersons SP ON S.SalespersonID = SP.SalespersonID
GROUP BY SP.SalespersonName
ORDER BY Revenue DESC
LIMIT 5;

COPY Top5Salespersons TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_7_Result_Top_5_Salesperson_By_Revenue' WITH CSV HEADER;


-- Best-Selling Product in Each Category
CREATE TABLE BestSellingProducts AS
SELECT P.Category, P.ProductName, SUM(S.QuantitySold) AS TotalQuantity
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category, P.ProductName
HAVING SUM(S.QuantitySold) = (
    SELECT MAX(total_quantity)
    FROM (
        SELECT P2.Category, SUM(S2.QuantitySold) AS total_quantity
        FROM Sales S2
        JOIN Products P2 ON S2.ProductID = P2.ProductID
        WHERE P2.Category = P.Category
        GROUP BY P2.ProductName, P2.Category
    ) AS category_totals
)
ORDER BY P.Category;

COPY BestSellingProducts TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_8_Result_Best_Selling_Products_In_Each_Category' WITH CSV HEADER;


--Sales Distribution by Quantity Buckets
CREATE TABLE DistributionByQuantityBuckets AS
SELECT 
    CASE
        WHEN QuantitySold BETWEEN 1 AND 3 THEN 'Low (1-3)'
		WHEN QuantitySold BETWEEN 4 AND 6 THEN 'Medium (4-6)'
		ELSE 'High (7-9)'
	END AS QuantityRange,
	COUNT(*) AS NumOfSales
FROM Sales
GROUP BY QuantityRange;

COPY DistributionByQuantityBuckets TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_9_Result_Distribution_by_Quantity_Buckets' WITH CSV HEADER;


-- Yearly Sales Comparison
CREATE TABLE YearlySalesComparison AS
SELECT
    TO_CHAR(SaleDate, 'YYYY') AS Year,
	SUM(QuantitySold * Price) AS TotalSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY Year
ORDER BY Year;

COPY YearlySalesComparison TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_10_Result_Yearly_Sales_Comparison' WITH CSV HEADER;
