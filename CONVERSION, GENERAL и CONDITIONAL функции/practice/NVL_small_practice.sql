-- Task 1: Keep 18 because it is not NULL.
SELECT NVL(18, 19) AS result
FROM dual;

-- Task 2: Replace NULL with number 19.
SELECT NVL(NULL, 19) AS result
FROM dual;
