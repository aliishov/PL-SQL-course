-- Numeric functions
-- ROUND(n, precision)

SELECT ROUND(3.14)
FROM dual;

SELECT ROUND(3.5)
FROM dual;

SELECT ROUND(3.14, 0)
FROM dual;

SELECT ROUND(3.1415, 1)
FROM dual;

SELECT ROUND(3.1415, 3)
FROM dual;

SELECT salary original_salary,
       salary * 3.14 multiplied_salary,
       ROUND(salary * 3.14) rounded_salary
FROM employees;

SELECT ROUND(32526, -3)
FROM dual;

SELECT ROUND(325.26, -1)
FROM dual;

SELECT first_name,
       ROUND((SYSDATE - hire_date) * employee_id)
FROM employees;


-- ============================================================
-- Numeric functions
-- ROUND
-- ============================================================
-- ROUND         - single-row numeric function.
--
-- Простыми словами:
--   ROUND округляет number.
--
-- ROUND не меняет data в table.
-- Он только возвращает rounded result в result set.
--
-- Result:
--   NUMBER
--
-- В этом уроке только numeric ROUND.
-- Другие numeric functions будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- ROUND отвечает на вопрос:
--   "Округли number до нужной точности."
--
-- Пример:
SELECT ROUND(3.14) AS rounded_number
FROM dual;

-- Result:
--   3
--
-- Почему:
--   если precision не указан,
--   Oracle округляет до целого number.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   ROUND(number_value, precision)
--
-- Где:
--   number_value   - число или numeric expression;
--   precision      - до какого decimal place округлять.
--
-- precision можно не писать:
--
--   ROUND(number_value)
--
-- Если precision не указан,
-- Oracle использует precision = 0.
--
-- То есть:
--   ROUND(3.14)
--
-- По смыслу то же самое, что:
--   ROUND(3.14, 0)


-- ============================================================
-- ROUND without precision
-- ============================================================
-- Если второй argument не указан,
-- result будет округлен до целого number.
--
-- Пример из начала файла:
SELECT ROUND(3.14) AS rounded_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT ROUND(3.5) AS rounded_number
FROM dual;

-- Result:
--   4
--
-- Почему:
--   .5 округляется вверх от 3 к 4.


-- ============================================================
-- ROUND with precision = 0
-- ============================================================
-- precision = 0 означает:
--   округлить до целого number.
--
-- Пример:
SELECT ROUND(3.14, 0) AS rounded_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT ROUND(3.5, 0) AS rounded_number
FROM dual;

-- Result:
--   4
--
-- Поэтому ROUND(number) и ROUND(number, 0)
-- обычно дают одинаковый result.


-- ============================================================
-- Positive precision
-- ============================================================
-- Positive precision округляет справа от decimal point.
--
-- Пример:
SELECT ROUND(3.1415, 1) AS rounded_number
FROM dual;

-- Result:
--   3.1
--
-- Meaning:
--   оставить 1 digit после decimal point.
--
-- Пример:
SELECT ROUND(3.1415, 2) AS rounded_number
FROM dual;

-- Result:
--   3.14
--
-- Meaning:
--   оставить 2 digits после decimal point.
--
-- Пример из начала файла:
SELECT ROUND(3.1415, 3) AS rounded_number
FROM dual;

-- Result:
--   3.142
--
-- Почему:
--   нужно оставить 3 digits после decimal point;
--   fourth digit = 5;
--   поэтому 3.141 становится 3.142.


-- ============================================================
-- Precision table
-- ============================================================
-- Один и тот же number можно округлять по-разному.
--
-- Пример:
SELECT ROUND(125.4567, 3) AS p3,
       ROUND(125.4567, 2) AS p2,
       ROUND(125.4567, 1) AS p1,
       ROUND(125.4567, 0) AS p0
FROM dual;

-- Results:
--   p3 = 125.457
--   p2 = 125.46
--   p1 = 125.5
--   p0 = 125
--
-- Чем меньше precision,
-- тем грубее округление.


