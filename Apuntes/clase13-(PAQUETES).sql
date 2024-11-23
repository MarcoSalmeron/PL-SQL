CREATE OR REPLACE FUNCTION salario_out(dep NUMBER, n_empleados OUT NUMBER) 
RETURN NUMBER
IS
  sal NUMBER;
  depart DEPARTMENTS.DEPARTMENT_ID%TYPE;
  --num_emp NUMBER;
BEGIN
  SELECT DEPARTMENT_ID INTO depart FROM DEPARTMENTS WHERE DEPARTMENT_ID = dep;
  SELECT SUM(SALARY), COUNT(SALARY) INTO sal, n_empleados FROM EMPLOYEES WHERE DEPARTMENT_ID = dep GROUP BY DEPARTMENT_ID;
  RETURN sal;
END;

-- Ejercicio 03

CREATE OR REPLACE FUNCTION crear_region(nombre VARCHAR2)
RETURN NUMBER
IS
  region NUMBER;
  nom_region VARCHAR2(100);
BEGIN
  -- averiguar si existe la region
  SELECT REGION_NAME INTO nom_region FROM REGIONS WHERE REGION_NAME = UPPER(nombre);
  RAISE_APPLICATION_ERROR(-20321, 'Esta region ya existe!');
EXCEPTION
  --si la region no existe
  WHEN NO_DATA_FOUND THEN
    SELECT MAX(REGION_ID)+1 INTO region FROM REGIONS;
    INSERT INTO REGIONS(REGION_ID, REGION_NAME) VALUES(region, UPPER(nombre));
    RETURN region;
END;

-- PAQUETES
CREATE OR REPLACE PACKAGE pack1
IS
  PROCEDURE CONVERT(nombre VARCHAR2, conversion_type CHAR);
END;

CREATE OR REPLACE PACKAGE BODY pack1
IS
  FUNCTION UP(nombre VARCHAR2)
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN UPPER(nombre);
  END;
  FUNCTION LO(nombre VARCHAR2)
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN LOWER(nombre);
  END;
  PROCEDURE CONVERT (nombre VARCHAR2, conversion_type CHAR)
  IS
  BEGIN
    IF conversion_type = 'U' THEN
      dbms_output.put_line(UP(nombre));
    ELSIF conversion_type = 'L' THEN
      dbms_output.put_line(LO(nombre));
    ELSE
      dbms_output.put_line('El parametro debe ser U o L');
    END IF;
  END CONVERT;
END pack1;


-- Usar funciones de un paquete en comando SQL

CREATE OR REPLACE PACKAGE pack1
IS
  FUNCTION CONVERT(nombre VARCHAR2, conversion_type CHAR) RETURN VARCHAR2;
END;

CREATE OR REPLACE PACKAGE BODY pack1
IS
  FUNCTION UP(nombre VARCHAR2)
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN UPPER(nombre);
  END;
  FUNCTION LO(nombre VARCHAR2)
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN LOWER(nombre);
  END;
  FUNCTION CONVERT (nombre VARCHAR2, conversion_type CHAR)
  RETURN VARCHAR2
  IS
  BEGIN
    IF conversion_type = 'U' THEN
      RETURN UP(nombre);
    ELSIF conversion_type = 'L' THEN
      RETURN LO(nombre);
    ELSE
      dbms_output.put_line('El parametro debe ser U o L');
    END IF;
  END CONVERT;
END pack1;































































