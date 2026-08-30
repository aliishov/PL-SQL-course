-- Task 1: Drop the decimal part.
SELECT TRUNC(46.67) AS result
FROM dual;

-- Task 2: Leave 1 digit after the decimal point.
SELECT TRUNC(46.67, 1) AS result
FROM dual;