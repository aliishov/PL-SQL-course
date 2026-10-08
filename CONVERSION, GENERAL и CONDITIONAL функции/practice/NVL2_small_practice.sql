-- Task 1: Return 18 because checked value 17 is not NULL.
SELECT NVL2(17, 18, 19) AS result
FROM dual;
