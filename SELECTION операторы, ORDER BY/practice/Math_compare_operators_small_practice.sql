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

-- Task 3: Print employees with first_name equal to 'Steven'.
SELECT * 
FROM employees
WHERE first_name = 'Steven';

-- Task 4: Print rows from job_history where start_date is later than 01 January 2005. Use TO_DATE.
SELECt * 
FROM job_history
WHERE start_date > TO_DATE('01.01.2005', 'DD.MM.YYYY');

-- Task 5: Print employees with job_id not equal to 'IT_PROG'. Use <> or !=.
SELECT *
FROM employees
WHERE job_id <> 'IT_PROG';
