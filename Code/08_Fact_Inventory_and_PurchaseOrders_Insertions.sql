select * FROM [dbo].[date_dime]
select * FROM [dbo].[dime_Outlet]
select * FROM [dbo].[dime_ProductDm][dbo]
select * FROM [dime_SupplierDm]
select * FROM [dbo].[date_dime]
select * FROM [dbo].[suppl]
select * FROM [dbo].[Sampleforoutlet]
select * FROM [dbo].[product table]
select * FROM [dbo].[Fact_Inventory]

INSERT INTO [dbo].[Fact_Inventory] ([ProductID],[CurrentStockLevel] , [CostPrice], [RetailPrice], [DateCreatedAt], [IsActive])
SELECT 
    ps.ProductID,
    P.[CurrentStockLevel],  
    P.[CostPrice],                
    P.[RetailPrice],               
    P.[DateCreatedAt],  
    P.[IsActive]              
FROM 
   [dbo].[product table] P
 jOIN 
    [dbo].[dime_ProductDm] ps ON p.SKU = ps.SKU

   CREATE TABLE Fact_Inventory(
InventoryID INT PRIMARY KEY IDENTITY(1,1), 
ProductID INT,
CurrentStockLevel INT,
CostPrice DECIMAL(10, 2),
RetailPrice DECIMAL(10, 2),
DateCreatedAt Date,
IsActive BIT,
);

select * FROM [dbo].[FactRecievedPurchaseOrders]


--recieved order
CREATE TABLE FactRecievedPurchaseOrders(
PurchaseOrderID varchar(50),
ProductID varchar(50),
SupplierID varchar(50),
DateID Date,
OutletName varchar(200) ,
SentDate DATE,
RecievedDate DATE,
RecievedQTY INT,
OrderedQTY INT,
SupplierName Varchar(200),
SKU varchar(50)
);

INSERT INTO [dbo].[FactRecievedPurchaseOrders] ([PurchaseOrderID],[ProductID],[SupplierID],[DateID],[OutletName],[SentDate],[RecievedDate],[RecievedQTY],[OrderedQTY],[SupplierName],[SKU])
SELECT 
    p.[PurchaseOrderCode],  
	ps.ProductID,
	s.SupplierID,
	d.DateID,
	p.[DestinationOutletID],
	p.[SentDate],
	p.[ReceivedDate],
	p.[ReceivedQty],
	p.[OrderedQty],
	s.SupplierName,
	ps.SKU
                 
FROM 
   [dbo].[SampleOfReceivedPurchaseOrders] p
JOIN 
    [dbo].[dime_ProductDm] ps ON p.[ProductSKU] = ps.SKU
JOIN 
	[dbo].[dime_SupplierDm] s ON p.[SupplierName] = s.SupplierName
JOIN
    [dbo].[dime_DateDm] d ON p.[SentDate] = d.DateID


select * FROM [dbo].[FactRecievedPurchaseOrders]
--sent orders

CREATE TABLE FactSentPurchaseOrders(
 SentOrderID varchar(50) NOT NULL,
 ProductID varchar(50),
 SKU varchar(50),
 SupplierID varchar(50),
 SupplierName varchar(50),
 OutletName varchar(50),
 SentDate Date,
 OrderedQTY INT
);



INSERT INTO [dbo].[FactSentPurchaseOrders] ([SentOrderID],[ProductID],[SKU],[SupplierID],[SupplierName],[OutletName],[SentDate],[OrderedQTY])
SELECT 
    p.[PurchaseOrderCode],  
	ps.ProductID,
	ps.SKU,
	s.SupplierID,
	s.SupplierName,
	o.OutletName,
	p.[SentDate],
	p.[OrderedQty]
                 
FROM 
   [dbo].[SampleofSentPurchaseOrders] p
JOIN 
    [dbo].[dime_ProductDm] ps ON p.[ProductSKU] = ps.SKU
JOIN 
	[dbo].[dime_SupplierDm] s ON p.[SupplierName] = s.SupplierName
JOIN
    [dbo].[dime_Outlet] o ON p.[DestinationOutlet] = o.OutletName

	select * FROM [dbo].[FactSentPurchaseOrders]


[ABCdatbase].[dbo].[dime_DateDm]
[ABCdatbase].[dbo].[dime_ProductDm]
[ABCdatbase].[dbo].[dime_SupplierDm]
[ABCdatbase].[dbo].[Fact_Inventory]
[ABCdatbase].[dbo].[dime_Outlet]
[ABCdatbase].[dbo].[FactSentPurchaseOrders]
[ABCdatbase].[dbo].[FactRecievedPurchaseOrders]