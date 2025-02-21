-- Base de datos Tienda ABC
-- Chevarria Revollar Jose Andrei
-- Gamarra Laura Edgar Mauricio
-- Vargas Torres Danny Ruben
-- Yabar Nieto Ricardo Fabio
-- 21/02/2025

USE master
GO
IF DB_ID('BDTiendaABC') IS NOT NULL
    DROP DATABASE BDTiendaABC
GO
CREATE DATABASE BDTiendaABC
GO

USE BDTiendaABC
GO

-- Creación de la tabla Cliente
IF OBJECT_ID('Cliente', 'U') IS NOT NULL
    DROP TABLE Cliente
GO
CREATE TABLE Cliente (
    IdCliente INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI CHAR(8) UNIQUE NOT NULL,
    Telefono CHAR(9) NOT NULL,
    Direccion VARCHAR(100) NOT NULL
)
GO

-- Creación de la tabla Proveedor
IF OBJECT_ID('Proveedor', 'U') IS NOT NULL
    DROP TABLE Proveedor
GO
CREATE TABLE Proveedor (
    IdProveedor INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono CHAR(9) NOT NULL
)
GO

-- Creación de la tabla Electrodoméstico
IF OBJECT_ID('Electrodomestico', 'U') IS NOT NULL
    DROP TABLE Electrodomestico
GO
CREATE TABLE Electrodomestico (
    IdElectrodomestico INT PRIMARY KEY IDENTITY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL
)
GO

-- Creación de la tabla Orden de Compra
IF OBJECT_ID('OrdenCompra', 'U') IS NOT NULL
    DROP TABLE OrdenCompra
GO
CREATE TABLE OrdenCompra (
    IdOrdenCompra INT PRIMARY KEY IDENTITY,
    FechaHora DATETIME NOT NULL,
    MontoTotal DECIMAL(10,2) NOT NULL,
    IdProveedor INT NOT NULL,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
)
GO

-- Creación de la tabla Comprobante de Venta
IF OBJECT_ID('Comprobante', 'U') IS NOT NULL
    DROP TABLE Comprobante
GO
CREATE TABLE Comprobante (
    IdComprobante INT PRIMARY KEY IDENTITY,
    FechaHora DATETIME NOT NULL,
    MontoTotal DECIMAL(10,2) NOT NULL,
    IdCliente INT NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
)
GO

-- Creación de la tabla Detalle de Entrada/Salida
IF OBJECT_ID('DetalleEntradaSalida', 'U') IS NOT NULL
    DROP TABLE DetalleEntradaSalida
GO
CREATE TABLE DetalleEntradaSalida (
    IdDetalle INT PRIMARY KEY IDENTITY,
    IdElectrodomestico INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    TipoMovimiento CHAR(1) CHECK (TipoMovimiento IN ('+', '-')) NOT NULL,
    IdOrdenCompra INT NULL,
    IdComprobante INT NULL,
    FOREIGN KEY (IdElectrodomestico) REFERENCES Electrodomestico(IdElectrodomestico),
    FOREIGN KEY (IdOrdenCompra) REFERENCES OrdenCompra(IdOrdenCompra),
    FOREIGN KEY (IdComprobante) REFERENCES Comprobante(IdComprobante)
)
GO