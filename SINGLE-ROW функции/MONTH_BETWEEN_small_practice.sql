-- Task 1: Count months between two dates.
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-01-01') AS result
FROM dual;

-- Task 2: Reverse the dates.
SELECT MONTHS_BETWEEN(DATE '2020-01-01', DATE '2020-05-01') AS result
FROM dual;

-- Task 3: Same dates.
SELECT MONTHS_BETWEEN(DATE '2020-05-01', DATE '2020-05-01') AS result
FROM dual;

-- Task 4: Different day of month.
SELECT MONTHS_BETWEEN(DATE '2020-05-15', DATE '2020-01-10') AS result
FROM dual;

-- Task 5: Both dates are last day of month.
SELECT MONTHS_BETWEEN(DATE '2020-02-29', DATE '2020-01-31') AS result
FROM dual;

-- Task 6: Use job_history.
SELECT employee_id,
       start_date,
       end_date,
       MONTHS_BETWEEN(end_date, start_date) AS months_count
FROM job_history;

-- Task 7: Filter periods at least 12 months.
SELECT employee_id,
       start_date,
       end_date
FROM job_history
WHERE MONTHS_BETWEEN(end_date, start_date) >= 12;
