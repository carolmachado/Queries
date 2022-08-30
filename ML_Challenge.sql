create table Gender
(
Id int primary key identity,
Description varchar(30)
)

create table Customer 
(
Id int primary key identity,
First_Name varchar(30),
Last_Name varchar(50),
Birth_Date date,
Email varchar (100),
Id_Gender int,
Id_Address int,
);

create table Address
(
 Id int primary key identity,
 Street varchar(100),
 Number varchar(8) null,
 Complement varchar(50),
 City varchar(50),
 State varchar(50),
 Country varchar(50),
 Zip_Code varchar(10)
)

create table Category
(
Id int primary key identity,
Description varchar(100),
Id_Category int null,
)

create table Item
(
Id int primary key identity,
Description varchar(100),
Id_Category int,
Active bit,
End_Date date,
Price DECIMAL(10,2)
)

create table Purchase_Order_Status
(
Id int primary key identity,
Description varchar(30),
)

create table Purchase_Order
(
Id int primary key identity,
Id_Customer int,
Id_Item int,
Id_Purchase_Order_Status int ,
Date_Order datetime,
Quantity int,
Price decimal(10,2)
)

create table Item_Daily_Processing
(
Id int primary key identity,
Id_Item int,
Active bit,
Price decimal(10,2),
Date_Processing datetime
)

Alter table Customer add constraint fk_Customer_Gender foreign Key (Id_Gender) references Gender(Id)
Alter table  Customer add constraint fk_Customer_Address foreign key (Id_Address) references Address(Id)
Alter table Category add constraint fk_Category foreign key (Id_Category) references Category(Id)
Alter table Item add constraint fk_Item_Category foreign key(Id_Category) references Category(Id)


Alter table Purchase_Order add constraint fk_Purchase_Order_Custumer foreign key (Id_Customer) references Customer(Id)
Alter table Purchase_Order add constraint fk_Purchase_Order_Item foreign key (Id_Item) references Item(Id)
Alter table Purchase_Order add constraint fk_Purchase_Order_Purchase_Order_Status foreign key (Id_Purchase_Order_Status) references Purchase_Order_Status(Id)
Alter table Item_Daily_Processing add constraint fk_Item_Item_Daily_Processing foreign key (Id_Item) references Item(Id)

CREATE INDEX ix_mytable_col1 ON mytable (col1)
