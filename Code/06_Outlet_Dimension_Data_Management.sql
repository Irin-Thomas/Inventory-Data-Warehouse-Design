INSERT INTO [dbo].[dime_Outlet]([OutletName])
SELECT DISTINCT [DestinationOutletID]
FROM [dbo].[Sampleforoutlet]
WHERE [DestinationOutletID] NOT IN (SELECT [OutletName] FROM [dbo].[dime_Outlet]);

Select * FROM [dbo].[dime_Outlet];
Select * FRO[dbo].[dime_Date];

DELETE FROM [dbo].[dime_Outlet];