-- ============================================================
-- Negative precision
-- ============================================================
-- Negative precision округляет слева от decimal point.
--
-- Это значит:
--   -1  округляет до tens;
--   -2  округляет до hundreds;
--   -3  округляет до thousands.
--
-- Пример из начала файла:
SELECT ROUND(32526, -3) AS rounded_number
FROM dual;

-- Result:
--   33000
--
-- Почему:
--   precision = -3;
--   округляем до thousands.
--
-- Пример:
SELECT ROUND(325.26, -1) AS rounded_number
FROM dual;

-- Result:
--   330
--
-- Почему:
--   precision = -1;
--   округляем до tens.


-- ============================================================
-- More negative precision examples
-- ============================================================
SELECT ROUND(1549, -1) AS rounded_number
FROM dual;

-- Result:
--   1550
--
-- Rounded to tens.

SELECT ROUND(1549, -2) AS rounded_number
FROM dual;

-- Result:
--   1500
--
-- Rounded to hundreds.

SELECT ROUND(1549, -3) AS rounded_number
FROM dual;

-- Result:
--   2000
--
-- Rounded to thousands.


-- ============================================================
-- When decimal part is less than 5
-- ============================================================
-- Если next digit меньше 5,
-- number округляется вниз.
--
-- Пример:
SELECT ROUND(8.24, 1) AS rounded_number
FROM dual;

-- Result:
--   8.2
--
-- Почему:
--   нужно оставить 1 digit после decimal point;
--   next digit = 4;
--   4 меньше 5.


-- ============================================================
-- When decimal part is 5 or greater
-- ============================================================
-- Если next digit равен 5 или больше,
-- number округляется вверх.
--
-- Пример:
SELECT ROUND(8.25, 1) AS rounded_number
FROM dual;

-- Result:
--   8.3
--
-- Почему:
--   нужно оставить 1 digit после decimal point;
--   next digit = 5;
--   поэтому 8.2 becomes 8.3.
--
-- Пример:
SELECT ROUND(8.26, 1) AS rounded_number
FROM dual;

-- Result:
--   8.3


-- ============================================================
-- ROUND with salary expression
-- ============================================================
-- ROUND можно применять к numeric expression.
--
-- Пример из начала файла:
SELECT salary AS original_salary,
       salary * 3.14 AS multiplied_salary,
       ROUND(salary * 3.14) AS rounded_salary
FROM employees;

-- Meaning:
--   salary * 3.14 сначала calculated;
--   потом ROUND округляет calculated result.
--
-- Важно:
--   original salary в table не меняется.
--   rounded_salary существует только в output.


-- ============================================================
-- ROUND with column
-- ============================================================
-- ROUND можно использовать с numeric column.
--
-- Пример:
SELECT employee_id,
       salary,
       ROUND(salary, -3) AS salary_rounded_to_thousands
FROM employees;

-- Meaning:
--   показать salary;
--   рядом показать salary rounded to thousands.
--
-- Если salary = 24000,
-- ROUND(salary, -3) вернет:
--   24000
--
-- Если salary = 24500,
-- ROUND(salary, -3) вернет:
--   25000


-- ============================================================
-- ROUND in SELECT list
-- ============================================================
-- ROUND часто используется в SELECT list.
--
-- Пример:
SELECT employee_id,
       salary,
       ROUND(salary * 1.10, 2) AS salary_plus_10_percent
FROM employees;

-- Meaning:
--   salary * 1.10 calculates new value;
--   ROUND(..., 2) keeps 2 digits after decimal point.
--
-- Это только calculated output.
-- Table employees не изменяется.


-- ============================================================
-- ROUND with alias
-- ============================================================
-- Для ROUND expression лучше давать alias.
--
-- Пример:
SELECT ROUND(3.1415, 2) AS rounded_value
FROM dual;

