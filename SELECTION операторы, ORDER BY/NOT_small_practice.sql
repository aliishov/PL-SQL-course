-- Task 1: Display employees whose salary is not 17,000. Use NOT.
SELECT *
FROM employees
WHERE NOT (salary = 17000);

-- Task 2: Display employees whose job_id is not 'IT_PROG'. Use NOT.
SELECT *
FROM employees
WHERE NOT (job_id = 'IT_PROG');

-- Task 3: Display employees whose hire_date is not 2005-01-01. Use TO_DATE.
SELECT *
FROM employees 
WHERE NOT(hire_date = TO_DATE('2005-01-01', 'yyyy-mm-dd'));

-- Task 4: Display employees whose first_name does not start with S.
SELECT *
FROM employees
WHERE first_name NOT LIKE 'S%';

-- Task 5: Display employees whose department_id is not in the list: 60, 90.
SELECT *
FROM employees
WHERE department_id NOT IN (60, 90);

-- Task 6: Display employees whose salary is not between 4,000 and 10,000.
SELECT *
FROM employees
WHERE salary NOT BETWEEN 4000 AND 10000;

-- Task 7: Display employees whose commission_pct is not empty.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;