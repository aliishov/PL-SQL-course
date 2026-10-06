-- Task 1: Show current date with default format.
SELECT TO_CHAR(SYSDATE) AS result
FROM dual;

-- Task 2: Show current date as DD-MM-YYYY.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS result
FROM dual;

-- Task 3: Show current date and time.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MM:SS') AS result
FROM dual;

-- Task 4: Show month name.
SELECT TO_CHAR(SYSDATE, 'fmMonth') AS result
FROM dual;

-- Task 5: Show day name.
SELECT TO_CHAR(SYSDATE, 'fmDay') AS result
FROM dual;

-- Task 6: Show quarter.
SELECT TO_CHAR(SYSDATE, 'Q') AS result
FROM dual;

-- Task 7: Show seconds after midnight.
SELECT TO_CHAR(SYSDATE, 'SSSSS') AS result
FROM dual

-- Task 8: Format employees hire_date.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(e.hire_date, 'DD-MON-YYYY') AS hire_date_text
FROM employees e;

-- Task 9: Find employees hired in August.
SELECT e.employee_id,
       e.first_name,
       e.hire_date
FROM employees e
WHERE TO_CHAR(e.hire_date, 'fmMonth') = 'August';
