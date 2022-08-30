-- EXERCICIO 1

SELECT C.First_Name + ' ' + C.Last_Name, C1.Qtd 
FROM Customer C INNER JOIN 
	(SELECT COUNT(1) Qtd, C.Id
	 FROM Customer C 
	 INNER JOIN Purchase_Order PO ON C.Id = PO. Id_Customer 
	 INNER JOIN Customer_Type CT ON C.Id_Customer_Type = CT.Id
	 WHERE CT.Description = 'Sellers'
	 AND FORMAT(PO.Date_Order,'MM-yyyy') = '01-2020'
	 AND C.Birth_Date = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
	 GROUP BY C.Id 
	 HAVING COUNT(1) > 1500) C1 ON C.Id = C1.Id
ORDER BY C1.Qtd DESC

GO

--

-- EXERCICIO 2


SELECT DISTINCT C.First_Name + ' ' + C.Last_Name as Full_Name, Sales.Date_Order, Sales.Qt_Products, Sales.Qt_Sales, Sales.Total_Amount
FROM Customer C
CROSS APPLY (
SELECT TOP 5 MOV.* FROM
(SELECT PO.Id_Customer, FORMAT(PO.Date_Order,'MM-yyyy') Date_Order, Count(1) Qt_Sales, Sum(PO.Quantity) Qt_Products, Sum(PO.Price * PO.Quantity) Total_Amount 
FROM Purchase_Order PO 
INNER JOIN Item I ON PO.Id_Item = I.Id
INNER JOIN Category Ca ON I.Id_Category = Ca.Id
INNER JOIN Customer C ON PO.Id_Customer = C.Id
INNER JOIN Customer_Type CT ON C.Id_Customer_Type = CT.Id 
WHERE CT.Description = 'Sellers'
AND YEAR(PO.Date_Order) = 2022
AND Ca.Description = 'Celulares'
GROUP BY PO.Id_Customer, FORMAT(PO.Date_Order,'MM-yyyy')) MOV
WHERE MOV.Id_Customer = C.Id
ORDER BY MOV.Date_Order, MOV.Total_Amount DESC) Sales
ORDER BY Sales.Date_Order, Sales.Total_Amount DESC

GO

--

-- EXERCICIO 3

CREATE PROCEDURE Proc_Item_Daily_Processing 
AS
BEGIN
    DECLARE @DATETIME_ACTUAL DATETIME;
	SET @DATETIME_ACTUAL = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()));

	DELETE Item_Daily_Processing WHERE Date_Processing = @DATETIME_ACTUAL;
	
	INSERT INTO Item_Daily_Processing (Id_Item, Active, Price, Date_Processing)
	SELECT I.Id, I.Active, I.Price, @DATETIME_ACTUAL FROM  Item I 
END

GO
--