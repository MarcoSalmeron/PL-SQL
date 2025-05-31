/*
    1- Desarrolle una consulta que liste el nombre del empleado, el código del departamento y la fecha de inicio que empezó a trabajar,
     ordenando el resultado por departamento y por fecha de inicio, el último que entró a trabajar va primero.
*/
    SELECT emp.FIRST_NAME , dep.DEPARTMENT_ID, TO_CHAR(emp.HIRE_DATE,'DD-MM-YYYY') AS Fecha_Inicio
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    ORDER BY dep.DEPARTMENT_ID ASC, emp.HIRE_DATE DESC;

/*
    2- Desarrolle una consulta que liste los países por región,
    los datos que debe mostrar son: el código de la región y nombre de la región con los nombres de sus países.
*/
    SELECT co.REGION_ID, re.REGION_NAME, co.COUNTRY_NAME 
    FROM COUNTRIES co
    JOIN REGIONS re ON re.REGION_ID = co.REGION_ID
    ORDER BY re.REGION_NAME;

/*
    3- Realice una consulta que muestre el código, nombre, apellido, inicio y fin del historial de trabajo de los empleados.
*/
    SELECT emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.LAST_NAME, historial.START_DATE, historial.END_DATE
    FROM EMPLOYEES emp
    JOIN JOB_HISTORY historial ON historial.EMPLOYEE_ID = emp.EMPLOYEE_ID;

/*
    4- Elabore una consulta que liste nombre del trabajo y el salario de los empleados que son manager,
    cuyo código es 100 o 124 y cuyo salario sea mayor de 6000.
*/
    SELECT j.JOB_TITLE,  e.SALARY
    FROM JOBS j
    JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
    WHERE e.MANAGER_ID IN(100,124) AND e.SALARY > 6000;

/*
    5- Desarrolle una consulta que liste el código de la localidad, la ciudad
    y el nombre del departamento de únicamente de los que se encuentran fuera de Estados Unidos (US).
*/
    SELECT loc.LOCATION_ID, loc.CITY, dep.DEPARTMENT_NAME
    FROM LOCATIONS loc
    JOIN DEPARTMENTS dep ON dep.LOCATION_ID = loc.LOCATION_ID
    WHERE loc.COUNTRY_ID NOT IN ('US');

/*
    6- Crear un bloque anónimo donde reciba como parámetro el ID de departamento
    y me regrese el nombre del departamento con el promedio de salarios de dicho departamento.
*/
DECLARE
    id_dep DEPARTMENTS.DEPARTMENT_ID%TYPE := 10;
    promedio NUMBER;
    dep_nombre DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT dep.DEPARTMENT_NAME, AVG(emp.SALARY)
    INTO dep_nombre, promedio
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    WHERE dep.DEPARTMENT_ID = id_dep
    GROUP BY dep.DEPARTMENT_NAME;

    DBMS_OUTPUT.PUT_LINE('(Nombre del Departamento) = ' || dep_nombre || ' (Salario Promedio) = ' || promedio);

    EXCEPTION
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error -> '|| SQLERRM);
END;

