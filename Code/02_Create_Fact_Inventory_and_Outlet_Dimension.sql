SELECT * FROM [dbo].[product_dime];
SELECT * FROM [dbo].[Date_dime];
SELECT * FROM [dbo].[Supplier_dime];
SELECT * FROM [dbo].[Fact_SentOrderPurchased];
SELECT * FROM [dbo].[Fact_RecivedOrderPurchased];

CREATE TABLE Fact_Inventory(
InventoryID INT PRIMARY KEY IDENTITY(1,1), 
ProductID INT,
CurrentStockLevel INT,
CostPrice DECIMAL(10, 2),
RetailPrice DECIMAL(10, 2),
DateCreatedAt Date,
IsActive BIT,
);

ALTER TABLE [dbo].[product_dime]
ADD productID INT PRIMARY KEY IDENTITY(1,1);


INSERT INTO [dbo].[Fact_Inventory] ([ProductID],[CurrentStockLevel] , [CostPrice], [RetailPrice], [DateCreatedAt], [IsActive])
SELECT 
    [productID],
    [CurrentStockLevel],  
    [CostPrice],                
    [RetailPrice],               
    [DateCreatedAt],  
    [IsActive]              
FROM 
    [dbo].[product_dime]
WHERE 
    [CostPrice] IS NOT NULL AND [RetailPrice] IS NOT NULL;  -

	SELECT * FROM [dbo].[Fact_Inventory];


CREATE TABLE Outlet_dime(
OutletID INT PRIMARY KEY IDENTITY(1,1), 
OutletName NVARCHAR(255) NOT NULL,
OutletAddress VARCHAR(250),
OutletCity VARCHAR(50),
OutletState VARCHAR(50),
OutletCountry VARCHAR(50),
OutletPostcode VARCHAR(20)
);

INSERT INTO [dbo].[Outlet_dime]([OutletName])
SELECT DISTINCT [DestinationOutlet]
FROM [dbo].[Fact_SentOrderPurchased]
WHERE [DestinationOutlet] IS NOT NULL  -- Exclude NULL values
AND [DestinationOutlet] NOT IN (SELECT [OutletName] FROM [dbo].[Outlet_dime]);  - 

Select * From [dbo].[Outlet_dime];

