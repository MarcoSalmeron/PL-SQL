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