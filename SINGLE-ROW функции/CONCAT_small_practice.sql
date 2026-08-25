-- Task 1: Concatenate 'Hello' and 'Oracle' using CONCAT.
SELECT CONCAT('Hello', ' Oracle') AS message
FROM dual;

-- Task 2: Print first_name, last_name, and full_name using nested CONCAT.
SELECT first_name,
       last_name,
       CONCAT(first_name, CONCAT(' ', last_name) AS full_name
FROM employees;
