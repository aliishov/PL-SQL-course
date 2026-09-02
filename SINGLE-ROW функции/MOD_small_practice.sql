-- Task 1: Find the remainder after 17 / 5.
SELECT MOD(17, 5) AS result
FROM dual;

-- Task 2: Check the number without remainder.
SELECT MOD(20, 5) AS result
FROM dual;

-- Task 3: Check if the dividend is smaller than the divisor.
SELECT MOD(2, 5) AS result
FROM dual;

-- Task 4: Check if the divisor is 0.
SELECT MOD(9, 0) AS result
FROM dual;

-- Task 5: Find the even employee_id.
SELECT employee_id,
       first_name
FROM employees
WHERE MOD(employee_id, 2) = 0;