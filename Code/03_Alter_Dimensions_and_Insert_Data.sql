ALTER TABLE [dbo].[dime_Product]
ADD SupplierName varchar(250);

ALTER TABLE [dbo].[Fact_RecievedPurchaseOrders]
ADD SupplierName varchar(50),
ProductSKU varchar(50);

ALTER TABLE [dbo].[Fact_SentPurchaseOrders]
ADD ProductSKU varchar(50),
SupplierNmae varchar(50);


INSERT INTO [ABCdatawarehouse].[dbo].[dime_Product]([SKU], [ProductName], [ProductDescription], [Condition], [ProductType], [Brand], [SupplierName])  -- Make sure these columns are correct
SELECT 
    [SKU],
	[ProductName],
	[Description],
	[Condition],
	[ProductType],
	[Brand],
	[SupplierName]
FROM 
    [Staging Area Final].[dbo].[Productdime];


	BEGIN TRY
    -- Start a transaction for safety
    BEGIN TRANSACTION;

    -- Insert into the dime_Product table from the staging table
    INSERT INTO ABCdatawarehouse.dbo.dime_Product (ProductID, [SKU], [ProductName], [ProductDescription], [Condition], [ProductType], [Brand], [SupplierName])  -- Specify all necessary columns
    SELECT 
        CAST(s.[productID] AS INT) AS ProductID,  -- Valid ProductID from the Product reference table
        s.[SKU],
		s.[ProductName],
		s.[Description],
        s.[Condition],
		s.[ProductType],
		s.[Brand],
		s.[SupplierName]
    FROM 
        [Staging Area Final].[dbo].[Productdime] s
    WHERE 
        ISNUMERIC(s.ProductID) = 1 AND  -- Ensure only numeric ProductIDs are processed
        NOT EXISTS (  -- Check for duplicates
            SELECT 1 
            FROM ABCdatawarehouse.dbo.dime_Product p
            WHERE p.ProductID = CAST(s.[productID] AS INT)
        );  -- Ensure only numeric ProductIDs are processed

    COMMIT TRANSACTION;

    PRINT 'Data inserted successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;


	Select * FROM [dbo].[dime_Product];