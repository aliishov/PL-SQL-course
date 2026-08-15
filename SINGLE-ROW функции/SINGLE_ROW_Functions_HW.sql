-- Task 1: Get a list of all employees whose first name is longer than 10 letters.
SELECT *
FROM employees
WHERE LENGTH(first_name) > 10;

-- Task 2: Get a list of all employees whose salary is a multiple of 1000.
SELECT *
FROM employees
WHERE MOD(salary, 1000) = 0;

-- Task 3: Print the employee's phone number and the first 3-digit digit of the 
--         phone number if the number is in the format XXX.XXX.XXXX.
SELECT phone_number,
       SUBSTR(phone_number, 1, 3)
FROM employees
WHERE phone_number LIKE '___.___.____';

-- Task 4: Get a list of all employees whose last letter in their first name is 
--         'm' and whose first name is longer than 5.
SELECT *
FROM employees
WHERE SUBSTR(first_name, -1) = 'm' 
AND LENGTH(first_name) > 5;

-- Task 5: Print the date of next Friday.
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') next_day
FROM dual;

-- Task 6: Get a list of all employees who have been with the company for more 
--         than 12 years and 6 months (150 months).
SELECT *
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) > 150;

-- Task 7: Print the phone number, replacing all '.' with '-' in the PHONE_NUMBER value.
SELECT phone_number,
       REPLACE(phone_number, '.', '-') replaced
FROM employees;

-- Task 8: Display the name, email, and job_id for all employees in the format: 
--         STEVEN sking Ad_Pres
SELECT UPPER(first_name),
       LOWER(email),
       INITCAP(job_id)
FROM employees;

-- Task 9: Display the employee's name and salary information, without using the 
--         || symbol, as follows: Steven24000
SELECT CONCAT(first_name, salary)
FROM employees;

-- Task 10: Display the employee's hire date, the hire date rounded to the nearest 
--          month, and the first day of the year of hire.
SELECT hire_date,
       ROUND(hire_date, 'MM') rounded_month,
       TRUNC(hire_date, 'YYYY') rounded_year
FROM employees;
       

-- Task 11: Display the first and last names of all employees. The first name
--          must be 10 characters long, and if the first name is less than 10, then
--          pad it with the $ sign to 10 characters. The last name must be 15 characters 
--          long, and if the last name is less than 15, then precede the last name 
--          with as many ! signs as necessary.
SELECT RPAD(first_name, 10, '$'),
       LPAD(last_name, 15, '!')
FROM employees;

-- Task 12: Display the employee's first name and the position of the second 
--          letter 'a' in their first name.
SELECT first_name,
       INSTR(first_name, 'a', 1, 2)
FROM employees;

-- Task 13: Display the text '!!!HELLO!!MY FRIEND!!!!!!!!' and the same text, but
--          without the exclamation point at the beginning and end of the text.
SELECT '!!!HELLO!!MY FRIEND!!!!!!!!',
       TRIM('!' FROM '!!!HELLO!!MY FRIEND!!!!!!!!')
FROM dual;

-- Task 14: Display information about:
--          -the employee's salary,
--          -salary multiplied by the coefficient 3.1415,
--          -the increased salary rounded to the nearest whole number,
--          -the integer number of thousands of the increased salary.
SELECT salary,
       salary * 3.1415,
       ROUND(salary * 3.1415),
       TRUNC(salary * 3.1415, -3) / 1000
FROM employees;

-- Task 15: Display information about:
--          -the employee's hiring date,
--          -the date six months after the employee's hiring,
--          -the date of the last day of the month the employee was hired.
SELECT hire_date,
       ADD_MONTHS(hire_date, 6),
       LAST_DAY(hire_date)
FROM employees;