Create table dime_ProductDm(
ProductID INT PRIMARY KEY IDENTITY(1,1),
SKU VARCHAR(50),
ProductName VARCHAR(100),
ProductDescription VARCHAR(150),
Condition VARCHAR(50),
ProductType VARCHAR(50),
Brand VARCHAR(50),
SupplierName VARCHAR(100),
);

CREATE TABLE dime_SupplierDm(
SupplierID INT PRIMARY KEY IDENTITY(1,1),
SupplierName VARCHAR(100),
Phone INT,
Email VARCHAR(50),
FAX VARCHAR(20),
Address VARCHAR (250),
PostCode VARCHAR(20),
City varchar(20),
State Varchar (20),
CountryID VARCHAR(20),
);

CREATE TABLE dime_DateDm(
DateID Date PRIMARY KEY,
Day INT,
WeekDay varchar(10),
Month varchar(10),
MonthofYear INT,
YearNo INT,
QuarterNo INT,
);

CREATE TABLE dime_Outlet(
OutletID INT PRIMARY KEY IDENTITY(1,1),
OutletName VARCHAR(100),
OutletAddress VARCHAR(250),
OutletCity VARCHAR(50),
OutletState VARCHAR(50),
OutletCountry VARCHAR(50),
OutletPostcode VARCHAR(20)
);


CREATE TABLE Fact_SentPurchaseOrders(
SentOrderID varchar(50) PRIMARY KEY,
ProductID INT,
SKU varchar(50),
SupplierID INT,
SupplierName varchar(100),
OutletName varchar(100),
SentDate DATE,
OrderedQTY INT,
FOREIGN KEY (ProductID) REFERENCES [dbo].[dime_ProductDm]([ProductID]),
FOREIGN KEY (SupplierID) REFERENCES [dbo].[dime_SupplierDm](SupplierID),
FOREIGN KEY (SentDate) REFERENCES [dbo].[dime_DateDm](DateID),
);

CREATE TABLE Fact_RecievedPurchaseOrders(
PurchaseOrderID INT PRIMARY KEY,
ProductID INT,
SupplierID INT,
DateID Date,
OutletName varchar(200) ,
SentDate DATE,
RecievedDate DATE,
RecievedQTY INT,
OrderedQTY INT,
SupplierName Varchar(200),
SKU varchar(50),
FOREIGN KEY (ProductID) REFERENCES [dbo].[dime_ProductDm](ProductID),
FOREIGN KEY (SupplierID) REFERENCES [dbo].[dime_SupplierDm](SupplierID),
FOREIGN KEY (DateID) REFERENCES [dbo].[dime_DateDm](DateID),
);

CREATE TABLE Fact_Inventory(
InventoryID INT PRIMARY KEY,
ProductID INT,
DateID Date,
OutletID INT,
CurrentStockLevel INT,
CostPrice DECIMAL(10, 2),
RetailPrice DECIMAL(10, 2),
DateCreatedAt Date,
IsActive BIT,
FOREIGN KEY (ProductID) REFERENCES [dbo].[dime_ProductDm](ProductID),
FOREIGN KEY (DateID) REFERENCES [dbo].[dime_DateDm](DateID),
FOREIGN KEY(OutletID) REFERENCES [dbo].[dime_Outlet],
);

SELECT* FROM [dbo].[date_dime];

INSERT INTO [dbo].[dime_DateDm] ([DateID], [Day], [WeekDay], [Month], [MonthofYear], [YearNo], [QuarterNo])
SELECT [FullDate], [DayOfYear], [DayNameOfWeek], [MonthName], [MonthOfYear], [CalendarYear], [CalendarQuarter]
FROM [dbo].[date_dime]
WHERE [FullDate] NOT IN (SELECT [DateID] FROM [dbo].[dime_DateDm]);

SELECT* FROM [dbo].[dime_DateDm];
SELECT* FROM [dbo].[product table];

INSERT INTO [dbo].[dime_ProductDm]([SKU], [ProductName], [ProductDescription], [Condition],[ProductType], [Brand], [SupplierName])
SELECT [SKU], [ProductName], [Description], [Condition], [ProductType], [Brand], [SupplierName]
FROM [dbo].[product table]
WHERE [SKU] NOT IN (SELECT [SKU] FROM [dbo].[dime_ProductDm]);

SELECT* FROM [dbo].[dime_ProductDm];

ALTER TABLE [dbo].[dime_SupplierDm]
ALTER COLUMN Phone VARCHAR(15) NULL;
EXEC sp_help '[dbo].[dime_SupplierDm]';
SELECT* FROM [dbo].[suppl];


UPDATE [dbo].[suppl]
SET 
[City] = 'Unknown',
[Phone]= '000 000 000',
[Email]= 'NOT Given',
[Fax] = 'Unavailable',
[FirstLineAddress]= 'NO ADDRESS',
[State]='NOT GIVEN',
[CountryID]='NOT GIVEN'
WHERE 
[City] = 'NULL' OR
    [Phone] = 'NULL' OR
    [Email] = 'NULL' OR
    [Fax] = 'NULL' OR
    [FirstLineAddress] = 'NULL' OR
    [State] = 'NULL' OR
    [CountryID] = 'NULL';

INSERT INTO [dbo].[dime_SupplierDm] ([SupplierName], [Phone], [Email], [FAX], [Address], [PostCode], [City], [State], [CountryID])
SELECT [SupplierName], [Phone], [Email], [Fax], [FirstLineAddress], [PostCode], [City], [State], [CountryID]
FROM [dbo].[suppl]
WHERE [SupplierName] NOT IN (SELECT [SupplierName] FROM [dbo].[dime_SupplierDm]);

SELECT* FROM [dbo].[dime_SupplierDm];

