-- Task 1: Convert number to text without format.
SELECT TO_CHAR(18) AS result
FROM dual;

-- Task 2: Use 9 positions.
SELECT TO_CHAR(18, '99999') AS result
FROM dual;
