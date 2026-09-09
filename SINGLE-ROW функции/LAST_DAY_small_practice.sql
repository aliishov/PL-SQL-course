-- Task 1: Find last day of current month.
SELECT LAST_DAY(SYSDATE) AS result
FROM dual;

-- Task 2: Find last day of August 2026.
SELECT LAST_DAY(DATE '2026-08-01') AS result
FROM dual;