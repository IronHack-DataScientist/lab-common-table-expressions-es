-- Response 1
WITH ProductosCostosos AS (
    SELECT ProductName, Unit
    FROM Products
    WHERE Price > 50
)
SELECT ProductName, Unit
FROM ProductosCostosos;

-- Response 2
WITH IngresosProducto AS (
    SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    GROUP BY p.ProductName
)
SELECT ProductName, TotalRevenue
FROM IngresosProducto
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Response 3
WITH CategoriasProductos AS (
    SELECT c.CategoryName, COUNT(*) AS ProductCount
    FROM Categories c
    JOIN Products p ON c.CategoryID = p.CategoryID
    GROUP BY c.CategoryName
)
SELECT CategoryName, ProductCount
FROM CategoriasProductos
ORDER BY ProductCount DESC
LIMIT 5;

-- Response 4
WITH PromedioOrdenes AS (
    SELECT c.CategoryName, AVG(od.Quantity) AS AvgOrderQuantity
    FROM Categories c
    JOIN Products p ON c.CategoryID = p.CategoryID
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY c.CategoryName
)
SELECT CategoryName, AvgOrderQuantity
FROM PromedioOrdenes;

-- Response 5
WITH ImporteMedio AS (
    SELECT cu.CustomerID, cu.CustomerName, AVG(od.Quantity * p.Price) AS AvgOrderAmount
    FROM Customers cu
    JOIN Orders o ON cu.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY cu.CustomerID, cu.CustomerName
)
SELECT CustomerID, CustomerName, AvgOrderAmount
FROM ImporteMedio;

-- Response 6
WITH Ventas1997 AS (
    SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalSales
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.OrderDate) = 1997
    GROUP BY p.ProductName
)
SELECT ProductName, TotalSales
FROM Ventas1997;

