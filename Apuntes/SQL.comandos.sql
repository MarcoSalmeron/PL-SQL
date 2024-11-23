-- Crear Base de Datos
CREATE DATABASE escuela;
-- Crear Tabla BasedeD.tabla = (Crear Clava Primaria y Atributos)
CREATE TABLE escuela.estudiantes(id_estudiante INT NOT NULL auto_increment, 
nombre varchar(10) not null, apellido varchar(10) not null,
 edad int(2) not null, genero varchar(10)not null,
 calificacion decimal(5,2)not null, primary key(id_estudiante));
-- Eliminar Tabla 
 drop table escuela.estudiantes;
 -- Mostrar Tabla
select * from escuela.estudiantes; 
-- Insertar Valores a los Atributos BD.tabla(*Atributos*) Values(*Valores*)
insert into escuela.estudiantes(nombre,apellido,edad,genero,calificacion) values("Juan","Mendoza",26,"masculino",7.8);
insert into escuela.estudiantes(nombre,apellido,edad,genero,calificacion) values("Maria","Rosas",22,"femenino",9.8);
insert into escuela.estudiantes(nombre,apellido,edad,genero,calificacion) values("Marco","Ramirez",20,"masculino",8.0);
insert into escuela.estudiantes(nombre,apellido,edad,genero,calificacion) values("Juan","Zacarias",32,"masculino",6.5);
insert into escuela.estudiantes(nombre,apellido,edad,genero,calificacion) values("Paola","Cebedo",23,"femenino",8.2); 
-- Mostrar Columna nombre
select nombre from escuela.estudiantes;
-- Buscar calificacion menor a 8
select * from escuela.estudiantes where calificacion <= 8;
-- Buscar personal femenino
select * from escuela.estudiantes where genero = "femenino";
-- Buscar por edad
select * from escuela.estudiantes where edad <= 26;
-- Buscar personal masculino
select * from escuela.estudiantes where genero = "masculino";

-- cargar ejemplo
use world;
select * from country;
-- Buscar Continente Especifico con expectativa Media
select * from world.country where (Continent = "North America") and (LifeExpectancy > 70.0);
-- Ordenar por capital asendente
select * from world.country order by Capital ASC ; 
-- Ordenar por gobierno y espectativa baja de vida 
select * from world.country where (GovernmentForm = "Republic") and (LifeExpectancy < 40.0) order by LifeExpectancy ASC;

-- Ordenar Expectativa decreciente
select * from world.country order by LifeExpectancy DESC;
-- buscar solo a dos continentes
select * from world.country where Continent in ("Africa","North America") order by Capital between 10 and 100;

-- Crear BD con Tabla de productos
create database Tienda;
create table Tienda.Productos(ID int(2) not null auto_increment, Producto varchar(10) not null,
 Categoria varchar(20) not null, Precio decimal(5,2) not null, primary key(ID));
-- Insertar Valores en la Tabla de forma desordenada
insert into Tienda.Productos(Producto,Categoria,Precio) values('Laptop','Electronico',200.0);
insert into Tienda.Productos(Producto,Categoria,Precio) values('Camisa','Ropa',50.20);
insert into Tienda.Productos(Producto,Categoria,Precio) values('Mouse','Electronico',100.50);
insert into Tienda.Productos(Producto,Categoria,Precio) values('Jeans','Ropa',150.20);
insert into Tienda.Productos(Producto,Categoria,Precio) values('Pizza','Comida',200.20);
insert into Tienda.Productos(Producto,Categoria,Precio) values('Celular','Electronico',500.50);
-- Mostrar Tabla
select * from Tienda.Productos;
-- Ordenar Precio Total por Categoria
Select Categoria, SUM(Precio) 
From Tienda.Productos 
Group By Categoria;
select * from world.countrylanguage group by Language;
select Language, count(*) as Number_Country from world.countrylanguage group by Language;
select * from world.country;
-- Ordenar por lenguaje Oficial y no Oficial
select IsOfficial, count(IsOfficial) as Total
from world.countrylanguage group by IsOfficial; 
select Continent, char_length(Continent);

