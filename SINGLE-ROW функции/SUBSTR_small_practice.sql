-- Task 1: Get the first 3 characters.
SELECT SUBSTR('Oracle', 1, 3) AS result
FROM dual;

-- Task 2: Get the text from position 4 to the end.
SELECT SUBSTR('Oracle Database', 4) AS result
FROM dual;

-- Task 3: Get 4 characters from position 8.
SELECT SUBSTR('Oracle Database', 8, 4) AS result
FROM dual;

-- Task 4: Get the last 3 characters.
SELECT SUBSTR('Oracle', -3) AS result
FROM dual;
