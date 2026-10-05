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

-- Task 6: Use group separator.
SELECT TO_CHAR(1234567, '9,999,999') AS result
FROM dual;

-- Task 7: Use local decimal and group elements.
SELECT TO_CHAR(1234567.89, '9G999G999D99') AS result
FROM dual;

-- Task 8: Show dollar amount.
SELECT TO_CHAR(1234.5, '$999,999.99') AS result
FROM dual;

-- Task 9: Show sign.
SELECT TO_CHAR(-18, 'S099') AS result
FROM dual;

-- Task 10: Format employees salary.
SELECT e.first_name,
       e.salary,
       TO_CHAR(e.salary, '$999,999') AS salary_text
FROM employees e;
