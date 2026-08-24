-- Task 1: Print first_name and UPPER(first_name) from employees.
SELECT first_name
       UPPER(first_name) AS first_name_lower
FROM employees;

-- Task 2: Print last_name and UPPER(last_name) from employees.
SELECT last_name
       UPPER(last_name) AS last_name_lower
FROM employees;

-- Task 3: Print UPPER('oracle sql') from dual.
SELECT UPPER('oracle sql') AS text_lower
FROM dual;

-- Task 4: Print UPPER('PRIVET' || ' KAK DELa?888') from dual.
SELECT UPPER('PRIVET' || ' KAK DELa?888') AS text_lower
FROM dual;

-- Task 5: Find employees whose UPPER(first_name) is 'DAVID'.
SELECT *
FROM employees
WHERE UPPER(first_name) = 'DAVID';

-- Task 6: Find employees whose UPPER(first_name) contains 'EN'.
SELECT *
FROM employees
WHERE UPPER(first_name) LIKE '%EN%';

-- Task 7: Print full_name: first_name || ' ' || last_name 
--         And next to it, full_name_lower through UPPER.
SELECT first_name || ' ' || last_name AS full_name,
       UPPER(first_name || ' ' || last_name) AS full_name_lower
FROM employees;