SELECT 'Name', Longitud FROM(
    select CHAR_LENGTH('Continent') AS Longitud FROM world.country
) AS Subconsulta
WHERE Longitud >6;
-- Ejemplo Elaborado
-- Crear subconsulta en Donde se determine alumnos aprobados por edad desendiente
SELECT nombre, edad , Status FROM (
SELECT nombre , edad, 
CASE 
WHEN calificacion >= 8 THEN 'Alumno Aprobado'
WHEN calificacion < 8 THEN 'Alumno Reprobado'  
ELSE 'Alumno sin calificacion'  
END AS Status FROM escuela.estudiantes
) AS Subconsulta
ORDER BY edad DESC;
-- Seleccionar Distritos que no empiecen con B y ordenar a la poblacion asendetemente menor de 50.000
SELECT * FROM world.city WHERE District NOT LIKE 'B%' AND Population < 50000
ORDER BY `Population` ASC;
-- Subconsulta de los distritos con sobrepoblacion
SELECT CONCAT_WS('---',`Name`,`District`,TOTAL) AS Nombre_Distrito_Poblacion FROM (
SELECT `Name`,`District`,
CASE 
WHEN Population > 100000 THEN 'Sobrepoblado'
WHEN Population < 100000 THEN 'Despoblado'  
END AS TOTAL FROM world.city
) AS subconsulta;
-- Buscar Regionescon esperanza de vida peligrosa
SELECT CONCAT_WS('---',`Continent`,`Region`, esperanza) FROM (
    SELECT `Continent`,`Region`,
    CASE 
        WHEN `LifeExpectancy` < 40 THEN 'Region Peligrosa'
        WHEN `LifeExpectancy` >= 40 THEN 'Region Aceptable'
        WHEN `LifeExpectancy` > 66 THEN 'Region Lujosa'  
        ELSE 'Sin Datos...'
    END AS esperanza FROM world.country
) AS subconsulta;
-- Mostrar consulta de Nombre, Continente y mostrar lenguaje consultanto  otra tabla(Subconsulta) 
SELECT CONCAT_WS('***',`Name`,`Continent`, Lenguaje) AS Nombre_Continente_Lenguaje FROM (
    SELECT CONCAT_WS('--',`Language`,`IsOfficial`) AS Lenguaje  FROM world.countrylanguage LIMIT 100
) AS Subconsulta1 , (
    SELECT `Name`,`Continent` FROM world.country
) AS Subconsulta2;

SELECT Name,Region, IndepYear, (Population / SurfaceArea) AS Densidad
FROM world.country
WHERE Region = 'Northern Africa' AND `IndepYear` < 1960
ORDER BY Densidad DESC LIMIT 5;
-- Ordenar superficie y población,GNP 
SELECT `SurfaceArea`,`Population`,`GNP`,`GNPOld`,
CASE 
    WHEN `SurfaceArea` < 50000 THEN  'Terreno Pequenno'
    WHEN `SurfaceArea` >= 50000 AND `SurfaceArea` < 1000000 THEN 'Terreno Mediano'
    WHEN `SurfaceArea` > 1000000 THEN 'Terreno Grande'
    ELSE  '*Sin Datos*'
END AS Superficie,
CASE 
    WHEN `Population` < 1000000 THEN  'Poblacion: Baja'
    WHEN `Population` > 1000000 AND `Population` < 10000000 THEN 'Poblacion: Media'
    WHEN `Population` > 10000000 THEN 'Poblacion: Alta'
    ELSE '*Sin Datos*' 
END AS Poblacion ,
CASE 
    WHEN `GNP` > `GNPOld` THEN GNP * 1.10 
    WHEN `GNP` < `GNPOld` THEN GNP * 0.95
    ELSE 'Sin Datos'
END AS ProductoNacionalBruto FROM world.country
GROUP BY `SurfaceArea`,`Population`,`GNP`,`GNPOld`
ORDER BY ProductoNacionalBruto ASC;
-- Actualizar un Atributo con Change
UPDATE world.country SET `Name` = 'Holamundo' WHERE `Continent` = 'Asia';
SELECT * FROM world.country WHERE `Continent` = 'Asia';
-- Cambiar TTabla
Alter Table world.city ADD column Country varchar(10);
UPDATE world.city Set Country = 'Mexico' WHERE Population Between 0 AND 10;
UPDATE world.city Set Country = 'Rusia' WHERE Population Between 10 AND 30000;
UPDATE world.city Set Country = 'Canada' WHERE Population < 30000;
SELECT * From world.city;
UPDATE world.city SET District = 'Prueba000' 
WHERE CountryCode = 'BMU';

-- Crear Tablas de las Entidades
CREATE Table AEROLINEA.Vuelos(ID_Vuelo INT NOT NULL AUTO_INCREMENT, ID_AVION INT NOT NULL,
 Fecha_Salida DATETIME NOT NULL,Hora_Salida TIME NOT NULL,Duracion VARCHAR(15) NOT NULL,
 Origen VARCHAR(15) NOT NULL, Destino VARCHAR(15) NOT NULL, PRIMARY KEY(ID_Vuelo));

CREATE Table AEROLINEA.Aviones(ID_AVION INT NOT NULL AUTO_INCREMENT, Modelo VARCHAR(15) NOT NULL, 
Capacidad_Asientos INT(2)NOT NULL,Aerolinea VARCHAR(15) NOT NULL, PRIMARY KEY(ID_AVION));

