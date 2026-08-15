-- Numeric functions
-- MOD(dividend, divisor)

SELECT MOD(7, 3)
FROM dual;

SELECT MOD(8, 3)
FROM dual;

SELECT MOD(9, 3)
FROM dual;

SELECT MOD(1, 3)
FROM dual;

SELECT MOD(0, 3)
FROM dual;

SELECT MOD(7, 0)
FROM dual;

SELECT MOD(-39, 5)
FROM dual;

SELECT MOD(3.1, 2)
FROM dual;

SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;

SELECT employee_id,
       first_name,
       last_name,
       MOD(employee_id, 3) + 1 team
FROM employees;


-- ============================================================
-- Numeric functions
-- MOD
-- ============================================================
-- MOD           - single-row numeric function.
--
-- Простыми словами:
--   MOD возвращает remainder after division.
--
-- Remainder     - остаток после деления.
--
-- Пример:
--   7 / 3 = 2 и остаток 1
--
-- Поэтому:
--   MOD(7, 3) = 1
--
-- Result:
--   NUMBER
--
-- В этом уроке только MOD.
-- Другие numeric functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- MOD отвечает на вопрос:
--   "Какой остаток получится после деления?"
--
-- Пример:
SELECT MOD(7, 3) AS remainder_value
FROM dual;

-- Result:
--   1
--
-- Почему:
--   7 можно разделить на 3 два раза:
--   3 + 3 = 6
--
-- Остаток:
--   7 - 6 = 1


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   MOD(dividend, divisor)
--
-- Где:
--   dividend   - number, который делим;
--   divisor    - number, на который делим.
--
-- MOD возвращает remainder.
--
-- Пример:
SELECT MOD(8, 3) AS remainder_value
FROM dual;

-- Result:
--   2
--
-- Почему:
--   8 / 3 = 2 full parts;
--   3 + 3 = 6;
--   8 - 6 = 2.


-- ============================================================
-- When division has no remainder
-- ============================================================
-- Если number делится без остатка,
-- MOD возвращает 0.
--
-- Пример из начала файла:
SELECT MOD(9, 3) AS remainder_value
FROM dual;

-- Result:
--   0
--
-- Почему:
--   9 / 3 = 3 exactly;
--   remainder = 0.
--
-- Важно:
--   result 0 часто используют,
--   чтобы проверить divisibility.


-- ============================================================
-- Dividend smaller than divisor
-- ============================================================
-- Если dividend меньше divisor,
-- full division не происходит.
--
-- Пример:
SELECT MOD(1, 3) AS remainder_value
FROM dual;

-- Result:
--   1
--
-- Почему:
--   1 меньше 3;
--   3 не помещается в 1 ни разу;
--   whole remainder = 1.


-- ============================================================
-- Dividend equals zero
-- ============================================================
-- Если dividend = 0,
-- remainder тоже будет 0.
--
-- Пример:
SELECT MOD(0, 3) AS remainder_value
FROM dual;

-- Result:
--   0
--
-- Почему:
--   0 / 3 = 0;
--   remainder = 0.


-- ============================================================
-- Divisor equals zero
-- ============================================================
-- В Oracle есть важная особенность:
--   MOD(number, 0) returns number.
--
-- Пример из начала файла:
SELECT MOD(7, 0) AS remainder_value
FROM dual;

-- Result:
--   7
--
-- Это не обычное arithmetic division by zero.
-- Это поведение именно Oracle MOD.
--
-- В реальном коде лучше избегать divisor = 0,
-- если это не сделано специально и осознанно.


-- ============================================================
-- MOD with positive numbers
-- ============================================================
SELECT MOD(10, 2) AS remainder_value
FROM dual;

-- Result:
--   0
--
-- 10 делится на 2 без остатка.

SELECT MOD(10, 3) AS remainder_value
FROM dual;

-- Result:
--   1
--
-- 10 / 3 gives remainder 1.

SELECT MOD(10, 4) AS remainder_value
FROM dual;

-- Result:
--   2
--
-- 10 / 4 gives remainder 2.


-- ============================================================
-- MOD with decimal numbers
-- ============================================================
-- MOD может работать с decimal numbers.
--
-- Пример из начала файла:
SELECT MOD(3.1, 2) AS remainder_value
FROM dual;

-- Result:
--   1.1
--
-- Почему:
--   2 помещается в 3.1 один раз;
--   3.1 - 2 = 1.1.
--
-- Пример:
SELECT MOD(8.75, 2) AS remainder_value
FROM dual;

-- Result:
--   0.75


