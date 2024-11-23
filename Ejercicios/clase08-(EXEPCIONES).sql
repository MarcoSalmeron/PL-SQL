SET SERVEROUTPUT ON

DECLARE
  reg_max EXCEPTION;
  regn NUMBER;
  regt VARCHAR2(200);
BEGIN
  regn := 11;
  regt := 'ASIA';
  If regn > 100 THEN
    RAISE reg_max;
  ELSE
    INSERT INTO REGIONS VALUES (regn, regt);
  END IF;
EXCEPTION
  WHEN reg_max THEN
    dbms_output.put_line('La region no puede ser mayor de 100');
  WHEN OTHERS THEN
    dbms_output.put_line('Error indefinido!');
END;

-- Ejercicio 02
DECLARE
control_regiones EXCEPTION;
codigo NUMBER := 192;
BEGIN
  IF codigo > 200 THEN
    RAISE control_regiones;
  ELSE
    INSERT INTO REGIONS VALUES (codigo, 'Prueba');
  END IF;

EXCEPTION
  WHEN control_regiones THEN
    dbms_output.put_line('El codigo para la region no puede ser mayor a 200');
  WHEN OTHERS THEN
    dbms_output.put_line(SQLCODE);
    dbms_output.put_line(SQLERRM);
END;

--Ambito de las excepciones
DECLARE
  
  regn NUMBER;
  regt VARCHAR2(200);
BEGIN
  regn := 110;
  regt := 'ASIA';
  DECLARE
    reg_max EXCEPTION;
  BEGIN
    If regn > 100 THEN
      RAISE reg_max;
    ELSE
      INSERT INTO REGIONS VALUES (regn, regt);
      COMMIT;
    END IF;
  END;
EXCEPTION
  WHEN reg_max THEN
    dbms_output.put_line('La region no puede ser mayor de 100');
  WHEN OTHERS THEN
    dbms_output.put_line('Error indefinido!');
END;

--Comando RAISE_APLICATION_ERROR
DECLARE
  regn NUMBER;
  regt VARCHAR2(200);
BEGIN
  regn := 110;
  regt := 'ASIA';
  If regn > 100 THEN
    -- EL dodigo debe estar entre -20,000 y -20,999
    RAISE_APPLICATION_ERROR(-20001,'EL ID NO PUEDE SER MAYOR A 100');
  ELSE
    INSERT INTO REGIONS VALUES (regn, regt);
    COMMIT;
  END IF;
END;

-- Ejercicio 03
DECLARE
codigo NUMBER := 250;
BEGIN
  IF codigo > 200 THEN
    RAISE_APPLICATION_ERROR(-20002,'EL ID NO PUEDE SER MAYOR A 200');
  ELSE
    INSERT INTO REGIONS VALUES (codigo, 'Prueba');
  END IF;

END;

-- RECORD TYPE nombre IS RECORD(camp1,campo,2,...,campon);
/*
TYPE empleado is RECORD
  (nombre VARCHAR2(100),
  salario NUMBER,
  fecha_ingreso EMPLOYEES.HIRE_DATE%TYPE
  datos EMPLOYEES%ROWTYPE);
empl1 empleado;
*/

DECLARE
  TYPE empleado IS RECORD -- Tabla con Atributos
    (nombre VARCHAR2(100),
    salario NUMBER,
    fecha EMPLOYEES.HIRE_DATE%TYPE,
    datos EMPLOYEES%ROWTYPE); -- Variable Con Estructura de Tabla Completa

  emp empleado;
BEGIN
  SELECT * INTO emp.datos
  FROM EMPLOYEES WHERE employee_id = 100;
  emp.nombre := emp.datos.FIRST_NAME||' '||emp.datos.LAST_NAME;
  emp.salario := emp.datos.SALARY*0.80;
  emp.fecha := emp.datos.HIRE_DATE;
  
  dbms_output.put_line(emp.nombre);
  dbms_output.put_line(emp.salario);
  dbms_output.put_line(emp.fecha);
  dbms_output.put_line(emp.datos.FIRST_NAME);
END;

CREATE TABLE REGIONES AS SELECT * FROM REGIONS WHERE REGION_ID = 0;

DECLARE
 reg1 REGIONS%ROWTYPE; -- Estructura de Registro Completo

BEGIN
  SELECT * INTO reg1 FROM REGIONS WHERE REGION_ID = 1;
  -- INSERT
  INSERT INTO REGIONES VALUES reg1; -- Insertar Valores de El registro Completo
  COMMIT;
  
END;

DECLARE
  reg1 REGIONS%ROWTYPE;
BEGIN
  reg1.REGION_ID:=1;
  reg1.REGION_NAME:='AAAAAA';
  -- UPDATE
  UPDATE REGIONES SET ROW=reg1 WHERE REGION_ID=1; -- Inserta los valores de todas las Columnas
END;

-- SINTAXIS ARRAY ASSOCIATIVOS
/*
TYPE nombre IS TABLE OF
  TIPO COLUMNA
  INDEX BY PLS_INTEGER|BINARY_INTEGER|VARCHAR(x);
  Variable TIPO:

TYPE DEPARTAMENTOS IS TABLE OF
  DEPARTAMENTS.DEPARTMNET_NAME%TYPE;
  INDEX BY PLS_INTEGER;

ARRAY(N).CAMPO
-- EXIST(N)
-- COUNT
-- FIRST
-- LAST
-- PRIOR(N)
-- NEXT(N) 
-- DELETE
-- DELETE(N)
-- DELETE(M,N) 
*/

DECLARE
  TYPE DEPARTAMENTOS IS TABLE OF
    DEPARTMENTS.DEPARTMENT_NAME%TYPE
  INDEX BY PLS_INTEGER;
  
  TYPE EMPLEADOS IS TABLE OF
    EMPLOYEES%ROWTYPE
  INDEX BY PLS_INTEGER;
  
  dep DEPARTAMENTOS;
  emp EMPLEADOS;
BEGIN
  -- TIpo Simple
  /*
  dep(1):='INFORMATICA';
  dep(2):='RRHH';
  dep(55):='PRUEBA';
  dbms_output.put_line(dep(1));
  dbms_output.put_line(dep(2));
  dbms_output.put_line(dep.LAST); --2
  dbms_output.put_line(dep.FIRST); --1
  IF dep.EXISTS(3) THEN
    dbms_output.put_line(dep(3));
  ELSE
    dbms_output.put_line('El valor no existe');
  END IF;
  */
  
  --TIPO COMPUESTO
  SELECT * INTO emp(1) FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
  SELECT * INTO emp(2) FROM EMPLOYEES WHERE EMPLOYEE_ID=108;
  dbms_output.put_line(emp(1).FIRST_NAME);
  dbms_output.put_line(emp(1).JOB_ID);
  dbms_output.put_line(emp(2).FIRST_NAME);
  dbms_output.put_line(emp(2).JOB_ID);
END;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  









































