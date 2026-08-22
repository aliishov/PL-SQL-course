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
