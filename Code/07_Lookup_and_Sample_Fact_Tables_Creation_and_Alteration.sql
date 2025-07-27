CREATE TABLE DateLookup(
[Day] INT  ,
[DateID] Date  
);
CREATE TABLE Productlookup(
[ProductName] VARCHAR(50),
[ProductID] INT NOT NULL,
[ProductType] varchar(50)
);
CREATE TABLE Supplierlookup(
[SupplierName] VARCHAR(20) NOT NULL ,
[SupplierID] INT NOT NULL
);
CREATE TABLE Outletlookup(
[OutletName] VARCHAR(20) NOT NULL PRIMARY KEY,
[OutletID] INT NOT NULL
);

SELECT * FROM [dbo].[Outletlookup];
SELECT * FROM [dbo].[DateLookup];
SELECT * FROM [dbo].[Productlookup];
SELECT * FROM [dbo].[Supplierlookup];


SELECT * FROM [dbo].[SampleOfReceivedPurchaseOrdersFACT];
SELECT * FROM [dbo].[SampleofSentPurchaseOrdersFACT];


CREATE TABLE SampleSentPurchaseOrders(
SentOrderID varchar(50) PRIMARY KEY,
ProductID INT,
SKU varchar(50),
SupplierID INT,
SupplierName varchar(100),
OutletName varchar(100),
SentDate DATE,
OrderedQTY INT
);

CREATE TABLE SampleRecievedPurchaseOrders(
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
SKU varchar(50)
);


	SELECT * FROM [dbo].[RecievedPurchaseOrders];
	SELECT * FROM [dbo].[SampleSentPurchaseOrders];
	--with values
	SELECT * FROM [dbo].[SampleOfReceivedPurchaseOrders];
	SELECT * FROM [dbo].[SentPurchaseOrders];

ALTER TABLE [dbo].[SentPurchaseOrders]
ADD ProductID INT,
    DateID DATE,
    SupplierID INT;
                 
ALTER TABLE [dbo].[SampleOfReceivedPurchaseOrders]
ADD ProductID INT,
    DateID DATE,
    SupplierID INT;
 
