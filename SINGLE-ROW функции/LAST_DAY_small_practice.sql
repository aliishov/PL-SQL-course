-- Task 1: Find last day of current month.
SELECT LAST_DAY(SYSDATE) AS result
FROM dual;

-- Task 2: Find last day of August 2026.
SELECT LAST_DAY(DATE '2026-08-01') AS result
FROM dual;

-- Task 3: Find last day of April 2026.
SELECT LAST_DAY(DATE '2026-04-01') AS result
FROM dual;

-- Task 4: Check February in common year.
SELECT LAST_DAY(DATE '2026-02-01') AS result
FROM dual;

-- Task 5: Check February in leap year.
SELECT LAST_DAY(DATE '2028-02-01') AS result
FROM dual;

-- Task 6: Calculate days left in fixed month.
SELECT LAST_DAY(SYSDATE) - DATE '2026-09-09' AS result
FROM dual;