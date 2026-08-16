-- Task 1: Display employees with a salary greater than 10,000 and a department_id of 90.
SELECT *
FROM employees
WHERE salary > 10000 AND department_id = 90;

-- Task 2: Display employees with a job_id of 'IT_PROG' and a department_id of 60.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND department_id = 60;
