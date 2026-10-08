-- Task 1: Return 18 because checked value 17 is not NULL.
SELECT NVL2(17, 18, 19) AS result
FROM dual;

-- Task 2: Return 19 because checked value is NULL.
SELECT NVL2(NULL, 18, 19) AS result
FROM dual;
