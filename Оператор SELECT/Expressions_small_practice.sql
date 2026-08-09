-- Task 1: Select salary and salary multiply by 12
SELECT salary, 
       salary * 12
FROM employees;

-- Task 2: Select first_name, salary and salary multiply by 12
SELECT first_name,
       salary, 
       salary * 12
FROM employees;

-- Task 3: Select commission_pct and ommission_pct devided by 2
SELECT commission_pct, 
       commission_pct / 12
FROM employees;

-- Task 4: Select salary * NVL(commission_pct, 0) with alias commission_amount
SELECT salary * NVL(commission_pct, 0) commission_amount
FROM employees;