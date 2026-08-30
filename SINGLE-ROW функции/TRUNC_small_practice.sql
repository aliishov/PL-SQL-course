-- Task 1: Drop the decimal part.
SELECT TRUNC(46.67) AS result
FROM dual;

-- Task 2: Leave 1 digit after the decimal point.
SELECT TRUNC(46.67, 1) AS result
FROM dual;

-- Task 3: Leave 2 digits after the decimal point.
SELECT TRUNC(46.678, 2) AS result
FROM dual;

-- Task 4: Leave the number before tens.
SELECT TRUNC(4567, -1) AS result
FROM dual;

-- Task 5: Leave the number before hundreds.
SELECT TRUNC(4567, -2) AS result
FROM dual;