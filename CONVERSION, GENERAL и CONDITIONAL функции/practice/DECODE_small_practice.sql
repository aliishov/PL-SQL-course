-- Task 1: Match calculation result 12 with text 'Twelve'.
SELECT DECODE(3 * 4, 12, 'Twelve') AS result
FROM dual;

-- Task 2: Return NULL when no value matches and default is absent.
SELECT DECODE(3 * 4, 13, 'Thriteen') AS result
FROM dual;