/*
    7- Crear un bloque anónimo donde imprima una seria de 2 en 2 hasta el 100
*/
BEGIN
    FOR i IN 2..100 LOOP
        IF MOD(i,2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('i : ' || i);
        END IF;
    END LOOP;
END;

/*
    8- Crear un bloque anónimo donde se reciba el id de empleado y me imprima
    nombre, apellido, correo, teléfono, nombre de departamento, código postal, dirección, ciudad, nombre de país y nombre de la región.
*/
DECLARE
    id_emp EMPLOYEES.EMPLOYEE_ID%TYPE := 100;

    TYPE RECORD_EMP IS RECORD (
        nombre EMPLOYEES.FIRST_NAME%TYPE,
        apellido EMPLOYEES.LAST_NAME%TYPE,
        email EMPLOYEES.EMAIL%TYPE,
        numero EMPLOYEES.PHONE_NUMBER%TYPE,
        depa DEPARTMENTS.DEPARTMENT_NAME%TYPE,
        cp LOCATIONS.POSTAL_CODE%TYPE,
        direccion LOCATIONS.STREET_ADDRESS%TYPE,
        ciudad LOCATIONS.CITY%TYPE,
        pais COUNTRIES.COUNTRY_NAME%TYPE,
        region REGIONS.REGION_NAME%TYPE
    );

    empleado RECORD_EMP;

BEGIN

    SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL, e.PHONE_NUMBER, d.DEPARTMENT_NAME, loc.POSTAL_CODE, loc.STREET_ADDRESS, loc.CITY, co.COUNTRY_NAME, reg.REGION_NAME 
    INTO empleado.nombre, empleado.apellido, empleado.email, empleado.numero, empleado.depa, empleado.cp, empleado.direccion, empleado.ciudad, empleado.pais, empleado.region
    FROM EMPLOYEES e
    JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
    JOIN LOCATIONS loc ON loc.LOCATION_ID = d.LOCATION_ID
    JOIN COUNTRIES co ON co.COUNTRY_ID = loc.COUNTRY_ID
    JOIN REGIONS reg ON reg.REGION_ID = co.REGION_ID
    WHERE e.EMPLOYEE_ID = id_emp;

    DBMS_OUTPUT.PUT_LINE (
        ' [ ID ] : '|| id_emp ||' [ Nombre ] : '|| empleado.nombre ||' [ Apellido ] : '|| empleado.apellido||' [ Email ] : '|| empleado.email||
        ' [ Numero ] : '||empleado.numero||' [ Departamento ] : '||empleado.depa||' [ CP ] : '|| empleado.cp|| ' [ Direccion ] : '||empleado.direccion||
        ' [ Ciudad ] : '||empleado.ciudad||' [ Pais ] : '||empleado.pais||' [ Region ] : '||empleado.region
        );

    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Hay Registros... ');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Mas Registros de lo esperado con ID : '|| id_emp);
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('ERROR DESCONOCIDO...'||SQLERRM||' Codigo -> '||SQLCODE);
END;

/*
    9- Crear un bloque anónimo donde se reciba como parámetro el id de la persona
    e imprima por pantalla el nombre de la persona y el nombre de su jefe
*/
DECLARE
    id_emp EMPLOYEES.EMPLOYEE_ID%TYPE := 100;

    nombre_emp EMPLOYEES.FIRST_NAME%TYPE;
    nombre_jefe EMPLOYEES.FIRST_NAME%TYPE;
BEGIN

    SELECT FIRST_NAME||' - '||LAST_NAME, (SELECT FIRST_NAME||' - '||LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = MANAGER_ID)
    INTO nombre_emp, nombre_jefe
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = id_emp;

    DBMS_OUTPUT.PUT_LINE('Empleado : '||nombre_emp);

    IF nombre_jefe IS NOT NULL THEN 
        DBMS_OUTPUT.PUT_LINE('Jefe : '||nombre_jefe);
    ELSE 
        DBMS_OUTPUT.PUT_LINE('No tiene Jefe ');
    END IF;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No hay Registros...');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Mas Registros de lo esperado...');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('ERROR -> '||SQLERRM||' [ Codigo ] -> '||SQLCODE);
END;

/*
    11- Hacer una consulta SQL donde se muestren todos los empleados e indique quién es su Jefe.
*/
    SELECT
        e.First_Name||' - '||e.Last_Name AS EMPLEADOS,
        m.First_Name||' - '||m.Last_Name AS JEFES
    FROM EMPLOYEES e
    LEFT JOIN EMPLOYEES m ON e.MANAGER_ID = m.EMPLOYEE_ID;
/*
    12- La consulta debe mostrar nombre y apellido del empleado y en el mismo registro mostrar nombre y apellido del jefe
*/
    SELECT
        e.FIRST_NAME||' - '||e.LAST_NAME AS Empleado,
        m.FIRST_NAME||' - '||m.LAST_NAME AS Jefe
    FROM EMPLOYEES e
    LEFT JOIN EMPLOYEES m ON e.MANAGER_ID = m.EMPLOYEE_ID
    WHERE e.EMPLOYEE_ID = 109;

/*
    13- Desarrolle una consulta que liste el nombre del empleado, el código del  departamento y la fecha de inicio que empezó a trabajar,
    ordenando el resultado por departamento y por fecha de inicio, el último que entró a trabajar va de primero.
*/
    SELECT e.FIRST_NAME, d.DEPARTMENT_ID, TO_CHAR(e.HIRE_DATE,'dd/MM/yyyy') AS Fecha_Inicio
    FROM EMPLOYEES e
    JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
    ORDER BY d.DEPARTMENT_ID, e.HIRE_DATE DESC; 

