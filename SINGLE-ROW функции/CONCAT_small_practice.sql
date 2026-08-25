-- Task 1: Concatenate 'Hello' and 'Oracle' using CONCAT.
SELECT CONCAT('Hello', ' Oracle') AS message
FROM dual;

-- Task 2: Print first_name, last_name, and full_name using nested CONCAT.
SELECT first_name,
       last_name,
       CONCAT(first_name, CONCAT(' ', last_name) AS full_name
FROM employees;

-- Task 3: Print first_name, salary, and the text: Salary: salary. Use CONCAT.
SELECT first_name,
       salary,
       CONCAT('Salary: ', salary) AS message
FROM employees;

-- Task 4: Print: Today is: SYSDATE using CONCAT.
SELECT CONCAT('Today is: ', SYSDATE) AS today
FROM dual;
