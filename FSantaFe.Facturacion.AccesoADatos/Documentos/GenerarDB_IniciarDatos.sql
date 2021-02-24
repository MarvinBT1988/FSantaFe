USE master
GO

CREATE DATABASE Facturacion
GO

USE Facturacion
GO

CREATE TABLE Estado(
	Id tinyint identity(1,1) primary key,
	Nombre varchar(40) NOT NULL
)

CREATE TABLE Cargo(
	Id tinyint identity(1,1) primary key,
	Nombre varchar(30) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Empleado(
	Id smallint identity(1,1) primary key,
	IdCargo tinyint NOT NULL references Cargo(Id),
	NumeroDUI char(10) NOT NULL,
	Nombres varchar(60) NOT NULL,
	Apellidos varchar(60) NOT NULL,
	Sexo varchar(6) NOT NULL,
	FechaNacimiento date null,
	Direccion varchar(500) null,
	Telefono char(9) NOT NULL,
	Correo varchar(50) null,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Usuario(
	Id smallint identity(1,1) primary key,
	IdEmpleado smallint NOT NULL references Empleado(Id),
	Nombre varchar(25) NOT NULL,
	Clave varchar(MAX) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Departamento(
	Id tinyint IDENTITY(1,1) NOT NULL primary key,
	Nombre varchar(75) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
  ) 

CREATE TABLE Municipio (
	Id smallint IDENTITY(1,1) NOT NULL primary key,
	Nombre varchar(150) NOT NULL,
	IdDepartamento tinyint NOT NULL references Departamento(Id),
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE TipoDocumento(
	Id tinyint identity(1,1) primary key,
	Nombre varchar(25) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Proveedor(
	Id int identity(1,1) NOT NULL primary key,
	Nombre varchar(150) NOT NULL,
	RazonSocial varchar(150) NOT NULL,
	SectorComercial varchar(50) NOT NULL,
	IdTipoDocumento tinyint NOT NULL references TipoDocumento(Id),
	NumeroDocumento varchar(11) NOT NULL,
	Direccion varchar(150) null,
	IdMunicipio smallint NOT NULL references Municipio(Id),
	Telefono char(9) NOT NULL,
	Correo varchar(50) null,
	SitioWeb varchar(200) null,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Cliente(
	Id int identity(1,1) NOT NULL primary key,
	Nombres varchar(50) NOT NULL,
	Apellidos varchar(50) NOT NULL,
	Sexo char(1) NOT NULL,
	FechaNacimiento date null,
	IdTipoDocumento tinyint NOT NULL references TipoDocumento(Id),
	NumeroDocumento varchar(11) NOT NULL,
	Direccion varchar(150) null,
	IdMunicipio smallint NOT NULL references Municipio(Id),
	Telefono char(9) NOT NULL,
	Correo varchar(50) null,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE TipoMaterial(
	Id smallint identity(1,1) NOT NULL primary key,
	Nombre varchar(50) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Categoria(
	Id smallint identity(1,1) NOT NULL primary key,
	Nombre varchar(50) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Marca(
	Id smallint identity(1,1) NOT NULL primary key,
	Nombre varchar(50) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Producto(
	Id int identity(1,1) NOT NULL primary key,
	Codigo varchar(50) NOT NULL,
	Nombre varchar(150) NOT NULL,
	Descripcion varchar(1024) null,
	Existencia decimal(5,4) null,
	PrecioCosto float NOT NULL,
	PrecioVenta float NOT NULL,
	StockMinimo int NOT NULL,
	StockMaximo int NOT NULL,
	IdCategoria smallint NOT NULL references Categoria(Id),
	IdMarca smallint NOT NULL references Marca(Id),
	IdTipoMaterial smallint NOT NULL references TipoMaterial(Id),
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Imagen(
	Id int identity(1,1) NOT NULL primary key,
	IdProducto Int NOT NULL references Producto(Id),
	Binarios varbinary(max) Null,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE TipoComprobante(
	Id tinyint identity(1,1) primary key,
	NombreTipo varchar(25) NOT NULL,
	IdEstado tinyint NOT NULL references Estado(Id)
)

CREATE TABLE Ingreso(---Ingreso es decir compra
	Id bigint identity(1,1) primary key,
	IdUsuario smallint NOT NULL references Usuario(Id),
	IdProveedor int NOT NULL references Proveedor(Id),
	FechaIngreso date NOT NULL,
	IdTipoComprobante tinyint NOT NULL references TipoComprobante(Id),
	Serie char(5) NOT NULL,
	Correlativo char(7) NOT NULL,
	Iva decimal(4,2) NOT NULL
)

CREATE TABLE DetalleIngreso(---Ingreso es decir compra
	Id bigint identity(1,1) primary key,
	IdIngreso bigint NOT NULL references Ingreso(Id),
	IdProducto int NOT NULL references Producto(Id),
	PrecioCompra float NOT NULL,
	PrecioVenta float NOT NULL,
	StockActual int NOT NULL,
	FechaProduccion date NOT NULL,
	FechaVencimiento date NOT NULL
)

CREATE TABLE Venta(
	Id bigint identity(1,1) primary key,
	IdCliente int NOT NULL references Cliente(Id),
	IdUsuario smallint NOT NULL references Empleado(Id),
	FechaVenta date NOT NULL,
	IdTipoComprobante tinyint NOT NULL references TipoComprobante,
	Serie varchar(10) NOT NULL,
	Correlativo varchar(10) NOT NULL,
	Iva float NOT NULL,
	TotalVenta float NOT NULL
)

CREATE TABLE DetalleVenta(
	Id bigint identity(1,1) primary key,
	IdVenta bigint NOT NULL references Venta(Id),
	Cantidad int NOT NULL,
	PrecioCosto float NOT NULL,
	PrecioVenta float NULL,
	SubTotalVenta float NULL,
	Descuento float NULL
)
GO
INSERT Estado(Nombre) VALUES ('HABILITADO')
INSERT Estado(Nombre) VALUES ('DESHABILITADO')

INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Ahuachapán', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Santa Ana', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Sonsonate', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Chalatenango', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('La Libertad', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('San Salvador', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Cuscatlán', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('La Paz', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Cabañas', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('San Vicente', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Usulután', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('San Miguel', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('Morazán', 1)
INSERT INTO Departamento (Nombre, IdEstado) VALUES ('La Unión', 1)
GO


INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ahuachapán', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Apaneca', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Atiquizaya', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Concepción de Ataco', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Refugio', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Guaymango', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jujutla', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Menéndez', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Lorenzo', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Pedro Puxtla', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tacuba', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Turín', 1, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Candelaria de la Frontera', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chalchuapa', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Coatepeque', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Congo', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Provenir', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Masahuat', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Metapán', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio Pajonal', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Sebastián Salitrillo', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Ana', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Rosa Guachipilín', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santiago de la Frontera', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Texistepeque', 2, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Acajutla', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Armenia', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Caluco', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cuisnahuat', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Izalco', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Juayua', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nahuizalco', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nahuilingo', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Salcoatitán', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio del Monte', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Julián', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Catarina Massahuat', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Isabel Ishuatán', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santo Domingo de Guzmán', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sonsonate', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sonzacate', 3, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Agua Caliente', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Arcatao',  4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Azacualpa', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chalatenango', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Comalapa',  4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Citalá',  4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Concepcion Quezaltepeque', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Dulce Nombre de María', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Carrizal', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Paraíso', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('La Laguna', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('La Palma', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('La Reina', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Las Vueltas', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nueva Concepción', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nueva Trinidad', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nombre de Jesús', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ojos de Agua', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Potonico', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio de la Cruz', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio Los Ranchos', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Fernando', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Lempa', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Morazán', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Ignacio', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Isidro Labrador', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San José Cancasque', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San José Las Flores', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Luis del Carmen', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Miguel de Mercedez', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Rafael', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Rita', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tejutla', 4, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Antiguo Cuscatlán', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chiltiupán', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ciudad Arce', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Colón', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Comasagua', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Huizúcar', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jayaque', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jicalapa', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('La Libertad', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Tecla', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nuevo Cuscatlán', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Juan Opico',  5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Quetzaltepeque',  5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sacacoyo', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San José Villanueva', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Matías', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Pablo Tacachico', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Talnique', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tamanique', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Teotepeque', 5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tepecoyo',  5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Zaragoza',  5, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Aguilares',  6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Apopa', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ayutuxtepeque',  6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cuscatancingo',  6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ciudad Delgado', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Paisnal', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Guazapa',  6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ilopango', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Mejicanos', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nejapa', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Panchimalco', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Rosario de Mora', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Marcos', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Martín', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Salvador', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santiago Texacuangos', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santo Tomás', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Soyapango', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tonacatepeque', 6, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Candelaria', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cojutepeque', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Carmen', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Rosario', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Monte San Juan', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Oratorio de Concepción', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Bartolomé Perulapía', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Cristobal', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San José Guayabal',  7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Pedro Perulapán', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Rafael Cedros', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Ramón', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Cruz Analquito', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Cruz Michapa', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Suchitoto', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tenancingo', 7, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cuyutitán', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Rosario', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jerusalén', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Mercedes La Ceiba', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Olocuilta', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Paraíso de Osorio', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio Masahuat', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Emigdio', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Chinameca', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Juan Nonualco', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Juan Talpa', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Juan Tepezontes', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Luis Talpa', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Luis La Herradura', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Miguel Tepezontes', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Pedro Masahuat', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Pedro Nonualco', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Rafael Obrajuelo', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa María Ostuma', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santiago Nonualco', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tapahualca', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Zacatecoluca', 8, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cinquera', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Dolores', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Guacotecti', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ilobasco', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jutiapa', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Isidro', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sensuntepeque', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tejutepeque', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Victoria', 9, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Apastepeque', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Guadalupe', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Cayetano Istepeque', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Esteban Catarina', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Ildefonso', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Lorenzo', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Sebastián', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Vicente', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Clara', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santo Domingo', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tecoluca', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tepetitán', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Verapaz', 10, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Alegría', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Berlín', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('California', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Concepción Batres', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Triunfo', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ereguayquil', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Estanzuelas', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jiquilisco', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jucuapa', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jucuarán', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Mercedes Umaña', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nueva Granada', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ozatlán', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Puerto El Triunfo',  11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Agustín', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Buenaventura', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Dionisio', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Javier', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Elena', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa María', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santiago de María', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Tecapán', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Usulután', 11, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Carolina', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chapeltique', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chinameca', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chirilagua', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Ciudad Barrios', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Comacarán', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Tránsito', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Lolotique', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Moncagua', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nueva Guadalupe', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nuevo Edén de San Juan', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Quelepa', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Antonio del Mosco', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Gerardo', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Jorge', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Luis de la Reina', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Miguel', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Rafel Oriente', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sesori', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Uluazapa', 12, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Arambala', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Cacaopera', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Chilanga', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Corinto', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Delicias de Concepción', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Divisadero', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Rosario', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Gualococti', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Guatajiagua', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Joateca', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jocoaitique', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Jocoro', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Lolotiquillo', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Meanguera', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Osicala', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Perquín', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Carlos',  13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Fernando', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Francisco Gotera', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Isidro', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Simón', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sensembra', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Sociedad', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Torola', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Yamabal', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Yoloaiquín', 13, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Anamorós', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Bolívar', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Concepción de Oriente', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Conchagua', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Carmen', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('El Sauce', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Intipucá', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('La Union', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Lislique', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Meanguera del Golfo', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Nueva Esparta', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Pasaquina', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Polorós', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San Alejo', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('San José la Fuente', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Santa Rosa de Lima', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Yayantique', 14, 1)
INSERT INTO Municipio (Nombre, IdDepartamento, IdEstado) VALUES ('Yucuaiquín', 14, 1)

GO
