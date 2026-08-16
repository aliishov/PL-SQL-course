-- Task 1: Print first_name, last_name, and salary from employees where 
--         the salary is between 4000 and 10000.
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary BETWEEN 4000 AND 10000;
