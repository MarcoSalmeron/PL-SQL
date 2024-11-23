SET SERVEROUTPUT ON

DECLARE
  v1 CHAR(1);
  
BEGIN
  v1 := 'E';
  CASE v1
    WHEN 'A' THEN dbms_output.put_line('Excelente!');
    WHEN 'B' THEN dbms_output.put_line('Muy Bien');
    WHEN 'C' THEN dbms_output.put_line('Bien');
    WHEN 'D' THEN dbms_output.put_line('Regular');
    WHEN 'F' THEN dbms_output.put_line('Np aprovado');
    ELSE dbms_output.put_line('No se puede evaluar!');
  END CASE;
END;

-- SEARCHED CASE
SET SERVEROUTPUT ON

DECLARE
  bonus NUMBER;
BEGIN
  bonus := 1000;
  CASE
    WHEN bonus > 500 THEN dbms_output.put_line('Excelente');
    WHEN bonus <= 500 AND bonus > 250 THEN dbms_output.put_line('Muy bueno');
    WHEN bonus <= 250 AND bonus > 100 THEN dbms_output.put_line('Bueno');
    ELSE dbms_output.put_line('Poco');
  END CASE;
END;

-- Ejercicio 01
SET SERVEROUTPUT ON

DECLARE
  usuario VARCHAR2(30);
BEGIN
  usuario := USER; -- funcion()
  CASE usuario
    WHEN 'SYS' THEN dbms_output.put_line('Eres SUPERADMINISTRADOR');
    WHEN 'SYSTEM' THEN dbms_output.put_line('Eres Administrador Normal');
    WHEN 'HR' THEN dbms_output.put_line('Eres de Recursos Humanos');
    ELSE dbms_output.put_line('Usuario no autorizado!');
  END CASE;
END;

-- LOOP
DECLARE
  x NUMBER := 1;
BEGIN
  LOOP
    dbms_output.put_line(x);
    x := x+1;
    /*IF x = 11 THEN EXIT;
    END IF; */
    EXIT WHEN x = 11;
  END LOOP;
END;

-- LOOPS ANIDADOS
DECLARE
  s PLS_INTEGER := 0;
  i PLS_INTEGER := 0;
  j PLS_INTEGER := 0;

BEGIN
  --loop padre
  <<parent>> -- etiqueta personalizable.
  LOOP 
    i := i + 1;
    j := 100;
    dbms_output.put_line('padre: ' || i);
    <<child>>
    LOOP
      -- loop hijo
      dbms_output.put_line('Hijo: ' || j);
      j := j + 1;
      EXIT parent WHEN (i > 3);
      EXIT child WHEN(j > 105);
    END LOOP child;
  END LOOP parent;
  dbms_output.put_line('Fin');
    
END;

-- CONTINUE

DECLARE
  x NUMBER := 0;

BEGIN
  LOOP
    dbms_output.put_line('LOOP: x = ' || TO_CHAR(x));
    x := x + 1;
    /*IF x < 3 THEN
      CONTINUE;
    END IF; */
    CONTINUE WHEN x < 3;
    dbms_output.put_line('DESPUES DE CONTINUE: x= ' || TO_CHAR(x));
    EXIT WHEN x = 5;
  END LOOP;
  dbms_output.put_line('DESPUES DEL LOOP: x= ' || TO_CHAR(x));
    
END;

-- FOR
DECLARE
  i VARCHAR2(10) := 'AAAAAA';

BEGIN
  FOR i IN REVERSE 5..15 LOOP  -- PLS_INTEGER
    dbms_output.put_line('i = ' || i);
    EXIT WHEN i = 10;
  END LOOP;
  dbms_output.put_line('i = ' || i);
END;

-- WHILE

DECLARE
  d BOOLEAN := TRUE;
  x NUMBER := 0;
BEGIN
  WHILE x < 10 LOOP
    dbms_output.put_line('x = ' || x);
    x := x + 1;
    EXIT WHEN x = 5;
  END LOOP;
  WHILE d LOOP
    dbms_output.put_line('NO imprimas esto.');
    d := FALSE;
  END LOOP;
  
  WHILE NOT d LOOP
    dbms_output.put_line('He pasado por aqui!');
    d := TRUE;
  END LOOP;
END;

-- GOTO






































































































