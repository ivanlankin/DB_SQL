USE master
GO


CREATE DATABASE [TransportationDB]
GO

USE [TransportationDB]
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
   ID_Transport		int NOT NULL,
   ID_Company		int NOT NULL,
   Name				nvarchar(50) NOT NULL,
   personal_documents		nvarchar(100) NOT NULL,
   salary			money  NOT NULL,
   experience		nvarchar(50) NOT NULL
);

CREATE TABLE Logistician
(
   ID				int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Logistician PRIMARY KEY,
   ID_Company		int NOT NULL,
   Name				nvarchar(50) NOT NULL,
   personal_documents		nvarchar(100) NOT NULL,
   salary			money  NOT NULL,
   experience		nvarchar(50) NOT NULL
);

CREATE TABLE Shipping
(
   ID	int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Shipping PRIMARY KEY,
   ID_Driver		int NOT NULL,
   ID_Route			int NOT NULL,
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

ALTER TABLE Logistician add Foreign key (ID_Company) References ShippingCompany(ID)
ALTER TABLE Transport add Foreign key (body_type) References BodyType(ID)
ALTER TABLE Driver add Foreign key (ID_Transport) References Transport(ID)
ALTER TABLE Driver add Foreign key (ID_Company) References DriversCompany(ID)
ALTER TABLE Shipping add Foreign key (ID_Driver) References Driver(ID)
ALTER TABLE Shipping add Foreign key (ID_Route) References Route(ID)
ALTER TABLE Route add Foreign key (start_location) References Location(ID)
ALTER TABLE Route add Foreign key (end_location) References Location(ID)
ALTER TABLE Cargo add Foreign key (body_type) References BodyType(ID)
ALTER TABLE OrderTable add Foreign key (ID_Cargo) References Cargo(ID)
ALTER TABLE OrderTable add Foreign key (ID_Shipping) References Shipping(ID)
ALTER TABLE OrderTable add Foreign key (ID_Customer) References Customer(ID)
ALTER TABLE OrderTable add Foreign key (ID_Shipping_Company) References ShippingCompany(ID)



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


INSERT Logistician(ID_Company, Name, personal_documents, salary, experience) VALUES
(1, N'Иванов Иван Иванович', N'паспорт: 6123 122345', 45662.00, N'Хороший сотрудник'),
(3, N'Петров Петр Петрович', N'паспорт: 1233 124245', 45124.00, N'Такой себе сотрудник'),
(2, N'Семенов Семен Семенович', N'паспорт: 2433 124245', 42561.00, N'Такой себе сотрудник')

INSERT BodyType(Name) VALUES
(N'Хрупкий, стекло'),
(N'Мебель, дерево'),
(N'Электроника')

INSERT Transport(model, capacity, lifting) VALUES
(N'камаз', 30, 20),
(N'газель', 20, 5),
(N'грузовик', 40, 30)

INSERT Driver(ID_Transport, ID_Company, Name, personal_documents, salary, experience) VALUES
(1, 3, N'Иванов Иван Иванович', N'паспорт: 6313 125665', 45662.00, N'Хороший сотрудник'),
(2, 1, N'Петров Петр Петрович', N'паспорт: 1233 424524', 45124.00, N'Такой себе сотрудник'),
(3, 2, N'Семенов Семен Семенович', N'паспорт: 2433 242222', 42561.00, N'Такой себе сотрудник')
SELECT * FROM Driver
DELETE FROM Driver WHERE ID_Company = 1
GO
SELECT * FROM Driver