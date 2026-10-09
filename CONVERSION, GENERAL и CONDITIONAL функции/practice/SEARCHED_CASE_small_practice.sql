-- Task 1: Return 100 when the calculation condition is TRUE.
SELECT CASE
           WHEN 3 * 4 = 12 THEN 100
       END AS result
FROM dual;
