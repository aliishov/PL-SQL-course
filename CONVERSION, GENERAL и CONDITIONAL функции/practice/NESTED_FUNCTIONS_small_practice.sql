-- Task 1: Convert current date to text and count its characters.
SELECT LENGTH(TO_CHAR(SYSDATE)) AS result
FROM dual;

SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS result
FROM dual;

-- Task 2: Convert current day name to uppercase and count its characters.
SELECT LENGTH(UPPER(TO_CHAR(SYSDATE, 'FMDAY'))) AS result
FROM dual;
