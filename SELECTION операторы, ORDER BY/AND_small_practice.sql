-- Task 1: Display employees with a salary greater than 10,000 and a department_id of 90.
SELECT *
FROM employees
WHERE salary > 10000 AND department_id = 90;

-- Task 2: Display employees with a job_id of 'IT_PROG' and a department_id of 60.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND department_id = 60;

-- Task 3: Display employees with a first_name of 'Steven' and a last_name of 'King'.
SELECT *
FROM employees
WHERE first_name = 'Steven' AND last_name = 'King';

-- Task 4: Display employees with a hire_date of 2005-01-01 or later and a department_id of 50.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('2005-01-01', 'YYYY-MM-DD') AND department_id = 50;
