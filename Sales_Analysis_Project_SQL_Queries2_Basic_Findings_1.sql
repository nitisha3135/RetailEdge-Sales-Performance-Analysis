-- Total sales per product

CREATE TABLE ProductTotalSales AS
SELECT P.ProductName, SUM(S.QuantitySold * P.Price) AS TotalSales
FROM Sales S
JOIN Products P On S.ProductID = P.ProductID
GROUP BY P.ProductName;

COPY ProductTotalSales TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_1_Result_Total_Sales_Per_Product' WITH CSV HEADER;


-- Total sales by region

CREATE TABLE ProductRegionSales AS
SELECT SP.Region, SUM(S.QuantitySold * P.Price) As RegionSales
FROM Sales S
JOIN Salespersons SP ON S.SalespersonID = SP.SalespersonID
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY SP.Region;

COPY ProductRegionSales TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_2_Result_Total_Sales_By_Region' WITH CSV HEADER;


-- Average sales per salesperson
CREATE TABLE AverageSalesPerPerson AS
SELECT SP.SalespersonName, AVG(S.QuantitySold * P.Price) AS AvgSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Salespersons SP ON S.SalespersonID = SP.SalespersonID
GROUP BY SP.SalespersonName;

COPY AverageSalesPerPerson TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_3_Average_Sales_Per_Salesperson' WITH CSV HEADER;


-- Top 5 products by total revenue
CREATE TABLE Top5Product AS
SELECT P.ProductName, SUM(S.QuantitySold * P.Price) AS Revenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY Revenue DESC
LIMIT 5;

COPY Top5Product TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_4_Top_5_Products' WITH CSV HEADER;


-- Sales by product category
CREATE TABLE SalesByProductCategory AS
SELECT P.Category, SUM(S.QuantitySold * P.Price) AS CategorySales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category
ORDER BY CategorySales DESC;

COPY SalesByProductCategory TO 'D:\Data Analytics Projects\Sales Analysis Project\Query_5_Sales_By_Product_Category' WITH CSV HEADER;


