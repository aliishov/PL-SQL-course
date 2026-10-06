-- Task 1: Convert simple text '750' to NUMBER.
SELECT TO_NUMBER('750') AS result
FROM dual;

-- Task 2: Convert text '$2,450.75' to NUMBER.
SELECT TO_NUMBER('$2,450.75', '$9,999.99') AS result
FROM dual;
