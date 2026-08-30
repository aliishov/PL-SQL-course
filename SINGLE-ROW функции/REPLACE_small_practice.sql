-- Task 1: Replace 'SQL' with 'PL/SQL'.
SELECT REPLACE('Oracle SQL', 'SQL', 'PL/SQL') AS result
FROM dual;

-- Task 2: Replace 'spaces' with 'underscores'.
SELECT REPLACE('Oracle SQL Course', ' ', '_') AS result
FROM dual;

-- Task 3: Remove 'hyphens'.
SELECT REPLACE('A-B-C-D', '-') AS result
FROM dual;

-- Task 4: Replace 'dots' with 'slashes'.
SELECT REPLACE('15.08.2026', '.', '/') AS result
FROM dual;