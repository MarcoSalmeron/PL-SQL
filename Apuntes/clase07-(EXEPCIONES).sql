SET SERVEROUTPUT ON
DECLARE
  emp EMPLOYEES%ROWTYPE;
BEGIN
  SELECT * INTO emp
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID > 1;
  
  dbms_output.put_line(emp.FIRST_NAME);
EXCEPTION
-- NO DATA FOUND ORA-01403
-- TOO MANY ROWS
-- ZERO DIVIDE
-- DUP VAL ON INDEX

  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Error, Empleado inexistente!');
  WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('Error, Demasiados Empleados');
  WHEN OTHERS THEN
    dbms_output.put_line('Error Indefinido');
  
END;

-- EXCEPCIONES NO PREDEFINIDAS
DECLARE
  MI_EXCEPT EXCEPTION;
  PRAGMA EXCEPTION_INIT(MI_EXCEPT,-937);
  v1 NUMBER;
  v2 NUMBER;
BEGIN
  SELECT EMPLOYEE_ID,SUM(SALARY) INTO v1,v2 
  FROM EMPLOYEES;
  dbms_output.put_line(v1);
EXCEPTION
  WHEN MI_EXCEPT THEN
    dbms_output.put_line('Funcion de grupo incorrecta');
  WHEN OTHERS THEN
    dbms_output.put_line('Error Indefinido');
  
END;

--SQLCODE y SQLERRM
SET SERVEROUTPUT ON
DECLARE
  empleado EMPLOYEES%ROWTYPE;
  code NUMBER;
  mesage VARCHAR2(100);
BEGIN
  SELECT * INTO empleado FROM EMPLOYEES;
  dbms_output.put_line(empleado.SALARY);

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(SQLCODE);  ---CODIGO DEL ERROR
    dbms_output.put_line(SQLERRM);  -- MENSAJE DEL ERROR
    code := SQLCODE;
    mesage := SQLERRM;
    INSERT INTO ERRORS VALUES (code,mesage);
    COMMIT;
END;

-- Ejercicio 04
DECLARE
  duplicado EXCEPTION;
  PRAGMA EXCEPTION_INIT(duplicado, -00001);
BEGIN
  INSERT INTO REGIONS VALUES(1,'PRUEBA');
  COMMIT;
  EXCEPTION
    WHEN duplicado THEN
      dbms_output.put_line('Registro duplicado');
END;

-- CONTROLAR SQL CON EXCEPCIONES
DECLARE
  REG REGIONS%ROWTYPE;
  reg_control REGIONS.REGION_ID%TYPE;
BEGIN
  REG.REGION_ID := 1;
  REG.REGION_NAME := 'AFRICA';
  
  SELECT REGION_ID INTO reg_control FROM REGIONS
  WHERE REGION_ID = REG.REGION_ID;
  dbms_output.put_line('La region existe');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    INSERT INTO REGIONS VALUES (REG.REGION_ID, REG.REGION_NAME);
    COMMIT;
END;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  















































