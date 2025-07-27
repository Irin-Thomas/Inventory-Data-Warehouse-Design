--!st business activity
	WITH LatestDate AS (
    SELECT MAX([DateCreatedAt]) AS MaxDate
    FROM [dbo].[Fact_Inventory]
),
DateRange AS (
    SELECT 
        DATEADD(MONTH, -1, MaxDate) AS StartDate,
        MaxDate AS EndDate
    FROM LatestDate
)
SELECT 
    p.[ProductName],
    i.[CurrentStockLevel],
    i.[DateCreatedAt] AS StockDate
FROM 
    [dbo].[Fact_Inventory] i
LEFT JOIN 
    [dbo].[Productdime] p ON i.[ProductID] = p.[productID]
CROSS JOIN 
    DateRange
WHERE 
    i. [DateCreatedAt]>= DateRange.StartDate 
    AND i.[DateCreatedAt]<= DateRange.EndDate
ORDER BY 
    i.[DateCreatedAt];


	--2nd businessa activity

	WITH WeeklyStockLevels AS (
    SELECT
        p.[ProductName],
        i.[CurrentStockLevel],
        i.[DateCreatedAt],
        DATEPART(WEEK, i.[DateCreatedAt]) AS WeekNumber,
        YEAR(i.[DateCreatedAt]) AS Year
    FROM
        [dbo].[Fact_Inventory] i
    LEFT JOIN
        [dbo].[Productdime] p ON i.[ProductID] = p.[productID]
)
SELECT
    ProductName,
    Year,
    WeekNumber,
    MIN([CurrentStockLevel]) AS MinStockLevel
FROM
    WeeklyStockLevels
GROUP BY
    ProductName,
    Year,
    WeekNumber
ORDER BY
    Year,
    WeekNumber,
    ProductName;


	--3rd business activity

	SELECT 
    p.[Brand],
    p.[ProductType],
    s.[SupplierName],
    SUM(i.[CurrentStockLevel]) AS TotalStockLevel
FROM 
    [dbo].[Fact_Inventory] i
LEFT JOIN 
    [dbo].[Productdime] p ON i.[ProductID] = p.[productID]
LEFT JOIN 
    [dbo].[Suppliers] s ON p.[SupplierName] = s.[SupplierName]
GROUP BY 
    p.[Brand],
    p.[ProductType],
    s.[SupplierName]
ORDER BY 
    TotalStockLevel DESC;
	 

	 -- 4th business activity 


-- Retrieve daily sent and received stock orders for the last four weeks
-- Retrieve daily sent and received stock orders for the last four weeks
-- Daily Report
SELECT 
    'Daily Report' AS ReportType,
    CAST(TRY_CAST(SentDate AS DATE) AS DATE) AS ReportDate,
    ProductSKU,
    SupplierName,
    DestinationOutletID,
    SUM(CAST(OrderedQty AS INT)) AS TotalOrderedQty,
    SUM(CAST(ReceivedQty AS INT)) AS TotalReceivedQty
FROM 
    [dbo].[dboReceivedPurchaseOrders]
WHERE 
    (TRY_CAST(SentDate AS DATE) >= DATEADD(WEEK, -4, GETDATE())
    OR TRY_CAST(ReceivedDate AS DATE) >= DATEADD(WEEK, -4, GETDATE()))
GROUP BY 
    CAST(TRY_CAST(SentDate AS DATE) AS DATE), ProductSKU, SupplierName, DestinationOutletID
ORDER BY 
    ReportDate;

-- Weekly Report
SELECT 
    'Weekly Report' AS ReportType,
    DATEPART(YEAR, TRY_CAST(SentDate AS DATE)) AS ReportYear,
    DATEPART(WEEK, TRY_CAST(SentDate AS DATE)) AS ReportWeek,
    ProductSKU,
    SupplierName,
    DestinationOutletID,
    SUM(CAST(OrderedQty AS INT)) AS TotalOrderedQty,
    SUM(CAST(ReceivedQty AS INT)) AS TotalReceivedQty
FROM 
    [dbo].[dboReceivedPurchaseOrders]
WHERE 
    (TRY_CAST(SentDate AS DATE) >= DATEADD(WEEK, -4, GETDATE())
    OR TRY_CAST(ReceivedDate AS DATE) >= DATEADD(WEEK, -4, GETDATE()))
GROUP BY 
    DATEPART(YEAR, TRY_CAST(SentDate AS DATE)), 
    DATEPART(WEEK, TRY_CAST(SentDate AS DATE)), 
    ProductSKU, SupplierName, DestinationOutletID
ORDER BY 
    ReportYear, ReportWeek;



	
	SELECT TOP 10 * FROM [dbo].[dboReceivedPurchaseOrders];

	--5th business activity
	-- Received stock orders by supplier and by month
SELECT 
    [SupplierName],
    DATEPART(YEAR, [ReceivedDate]) AS ReportYear,
    DATEPART(MONTH, [ReceivedDate]) AS ReportMonth,
    SUM(ReceivedQty) AS TotalReceivedQty
FROM 
    [dbo].[dboReceivedPurchaseOrders]
INNER JOIN 
   [dbo].[Suppliers]  ON [dbo].[dboReceivedPurchaseOrders].[SupplierName] = [dbo].[Suppliers].[SupplierName]
WHERE 
    [ReceivedDate] IS NOT NULL
GROUP BY 
    [SupplierName], 
    DATEPART(YEAR, [ReceivedDate]),
    DATEPART(MONTH, [ReceivedDate])
ORDER BY 
    ReportYear, ReportMonth, [SupplierName];

