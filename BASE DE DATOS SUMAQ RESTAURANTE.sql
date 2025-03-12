-- Base de Datos de "Sumaq Restobar"
-- Andrei Chevarria, Mauricio Gamarra, Danny Vargas, Ricardo Yabar
-- 10/03/2025

-- CREAR BASE DE DATOS
if OBJECT_ID('BDSUMAQ') is not null
    drop table BDSUMAQ
go
CREATE DATABASE BDSUMAQ;
go
USE BDSUMAQ;
go

-- TABLA CLIENTE
if OBJECT_ID('Cliente') is not null
    drop table Cliente
go
CREATE TABLE Cliente 
(
    idC INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NULL,  
    Telefono BIGINT NULL,
    Email VARCHAR(150) NULL,
    DNI BIGINT NULL,  
    RUC BIGINT NULL,  
    EsEmpresa BIT NOT NULL DEFAULT 0  
)
go

-- TABLA EMPLEADO
if OBJECT_ID('Empleado') is not null
    drop table Empleado
go
CREATE TABLE Empleado 
(
    codE INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL
)
go

-- TABLA PROVEEDOR
if OBJECT_ID('Proveedor') is not null
    drop table Proveedor
go
CREATE TABLE Proveedor 
(
    idP INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100) NOT NULL,
    Telefono BIGINT NOT NULL,
    RUC BIGINT NOT NULL,
    Direccion VARCHAR(255) NOT NULL
)
go

-- TABLA PRODUCTO 
if OBJECT_ID('Producto') is not null
    drop table Producto
go
CREATE TABLE Producto 
(
    idProd INT IDENTITY(1,1) PRIMARY KEY,
    idP INT NOT NULL,  
    Nombre VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (idP) REFERENCES Proveedor(idP)
)
go

-- TABLA COMPROBANTE
if OBJECT_ID('Comprobante') is not null
    drop table Comprobante
go
CREATE TABLE Comprobante 
(
    idComp INT IDENTITY(1,1) PRIMARY KEY,
    idC INT NOT NULL,  
    codE INT NOT NULL,  
    Fecha DATE NOT NULL,
    TipoComp VARCHAR(10) NOT NULL CHECK (TipoComp IN ('Boleta', 'Factura')),
    IGV DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    TipoComprobante VARCHAR(10) NOT NULL,
    FOREIGN KEY (idC) REFERENCES Cliente(idC),
    FOREIGN KEY (codE) REFERENCES Empleado(codE)
)
go

-- TABLA DETALLE_PEDIDO 
if OBJECT_ID('Detalle_Pedido') is not null
    drop table Detalle_Pedido
go
CREATE TABLE Detalle_Pedido 
(
    idDet INT IDENTITY(1,1) PRIMARY KEY,
    idComp INT NOT NULL,  
    idProd INT NOT NULL,  
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    FOREIGN KEY (idProd) REFERENCES Producto(idProd)
)
go

-- TABLA INGRESO 
if OBJECT_ID('Ingreso') is not null
    drop table Ingreso
go
CREATE TABLE Ingreso 
(
    idIng INT IDENTITY(1,1) PRIMARY KEY,
    codE INT NOT NULL,  
    Descripcion VARCHAR(255) NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha DATE NOT NULL,
    Origen VARCHAR(100) NOT NULL,
    FOREIGN KEY (codE) REFERENCES Empleado(codE)
)
go

-- TABLA DELIVERY 
if OBJECT_ID('Delivery') is not null
    drop table Delivery
go
CREATE TABLE Delivery 
(
    idDel INT IDENTITY(1,1) PRIMARY KEY,
    idComp INT NOT NULL,  
    Direccion VARCHAR(255) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    FechaEntrega DATE NOT NULL,
    CostoEnvio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (idComp) REFERENCES Comprobante(idComp)
)
go
