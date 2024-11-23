-- Funciones de grupo COUNT AVG
SET SERVEROUTPUT ON
DECLARE
  x VARCHAR2(30);
  mayus VARCHAR2(30);
  fecha DATE;
  z NUMBER := 109.85;
BEGIN
  x := 'Ejemplo';
  dbms_output.put_line(SUBSTR(x,1,3));
  mayus := UPPER(x);
  dbms_output.put_line(mayus);
  fecha := SYSDATE;
  dbms_output.put_line(fecha);
  dbms_output.put_line(FLOOR(z));
END;
-- dada la fecha d enacimeinto calcular el dia en qeu nacimos

SET SERVEROUTPUT ON

DECLARE
 fecha_nac DATE;
 dia VARCHAR2(20);
BEGIN
  fecha_nac := TO_DATE('12/09/2024');
  dia := TO_CHAR(fecha_nac,'DAY');
  dbms_output.put_line(dia);  
END;
/*
operadores relaciones
 = 
 <> distinto de
 <
 >
 >=
 <=
 operadores logicos
 AND 
 NOT
 OR
 
*/
-- Estructuras de control
-- IF
SET SERVEROUTPUT ON
DECLARE
  x NUMBER := 20;
BEGIN
  IF 
    x = 10
  THEN
    dbms_output.put_line('x = 10');
  ELSE
    dbms_output.put_line('x = otro valor');
  END IF;
    
END;

-- Otro Ejemplo
SET SERVEROUTPUT ON
DECLARE
  sueldo NUMBER := 26000;
  bonus NUMBER := 0;
BEGIN
  IF sueldo > 50000 THEN
    bonus := 1500;
  ELSIF sueldo > 35000 THEN
    bonus := 500;
   ELSIF sueldo > 25000 THEN
     bonus := 300;
  ELSE
    bonus := 100;
  END IF;
  dbms_output.put_line('Sueldo = ' || sueldo || ', bonus = ' || bonus);
END;








