/*
    14- Desarrolle una consulta que liste el código, nombre y apellido de los empleados y sus respectivos jefes con título
*/
    SELECT 
        e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, m.FIRST_NAME AS BOSS, j.JOB_TITLE
    FROM EMPLOYEES e
    LEFT JOIN EMPLOYEES m ON e.MANAGER_ID = m.EMPLOYEE_ID
    JOIN JOBS j ON j.JOB_ID = e.JOB_ID;

/*
    15- Desarrolle una consulta que liste los países por región, los datos que debe mostrar son:
    el código de la región y nombre de la región con los nombres de sus países.
*/
    SELECT reg.REGION_ID, reg.REGION_NAME, co.COUNTRY_NAME
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    ORDER BY reg.REGION_NAME;

/*
    16- Realice una consulta que muestre el código, nombre, apellido, inicio y fin del historial de trabajo de los empleados.
*/
    SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, TO_CHAR(historial.START_DATE,'dd/MM/yyyy') AS INICIO, TO_CHAR(historial.END_DATE,'dd/MM/yyyy') AS FIN
    FROM EMPLOYEES e
    JOIN JOB_HISTORY historial ON historial.EMPLOYEE_ID = e.EMPLOYEE_ID;

/*
    17- Elabore una consulta que muestre :
    nombre y apellido del empleado con titulo Empleado, el salario, porcentaje de comisión, la comisión y salario total.
*/
    SELECT e.FIRST_NAME, e.LAST_NAME, j.JOB_TITLE, e.SALARY, e.COMMISSION_PCT, (e.SALARY * NVL(e.COMMISSION_PCT,0)) AS Comision, (e.SALARY + (e.SALARY * NVL(e.COMMISSION_PCT,0))) AS Salario_Total
    FROM EMPLOYEES e
    JOIN JOBS j ON j.JOB_ID = e.JOB_ID;

/*
    18- Elabore una consulta que liste nombre del trabajo y el salario de los empleados que son manager,
    cuyo código es 100 o 125 y cuyo salario sea mayor de 6000.
*/
    SELECT j.JOB_TITLE, e.SALARY
    FROM JOBS j
    JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
    WHERE e.MANAGER_ID IN (100,125)
    AND e.SALARY > 6000;

/*
    20- Realice una consulta que muestre :
    el código de la región, nombre de la región y el nombre de los países que se encuentran en “Asia”
*/
    SELECT reg.REGION_ID, reg.REGION_NAME, co.COUNTRY_NAME
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    WHERE reg.REGION_NAME IN ('Asia');

/*
    21- Elabore una consulta que liste :
    el código de la región y nombre de la región, código de la localidad, la ciudad, código del país y nombre del país,
    de solamente de las localidades mayores a 2400.
*/
    SELECT reg.REGION_ID, reg.REGION_NAME, loc.LOCATION_ID, loc.CITY, co.COUNTRY_ID, co.COUNTRY_NAME
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    JOIN LOCATIONS loc ON loc.COUNTRY_ID = co.COUNTRY_ID
    WHERE loc.LOCATION_ID > 2400;

/*
    22- Desarrolle una consulta donde muestre :
    el código de región con un alias de Región,
    el nombre de la región con una etiqueta Nombre Región, 
    que muestre una cadena string (concatenación) que diga la siguiente frase “Código País:CA Nombre: Canadá“ ,CA es el código de país y Canadá es el nombre del país con etiqueta País,
    el código de localización con etiqueta Localización,
    la dirección de calle con etiqueta Dirección
    y el código postal con etiqueta“ Código Postal”, esto a su vez no deben aparecer código postal que sean nulos.
*/
    SELECT
        reg.REGION_ID AS REGION,
        reg.REGION_NAME AS NOMBRE_REGION,
        ' Codigo-Pais: '||co.COUNTRY_ID||' Nombre: '||co.COUNTRY_NAME AS PAIS,
        loc.LOCATION_ID AS LOCALIZACION,
        loc.STREET_ADDRESS AS DIRECCION,
        loc.POSTAL_CODE AS CODIGO_POSTAL
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    JOIN LOCATIONS loc ON loc.COUNTRY_ID = co.COUNTRY_ID
    WHERE loc.POSTAL_CODE IS NOT NULL;