-- Alias:
--   rounded_value
--
-- Без alias output column может называться длинно:
--   ROUND(3.1415,2)
--
-- С alias result set читать легче.


-- ============================================================
-- ROUND in WHERE
-- ============================================================
-- ROUND можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE ROUND(salary, -3) = 10000;

-- Meaning:
--   salary округляется до thousands;
--   потом result сравнивается с 10000.
--
-- Важно:
--   function в WHERE применяется к rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- ROUND with calculated number from dates
-- ============================================================
-- В Oracle difference между двумя dates
-- может дать number of days.
--
-- Пример из начала файла:
SELECT first_name,
       ROUND((SYSDATE - hire_date) * employee_id) AS rounded_result
FROM employees;

-- Meaning:
--   SYSDATE - hire_date returns number of days;
--   result умножается на employee_id;
--   ROUND округляет итоговое numeric expression.
--
-- В этом примере ROUND работает не с date directly,
-- а с number, который получился после date subtraction.


-- ============================================================
-- ROUND with negative numbers
-- ============================================================
-- ROUND можно применять и к negative numbers.
--
-- Пример:
SELECT ROUND(-3.14) AS rounded_number
FROM dual;

-- Result:
--   -3
--
-- Пример:
SELECT ROUND(-3.5) AS rounded_number
FROM dual;

-- Result:
--   -4
--
-- Почему:
--   .5 округляется от нуля:
--   3.5 -> 4
--   -3.5 -> -4


-- ============================================================
-- ROUND keeps number type
-- ============================================================
-- ROUND returns NUMBER.
--
-- Пример:
SELECT ROUND(10.75, 1) AS rounded_number
FROM dual;

-- Result:
--   10.8
--
-- Это numeric result.
-- Его можно использовать в numeric expressions.
--
-- Пример:
SELECT ROUND(10.75, 1) + 5 AS calculated_result
FROM dual;

-- Result:
--   15.8


-- ============================================================
-- ROUND does not format output visually
-- ============================================================
-- ROUND округляет number,
-- но не является formatting tool.
--
-- Пример:
SELECT ROUND(10.00, 2) AS rounded_number
FROM dual;

-- Result may display as:
--   10
--
-- Почему:
--   number value = 10;
--   display format зависит от client tool.
--
-- Если нужно именно visual format
-- с fixed decimal places,
-- это будет отдельная тема.


-- ============================================================
-- ROUND with NULL
-- ============================================================
-- Если number_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT ROUND(NULL) AS rounded_number
FROM dual;

-- Result:
--   NULL
--
-- Если precision is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT ROUND(3.1415, NULL) AS rounded_number
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- ROUND with decimal precision from expression
-- ============================================================
-- number_value может быть expression.
--
-- Пример:
SELECT ROUND((100 / 3), 2) AS rounded_number
FROM dual;

-- Result:
--   33.33
--
-- Почему:
--   100 / 3 gives long decimal result;
--   ROUND(..., 2) leaves 2 digits after decimal point.


-- ============================================================
-- ROUND with different precision values
-- ============================================================
SELECT ROUND(9876.54321, 4) AS result
FROM dual;

-- Result:
--   9876.5432

SELECT ROUND(9876.54321, 3) AS result
FROM dual;

-- Result:
--   9876.543

SELECT ROUND(9876.54321, 2) AS result
FROM dual;

-- Result:
--   9876.54

SELECT ROUND(9876.54321, 1) AS result
FROM dual;

-- Result:
--   9876.5

SELECT ROUND(9876.54321, 0) AS result
FROM dual;

-- Result:
--   9877

SELECT ROUND(9876.54321, -1) AS result
FROM dual;

-- Result:
--   9880

SELECT ROUND(9876.54321, -2) AS result
FROM dual;

-- Result:
--   9900

SELECT ROUND(9876.54321, -3) AS result
FROM dual;

-- Result:
--   10000