CREATE Table AEROLINEA.Reservas(ID_Reserva INT NOT NULL AUTO_INCREMENT, ID_Vuelo INT ,
ID_Pasajero INT ,Fecha_Reserva datetime NOT NULL, Estado_Reserva VARCHAR(10), PRIMARY KEY(ID_Reserva));

DROP TABLE aerolinea.Reservas; 

CREATE Table AEROLINEA.Pasajeros(ID_Pasajero INT NOT NULL AUTO_INCREMENT, Nombre VARCHAR(10) NOT NULL, 
Apellidos VARCHAR(15)NOT NULL, Nacimiento DATETIME NOT NULL, Telefono INT(10) NOT NULL , PRIMARY KEY(ID_Pasajero));
Select * From aerolinea.Reservas;
Select * From aerolinea.Aviones;
Select * From aerolinea.Vuelos;
Select * From aerolinea.Pasajeros;
-- Agregar valores Pasajeros
INSERT INTO aerolinea.Pasajeros(Nombre,Apellidos,Nacimiento,Telefono) VALUES('Marco','Ramirez','2004-01-23',22665437);
INSERT INTO aerolinea.Pasajeros(Nombre,Apellidos,Nacimiento,Telefono) VALUES('Paola','Rossel','2003-03-13',55005441);
INSERT INTO aerolinea.Pasajeros(Nombre,Apellidos,Nacimiento,Telefono) VALUES('Rosa','Melendez','1980-06-09',44005451);
INSERT INTO aerolinea.Pasajeros(Nombre,Apellidos,Nacimiento,Telefono) VALUES('Edwin','Ramos','2004-02-20',33005437);
INSERT INTO aerolinea.Pasajeros(Nombre,Apellidos,Nacimiento,Telefono) VALUES('Jesus','Rivas','2004-03-09',22330031);

-- Agregar Valores Avion
INSERT INTO aerolinea.Aviones(Modelo,Capacidad_Asientos,Aerolinea) VALUES('X-23',50,'Aeromexico');
INSERT INTO aerolinea.Aviones(Modelo,Capacidad_Asientos,Aerolinea) VALUES('X-25',30,'VivaAerobus');
INSERT INTO aerolinea.Aviones(Modelo,Capacidad_Asientos,Aerolinea) VALUES('Y-86',70,'CanadianLine');
INSERT INTO aerolinea.Aviones(Modelo,Capacidad_Asientos,Aerolinea) VALUES('Y-99',90,'JapanAirLines');
INSERT INTO aerolinea.Aviones(Modelo,Capacidad_Asientos,Aerolinea) VALUES('Z-90',70,'International');

INSERT INTO `aerolinea`.`Vuelos` (`ID_Vuelo`, `ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('1', '100', '2024-01-23', '18:30:00', '5 minutos', 'CDMX', 'Puebla');
INSERT INTO `aerolinea`.`Vuelos` (`ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('1', '2024-01-25', '18:30:05', '10 minutos', 'CDMX', 'Chile');
INSERT INTO `aerolinea`.`Vuelos` (`ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('3', '2024-01-27', '18:30:15', '20 minutos', 'CDMX', 'Canada');
INSERT INTO `aerolinea`.`Vuelos` (`ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('5', '2024-02-05', '18:30:30', '30 minutos', 'Toronto', 'Veracruz');
INSERT INTO `aerolinea`.`Vuelos` (`ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('4', '2024-02-22', '19:00:15', '40 minutos', 'L.A', 'Cuba');
INSERT INTO `aerolinea`.`Vuelos` (`ID_AVION`, `Fecha_Salida`, `Hora_Salida`, `Duracion`, `Origen`, `Destino`) VALUES ('2', '2024-03-10', '13:40:00', '50 minutos', 'CDMX', 'Culiacan');
alter table aerolinea.Reservas Change column Fecha_Reserva Fecha_Reserva date;
-- inner JOIN                                (tabla2.fk1 = tabla1.pk1 )
SELECT * FROM reservas INNER JOIN Pasajeros ON Reservas.ID_Pasajero=Pasajeros.ID_Pasajero;
SELECT ID_Reserva, Fecha_Reserva, Estado_Reserva, ID_Vuelo, Nombre, Apellidos, Telefono FROM reservas JOIN pasajeros ON Reservas.ID_Pasajero = Pasajeros.ID_Pasajero WHERE Estado_Reserva = "espera";
-- Reservas de octubre en adelante con estado en espera
SELECT * FROM reservas, pasajeros
WHERE Estado_Reserva = 'espera' AND Fecha_Reserva BETWEEN '2024-09-01' AND '2025-01-01';
