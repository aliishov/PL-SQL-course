-- Task 1: Print LPAD('Oracle', 10, '*') from dual.
SELECT LPAD('Oracle', 10, '*') AS l_pad
FROM dual;

-- Task 2: Print RPAD('Oracle', 10, '*') from dual.
SELECT RPAD('Oracle', 10, '*') AS r_pad
FROM dual;

-- Task 3: Print LPAD('25', 5, '0') from dual.
SELECT LPAD('25', 5, '0') AS l_pad
FROM dual;

-- Task 4: Print first_name, LPAD(first_name, 15, '*'), 
--         and RPAD(first_name, 15, '*') from employees.
SELECT first_name,
       LPAD(first_name, 15, '*') AS l_pad,
       RPAD(first_name, 15, '*') AS r_pad
FROM employees;

-- Task 5: Check: LPAD('SQL', 10, 'ab') RPAD('SQL', 10, 'ab') 
--         Explain the result.
SELECT LPAD('SQL', 10, 'ab') AS l_pad,
       RPAD('SQL', 10, 'ab') AS r_pad
FROM dual;

-- Task 6: Check: LPAD('Oracle', 3, '*') RPAD('Oracle', 3, '*') 
--         Explain why the result is short.
SELECT LPAD('Oracle', 3, '*') AS l_pad,
       RPAD('Oracle', 3, '*') AS r_pad
FROM dual;
