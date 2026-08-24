-- Task 1: Print first_name and INITCAP(first_name) from employees.
SELECT first_name
       INITCAP(first_name) AS first_name_INITCAP
FROM employees;

-- Task 2: Print last_name and INITCAP(last_name) from employees.
SELECT last_name
       INITCAP(last_name) AS last_name_initcap
FROM employees;

-- Task 3: Print INITCAP('ORACLE SQL') from dual.
SELECT INITCAP('ORACLE SQL') AS text_initcap
FROM dual;

-- Task 4: Print INITCAP('PRIVET' || ' KAK DELa?888') from dual.
SELECT INITCAP('PRIVET' || ' KAK DELa?888') AS text_initcap
FROM dual;

-- Task 5: Find employees whose INITCAP(first_name) is 'David'.
SELECT *
FROM employees
WHERE INITCAP(first_name) = 'David';

-- Task 6: Find employees whose INITCAP(first_name) contains 'en'.
SELECT *
FROM employees
WHERE INITCAP(first_name) LIKE '%en%';

