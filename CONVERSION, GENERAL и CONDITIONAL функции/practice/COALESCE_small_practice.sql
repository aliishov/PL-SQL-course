-- Task 1: Return the first non-NULL number.
SELECT COALESCE(1, NULL, 2) AS result
FROM dual;

-- Task 2: Skip two NULL values and return 2.
SELECT COALESCE(NULL, NULL, 2) AS result
FROM dual;

-- Task 3: Return NULL when every argument is NULL.
SELECT COALESCE(NULL, NULL, NULL, NULL) AS result
FROM dual;
