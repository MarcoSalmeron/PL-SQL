-- Ejercicio 01
SET SERVEROUTPUT ON
DECLARE
  CURSOR C1 IS SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES;
BEGIN
  FOR i IN C1 LOOP
    IF i.FIRST_NAME='Steven' AND i.LAST_NAME='Kingg' THEN
      RAISE_APPLICATION_ERROR(-20300,'El salario del Jefe no puede ser visto');
      --dbms_output.put_line('El salario del Jefe no puede ser visto');
    ELSE
      dbms_output.put_line(i.FIRST_NAME||' '||i.SALARY);
    END IF;
  END LOOP;
END;

-- Ejercicio 02
DECLARE
  departamento DEPARTMENTS%ROWTYPE;
  jefe DEPARTMENTS.MANAGER_ID%TYPE;
  CURSOR C1 IS SELECT * FROM EMPLOYEES;
  CURSOR C2(j DEPARTMENTS.MANAGER_ID%TYPE) IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID = j;
BEGIN
  FOR empleado in C1 LOOP
    OPEN C2(empleado.EMPLOYEE_ID);
    FETCH C2 INTO departamento;
    IF C2%NOTFOUND THEN
      dbms_output.put_line(empleado.FIRST_NAME||' No es jefe de nada');
    ELSE
      dbms_output.put_line(empleado.FIRST_NAME|| ' Es el jefe del departamento '|| departamento.DEPARTMENT_NAME);
    END IF;
    CLOSE C2;
  END LOOP;
END;

-- Ejercicio 03
DECLARE
  codigo DEPARTMENTS.DEPARTMENT_ID%TYPE;
  CURSOR C1(cod DEPARTMENTS.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES WHERE DEPARTMENT_ID = cod;
  num_empleados NUMBER;
BEGIN
  codigo:=50;
  OPEN C1(codigo);
  FETCH C1 INTO num_empleados;
  dbms_output.put_line('El numero de empleados de '||codigo||' es '||num_empleados);
END;

-- ejercicio 04
BEGIN
  FOR empleado IN(SELECT * FROM EMPLOYEES WHERE JOB_ID='ST_CLERK') LOOP
    dbms_output.put_line(empleado.FIRST_NAME);
    END LOOP;
END;

--Ejericio 05
DECLARE
  CURSOR C1 IS SELECT * FROM EMPLOYEES FOR UPDATE;
BEGIN
  FOR empleado IN C1 LOOP
    IF empleado.SALARY > 8000 THEN
      UPDATE EMPLOYEES SET SALARY=SALARY*1.02 WHERE CURRENT OF C1;
    ELSE
      UPDATE EMPLOYEES SET SALARY=SALARY*1.03 WHERE CURRENT OF C1;
    END IF;
  END LOOP;
  COMMIT; 
END;

-- BLOQUES ANONIMOS
-- PROCEDURES
-- FUNCIONES
-- PACKAGES
-- TRIGGERS

/*
1.- CREAR EL OBJETO
    CODIGO FUENTE
    CODIGO PSEUDO_OMPILADO
    
*/

-- PROCEDURES - PROCEDIMIENTOS
CREATE PROCEDURE PR1
IS
  x NUMBER:=10;
BEGIN
  dbms_output.put_line(x);
END;

BEGIN
  PR1;
END;

EXECUTE PR1;












































































