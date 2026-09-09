-- Task 1: Round fixed date to nearest day.
SELECT ROUND(DATE ' 2026-09-09') AS result
FROM dual;

-- Task 2: Round day 15 to month.
SELECT ROUND(DATE ' 2026-09-15', 'MM') AS result
FROM dual;

-- Task 3: Round day 16 to month.
SELECT ROUND(DATE '2026-09-16', 'MM') AS result
FROM dual;

-- Task 4: Round before July 1 to year.
SELECT ROUND(DATE ' 2026-06-30', 'YYYY') AS result
FROM dual;

-- Task 5: Round July 1 to year.
SELECT ROUND(DATE ' 2026-07-01', 'YYYY') AS result
FROM dual;

-- Task 6: Round quarter before border.
SELECT ROUND(DATE '2026-08-15', 'Q') AS result
FROM dual;

-- Task 7: Round quarter after border.
SELECT ROUND(DATE '2026-08-16', 'Q') AS result
FROM dual;

-- Task 8: Use employees hire_date.
SELECT employee_id,
       first_name, 
       hire_date,
       ROUND(hire_date, 'MM') AS rounded_month
FROM employees;