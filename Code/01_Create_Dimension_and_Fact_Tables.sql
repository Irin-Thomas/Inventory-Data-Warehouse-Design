Create table dime_Product(
ProductID INT PRIMARY KEY IDENTITY(1,1),
SKU VARCHAR(50),
ProductName VARCHAR(100),
ProductDescription VARCHAR(150),
Condition VARCHAR(50),
ProductType VARCHAR(50),
Brand VARCHAR(50),
);

CREATE TABLE dime_Supplier(
SupplierID INT PRIMARY KEY IDENTITY(1,1),
SupplierName VARCHAR(100),
Phone VARCHAR(20),
Email VARCHAR(50),
FAX VARCHAR(20),
Address VARCHAR (250),
PostCode VARCHAR(20),
City varchar(20),
State Varchar (20),
CountryID VARCHAR(20),
);

CREATE TABLE dime_Date(
DateID Date PRIMARY KEY,
Date DATE,
DayNo INT,
MonthNo INT,
YearNo INT,
QuarterNo INT,
Weekday VARCHAR(10)
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


CREATE TABLE Fact_RecievedPurchaseOrders(
PurchaseOrderID INT PRIMARY KEY,
ProductID INT,
SupplierID INT,
DestinationOutletID INT,
SentDate DATE,
RecievedDate DATE,
RecievedQTY INT,
OrderedQTY INT,
FOREIGN KEY (ProductID) REFERENCES dime_Product(ProductID),
FOREIGN KEY (SupplierID) REFERENCES dime_Supplier(SupplierID),
FOREIGN KEY (DestinationOutletID) REFERENCES dime_Outlet(OutletID),
FOREIGN KEY (SentDate) REFERENCES dime_Date(DateID),
FOREIGN KEY (RecievedDate) REFERENCES dime_Date(DateID),
);

CREATE TABLE Fact_SentPurchaseOrders(
SentOrderID INT PRIMARY KEY,
ProductID INT,
SupplierID INT,
DestinationOutletID INT,
SentDate DATE,
OrderedQTY INT,
FOREIGN KEY (ProductID) REFERENCES dime_Product(ProductID),
FOREIGN KEY (SupplierID) REFERENCES dime_Supplier(SupplierID),
FOREIGN KEY (SentDate) REFERENCES dime_Date(DateID),
FOREIGN KEY (DestinationOutletID) REFERENCES dime_Outlet(OutletID)
);

CREATE TABLE Fact_Inventory(
InventoryID INT PRIMARY KEY,
ProductID INT,
CurrentStockLevel INT,
CostPrice DECIMAL(10, 2),
RetailPrice DECIMAL(10, 2),
DateCreatedAt Date,
IsActive BIT,
FOREIGN KEY (ProductID) REFERENCES dime_Product(ProductID),
FOREIGN KEY (DateCreatedAt) REFERENCES dime_Date(DateID)
);

