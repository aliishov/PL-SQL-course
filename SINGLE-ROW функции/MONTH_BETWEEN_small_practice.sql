-- Task 1: Count months between two dates.
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-01-01') AS result
FROM dual;

-- Task 2: Reverse the dates.
SELECT MONTHS_BETWEEN(DATE '2020-01-01', DATE '2020-05-01') AS result
FROM dual;

-- Task 3: Same dates.
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-05-01') AS result
FROM dual;