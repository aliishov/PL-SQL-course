-- Task 1: Round to the nearest whole number.
SELECT ROUND(46.67) AS result
FROM dual;

-- Task 2: Round to 1 digit after decimal point.
SELECT ROUND(46.67, 1) AS result
FROM dual;

-- Task 3: Round to 2 digits after decimal point.
SELECT ROUND(46.678, 2) AS result
FROM dual;

-- Task 4: Round to tens.
SELECT ROUND(4567, -1) AS result
FROM dual;

-- Task 5: Round to hundreds.
SELECT ROUND(4567, -2) AS result
FROM dual;