-- ============================================================
-- Common use case: calculated money values
-- ============================================================
-- ROUND часто используют,
-- когда calculation дает decimal result.
--
-- Пример:
SELECT salary,
       salary / 12 AS monthly_value,
       ROUND(salary / 12, 2) AS monthly_value_rounded
FROM employees;

-- Meaning:
--   salary / 12 может дать many decimal digits;
--   ROUND(..., 2) оставляет 2 digits after decimal point.
--
-- Важно:
--   это учебный пример округления.
--   Реальные money calculations могут иметь свои правила.


-- ============================================================
-- Common use case: approximate category value
-- ============================================================
-- Иногда удобно показать approximate category.
--
-- Пример:
SELECT employee_id,
       salary,
       ROUND(salary, -3) AS salary_group_value
FROM employees;

-- Meaning:
--   salary_group_value показывает salary
--   rounded to nearest thousand.
--
-- Это просто rounded value в SELECT list.


-- ============================================================
-- Common use case: clean calculated output
-- ============================================================
-- Calculation может выглядеть слишком длинно.
--
-- Пример:
SELECT employee_id,
       salary,
       commission_pct,
       salary * commission_pct AS raw_commission,
       ROUND(salary * commission_pct, 2) AS rounded_commission
FROM employees;

-- Meaning:
--   raw_commission может иметь extra decimal digits;
--   rounded_commission показывает аккуратный result.
--
-- Если commission_pct is NULL,
-- expression result будет NULL.


-- ============================================================
-- ROUND and arithmetic order
-- ============================================================
-- ROUND применяется после того,
-- как expression внутри parentheses calculated.
--
-- Пример:
SELECT ROUND((10 + 5) / 4, 2) AS rounded_number
FROM dual;

-- Result:
--   3.75
--
-- Почему:
--   10 + 5 = 15;
--   15 / 4 = 3.75;
--   ROUND(3.75, 2) = 3.75.
--
-- Пример:
SELECT ROUND((10 + 5) / 4, 1) AS rounded_number
FROM dual;

-- Result:
--   3.8


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что ROUND always keeps decimal places visually.
--    ROUND округляет value, но display format зависит от tool.
--
-- 2. Путать positive и negative precision.
--    Positive precision работает справа от decimal point.
--    Negative precision работает слева от decimal point.
--
-- 3. Забывать, что omitted precision means 0.
--    ROUND(3.14) = ROUND(3.14, 0)
--
-- 4. Думать, что ROUND changes table data.
--    SELECT with ROUND only returns result set.
--
-- 5. Использовать ROUND в WHERE без понимания performance.
--    Function применяется к rows.
--
-- 6. Думать, что ROUND is string formatting.
--    ROUND returns NUMBER.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Округли до целого number:
SELECT ROUND(45.67) AS result
FROM dual;

-- 2. Округли до 1 digit after decimal point:
SELECT ROUND(45.67, 1) AS result
FROM dual;

-- 3. Округли до 2 digits after decimal point:
SELECT ROUND(45.678, 2) AS result
FROM dual;

-- 4. Округли до tens:
SELECT ROUND(4567, -1) AS result
FROM dual;

-- 5. Округли до hundreds:
SELECT ROUND(4567, -2) AS result
FROM dual;

-- 6. Округли salary до thousands:
SELECT salary,
       ROUND(salary, -3) AS rounded_salary
FROM employees;

-- 7. Округли calculated expression:
SELECT salary,
       ROUND(salary * 1.15, 2) AS increased_salary
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- ROUND rounds numbers.
--
-- Syntax:
--   ROUND(number_value, precision)
--
-- Short syntax:
--   ROUND(number_value)
--
-- Important:
--   omitted precision means precision = 0;
--   precision = 0 rounds to whole number;
--   positive precision rounds after decimal point;
--   negative precision rounds before decimal point;
--   ROUND returns NUMBER;
--   ROUND can work with numeric expressions;
--   SELECT with ROUND does not change table data.
