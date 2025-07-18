CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50),
	Category VARCHAR(50),
	Price DECIMAL
);

CREATE TABLE Salespersons(
    SalespersonID INT PRIMARY KEY,
	SalespersonName VARCHAR(50),
	Region VARCHAR(50)
);

CREATE TABLE Sales(
    SaleID INT PRIMARY KEY,
	ProductID INT,
	QuantitySold INT,
	SaleDate DATE,
	SalespersonID INT,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID)
);


COPY Products FROM 'D:\Data Analytics Projects\Sales Analyis Project\products.csv' DELIMITER ',' CSV HEADER;


COPY Salespersons FROM 'D:\Data Analytics Projects\Sales Analyis Project\salespersons.csv' DELIMITER ',' CSV HEADER;


COPY Sales FROM 'D:\Data Analytics Projects\Sales Analyis Project\sales.csv' DELIMITER ',' CSV HEADER;


SELECT * FROM Products;


SELECT * FROM Salespersons;


SELECT * FROM Sales;


