-- Task 1: Convert current date to text and count its characters.
SELECT LENGTH(TO_CHAR(SYSDATE)) AS result
FROM dual;

SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS result
FROM dual;

-- Task 2: Convert current day name to uppercase and count its characters.
SELECT LENGTH(UPPER(TO_CHAR(SYSDATE, 'FMDAY'))) AS result
FROM dual;

-- Task 3: Convert date text to DATE and show its day name.
SELECT TO_CHAR(TO_DATE('07-10-2026', 'DD-MM-YYYY'), 'FMDAY') AS result
FROM dual;
