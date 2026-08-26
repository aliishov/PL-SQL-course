-- Task 1: Remove spaces from both sides.
SELECT TRIM('     Oracle     ') AS result
FROM dual;

-- Task 2: Remove '*' only from left.
SELECT TRIM(LEADING '*' FROM '***Oracle***') AS result
FROM dual;

-- Task 3: Remove '#' only from right.
SELECT TRIM(TRAILING '#' FROM 'Oracle###') AS result
FROM dual;

-- Task 4: Remove '0' from both sides.
SELECT TRIM(BOTH '0' FROM '0004500') AS result
FROM dual;

