USE master
GO
USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'TransportationDB'
)
CREATE DATABASE [TransportationDB]
GO

USE [TransportationDB]
IF OBJECT_ID('dbo.Customer', 'U') IS NOT NULL
DROP TABLE Customer
IF OBJECT_ID('dbo.ShippingCompany', 'U') IS NOT NULL
DROP TABLE ShippingCompany
IF OBJECT_ID('dbo.DriversCompany', 'U') IS NOT NULL
DROP TABLE DriversCompany
IF OBJECT_ID('dbo.BodyType', 'U') IS NOT NULL
DROP TABLE BodyType
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL
DROP TABLE Location
IF OBJECT_ID('dbo.Cargo', 'U') IS NOT NULL
DROP TABLE Cargo
IF OBJECT_ID('dbo.Transport', 'U') IS NOT NULL
DROP TABLE Transport
IF OBJECT_ID('dbo.Route', 'U') IS NOT NULL
DROP TABLE Route
IF OBJECT_ID('dbo.Driver', 'U') IS NOT NULL
DROP TABLE Driver
IF OBJECT_ID('dbo.Logistician', 'U') IS NOT NULL
DROP TABLE Logistician
IF OBJECT_ID('dbo.Shipping', 'U') IS NOT NULL
DROP TABLE Shipping
IF OBJECT_ID('dbo.OrderTable', 'U') IS NOT NULL
DROP TABLE OrderTable
GO

CREATE TABLE Customer
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Customer PRIMARY KEY,
   Name      nvarchar(50)  NOT NULL,
   phone	 nvarchar(50)  NOT NULL,
   Email     varchar(50)  NOT NULL,
   age		 int	NOT NULL
);

CREATE TABLE ShippingCompany
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_ShippingCompany PRIMARY KEY,
   Name      nvarchar(50)  NOT NULL,
   phone	 nvarchar(50)  NOT NULL,
   Email     nvarchar(50)  NOT NULL
);

CREATE TABLE DriversCompany
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_DriversCompany PRIMARY KEY,
   Name      nvarchar(50)  NOT NULL,
   phone	 nvarchar(50)  NOT NULL,
   Email     nvarchar(50)  NOT NULL
);

CREATE TABLE BodyType
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_BodyType PRIMARY KEY,
   Name      nvarchar(50)  NOT NULL
);

CREATE TABLE Cargo
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Cargo PRIMARY KEY,
   capacity      int  NOT NULL,
   weight		 int NOT NULL,
   body_type	 int NULL
);

CREATE TABLE Location
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Location PRIMARY KEY,
   coordinates      nvarchar(50)  NOT NULL,
   Name				nvarchar(50)  NOT NULL
);

CREATE TABLE Route
(
   ID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Route PRIMARY KEY,
   start_location      int  NOT NULL,
   end_location		   int  NOT NULL
);

CREATE TABLE Transport
(
   ID	int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Transport PRIMARY KEY,
   model		nvarchar(50)  NOT NULL,
   capacity		int  NOT NULL,
   lifting		int NOT NULL,
   body_type	int NULL
);

CREATE TABLE Driver
(
   ID			int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Driver PRIMARY KEY,
   ID_Transport		int NULL,
   ID_Company		int NULL,
   Name				nvarchar(50) NOT NULL,
   personal_documents		nvarchar(100) NOT NULL,
   salary			money  NOT NULL,
   experience		nvarchar(50) NOT NULL
);

CREATE TABLE Logistician
(
   ID				int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Logistician PRIMARY KEY,
   ID_Company		int NULL,
   Name				nvarchar(50) NOT NULL,
   personal_documents		nvarchar(100) NOT NULL,
   salary			money  NOT NULL,
   experience		nvarchar(50) NOT NULL
);

CREATE TABLE Shipping
(
   ID	int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Shipping PRIMARY KEY,
   ID_Driver		int NULL,
   ID_Route			int NULL,
   date_start		date NOT NULL,
   date_end			date NOT NULL
);

CREATE TABLE OrderTable
(
   ID	int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Order PRIMARY KEY,
   ID_Shipping_Company	int  NOT NULL,
   ID_Customer			int NOT NULL,
   ID_Shipping			int NOT NULL,
   order_date			date NOT NULL,
   price				money NOT NULL,
   payment_date			date NOT NULL,
   isReceived			bit NOT NULL,
   ID_Cargo				int NOT NULL,
   review				int NOT NULL
);
GO

INSERT Customer (Name, phone, Email, age) VALUES
(N'Заказчик А', N'89231415780', 'customerA@mail.ru', 25),
(N'Заказчик Б', N'89571432421', 'customerB@mail.ru', 37),
(N'Заказчик В', N'89256322473', 'customerC@mail.ru', 42)

INSERT ShippingCompany(Name, phone, Email) VALUES
(N'Транспортная Компания А', N'89236172347', 'ShippingCompanyA@mail.ru'),
(N'Транспортная Компания Б', N'89871241975', 'ShippingCompanyB@mail.ru'),
(N'Транспортная Компания В', N'89302873562', 'ShippingCompanyC@mail.ru')

INSERT DriversCompany(Name, phone, Email) VALUES
(N'Компания водителей А', N'89236124156', 'DriversCompanyA@mail.ru'),
(N'Компания водителей Б', N'89871325975', 'DriversCompanyB@mail.ru'),
(N'Компания водителей В', N'89302236267', 'DriversCompanyC@mail.ru')

INSERT Logistician(Name, personal_documents, salary, experience) VALUES
(N'Иванов Иван Иванович', N'паспорт: 6123 122345, СНИЛС: 112-124-12-12', 45662.00, N'Хороший сотрудник'),
(N'Петров Петр Петрович', N'паспорт: 1233 124245, СНИЛС: 115-114-13-12', 45124.00, N'Такой себе сотрудник'),
(N'Семенов Семен Семенович', N'паспорт: 2433 124245, СНИЛС: 135-134-73-34', 42561.00, N'Такой себе сотрудник')

INSERT BodyType(Name) VALUES
(N'Хрупкий, стекло'),
(N'Мебель, дерево'),
(N'Электроника')

INSERT Transport(model, capacity, lifting) VALUES
(N'камаз', 30, 20),
(N'газель', 20, 5),
(N'грузовик', 40, 30)

INSERT Driver(Name, personal_documents, salary, experience) VALUES
(N'Иванов Иван Иванович', N'паспорт: 6313 125665, СНИЛС: 112-124-12-12', 45662.00, N'Хороший сотрудник'),
(N'Петров Петр Петрович', N'паспорт: 1233 424524, СНИЛС: 115-114-13-12', 45124.00, N'Такой себе сотрудник'),
(N'Семенов Семен Семенович', N'паспорт: 2433 242222, СНИЛС: 135-134-73-34', 42561.00, N'Такой себе сотрудник')

INSERT Cargo(capacity, weight) VALUES
(30, 20),
(50, 10),
(40, 30)

INSERT Location(coordinates, Name) VALUES
(N'Область А, район Х, город R,	адрес Q', N'Магнит'),
(N'Область B, район Y, город F,	адрес W', N'Дикси'),
(N'Область C, район Z, город V,	адрес E', N'Гроздь')



