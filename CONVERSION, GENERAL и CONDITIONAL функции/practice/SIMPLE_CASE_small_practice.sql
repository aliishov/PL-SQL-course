-- Task 1: Return numeric value 100 when 3 * 4 equals 12.
SELECT CASE 3 * 4
           WHEN 12 THEN 100
       END AS result
FROM dual;

-- Task 2: Show that the first of two equal matches wins.
SELECT CASE 3 * 4 
           WHEN 11     THEN 'Eleven'
           WHEN 12     THEN 'Twelve from literal'
           WHEN 24 / 2 THEN 'Twelve from expression'
           ELSE 'No match'
       END AS result
FROM dual;
