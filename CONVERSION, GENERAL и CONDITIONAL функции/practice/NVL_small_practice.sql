-- Task 1: Keep 18 because it is not NULL.
SELECT NVL(18, 19) AS result
FROM dual;

-- Task 2: Replace NULL with number 19.
SELECT NVL(NULL, 19) AS result
FROM dual;

-- Task 3: Replace an empty string with text 'No value'.
SELECT NVL('', 'No value') AS result
FROM dual;

-- Task 4: Show 0 instead of NULL commission_pct.
SELECT e.employee_id,
       e.first_name,
       e.commission_pct,
       NVL(e.commission_pct, 0) AS commission_value
FROM employees e;
