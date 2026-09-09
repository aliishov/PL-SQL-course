-- Task 1: Round fixed date to nearest day.
SELECT ROUND(DATE ' 2026-09-09') AS result
FROM dual;

-- Task 2: Round day 15 to month.
SELECT ROUND(DATE ' 2026-09-15', 'MM') AS result
FROM dual;