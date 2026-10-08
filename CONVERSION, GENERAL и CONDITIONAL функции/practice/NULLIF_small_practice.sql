-- Task 1: Compare equal numbers and return NULL.
SELECT NULLIF(18, 18) AS result
FROM dual;

-- Task 2: Compare different numbers and return the first number.
SELECT NULLIF(18, 19) AS result
FROM dual;

-- Task 3: Convert differently formatted date text and compare the dates.
SELECT NULLIF(
           TO_DATE('18-09-1987', 'DD-MM-YYYY'),
           TO_DATE('1987/09/18', 'YYYY/MM/DD')
       ) AS result
FROM dual;

-- Task 4: Turn commission_pct 0 into NULL.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NULLIF(e.commission_pct, 0)
FROM employees e;