-- ============================================================
-- MOD with negative numbers
-- ============================================================
-- MOD можно использовать с negative numbers.
--
-- Пример из начала файла:
SELECT MOD(-39, 5) AS remainder_value
FROM dual;

-- Result:
--   -4
--
-- Важно:
--   при negative dividend result тоже может быть negative.
--
-- Пример:
SELECT MOD(39, -5) AS remainder_value
FROM dual;

-- Result:
--   4
--
-- Пример:
SELECT MOD(-39, -5) AS remainder_value
FROM dual;

-- Result:
--   -4
--
-- Для beginner level главное запомнить:
--   MOD чаще всего используют с positive numbers;
--   negative numbers могут давать непривычные results.


-- ============================================================
-- MOD returns NUMBER
-- ============================================================
-- MOD returns NUMBER.
--
-- Поэтому result можно использовать
-- в numeric expressions.
--
-- Пример:
SELECT MOD(7, 3) + 10 AS calculated_result
FROM dual;

-- Result:
--   11
--
-- Потому что:
--   MOD(7, 3) = 1;
--   1 + 10 = 11.


-- ============================================================
-- MOD in SELECT list
-- ============================================================
-- MOD можно использовать в SELECT list.
--
-- Пример:
SELECT employee_id,
       MOD(employee_id, 2) AS remainder_value
FROM employees;

-- Meaning:
--   для каждого employee_id показать remainder
--   after division by 2.
--
-- Если result = 0,
-- employee_id делится на 2 без остатка.
--
-- Если result = 1,
-- employee_id не делится на 2 без остатка.


-- ============================================================
-- MOD with alias
-- ============================================================
-- Для MOD expression лучше давать alias.
--
-- Пример:
SELECT MOD(7, 3) AS remainder_value
FROM dual;

-- Alias:
--   remainder_value
--
-- Без alias output column может называться так:
--   MOD(7,3)
--
-- С alias result set читать легче.


-- ============================================================
-- Check even numbers
-- ============================================================
-- MOD часто используют,
-- чтобы проверить even numbers.
--
-- Even number делится на 2 без остатка.
--
-- Пример из начала файла:
SELECT *
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- Meaning:
--   взять employee_id;
--   разделить employee_id на 2;
--   если remainder = 0,
--   значит employee_id even.
--
-- Примеры:
--   MOD(100, 2) = 0
--   MOD(101, 2) = 1
--   MOD(102, 2) = 0


-- ============================================================
-- Check odd numbers
-- ============================================================
-- Odd number при делении на 2 дает remainder 1.
--
-- Пример:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE MOD(employee_id, 2) = 1;

-- Meaning:
--   вернуть rows,
--   где employee_id is odd.
--
-- Примеры:
--   MOD(101, 2) = 1
--   MOD(103, 2) = 1


-- ============================================================
-- Split rows into teams
-- ============================================================
-- MOD удобно использовать,
-- чтобы распределить rows по numeric categories.
--
-- Это просто calculated team number.
--
-- Пример из начала файла:
SELECT employee_id,
       first_name,
       last_name,
       MOD(employee_id, 3) + 1 AS team
FROM employees;

-- Meaning:
--   MOD(employee_id, 3) returns:
--     0, 1, or 2
--
-- Потом + 1 превращает это в:
--     1, 2, or 3
--
-- Поэтому employees можно визуально разделить
-- на three teams.


-- ============================================================
-- Why add 1 for team number
-- ============================================================
-- MOD(employee_id, 3) возвращает possible results:
--   0
--   1
--   2
--
-- Но team numbers обычно удобнее видеть как:
--   1
--   2
--   3
--
-- Поэтому пишем:
SELECT employee_id,
       MOD(employee_id, 3) + 1 AS team_number
FROM employees;

-- Examples:
--   employee_id = 100
--   MOD(100, 3) = 1
--   team_number = 2
--
--   employee_id = 101
--   MOD(101, 3) = 2
--   team_number = 3
--
--   employee_id = 102
--   MOD(102, 3) = 0
--   team_number = 1


-- ============================================================
-- Find every N-th row pattern by id
-- ============================================================
-- MOD можно использовать,
-- чтобы находить values with repeated numeric pattern.
--
-- Пример:
SELECT employee_id,
       first_name,
       last_name
FROM employees
WHERE MOD(employee_id, 5) = 0;

-- Meaning:
--   показать employees,
--   у которых employee_id делится на 5 без остатка.
--
-- Примеры:
--   100
--   105
--   110


