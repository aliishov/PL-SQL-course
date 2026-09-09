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

-- Task 5: Check the result if start_position is too large.
SELECT SUBSTR('Oracle Database', 100, 4) AS result
FROM dual;

-- Task 6: Check the result if number_of_characters = 0.
SELECT SUBSTR('Oracle Database', 7, 0) AS result
FROM dual;

-- Task 7: Get the first character from employee email.
SELECT email,
       SUBSTR(email, 1, 1) AS first_character
FROM employees;
