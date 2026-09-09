-- Task 1: Find next Monday after fixed date.
SELECT NEXT_DAY(DATE '2026-09-09', 'MONDAY') AS result
FROM dual;

-- Task 2: Find next Saturday after same Saturday.
SELECT NEXT_DAY(DATE '2026-09-05', 'SATURDAY') AS result
FROM dual;