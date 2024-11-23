-- HEADER
CREATE OR REPLACE TYPE PRODUCTO AS OBJECT (
--ATRIBUTOS
codigo NUMBER,
nombre VARCHAR2(100),
precio NUMBER,

--METODOS
--SELF
MEMBER FUNCTION ver_producto RETURN VARCHAR,
MEMBER FUNCTION ver_precio RETURN NUMBER,
MEMBER FUNCTION ver_precio(impuesto NUMBER) RETURN NUMBER,
MEMBER PROCEDURE cambiar_precio(precio NUMBER),
MEMBER PROCEDURE mayus,
STATIC PROCEDURE auditoria,
CONSTRUCTOR FUNCTION PRODUCTO(n1 VARCHAR2) RETURN SELF AS RESULT
)NOT FINAL;

--DROP TYPE PRODUCTO;

--BODY
CREATE OR REPLACE TYPE BODY PRODUCTO AS
  MEMBER FUNCTION ver_producto RETURN VARCHAR AS
  BEGIN
    RETURN 'Codigo-->'||codigo||' Nombre-->'||nombre||' Precio-->'||precio;
  END ver_producto;

  MEMBER FUNCTION ver_precio RETURN NUMBER AS
  BEGIN
    return precio;
  END ver_precio;
  
  MEMBER FUNCTION ver_precio(impuesto NUMBER) RETURN NUMBER AS
  BEGIN
    RETURN precio -(precio*impuesto/100);
  END ver_precio;
  
  MEMBER PROCEDURE cambiar_precio(precio NUMBER) AS
  BEGIN
    self.precio:=precio;
  END cambiar_precio;
  
  MEMBER PROCEDURE mayus AS
  BEGIN
    nombre:=upper(nombre);
  END mayus;
  
  STATIC PROCEDURE auditoria AS
  BEGIN
    INSERT INTO AUDITORIA VALUES(USER, SYSDATE);
  END auditoria;
  
  CONSTRUCTOR FUNCTION PRODUCTO(n1 VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
      SELF.nombre := n1;
      SELF.precio := NULL;
      SELF.codigo := SEQ1.NEXTVAL;
      RETURN;
    END;
END;

--HERENCIA
/*
SE USA LA CLAUSULA UNDER
PARA QUE SEA HEREDABLE, EL OBJETO O EL METODO DEBE SER "NOT FINAL"
*/

-- HEADER
CREATE OR REPLACE TYPE COMESTIBLES UNDER PRODUCTO(
caducidad DATE,
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2,
OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER
);

--BODY
CREATE OR REPLACE TYPE BODY COMESTIBLES AS
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2 AS
BEGIN
  RETURN caducidad;
END;

OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER AS
BEGIN
  return precio + 10;
END;
END;

DROP TYPE COMESTIBLES;

-- COLUMNAS DE TIPO OBJETO EN UNA TABLA
CREATE TABLE TIENDA(
codigo NUMBER,
estanteria NUMBER,
producto PRODUCTO
);

DESC TIENDA;

INSERT INTO TIENDA VALUES(1,1,PRODUCTO(1,'Limon',90));

SELECT * FROM TIENDA;

SELECT t.PRODUCTO.precio FROM TIENDA t;

SELECT t.PRODUCTO.cambiar_precio(100) FROM TIENDA t;

--JSON
/*
json_value
json_query
json_table
json_exist
is json / is not json
json_transform

--PLSQL
JSON_ELEMENT_T 
JSON_OBJECT_T 
JSON_ARRAY_T
JSON_SCALAR_T
JSON_KEY_LIST
*/

CREATE TABLE PRODUCTOS1(
codigo INT,
nombre VARCHAR2(200),
datos JSON
);

DESC PRODUCTOS1;

INSERT INTO PRODUCTOS1
VALUES(1,'Ejemplo1',
'{
   "pais" : "Argentina",
   "ciudad" : "Buenos Aires",
   "poblacion" : 1000000
}'
);

SELECT datos FROM PRODUCTOS1;

INSERT INTO PRODUCTOS1
VALUES(3,'Ejemplo3',
'{
   "pais" : "Argentina",
   "ciudad" : "Buenos Aires",
   "poblacion" : 1000000,
   "direccion" : {
            "calle" : "calle1",
            "piso" : 5,
            "puerta" : "c"
   }
}'
);


SELECT prd1.datos.direccion FROM PRODUCTOS1 prd1;
SELECT prd1.datos.direccion.puerta FROM PRODUCTOS1 prd1;

CREATE TABLE ejemplo(
codigo INT,
fichero CLOB
);

INSERT INTO ejemplo VALUES(1,'{"col1" : "prueba"}');
INSERT INTO ejemplo VALUES(2,'Esto es una prueba');
INSERT INTO ejemplo VALUES(3,'<doc><col>preuba</doc></doc>');

SELECT * FROM ejemplo WHERE fichero IS JSON;

SELECT * FROM ejemplo WHERE fichero IS NOT JSON;

--JSON DEVELOPER GUIDE
SELECT prd1.datos FROM PRODUCTOS1 prd1 WHERE JSON_EXISTS(prd1.datos,'$.ciudad');

SELECT JSON_VALUE(prd1.datos,'$.direccion') FROM PRODUCTOS1 prd1;

SELECT JSON_QUERY(prd1.datos,'$.pais') FROM PRODUCTOS1 prd1;

SELECT JSON_QUERY(prd1.datos,'$.direccion') FROM PRODUCTOS1 prd1;

SELECT J_Pais FROM PRODUCTOS1 prd1, JSON_TABLE(prd1.datos, '$' COLUMNS(J_Pais PATH '$.pais'));

SELECT J_Pais,J_Ciudad FROM PRODUCTOS1 prd1, JSON_TABLE(prd1.datos, '$' COLUMNS
(J_Pais PATH '$.pais', J_Ciudad PATH '$.ciudad'));




















































