CREATE DATABASE DataDigger;
USE DataDigger;


CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name       VARCHAR(100) NOT NULL,
  Email      VARCHAR(100) NOT NULL UNIQUE,
  Address    VARCHAR(100)
);

#1) Insert at least 5 customers
INSERT INTO Customers (CustomerID,Name, Email, Address) VALUES
(1,'Alice',   'alice@example.com',   'Ahmedabad'),
(2,'Bob',     'bob@example.com',     'Surat'),
(3,'Charlie', 'charlie@example.com', 'Vadodara'),
(4,'David',   'david@example.com',   'Rajkot'),
(5,'Alice',   'alice2@example.com',  'Mumbai');

#2) Retrieve all customer details
SELECT * FROM Customers;

#3) Update a customer’s address
UPDATE Customers
SET Address = 'junagadh'
WHERE CustomerID = 1;

#4) Delete a customer using CustomerID
DELETE FROM Customers
WHERE CustomerID = 4;

#5) Display all customers whose name is 'Alice'
SELECT *
FROM Customers
WHERE Name = 'Alice';





CREATE TABLE Orders (
  OrderID     INT PRIMARY KEY,
  CustomerID  INT NOT NULL,
  OrderDate   DATE NOT NULL,
  TotalAmount DECIMAL(10,2)
  );

#1) Insert at least 5 orders
INSERT INTO Orders (OrderID,CustomerID, OrderDate, TotalAmount) VALUES
(1,1, '2025-12-01', 2300.00),
(2,2, '2025-12-05', 7000.00),
(3,1, '2025-12-10', 1500.00),
(4,3, '2025-11-28', 500.00),
(5,5, '2025-12-20', 900.00);

#2) Retrieve all orders made by a specific customer 
SELECT *
FROM Orders
WHERE CustomerID = 1;

#3) Update an order’s total amount
UPDATE Orders
SET TotalAmount = 2500.00
WHERE OrderID = 1;

#4) Delete an order using its OrderID
DELETE FROM Orders
WHERE OrderID = 5;

#5) Retrieve orders placed in the last 30 days
SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

#6) Retrieve highest, lowest, and average order amount
SELECT
  MAX(TotalAmount) AS HighestAmount,
  MIN(TotalAmount) AS LowestAmount,
  AVG(TotalAmount) AS AverageAmount
FROM Orders;






CREATE TABLE Products (
  ProductID   INT PRIMARY KEY,
  ProductName VARCHAR(100) NOT NULL,
  Price       DECIMAL(10,2) NOT NULL,
  Stock       INT NOT NULL
);

#1) Insert at least 5 products
INSERT INTO Products (ProductID,ProductName, Price, Stock) VALUES
(1,'Keyboard',   800.00,  20),
(2,'Mouse',      500.00,  0),
(3,'Headphones', 1500.00, 15),
(4,'Monitor',    7000.00, 8),
(5,'USB Cable',  200.00,  50);

#2) Retrieve all products sorted by price (descending)
SELECT *
FROM Products
ORDER BY Price DESC;

#3) Update the price of a specific product
UPDATE Products
SET Price = 1600.00
WHERE ProductID = 3;

#4) Delete a product if it is out of stock
DELETE FROM Products
WHERE Stock = 0;

select * from products;

#5) Retrieve products whose price is between ₹500 and ₹2000
SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 2000;

#6) Retrieve most expensive and cheapest product
SELECT *
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products)
   OR Price = (SELECT MIN(Price) FROM Products);
   
   
   
   
   
CREATE TABLE OrderDetails (
  OrderDetailID INT PRIMARY KEY,
  OrderID       INT NOT NULL,
  ProductID     INT NOT NULL,
  Quantity      INT NOT NULL,
  SubTotal      DECIMAL(10,2),
);

#1) Insert at least 5 order‑detail records
INSERT INTO OrderDetails (OrderDetailedID,OrderID, ProductID, Quantity, SubTotal) VALUES
(1,1, 1, 1, 800.00),
(2,1, 3, 1, 1500.00),
(3,2, 4, 1, 7000.00),
(4,3, 2, 3, 1500.00),
(5,4, 5, 2, 400.00);

#2) Retrieve all order details for a specific order
SELECT *
FROM OrderDetails
WHERE OrderID = 1;

#3) Calculate total revenue from all orders using SUM()
SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

#4) Retrieve the top 3 most ordered products
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalQuantity DESC
LIMIT 3;

#5) Count how many times a specific product has been sold using COUNT()
SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1;