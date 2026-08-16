-- Task 1: Print employees whose first_name begins with S.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Task 2: Print employees whose first_name ends with r.
SELECT * 
FROM employees
WHERE first_name LIKE '%r';