/*
    23- Desarrolle una consulta que muestre el salario promedio de los empleados de los departamentos 30 y 80.
*/
    SELECT dep.DEPARTMENT_ID, ROUND(AVG(emp.SALARY),2) AS SALARIO_PROMEDIO
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    WHERE dep.DEPARTMENT_ID IN (30,80)
    GROUP BY dep.DEPARTMENT_ID;

/*
    24- Desarrolle una consulta que muestre :
    el nombre de la región,
    el nombre del país,
    el estado de la provincia,
    el código de los empleados que son manager,
    el nombre y apellido del empleado que es manager de los países del reino Unido (UK), Estados Unidos de América (US),
    respectivamente de los estados de la provincia de Washington y Oxford.
*/
    SELECT 
        reg.REGION_NAME,
        co.COUNTRY_NAME,
        loc.STATE_PROVINCE,
        emp.MANAGER_ID,
        'Nombre: '||emp.FIRST_NAME||' Apellido: '||emp.LAST_NAME AS Manager
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    JOIN LOCATIONS loc ON loc.COUNTRY_ID = co.COUNTRY_ID
    JOIN DEPARTMENTS dep ON dep.LOCATION_ID = loc.LOCATION_ID
    JOIN EMPLOYEES emp ON emp.EMPLOYEE_ID = dep.MANAGER_ID
    WHERE co.COUNTRY_ID IN ('UK','US')
    AND loc.STATE_PROVINCE IN ('Washington', 'Oxford');

/*
    25- Realice una consulta que muestre :
    el nombre y apellido de los empleados
    que trabajan para departamentos que están localizados en países cuyo nombre comienza con la letra C, que muestre el nombre del país.
*/
    SELECT emp.FIRST_NAME, emp.LAST_NAME, co.COUNTRY_NAME
    FROM EMPLOYEES emp
    JOIN DEPARTMENTS dep ON dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
    JOIN LOCATIONS loc ON loc.LOCATION_ID = dep.LOCATION_ID
    JOIN COUNTRIES co ON co.COUNTRY_ID = loc.COUNTRY_ID
    WHERE UPPER(co.COUNTRY_NAME) LIKE 'C%';
/*
    26- Desarrolle una consulta que liste en nombre del puesto (TRABAJO_TITULO),
    el nombre y apellidos del empleado que ocupa ese puesto, 
    cuyo email es ‘NKOCHHAR’,
    el 21 de septiembre de 1989
*/
    SELECT j.JOB_TITLE, e.FIRST_NAME, e.LAST_NAME
    FROM JOBS j
    JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
    WHERE e.EMAIL LIKE 'NKOCHHAR%'
    AND e.HIRE_DATE = TO_DATE('21-09-1989','dd/MM/yyyy');

/*
    27- Escriba una sola consulta que liste los empleados de los departamentos 10,20 y 80 que fueron contratados hace mas de 180 días,
    que ganan una comisión no menor de 20% y cuyo nombre o apellido comienza con la letra “J”
*/
    SELECT emp.FIRST_NAME, emp.LAST_NAME, TO_CHAR(emp.HIRE_DATE,'dd/MM/yyyy') AS Fecha_Contrato, emp.DEPARTMENT_ID
    FROM EMPLOYEES emp
    WHERE emp.DEPARTMENT_ID IN (10,20,80)
    AND emp.HIRE_DATE <= SYSDATE - 180
    AND emp.COMMISSION_PCT >= 0.20
    AND (emp.FIRST_NAME LIKE 'J%' OR emp.LAST_NAME LIKE 'J%');

/*
    28- Realice una consulta de muestre el nombre, el apellido y nombre de departamento
    de los empleados cuyo número telefónico tiene código de área 515
    (número de 12 dígitos: 3 del área, 7 del numero y dos puntos),
    excluya los números telefónicos que tienen una longitud diferente de 12 caracteres.
*/
    SELECT emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME, emp.PHONE_NUMBER
    FROM EMPLOYEES emp
    JOIN DEPARTMENTS dep ON dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
    WHERE LENGTH(emp.PHONE_NUMBER) = 12
    AND emp.PHONE_NUMBER LIKE '515.%';

