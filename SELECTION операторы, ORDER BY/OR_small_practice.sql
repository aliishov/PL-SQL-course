-- Task 1: Display employees with a department_id of 60 or a department_id of 90.
SELECT * 
FROM employees
WHERE department_id = 60 
   OR department_id = 90;

-- Task 2: Display employees with a job_id of 'IT_PROG' or a job_id of 'ST_CLERK'.
SELECT * 
FROM employees
WHERE job_id = 'IT_PROG' 
   OR job_id = 'ST_CLERK';

-- Task 3: Display employees with a first_name of 'Steven' or a first_name of 'David'.
SELECT * 
FROM employees
WHERE first_name = 'Steven' 
   OR first_name = 'David';
   