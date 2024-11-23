SET SERVEROUTPUT ON
DECLARE
  p VARCHAR2(30);
  n PLS_INTEGER := 90;
BEGIN
    FOR j IN 2..ROUND(SQRT(n)) LOOP
      IF n MOD j = 0 THEN
        p := 'no es un mumero primo';
        GOTO etiqueta_1;
      END IF;
    END LOOP;
    p := 'Es un numero primo';
    <<etiqueta_1>>
    DBMS_OUTPUT.PUT_LINE('se ejecuto!');

END;
-- Ejercio 02
SET SERVEROUTPUT ON

DECLARE
  frase VARCHAR2(100);
  l NUMBER;
  frase_alreves VARCHAR2(100);
BEGIN
  frase := 'Esto es una frase de prueba';
  l := LENGTH(frase);
  
  WHILE l > 0 LOOP
    frase_alreves := frase_alreves || SUBSTR(frase, l, 1);
    l := l - 1;
  END LOOP;
  dbms_output.put_line(frase_alreves);
END;

-- Ejercio 03
SET SERVEROUTPUT ON

DECLARE
  frase VARCHAR2(100);
  limit NUMBER;
  frase_alreves VARCHAR2(100);
BEGIN
  frase := 'Esto es una frase de x-prueba';
  limit := LENGTH(frase);
  
  WHILE limit > 0 LOOP
    EXIT WHEN UPPER(SUBSTR(frase,limit,1)) = 'X';
    frase_alreves := frase_alreves || SUBSTR(frase, limit, 1);
    limit := limit - 1;
  END LOOP;
  dbms_output.put_line(frase_alreves);
END;

-- ejercicio 04
-- dos variables numericas a y b, 
-- obtener los numeros que sean multiplos de 4 y que esten el rango [a, b]
DECLARE
  a NUMBER;
  b NUMBER;
BEGIN
  a := 10;
  b := 40;
  FOR i IN a..b LOOP
    IF MOD(i, 4) = 0 THEN
      dbms_output.put_line(i);
    END IF;
  END LOOP;
END;

-- SQL/PLSQL
DECLARE
  salario NUMBER;
  nombre EMPLOYEES.FIRST_NAME%TYPE;
  empleado EMPLOYEES%ROWTYPE;
BEGIN
  SELECT   -- SOLO PUEDE DEVOLVER UNA FILA
   * INTO empleado
  FROM
    employees
  WHERE
    employee_id = 100;
  dbms_output.put_line(empleado.SALARY * 100);
  dbms_output.put_line(empleado.FIRST_NAME);
  dbms_output.put_line(empleado.EMAIL);
END;

-- Ejercicio 01
DECLARE
  maximo NUMBER;
  minimo NUMBER;
  diferencia NUMBER;
BEGIN
  SELECT MAX(SALARY),MIN(SALARY) INTO maximo, minimo
  FROM EMPLOYEES;
  dbms_output.put_line('El salario maximo es: ' || maximo);
  dbms_output.put_line('El salario minimo es: ' || minimo);
  diferencia := maximo - minimo;
  dbms_output.put_line('La diferencia es es: ' || diferencia);
  
END;





















































