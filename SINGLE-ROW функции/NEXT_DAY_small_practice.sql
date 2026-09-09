-- Task 1: Find next Monday after fixed date.
SELECT NEXT_DAY(DATE '2026-09-09', 'MONDAY') AS result
FROM dual;

-- Task 2: Find next Saturday after same Saturday.
SELECT NEXT_DAY(DATE '2026-09-05', 'SATURDAY') AS result
FROM dual;

-- Task 3: Find next Sunday after fixed date.
SELECT NEXT_DAY(DATE '2026-09-09', 'SUNDAY') AS result
FROM dual;

-- Task 4: Use abbreviation.
SELECT NEXT_DAY(DATE '2026-09-09', 'FRI') AS result
FROM dual;

-- Task 5: Use SYSDATE.
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS result
FROM dual;

-- Task 6: Use employees hire_date.
SELECT employee_id,
       first_name,
       hire_date,
       NEXT_DAY(hire_date, 'MONDAY') AS next_monday_after_hire
FROM employees;

-- Task 7: Use job_history start_date.
SELECT employee_id,
       start_date,
       NEXT_DAY(start_date, 'FRIDAY') AS next_friday_fater_start
FROM job_history;