create database Datatransformer;
use Datatransformer;

#customer table
CREATE TABLE Customers (
    CustomerID       INT PRIMARY KEY,
    FirstName        VARCHAR(50)  NOT NULL,
    LastName         VARCHAR(50)  NOT NULL,
    Email            VARCHAR(100) NOT NULL,
    RegistrationDate DATE         NOT NULL
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, RegistrationDate) VALUES
(1, 'John',   'Doe',      'john.doe@email.com',   '2022-03-15'),
(2, 'Jane',   'Smith',    'jane.smith@email.com', '2021-11-02'),
(3, 'Rahul',  'Patel',    'rahul.patel@email.com','2023-01-20'),
(4, 'Anita',  'Shah',     'anita.shah@email.com', '2023-06-05'),
(5, 'Robert', 'Brown',    'robert.brown@email.com','2020-09-10');

#order table
CREATE TABLE Orders (
    OrderID     INT PRIMARY KEY,
    CustomerID  INT         NOT NULL,
    OrderDate   DATE        NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-08-10', 950.00),
(104, 3, '2023-09-15', 1200.25),
(105, 4, '2023-10-05', 480.00);


#employee table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName  VARCHAR(50)  NOT NULL,
    LastName   VARCHAR(50)  NOT NULL,
    Department VARCHAR(50)  NOT NULL,
    HireDate   DATE         NOT NULL,
    Salary     DECIMAL(10,2) NOT NULL
);
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary) VALUES
(1, 'Mark',   'Johnson', 'Sales',      '2020-01-15', 50000.00),
(2, 'Susan',  'Lee',     'HR',         '2021-03-20', 55000.00),
(3, 'Amit',   'Kumar',   'IT',         '2019-07-10', 72000.00),
(4, 'Neha',   'Verma',   'Finance',    '2022-02-01', 60000.00),
(5, 'David',  'Wilson',  'Marketing',  '2018-11-25', 85000.00);

#INNER JOIN: orders with customer details

SELECT  o.OrderID,
        o.OrderDate,
        o.TotalAmount,
        c.CustomerID,
        c.FirstName,
        c.LastName,
        c.Email
FROM    Orders o
INNER JOIN Customers c
        ON o.CustomerID = c.CustomerID;


#LEFT JOIN - all customers and their orders
SELECT  c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount
FROM    Customers c
LEFT JOIN Orders o
        ON c.CustomerID = o.CustomerID;


#RIGHT JOIN: all orders and their customers

SELECT  c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount
FROM    Customers c
RIGHT JOIN Orders o
        ON c.CustomerID = o.CustomerID;
#FULL OUTER JOIN: all customers and all orders

SELECT  c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID

UNION

SELECT  c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount
FROM Customers c
RIGHT JOIN Orders o
    ON c.CustomerID = o.CustomerID;
    
    
    
#Customers with orders > average order amount
SELECT  c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderID,
        o.TotalAmount
FROM    Orders o
JOIN    Customers c
        ON o.CustomerID = c.CustomerID
WHERE   o.TotalAmount >
        (SELECT AVG(TotalAmount) FROM Orders);


#Employees with salary above average
SELECT  e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.Department,
        e.Salary
FROM    Employees e
WHERE   e.Salary >
        (SELECT AVG(Salary) FROM Employees);
        
        
#Extract year and month from OrderDate
SELECT  OrderID,
        OrderDate,
        EXTRACT(YEAR  FROM OrderDate) AS OrderYear,
        EXTRACT(MONTH FROM OrderDate) AS OrderMonth
FROM    Orders;    

#Difference in days between OrderDate and current date
SELECT  OrderID,
        OrderDate,
        DATEDIFF(CURRENT_DATE, OrderDate) AS DaysDifference
FROM    Orders;

#Format OrderDate as DD-MMM-YYYY
SELECT  OrderID,
        OrderDate,
        DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedOrderDate
FROM    Orders;



#Concatenate first and last name
SELECT  CustomerID,
        FirstName,
        LastName,
        FirstName || ' ' || LastName AS FullName
FROM    Customers;



#Replace part of a string in FirstName
SELECT  CustomerID,
        FirstName,
        REPLACE(FirstName, 'John', 'Jonathan') AS UpdatedFirstName
FROM    Customers;


#FirstName uppercase, LastName lowercase
SELECT  CustomerID,
        UPPER(FirstName) AS FirstNameUpper,
        LOWER(LastName)  AS LastNameLower
FROM    Customers;


#Trim extra spaces from Email
SELECT  CustomerID,
        Email,
        TRIM(Email) AS CleanEmail
FROM    Customers;



#Running total of TotalAmount per customer
SELECT  o.OrderID,
        o.CustomerID,
        o.OrderDate,
        o.TotalAmount,
        SUM(o.TotalAmount) OVER(
            PARTITION BY o.CustomerID
            ORDER BY     o.OrderDate,
                         o.OrderID
        ) AS RunningTotal
FROM    Orders o;



#Rank orders by TotalAmount
SELECT  o.OrderID,
        o.CustomerID,
        o.TotalAmount,
        RANK() OVER(
            ORDER BY o.TotalAmount DESC
        ) AS AmountRank
FROM    Orders o;



#Assign discount based on TotalAmount
SELECT  o.OrderID,
        o.CustomerID,
        o.TotalAmount,
        CASE
            WHEN o.TotalAmount > 1000 THEN '10% off'
            WHEN o.TotalAmount >  500 THEN '5% off'
            ELSE 'No discount'
        END AS Discount
FROM    Orders o;



#Categorize employee salaries as high / medium / low
SELECT  e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.Salary,
        CASE
            WHEN e.Salary >= 70000 THEN 'High'
            WHEN e.Salary >= 50000 THEN 'Medium'
            ELSE 'Low'
        END AS SalaryCategory
FROM    Employees e;



