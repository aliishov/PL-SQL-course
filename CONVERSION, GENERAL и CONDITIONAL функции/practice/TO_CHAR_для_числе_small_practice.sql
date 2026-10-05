-- Task 1: Convert number to text without format.
SELECT TO_CHAR(18) AS result
FROM dual;

-- Task 2: Use 9 positions.
SELECT TO_CHAR(18, '99999') AS result
FROM dual;

-- Task 3: Use 0 positions.
SELECT TO_CHAR(18, '00000') AS result
FROM dual;

-- Task 4: Show decimal digits.
SELECT TO_CHAR(18.35, '999.99') AS result
FROM dual;

-- Task 5: Force decimal zeros.
SELECT TO_CHAR(18, '999.00') AS result
FROM dual;
