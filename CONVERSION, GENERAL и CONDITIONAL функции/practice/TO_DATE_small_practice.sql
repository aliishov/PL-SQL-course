-- Task 1: Convert text '15-08-2026' to DATE.
SELECT TO_DATE('15-08-2026', 'DD-MM-YYYY') AS result
FROM dual;

-- Task 2: Convert text with time to DATE and show it with TO_CHAR.
SELECT TO_CHAR(TO_DATE('15-08-2026 14:30:25', 'DD-MM-YYYY HH24:MI:SS'),
                       'DD-MM-YYYY HH24:MI:SS') AS result
FROM dual;
