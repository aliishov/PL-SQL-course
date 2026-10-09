-- Task 1: Return 100 when the calculation condition is TRUE.
SELECT CASE
           WHEN 3 * 4 = 12 THEN 100
       END AS result
FROM dual;

-- Task 2: Show that the first TRUE condition wins.
SELECT CASE
           WHEN 10 > 5 THEN 'First true condition'
           WHEN 10 > 1 THEN 'Second true condition'
           ELSE 'No condition'
       END AS result
FROM dual;
