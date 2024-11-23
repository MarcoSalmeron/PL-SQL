SET SERVEROUTPUT ON

DECLARE
  salario_maximo EMPLOYEES.SALARY%TYPE;
BEGIN
  SELECT MAX(SALARY) INTO salario_maximo
  FROM EMPLOYEES
  WHERE department_id = 100;
  dbms_output.put_line('El salario maximo de ese departamento es: ' || salario_maximo);
END;

-- Ejercicio 03
DECLARE
  cod DEPARTMENTS.DEPARTMENT_ID%TYPE := 60;
  nombre DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  num_empleados NUMBER;
  
BEGIN
  --Recuperar el nombre del departamento
  SELECT DEPARTMENT_NAME INTO nombre
  FROM DEPARTMENTS
  WHERE department_id = cod;
  -- Recuperar el numero de empleados del departamento
  SELECT COUNT(*) INTO num_empleados
  FROM EMPLOYEES
  WHERE department_id = cod;
  
  dbms_output.put_line('El departamento ' || nombre || ' Tiene ' || num_empleados || ' Empleados');

END;

-- INSERT/PLSQL

DECLARE
  columna1 TEST.C1%TYPE;
BEGIN
  columna1 := 20;
  INSERT INTO TEST (C1, C2) VALUES (columna1, 'BBBBBBB');
  COMMIT;
END;

-- UPDATE/PLSQL
DECLARE
  t TEST.C1%TYPE;
BEGIN
  t := 10;
  UPDATE TEST SET C2='CCCCCC' WHERE C1 = t;
  COMMIT;
END;

-- DELETE/PLSQL
DECLARE
  t TEST.C1%TYPE;
BEGIN
  t := 20;
  DELETE FROM TEST WHERE c1 = t;
  COMMIT;
END;

SELECT * FROM TEST;

-- Excepciones
DECLARE
  emp EMPLOYEES%ROWTYPE;
BEGIN
  SELECT * INTO emp
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = 10000;
  
  dbms_output.put_line(emp.FIRST_NAME);
EXCEPTION
  WHEN EX1 THEN
    NULL;
  WHEN EX2 THEN
    NULL;
  WHEN OTHERS THEN
    NULL;
  
END;
















