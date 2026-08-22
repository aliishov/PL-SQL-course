-- Task 1: Display employees whose salary is not 17,000. Use NOT.
SELECT *
FROM employees
WHERE NOT (salary = 17000);

-- Task 2: Display employees whose job_id is not 'IT_PROG'. Use NOT.
SELECT *
FROM employees
WHERE NOT (job_id = 'IT_PROG');
