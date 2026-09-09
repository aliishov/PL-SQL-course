-- Task 1: Truncate current database date to day.
SELECT TRUNC(SYSDATE) AS result
FROM dual;

-- Task 2: Truncate fixed date to month.
SELECT TRUNC(DATE '2026-09-09', 'MM') AS result
FROM dual;

-- Task 3: Truncate end of month to month.
SELECT TRUNC(DATE '2026-12-31', 'MM') AS result
FROM dual;

-- Task 4: Truncate fixed date to year.
SELECT TRUNC(DATE '2026-12-31', 'YYYY') AS result
FROM dual;

-- Task 5: Truncate fixed date to quarter.
SELECT TRUNC(DATE '2026-12-31', 'Q') AS result
FROM dual;

-- Task 6: Compare MM and MONTH.
SELECT TRUNC(DATE '2026-12-31', 'MM') AS result_mm,
       TRUNC(DATE '2026-12-31', 'MONTH') AS result_month
FROM dual;

-- Task 7: Use employees hire_date.
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date, 'MM') AS hire_month_start
FROM employees;

-- Task 8: Use selected employees from the first examples.
SELECT employee_id,
       first_name,
       hire_date,
       TRUNC(hire_date, 'YYYY') AS year_start,
       TRUNC(hire_date, 'Q') AS quarter_start,
       TRUNC(hire_date, 'MM') AS month_start
FROM employees
WHERE employee_id IN (120, 121, 100, 101);

-- Task 9: Find rows inside one month.
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE TRUNC(hire_date, 'MM') = DATE '2007-06-01';