-- Task 1: Convert current date to text and count its characters.
SELECT LENGTH(TO_CHAR(SYSDATE)) AS result
FROM dual;

SELECT LENGTH(TO_CHAR(SYSDATE, 'DD-MM-YYYY')) AS result
FROM dual;

-- Task 2: Convert current day name to uppercase and count its characters.
SELECT LENGTH(UPPER(TO_CHAR(SYSDATE, 'FMDAY'))) AS result
FROM dual;

-- Task 3: Convert date text to DATE and show its day name.
SELECT TO_CHAR(TO_DATE('07-10-2026', 'DD-MM-YYYY'), 'FMDAY') AS result
FROM dual;

-- Task 4: Show first 3 letters of each first_name in lowercase.
SELECT e.employee_id,
       e.first_name,
       LOWER(SUBSTR(e.first_name, 1, 3)) AS short_name
FROM employees e;

-- Task 5: Remove outer spaces from last_name and count its characters.
SELECT e.employee_id,
       e.last_name,
       LENGTH(TRIM(e.last_name)) AS last_name_length
FROM employees e;

-- Task 6: Use first_name length as precision for ROUND.
SELECT e.emplopyee_id,
       e.first_name,
       LENGTH(e.first_name) AS name_length,
       ROUND(123.456789123456, LENGTH(first_name)) AS rounded_number
FROM employees;

-- Task 7: Use employee_id length as start position in first_name.
SELECT e.employee_id,
       e.first_name,
       LENGTH(e.employee_id) AS id_length,
       SUBSTR(e.first_name, LENGTH(TO_CHAR(employee_id))) AS name_part
FROM employees e;

-- Task 8: Count characters in the name part created by nested SUBSTR.
SELECT e.employee_id,
       e.first_name,
       LENGTH(e.employee_id) AS id_length,
       SUBSTR(e.first_name, LENGTH(TO_CHAR(employee_id))) AS name_part,
       LENGTH(SUBSTR(e.first_name, LENGTH(TO_CHAR(employee_id)))) AS name_part_length
FROM employees e;

-- Task 9: Add 6 months to hire_date and format the result as text.
SELECT e.employee_id,
       e.first_name,
       e.hire_date,
       TO_CHAR(ADD_MONTHS(e.hire_date, 6), 'DD-MON-YYYY') AS review_date
FROM employees e;

-- Task 10: Remove dots from phone_number and convert result to NUMBER.
SELECT e.employee_id,
       e.first_mname,
       e.phone_number,
       TO_NUMBER(REPLACE(e.phone_number, '.', '')) AS phone_as_number
FROM employees e;
