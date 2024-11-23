-- Ejercicio 03

CREATE OR REPLACE PROCEDURE formato(numero IN OUT VARCHAR2) IS
g1 VARCHAR2(20);
g2 VARCHAR2(20);
g3 VARCHAR2(20);
g4 VARCHAR2(20);
BEGIN
  g1:=substr(numero,1,4);
  g2:=substr(numero,5,4);
  g3:=substr(numero,9,2);
  g4:=substr(numero,10);
  numero:=g1||'-'||g2||'-'||g3||'-'||g4;
END;

-- Prueba
SET SERVEROUTPUT ON
DECLARE
  x VARCHAR2(30):='1234546787987897987';
BEGIN
  formato(x);
  dbms_output.put_line(x);
END;

-- FUNCIONES

CREATE OR REPLACE FUNCTION CALC_TAX_F
  (emp IN EMPLOYEES.EMPLOYEE_ID%TYPE, T IN NUMBER)
RETURN NUMBER
IS
  TAX NUMBER:=0;
  SAL NUMBER:=0;
BEGIN
  IF T < 0 OR T > 60 THEN
    RAISE_APPLICATION_ERROR(-20001,'EL PORCENTAJE DEBE ESTAR ENTRE 0 y 60');
  END IF;
  SELECT SALARY INTO SAL FROM EMPLOYEES WHERE EMPLOYEE_ID = emp;
  TAX := SAL*T/100;
  RETURN TAX;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('NO EXISTE EL EMPLEADO');
END;

-- Llamar funcion
SET SERVEROUTPUT ON
DECLARE
  a NUMBER;
  b NUMBER;
  r NUMBER;
BEGIN
  a:=120;
  b:=20;
  r:= CALC_TAX_F(a,b);
  dbms_output.put_line('El resultado es: '||r);
END;

--Funciones con comandos SQL

SELECT FIRST_NAME, SALARY, CALC_TAX_F(EMPLOYEE_ID,18) FROM EMPLOYEES;

-- Ejercicio 01 Funciones --

CREATE OR REPLACE FUNCTION salario(dep NUMBER) 
RETURN NUMBER
IS
  sal NUMBER;
  depart DEPARTMENTS.DEPARTMENT_ID%TYPE;
  num_emp NUMBER;
BEGIN
  SELECT DEPARTMENT_ID INTO depart FROM DEPARTMENTS WHERE DEPARTMENT_ID = dep;
  SELECT COUNT(*) INTO num_emp FROM EMPLOYEES WHERE DEPARTMENT_ID = dep;
  
  IF dep > 0 THEN
    SELECT SUM(SALARY) INTO sal FROM EMPLOYEES WHERE DEPARTMENT_ID = dep GROUP BY DEPARTMENT_ID;
  ELSE
    RAISE_APPLICATION_ERROR(-20730, 'EL departamento existe, pero no hay empleados' || dep);
  END IF;
  RETURN sal;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20730, 'EL departamento existe, pero no hay empleados' || dep);
END;

-- Probar funcion
SET SERVEROUTPUT ON
DECLARE
  salary NUMBER;
  dept NUMBER:=280;
BEGIN
  salary:= salario(dept);
  dbms_output.put_line('El salario total del departamento '||dept||' es: '||salary);
END;































































  