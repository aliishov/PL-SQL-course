-- Task 1: Show current date with default format.
SELECT TO_CHAR(SYSDATE) AS result
FROM dual;

-- Task 2: Show current date as DD-MM-YYYY.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS result
FROM dual;

-- Task 3: Show current date and time.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MM:SS') AS result
FROM dual;

-- Task 4: Show month name.
SELECT TO_CHAR(SYSDATE, 'fmMonth') AS result
FROM dual;

-- Task 5: Show day name.
SELECT TO_CHAR(SYSDATE, 'fmDay') AS result
FROM dual;

-- Task 6: Show quarter.
SELECT TO_CHAR(SYSDATE, 'Q') AS result
FROM dual;

-- Task 7: Show seconds after midnight.
SELECT TO_CHAR(SYSDATE, 'SSSSS') AS result
FROM dual
