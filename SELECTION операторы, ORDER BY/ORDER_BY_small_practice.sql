-- Task 1: Print the first_name and salary of employees. Sort by salary ascending.
SELECT first_name,
       salary
FROM employees
ORDER BY salary;

-- Task 2: Print the first_name and salary of employees. Sort by salary descending.
SELECT first_name,
       salary
FROM employees
ORDER BY salary DESC;

-- Task 3: Print the first_name, salary, and hire_date for employees with job_id = 'IT_PROG'. Sort by hire_date.
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY hire_date;

