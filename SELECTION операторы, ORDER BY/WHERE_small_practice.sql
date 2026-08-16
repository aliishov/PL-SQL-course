-- Task 1: Print first_name, last_name, and salary from employees where salary is 17000.
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = 17000;

-- Task 2: Print first_name and salary from employees where last_name is 'King'.
SELECT first_name,
       salary
FROM employees
WHERE last_name = 'King';

-- Task 3: Print all columns from employees where hire_date is September 21, 2005. 
--         Use TO_DATE with the format 'YYYY-MM-DD'.
SELECT *
FROM employees
WHERE hire_date = TO_DATE('2005-09-21', 'YYYY-MM-DD');
