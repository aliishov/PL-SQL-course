-- Task 1: Convert current date to text and count its characters.
SELECT LENGTH(TO_CHAR(SYSDATE)) AS result
FROM dual;

SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS result
FROM dual;
