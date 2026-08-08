-- Task 1: Select all columns from employees table
SELECT *
FROM employees;

-- Task 2: Select first_name, last_name, salary from employees table
SELECT first_name,
       last_name,
       salary
FROM employees;

-- Task 3: Select salaty * 12 with alisas
SELECT first_name AS name,
       salary * 12 AS annual_salary
FROM employees;

-- Task 4: Select full name
SELECT first_name,
       last_name,
       first_name || ' ' || last_name AS full_name
FROM employees;

-- Task 5: select 'Hello Oracle' using dual table
SELECT 'Hello Oracle' AS message
FROM dual;