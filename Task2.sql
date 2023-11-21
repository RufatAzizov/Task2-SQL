----create database TaskGroupBy

create table Employees(
Id int identity primary key,
Name nvarchar(20),
Surname nvarchar(25) not null,
FatherName nvarchar (20)
)	

create table Position(
Id int identity primary key,
Name nvarchar(25),
)

create table Branch(
Id int identity primary key,	
Name nvarchar(25),
)

create table Products(
Id int identity primary key,
BoughtFor float not null, 
SellingFor float not null
)

create table Payments(
Id int identity primary key,
ProductId int foreign key references Products(Id),
EmployeeId int foreign key references Employees(Id),
PaymentTime datetime
)

INSERT INTO Employees (Name, Surname, FatherName)
VALUES
    ('John', 'Doe', 'Michael'),
    ('Jane', 'Smith', 'Andrew'),
    ('Michael', 'Johnson', 'David');

INSERT INTO Position (Name)
VALUES
    ('Manager'),
    ('Salesperson'),
    ('Clerk');

INSERT INTO Branch (Name)
VALUES
    ('Branch A'),
    ('Branch B'),
    ('Branch C');

INSERT INTO Products (BoughtFor, SellingFor)
VALUES
    (50.9, 75.8),
    (30.0, 45.5),
    (20.9, 35.0);

INSERT INTO Payments (ProductId, EmployeeId, PaymentTime)
VALUES
    (1, 1, '2023-01-15 10:30:00'),
    (2, 2, '2023-02-20 14:45:00'),
    (3, 3, '2023-03-25 09:15:00');

--1) Satış cədvəlində işçilərin , satılan məhsulların, satışın olduğu filialın, məhsulun alış və satış qiyməti yazılsın.
--2) Bütün satışların cəmini tap.
--3) Cari ayda məhsul satışından gələn yekun məbləği tap

--Task 1

ALTER TABLE Employees
ADD BranchId INT;

Alter table Products
ADD Name nvarchar(50)

UPDATE Products
SET Name = 'Acer'
WHERE Id = 1;

UPDATE Products
SET Name = 'HP'
WHERE Id = 2;

UPDATE Products
SET Name = 'LENOVO'
WHERE Id = 3;


ALTER TABLE Employees
ADD CONSTRAINT FK_Branch_Employee
FOREIGN KEY (BranchId)
REFERENCES Branch(Id);

UPDATE Employees
SET BranchId = 1
WHERE Id = 1;

UPDATE Employees
SET BranchId = 2
WHERE Id = 2;

UPDATE Employees
SET BranchId = 3
WHERE Id = 3;

SELECT
    Employees.Name AS EmployeeName,
    Employees.Surname AS EmployeeSurname,
    Branch.Name AS BranchName,
    Products.Name AS ProductName,
    Products.BoughtFor AS PurchasePrice,
    Products.SellingFor AS SellingPrice
FROM
    Payments
JOIN
    Employees ON Payments.EmployeeId = Employees.Id
JOIN
    Products ON Payments.ProductId = Products.Id
JOIN
    Branch ON Employees.BranchId = Branch.Id;

	-- Task 2
SELECT
    SUM(Products.SellingFor) AS TotalSales
FROM
    Payments
JOIN
    Products ON Payments.ProductId = Products.Id;

	-- Task 3
	SELECT
    SUM(Products.SellingFor) AS TotalSalesRevenue
FROM
    Payments
JOIN
    Products ON Payments.ProductId = Products.Id
WHERE
    MONTH(Payments.PaymentTime) = MONTH(GETDATE())
    AND YEAR(Payments.PaymentTime) = YEAR(GETDATE());





