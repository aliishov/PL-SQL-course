-- Task 1: Print employees whose first_name begins with S.
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- Task 2: Print employees whose first_name ends with r.
SELECT * 
FROM employees
WHERE first_name LIKE '%r';

-- Task 3: Print employees whose first_name contains ar.
SELECT *
FROM employees
WHERE first_name LIKE '%ar%';

-- Task 4: Print employees whose first_name matches the pattern: D_n
SELECT *
FROM employees
WHERE first_name LIKE 'D_n';
