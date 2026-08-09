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

-- Task 5: Select start_date and start_date + 7 from job_history
SELECT start_date,
       start_date + 7
FROM job_history;

-- Task 6: Select start_date, end_date and days between them
SELECT start_date,
       end_date,
       (end_date - start_date) + 1 days_between
FROM job_history;