-- Paquetes predefinidos de Oracle
/*
DBMS_OUTPUT
UTL_FILE
UTL_MAIL
DBMS_ALERT
DBMS_LOCK

UTL_FILE
1.- permisos al usuario
GRANT CREATE ANY DIRECTORY TO HR;
GRANT EXECUTE ON SYS.UTL_FILE TO HR;

2.- Crear un directorio.

*/

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE leer_archivo IS
  dato VARCHAR2(32767);
  Vfile UTL_FILE.FILE_TYPE;
BEGIN
  -- abrir el fichero
  Vfile := UTL_FILE.FOPEN('EJERCICIO','f1.txt','R');
  LOOP
    BEGIN
      -- leer las lineas
      UTL_FILE.GET_LINE(Vfile, dato);
      --dbms_output.put_line(dato);
      INSERT INTO F1 VALUES(dato);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN EXIT;
    END;
  END LOOP;
  -- Cerrar nuestro fichero
  UTL_FILE.FCLOSE(Vfile);
END;

-- Ejercicio 01

-- Package HEAD
CREATE OR REPLACE PACKAGE regiones1 IS
  PROCEDURE alta_region(codigo NUMBER, nombre VARCHAR2);
  PROCEDURE baja_region(id NUMBER);
  PROCEDURE mod_region(id NUMBER, nombre VARCHAR2);
  FUNCTION con_region(codigo NUMBER) RETURN VARCHAR2;
END regiones1;

-- Package BODY 
CREATE OR REPLACE PACKAGE BODY regiones1 IS
  --funcion EXISTE_REGION PRIVADA
  FUNCTION existe_region(id NUMBER, nombre VARCHAR2)
  RETURN BOOLEAN
  IS
    CURSOR C1 IS SELECT REGION_NAME, REGION_ID FROM REGIONS;
  BEGIN
    FOR i IN C1 LOOP
      IF i.REGION_NAME = nombre AND i.REGION_ID = id THEN
        RETURN TRUE;
      END IF;
    END LOOP;
    RETURN FALSE;
  END;
  -- PROCEDURE ALTA_REGION
  PROCEDURE alta_region(codigo NUMBER, nombre VARCHAR2)
  IS
    verificador BOOLEAN;
  BEGIN
    verificador := existe_region(codigo, nombre);
    IF verificador = FALSE THEN
      INSERT INTO REGIONS(REGION_ID, REGION_NAME) VALUES(codigo, nombre);
      dbms_output.put_line('Registro agregado correctamente.');
    ELSE
      dbms_output.put_line('La region ya existe!');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
       dbms_output.put_line('EL REGION_ID ya existe(duplicado)');
  END;
  -- PROCEDURE BAJA_REGION
  PROCEDURE baja_region(id NUMBER) IS
    verificador BOOLEAN;
    nombre VARCHAR2(30);
  BEGIN
    SELECT REGION_NAME INTO nombre FROM REGIONS WHERE REGION_ID = id;
    verificador := existe_region(id, nombre);
    IF verificador = TRUE THEN
      DELETE FROM REGIONS WHERE REGION_ID = id;
      dbms_output.put_line('Region con ID '||id||' borrada');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('La region no existe!');
  END;
  -- FUNCTION CON_REGION
  FUNCTION con_region(codigo NUMBER) RETURN VARCHAR2 IS
    nombre VARCHAR2(30);
  BEGIN
    SELECT REGION_NAME INTO nombre FROM REGIONS WHERE REGION_ID = codigo;
    RETURN nombre;
  END;
  -- PROCEDURE MOD_REGION
  PROCEDURE mod_region(id NUMBER, nombre VARCHAR2) IS
    verificador BOOLEAN;
    nombre_region VARCHAR2(30);
  BEGIN
    nombre_region := con_region(id);
    verificador := existe_region(id, nombre_region);
    IF verificador = TRUE THEN
      UPDATE REGIONS SET REGION_NAME=nombre WHERE REGION_ID=id;
      dbms_output.put_line('La region ha sido actualizada correctamente');
    ELSE 
      dbms_output.put_line('La region no existe');
    END IF;
  END;
  END regiones1;

