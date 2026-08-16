-- Task 1: Print first_name and last_name for employees with a salary greater than 10,000.
SELECT first_name,
       last_name
FROM employees
WHERE salary > 10000;

-- Task 2: Print first_name and last_name for employees with a salary less than 10,000.
SELECT first_name,
       last_name
FROM employees
WHERE salary < 10000;
