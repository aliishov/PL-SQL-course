-- Task 1: Print first_name, last_name, and salary from employees where 
--         the salary is between 4000 and 10000.
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary BETWEEN 4000 AND 10000;

-- Task 2: Print rows from job_history where the start_date is between 
--         January 1, 2004, and December 31, 2006. Use TO_DATE.
SELECT *
FROM job_history
WHERE start_date BETWEEN TO_DATE('01.01.2004', 'DD.MM.YYYY') 
                     AND TO_DATE('31.12.2006', 'DD.MM.YYYY');

-- Task 3: Print employees where the first_name is between 'A' and 'C'.
SELECT *
FROM employees
WHERE first_name BETWEEN 'A' AND 'C';

-- Task 4: Display departments where location_id is in the list: 1700, 2400, 1500
SELECT *
FROM departments
WHERE location_id IN (1700, 2400, 1500);

-- Task 5: Display rows from job_history where job_id is 
--         in the list: 'IT_PROG', 'ST_CLERK'
SELECT *
FROM job_history
WHERE job_id in ('IT_PROG', 'ST_CLERK');
