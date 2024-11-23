SET SERVEROUTPUT ON
DECLARE
  total NUMBER;
  n NUMBER;
  dept NUMBER:=110;
BEGIN
  total := salario_out(dept, n);
  dbms_output.put_line('El salario total del departamento '||dept||' es '||total);
  dbms_output.put_line('El numero total de empleados recabados es: '||n);
END;

-- Ejercio 03 -Prueba
SET SERVEROUTPUT ON
DECLARE
  n_region NUMBER;
BEGIN
  n_region := crear_region('NORMANDIA');
  dbms_output.put_line('EL numero asignado es: '||n_region);
END;

-- Paquete
BEGIN
  pack1.v1:=pack1.v1+100;
  --pack1.v2:='AAAA';
  dbms_output.put_line(pack1.v1);
  --dbms_output.put_line(pack1.v2);
END;

DECLARE
  v1 VARCHAR2(100);
BEGIN
  v1 := pack1.CONVERT('AAABBB', 'L');
  dbms_output.put_line(v1);
END;

SELECT
    first_name, pack1.CONVERT(FIRST_NAME, 'U') as Nombre_Mayus
FROM
    employees;
    

BEGIN
  dbms_output.put_line(PACK2.COUNT_EMP('Marketing'));
END;