-- ============================================================
-- MOD with salary
-- ============================================================
-- MOD можно применять к numeric columns.
--
-- Пример:
SELECT employee_id,
       salary,
       MOD(salary, 1000) AS salary_remainder
FROM employees;

-- Meaning:
--   показать salary;
--   рядом показать remainder after division by 1000.
--
-- Если salary = 24000:
--   MOD(24000, 1000) = 0
--
-- Если salary = 24550:
--   MOD(24550, 1000) = 550


-- ============================================================
-- MOD in WHERE with salary
-- ============================================================
-- Можно искать rows,
-- где salary делится на нужное number без остатка.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE MOD(salary, 1000) = 0;

-- Meaning:
--   вернуть employees,
--   у которых salary is multiple of 1000.


-- ============================================================
-- MOD with calculated expression
-- ============================================================
-- MOD arguments могут быть numeric expressions.
--
-- Пример:
SELECT MOD(10 + 5, 4) AS remainder_value
FROM dual;

-- Result:
--   3
--
-- Почему:
--   10 + 5 = 15;
--   MOD(15, 4) = 3.
--
-- Пример:
SELECT employee_id,
       salary,
       MOD(salary + employee_id, 10) AS calculated_remainder
FROM employees;

-- Meaning:
--   сначала salary + employee_id calculated;
--   потом MOD returns remainder after division by 10.


-- ============================================================
-- MOD and NULL
-- ============================================================
-- Если dividend is NULL,
-- result будет NULL.
--
-- Пример:
SELECT MOD(NULL, 3) AS remainder_value
FROM dual;

-- Result:
--   NULL
--
-- Если divisor is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT MOD(7, NULL) AS remainder_value
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- MOD with non-integer divisor
-- ============================================================
-- Divisor тоже может быть decimal number.
--
-- Пример:
SELECT MOD(10, 2.5) AS remainder_value
FROM dual;

-- Result:
--   0
--
-- Почему:
--   10 divides by 2.5 exactly four times.
--
-- Пример:
SELECT MOD(10, 2.7) AS remainder_value
FROM dual;

-- Result:
--   1.9
--
-- Для beginner level чаще всего MOD используют
-- с integer values.


-- ============================================================
-- MOD does not change table data
-- ============================================================
-- SELECT with MOD показывает calculated result.
--
-- Пример:
SELECT employee_id AS original_employee_id,
       MOD(employee_id, 2) AS remainder_value
FROM employees;

-- original_employee_id показывает value из table.
-- remainder_value показывает calculated value.
--
-- Table employees не изменяется.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что MOD returns division result.
--    Нет, MOD returns remainder.
--
-- 2. Забывать, что no remainder means 0.
--    MOD(9, 3) = 0
--
-- 3. Путать dividend и divisor.
--    MOD(7, 3) и MOD(3, 7) дают разные results.
--
-- 4. Не понимать MOD(number, 0).
--    В Oracle MOD(number, 0) returns number.
--
-- 5. Использовать negative numbers без проверки result.
--    Negative numbers могут давать negative remainder.
--
-- 6. Думать, что MOD changes table data.
--    SELECT with MOD only returns result set.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Найди remainder after 17 / 5:
SELECT MOD(17, 5) AS result
FROM dual;

-- 2. Проверь number without remainder:
SELECT MOD(20, 4) AS result
FROM dual;

-- 3. Проверь dividend smaller than divisor:
SELECT MOD(2, 5) AS result
FROM dual;

-- 4. Проверь divisor = 0:
SELECT MOD(9, 0) AS result
FROM dual;

-- 5. Найди even employee_id:
SELECT employee_id,
       first_name
FROM employees
WHERE MOD(employee_id, 2) = 0;

-- 6. Найди odd employee_id:
SELECT employee_id,
       first_name
FROM employees
WHERE MOD(employee_id, 2) = 1;

-- 7. Раздели employees на 4 teams:
SELECT employee_id,
       first_name,
       MOD(employee_id, 4) + 1 AS team_number
FROM employees;

-- 8. Найди salary values divisible by 1000:
SELECT employee_id,
       salary
FROM employees
WHERE MOD(salary, 1000) = 0;


-- ============================================================
-- Mini summary
-- ============================================================
-- MOD returns remainder after division.
--
-- Syntax:
--   MOD(dividend, divisor)
--
-- Important:
--   dividend is the number being divided;
--   divisor is the number we divide by;
--   MOD returns NUMBER;
--   if division has no remainder, result is 0;
--   MOD(number, 0) returns number in Oracle;
--   MOD is useful for even and odd checks;
--   MOD is useful for splitting rows into numeric patterns;
--   SELECT with MOD does not change table data.
