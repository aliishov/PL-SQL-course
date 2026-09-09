-- Task 1: Truncate current database date to day.
SELECT TRUNC(SYSDATE) AS result
FROM dual;

-- Task 2: Truncate fixed date to month.
SELECT TRUNC(DATE '2026-09-09', 'MM') AS result
FROM dual;