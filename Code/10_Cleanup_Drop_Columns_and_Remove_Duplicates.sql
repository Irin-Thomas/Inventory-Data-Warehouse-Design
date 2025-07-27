ALTER TABLE [dbo].[product_dime]
DROP COLUMN [SupplierName],[Tags],[CostPrice],[RetailPrice],[CurrentStockLevel],[DateCreatedAt],[DateDiscontinuedAt],[IsActive];

ALTER TABLE [dbo].[Supplier_dime]
DROP COLUMN [Description];

UPDATE [dbo].[Supplier_dime]
SET [FirstLineAddress] = CONCAT( [FirstLineAddress],', ',[PostCode] );

SELECT [FirstLineAddress] From [dbo].[Supplier_dime]

Alter Table [dbo].[Supplier_dime]
Drop Column [PostCode]


WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY [SKU], [ProductName], [Description], [Condition], [ProductType], [Brand] ORDER BY [productID]) AS RowNum
    FROM [dbo].[product_dime]
        
)
DELETE FROM CTE
WHERE RowNum > 1;  

SELECT * FROM [dbo].[product_dime]