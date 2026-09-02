-- Task 1: Show current database date and time.
SELECT SYSDATE AS server_date_time
FROM dual;

-- Task 2: Show current NLS_DATE_FORMAT.
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';