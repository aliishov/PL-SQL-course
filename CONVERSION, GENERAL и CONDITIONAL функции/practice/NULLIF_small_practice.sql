-- Task 1: Compare equal numbers and return NULL.
SELECT NULLIF(18, 18) AS result
FROM dual;

-- Task 2: Compare different numbers and return the first number.
SELECT NULLIF(18, 19) AS result
FROM dual;
