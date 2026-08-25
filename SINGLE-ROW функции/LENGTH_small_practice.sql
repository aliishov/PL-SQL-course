-- Task 1: Print first_name and LENGTH(first_name) from employees.
SELECT first_name,
       LENGTH(first_name) AS lngth
FROM employees;

-- Task 2: Print last_name and LENGTH(last_name) from employees.
SELECT last_name,
       LENGTH(last_name) AS lngth
FROM employees;

-- Task 3: Print LENGTH('Raul') from dual.
SELECT LENGTH('Raul') 
FROM dual;