/*
    29- Desarrolle una consulta que muestre el código, el nombre y apellido separado por coma con titulo de encabezado Nombre Completo,
    el salario con titulo Salario, el código de departamento con titulo Código de Departamento
    y el nombre de departamento al que pertenece con titulo Descripción,
    únicamente se desean consultas los que pertenezcan al departamento de IT y ordenar la información por salario descendentemente.
*/
    SELECT
        emp.FIRST_NAME||', '||emp.LAST_NAME AS NOMBRE_COMPLETO,
        emp.SALARY AS SALARIO,
        dep.DEPARTMENT_ID AS CODIGO_DEPARTAMENTO,
        dep.DEPARTMENT_NAME AS DESCRIPCION
    FROM EMPLOYEES emp
    JOIN DEPARTMENTS dep ON dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
    WHERE dep.DEPARTMENT_NAME = 'IT'
    ORDER BY emp.SALARY DESC;

/*
    30- Realice una consulta que liste :
    el nombre y apellido,
    salario del empleado,
    el nombre del departamento al que pertenece,
    la dirección,
    el código postal
    y la ciudad donde está ubicado el departamento,
    se debe mostrar únicamente aquellos que sean del departamento 100,80 y 50 respectivamente,
    además deben pertenecer únicamente a la ciudad del sur de san francisco
    y el rango de salario debe ser entre 4000 y 8000 incluyendo los valores limites.
*/
    SELECT
        emp.FIRST_NAME,
        emp.LAST_NAME,
        emp.SALARY,
        dep.DEPARTMENT_NAME,
        loc.STREET_ADDRESS,
        loc.POSTAL_CODE,
        loc.CITY,
        dep.DEPARTMENT_ID
    FROM EMPLOYEES emp
    JOIN DEPARTMENTS dep ON dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
    JOIN LOCATIONS loc ON loc.LOCATION_ID = dep.LOCATION_ID
    WHERE dep.DEPARTMENT_ID IN (100,80,50)
    AND loc.CITY = 'South San Francisco'
    AND (emp.SALARY BETWEEN 4000 AND 8000);

/*
    31- Desarrolle una consulta donde seleccione el código del empleado cuyo alias será código,
    el apellido concatenado con el nombre de empleado pero separados por coma(,) cuyo alias será Nombres,
    el email donde su inicial este en mayúscula y todos posean el dominio de @eisi.ues.edu.sv, es decir debe ir concatenado con ese dominio cuyo alias es email,
    además que aparezca si el número telefónico está almacenado en el campo de esta manera 515.123.4567 deberá convertirlo al formato siguiente formato (515)-123-4567,
    si posee un número telefónico con esta longitud 011.44.1344.429268, es decir una longitud mayor al formato anterior, deberá aparecer en el formato siguiente (011-44 -1344-429268)
    Funciones que puede hacer uso para este ejercicio LENGTH, SUBSTR.
    Dicha información deberá ir ordenada por código de empleado.
*/
    SELECT
        emp.EMPLOYEE_ID AS CODIGO,
        emp.LAST_NAME||', '||emp.FIRST_NAME AS NOMBRES,
        SUBSTR(emp.EMAIL,1,1)||LOWER(SUBSTR(emp.EMAIL,2))||'@eisi.ues.edu.sv' AS EMAIL,
        CASE
            WHEN LENGTH(PHONE_NUMBER) = 12 THEN
                '('||SUBSTR(PHONE_NUMBER,1,3)||')-'||
                     SUBSTR(PHONE_NUMBER,5,3)||'-'||
                     SUBSTR(PHONE_NUMBER,9)
            WHEN LENGTH(PHONE_NUMBER) > 12 THEN
                '('||SUBSTR(PHONE_NUMBER,1,3)||'-'||
                     SUBSTR(PHONE_NUMBER,5,2)||'-'||
                     SUBSTR(PHONE_NUMBER,8,4)||'-'||
                     SUBSTR(PHONE_NUMBER,13)||')'
            END AS TELEFONO
    FROM EMPLOYEES emp
    ORDER BY emp.EMPLOYEE_ID;

/*
    32- Desarrolle una consulta que permita seleccionar las ciudades,
    su código de país,
    y si es de Reino Unido (United Kingdom) lo cambia por (UNKing) caso contrario si no es de Reino Unido (Non- UNKing)
    y cuya ciudades deben iniciar con la letra S.
*/
    SELECT
        CITY,
        CASE 
            WHEN COUNTRY_ID = 'UK' THEN
                'UNKing'
            ELSE
                'Non-UNKing'
        END AS PAIS
    FROM LOCATIONS
    WHERE CITY LIKE 'S%';

