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

