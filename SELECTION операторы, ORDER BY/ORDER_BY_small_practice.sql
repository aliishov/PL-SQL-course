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

-- Task 3: Print the first_name, salary, and hire_date for employees with 
--         job_id = 'IT_PROG'. Sort by hire_date.
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY hire_date;

-- Task 4: Print the salary and hire_date for employees with job_id = 'IT_PROG'. 
--         Sort by first_name, even if first_name is not in the SELECT list.
SELECT salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name;

-- Task 5: Print the last_name, salary, and salary * 12 with alias annual_salary. 
--         Sort by annual_salary descending.
SELECT last_name,
       salary,
       salary * 12 AS annual_salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY annual_salary DESC;

-- Task 6: Print employees and sort by commission_pct DESC, but put 
--         NULL values ​​at the end.
SELECT *
FROM employees
ORDER BY commission_pct DESC NULLS LAST;

-- Task 7: Display first_name and salary. Use ORDER BY 2. Then rewrite the query using ORDER BY salary.
SELECT first_name,
       salary
FROM employees
ORDER BY 2;

SELECT first_name,
       salary
FROM employees
ORDER BY salary;
