-- Task 1: Select  all employees with name David
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--Task 2: Select all employees with job_id FI_ACCOUNT
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'FI_ACCOUNT';

-- Task 3: Select first_name, last_name salary, and department_id for all employees from 50th department with salary bigger than 4000
SELECT FIRST_NAME,
       LAST_NAME,
       SALARY,
       DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50 AND SALARY > 4000;

-- Task 4: Select salary for all employees, who work in 20th or 30 department
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20 OR DEPARTMENT_ID = 30;

-- Task 5: Select all employees, whos first_name-s ends with 'a' and tohe second character also 'a'
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_a%a';

-- Task 6: Select all employees from 50th or 80 department, who has commission_pct. SORT by email ASC using numeric position
SELECT *
FROM EMPLOYEES
WHERE (DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80)
AND COMMISSION_PCT IS NOT NULL
ORDER BY 4 ASC;

-- Task 7: Select all emplyees who has at least 2 'n' in their first_name
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%n%n%';

-- Task 8: Select all emplyees who has at least 4 characters in their first_name, order by department id DESC using numeric posirion
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '____%'
ORDER BY 11 DESC NULLS LAST;

-- Task 9: Select all employees whos salary is between 3000 and 7000 inclusive, with no bonus(commission_pct) and job_id in PU_CLERK, ST_MAN, ST_CLERK
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN 3000 AND 7001
AND COMMISSION_PCT IS NULL
AND JOB_ID IN ('PU_CLERK', 'ST_MAN', 'ST_CLERK');


-- Task 10: Select all emplyees who has '%' in their first_name
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '\%' ESCAPE '\';

-- Task 11: Select job_id, first_name, salary for employees whos id bigger or equals 120 and job_id not equals 'IT_PROG', sort by job_id DESC, and first_name ASC
SELECT JOB_ID,
       FIRST_NAME,
       SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID >= 120 AND JOB_ID != 'IT_PROG'
ORDER BY JOB_ID DESC, FIRST_NAME ASC;
