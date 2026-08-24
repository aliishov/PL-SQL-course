-- Task 1: Print first_name and LOWER(first_name) from employees.
SELECT first_name
       LOWER(first_name) AS first_name_lower
FROM employees;

-- Task 2: Print last_name and LOWER(last_name) from employees.
SELECT last_name
       LOWER(last_name) AS last_name_lower
FROM employees;

-- Task 3: Print LOWER('ORACLE SQL') from dual.
SELECT LOWER('ORACLE SQL') AS text_lower
FROM dual;
