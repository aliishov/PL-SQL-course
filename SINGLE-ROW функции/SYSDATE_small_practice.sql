-- Task 1: Show current database date and time.
SELECT SYSDATE AS server_date_time
FROM dual;

-- Task 2: Show current NLS_DATE_FORMAT.
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- Task 3: Show SYSDATE with visible time part.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss') as server_date_time
FROM dual;

-- Task 4: Add 10 days.
SELECT SYSDATE + 10 AS ten_days_later
FROM dual;

-- Task 5: Subtract 10 days.
SELECT SYSDATE - 10 AS ten_days_ago
FROM dual;

-- Task 6: Add half day.
SELECT SYSDATE + 0.5 AS ten_days_ago
FROM dual;

-- Task 7: Calculate days since hire.
SELECT employee_id,
       first_name,
       hire_date,
       SYSDATE - hire_date AS days_since_here
FROM employees;

-- Task 8: Find employees hired before current date.
SELECT employee_id,
       first_name,
       hire_date
FROM employees
WHERE hire_date < SYSDATE;