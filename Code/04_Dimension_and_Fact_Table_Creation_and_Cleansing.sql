SELECT * FROM [dbo].[Productdime];
SELECT * FROM [dbo].[Datedime];
SELECT * FROM [dbo].[Suppliers];
SELECT * FROM [dbo].[SentPurchaseOrders];
SELECT * FROM [dbo].[dboReceivedPurchaseOrders];

CREATE TABLE Fact_Inventory(
InventoryID INT PRIMARY KEY IDENTITY(1,1), 
ProductID INT,
CurrentStockLevel INT,
CostPrice DECIMAL(10, 2),
RetailPrice DECIMAL(10, 2),
DateCreatedAt Date,
IsActive BIT,
);

ALTER TABLE [dbo].[Productdime]
ADD productID INT PRIMARY KEY IDENTITY(1,1);
ALTER TABLE [dbo].[Suppliers]
ADD supplierID INT PRIMARY KEY IDENTITY(1,1);

INSERT INTO [dbo].[Fact_Inventory] ([ProductID],[CurrentStockLevel] , [CostPrice], [RetailPrice], [DateCreatedAt], [IsActive])
SELECT 
    [productID],
    [CurrentStockLevel],  
    [CostPrice],                
    [RetailPrice],               
    [DateCreatedAt],  
    [IsActive]              
FROM 
    [dbo].[Productdime]
WHERE 
    [CostPrice] IS NOT NULL AND [RetailPrice] IS NOT NULL; 

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
FROM [dbo].[SentPurchaseOrders]
WHERE [DestinationOutlet] IS NOT NULL  -- Exclude NULL values
AND [DestinationOutlet] NOT IN (SELECT [OutletName] FROM [dbo].[Outlet_dime]); 

Select * From [dbo].[Outlet_dime];

ALTER TABLE [dbo].[Productdime]
DROP COLUMN [Tags],[CostPrice],[RetailPrice],[CurrentStockLevel],[DateCreatedAt],[DateDiscontinuedAt],[IsActive];

ALTER TABLE [dbo].[Suppliers]
DROP COLUMN [Description];

UPDATE [dbo].[Suppliers]
SET [FirstLineAddress] = CONCAT( [FirstLineAddress],', ',[PostCode] );

SELECT [FirstLineAddress] From [dbo].[Suppliers]

Alter Table [dbo].[Suppliers]
Drop Column [PostCode]


WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY [SKU], [ProductName], [Description], [Condition], [ProductType], [Brand] ORDER BY [productID]) AS RowNum
    FROM [dbo].[Productdime]
        
)
DELETE FROM CTE
WHERE RowNum > 1;  



-- Step 1: Alter the fact table to add new columns
ALTER TABLE [dbo].[dboReceivedPurchaseOrders]
ADD ProductID INT,     -- Adjust data type as necessary
    SupplierID INT;   -- Adjust data type as necessary

-- Step 2: Populate the new columns
-- Assuming there is a column in PurchaseOrderSent that can be used to join with Product and Supplier tables
UPDATE ps
SET 
    ps.[ProductID] = p.[productID],
    ps.[SupplierID] = s.[supplierID]
FROM 
    [dbo].[dboReceivedPurchaseOrders] ps
JOIN 
    [dbo].[Productdime] p ON ps.[ProductSKU] = p.[SKU]  -- Adjust this condition based on your schema
JOIN 
    [dbo].[Suppliers] s ON p.[SupplierName] = s.[SupplierName];   -- Adjust join condition as needed

-- Step 3: Add foreign key constraints
ALTER TABLE [dbo].[dboReceivedPurchaseOrders]
ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES [dbo].[Productdime](ProductID),
ADD CONSTRAINT FK_SupplierID FOREIGN KEY (SupplierID) REFERENCES [dbo].[Suppliers](SupplierID);


-- Step 4: Optional - Verify the update
SELECT * FROM [dbo].[dboReceivedPurchaseOrders]; 


-- Step 1: Alter the fact table to add new columns
ALTER TABLE [dbo].[SentPurchaseOrders]
ADD ProductID INT,     -- Adjust data type as necessary
    SupplierID INT;   -- Adjust data type as necessary

-- Step 2: Populate the new columns
-- Assuming there is a column in PurchaseOrderSent that can be used to join with Product and Supplier tables
UPDATE po
SET 
    po.[ProductID] = p.[productID],
    po.[SupplierID] = s.[supplierID]
FROM 
   [dbo].[SentPurchaseOrders]  po
JOIN 
    [dbo].[Productdime] p ON po.[ProductSKU] = p.[SKU]  -- Adjust this condition based on your schema
JOIN 
    [dbo].[Suppliers] s ON p.[SupplierName] = s.[SupplierName];   -- Adjust join condition as needed

-- Step 3: Add foreign key constraints
ALTER TABLE [dbo].[dboReceivedPurchaseOrders]
ADD CONSTRAINT productID FOREIGN KEY (ProductID) REFERENCES [dbo].[Productdime](ProductID);

ALTER TABLE [dbo].[dboReceivedPurchaseOrders]
ADD CONSTRAINT  supplierID FOREIGN KEY (SupplierID) REFERENCES [dbo].[Suppliers](SupplierID);


-- Step 4: Optional - Verify the update
SELECT * FROM [dbo].[SentPurchaseOrders]; 


UPDATE [dbo].[Suppliers]
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


SELECT * FROM [dbo].[Suppliers];
