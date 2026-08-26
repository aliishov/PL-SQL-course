-- Task 1: Find the position of the letter 'S'.
SELECT INSTR('SQL Developer', 'S') AS result
FROM dual;

-- Task 2: Find the position of the text 'Dev'.
SELECT INSTR('SQL Developer', 'Dev') AS result
FROM dual;

-- Task 3: Check that the result is 0.
SELECT INSTR('SQL Developer', 'Java') AS result
FROM dual;

-- Task 4: Find the second occurrence of the letter 'a'.
SELECT INSTR('database', 'a', 1, 2) AS result
FROM dual;

