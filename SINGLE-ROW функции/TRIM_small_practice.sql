-- Task 1: Remove spaces from both sides.
SELECT TRIM('     Oracle     ') AS result
FROM dual;

-- Task 2: Remove '*' only from left.
SELECT TRIM(LEADING '*' FROM '***Oracle***') AS result
FROM dual;