/*
    33- Desarrolle una consulta que muestre el código del departamento con titulo Código del departamento,
    que cuente los empleados agrupados por departamentos, ordenados por código de departamento
*/
    SELECT
        dep.DEPARTMENT_ID AS CODIGO_DEPARTAMENTO,
        COUNT(emp.EMPLOYEE_ID) AS TOTAL_EMPLEADOS
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    GROUP BY dep.DEPARTMENT_ID
    ORDER BY dep.DEPARTMENT_ID;

/*
    34- Realicé una consulta que muestre solo los nombres de los empleados que se repiten
*/
    SELECT
        FIRST_NAME
    FROM EMPLOYEES emp
    GROUP BY FIRST_NAME
    HAVING COUNT(FIRST_NAME) > 1;

/*
    35- Desarrolle una consulta que muestre solo los nombres de los empleados que no se repiten
*/
    SELECT 
        FIRST_NAME
    FROM EMPLOYEES
    GROUP BY FIRST_NAME
    HAVING COUNT(FIRST_NAME) = 1;

/*
    36- Realice una consulta que muestre el número de países por región,
    la consulta debe mostrar el código y nombre de la región así como el número de países de cada región,
    ordenando el resultado por la región que tenga mayor número de países.
*/
    SELECT
        reg.REGION_ID,
        reg.REGION_NAME,
        COUNT(co.COUNTRY_ID) AS TOTAL_PAISES
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    GROUP BY reg.REGION_ID, reg.REGION_NAME
    ORDER BY TOTAL_PAISES DESC;

/*
    37- Desarrolle una consulta que liste los códigos de puestos con el número de empleados que pertenecen a cada puesto,
    ordenados por número de empleados: los puestos que tienen más empleados aparecen primero.
*/
    SELECT
        j.JOB_ID,
        j.JOB_TITLE,
        COUNT(e.EMPLOYEE_ID) AS TOTAL_EMPLEADOS
    FROM JOBS j
    JOIN EMPLOYEES e ON e.JOB_ID = j.JOB_ID
    GROUP BY j.JOB_ID, j.JOB_TITLE
    ORDER BY TOTAL_EMPLEADOS DESC;

/*
    38- Desarrolle una consulta que muestre el número de empleados por departamento,
    ordenados alfabéticamente por nombre de departamento.
*/
    SELECT
        dep.DEPARTMENT_NAME,
        COUNT(emp.EMPLOYEE_ID) AS TOTAL_EMPLEADOS
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    GROUP BY dep.DEPARTMENT_NAME
    ORDER BY dep.DEPARTMENT_NAME;

/*
    39- Realice una consulta que muestre el número de departamentos por región.
*/
    SELECT
        reg.REGION_NAME,
        COUNT(dep.DEPARTMENT_ID) AS TOTAL_DEPARTAMENTOS
    FROM REGIONS reg
    JOIN COUNTRIES co ON co.REGION_ID = reg.REGION_ID
    JOIN LOCATIONS loc ON loc.COUNTRY_ID = co.COUNTRY_ID
    JOIN DEPARTMENTS dep ON dep.LOCATION_ID = loc.LOCATION_ID
    GROUP BY reg.REGION_NAME;

/*
    40- Realice una consulta que  muestre el salario que paga cada departamento (sin incluir comisión),
    ordenado descendentemente por salario pagado. Se mostrara el código y nombre del departamento y el salario que paga.
*/
    SELECT 
        dep.DEPARTMENT_ID,
        dep.DEPARTMENT_NAME,
        emp.SALARY
    FROM DEPARTMENTS dep
    JOIN EMPLOYEES emp ON emp.DEPARTMENT_ID = dep.DEPARTMENT_ID
    ORDER BY emp.SALARY DESC;

/*
    41- Desarrolle una consulta que muestre el año de contratación,
    el salario menor, mayor y promedio de todos los  empleados por año de contratación.
    Ordene el resultado por año de contratación: Los más recientes primero.
*/
    SELECT
        EXTRACT(YEAR FROM emp.HIRE_DATE) AS ANIO_CONTRATACION,
        MIN(j.MIN_SALARY),
        MAX(j.MAX_SALARY),
        ROUND(AVG(emp.SALARY),2) AS SALARIO_PROMEDIO
    FROM EMPLOYEES emp
    JOIN JOBS j ON j.JOB_ID = emp.JOB_ID
    GROUP BY EXTRACT(YEAR FROM emp.HIRE_DATE)
    ORDER BY ANIO_CONTRATACION DESC;
