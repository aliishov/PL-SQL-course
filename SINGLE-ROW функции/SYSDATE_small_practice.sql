-- Task 1: Show current database date and time.
SELECT SYSDATE AS server_date_time
FROM dual;

-- Task 2: Show current NLS_DATE_FORMAT.
SELECT *
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

-- Task 3: Show SYSDATE with visible time part.
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY hh24:mi:ss') as server_date_time
FROM dual;

-- Task 4: Add 10 days.
SELECT SYSDATE + 10 AS ten_days_later
FROM dual;