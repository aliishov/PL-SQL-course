-- Numeric functions
-- TRUNC(n, precision)

SELECT TRUNC(3.14)
FROM dual;

SELECT TRUNC(3.5)
FROM dual;

SELECT TRUNC(3.14, 0)
FROM dual;

SELECT TRUNC(3.1415, 1)
FROM dual;

SELECT TRUNC(3.1415, 3)
FROM dual;

SELECT salary original_salary,
       salary * 3.14 multiplied_salary,
       TRUNC(salary * 3.14) truncated_salary
FROM employees;

SELECT TRUNC(32526, -3)
FROM dual;

SELECT TRUNC(325.26, -1)
FROM dual;

SELECT first_name,
       TRUNC((SYSDATE - hire_date) * employee_id)
FROM employees;


-- ============================================================
-- Numeric functions
-- TRUNC
-- ============================================================
-- TRUNC         - single-row numeric function.
--
-- Простыми словами:
--   TRUNC отбрасывает лишние digits у number.
--
-- TRUNC не меняет data в table.
-- Он только возвращает truncated result в result set.
--
-- Result:
--   NUMBER
--
-- В этом уроке только numeric TRUNC.
-- TRUNC with dates будет отдельной темой.
-- Другие numeric functions тоже будут отдельными темами.


-- ============================================================
-- Main idea
-- ============================================================
-- TRUNC отвечает на вопрос:
--   "Оставь number до нужной точности,
--    а лишнюю часть просто отбрось."
--
-- Пример:
SELECT TRUNC(3.14) AS truncated_number
FROM dual;

-- Result:
--   3
--
-- Почему:
--   если precision не указан,
--   Oracle оставляет только integer part.
--
-- Decimal part:
--   .14
--
-- Отбрасывается.


-- ============================================================
-- Syntax
-- ============================================================
-- Синтаксис:
--
--   TRUNC(number_value, precision)
--
-- Где:
--   number_value   - число или numeric expression;
--   precision      - сколько digits оставить.
--
-- precision можно не писать:
--
--   TRUNC(number_value)
--
-- Если precision не указан,
-- Oracle использует precision = 0.
--
-- То есть:
--   TRUNC(3.14)
--
-- По смыслу то же самое, что:
--   TRUNC(3.14, 0)


-- ============================================================
-- TRUNC without precision
-- ============================================================
-- Если второй argument не указан,
-- result будет number без decimal part.
--
-- Пример из начала файла:
SELECT TRUNC(3.14) AS truncated_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT TRUNC(3.5) AS truncated_number
FROM dual;

-- Result:
--   3
--
-- Важно:
--   TRUNC не смотрит, больше decimal part чем .5 или нет.
--   Он просто отбрасывает decimal part.


-- ============================================================
-- TRUNC with precision = 0
-- ============================================================
-- precision = 0 означает:
--   оставить 0 digits after decimal point.
--
-- Пример:
SELECT TRUNC(3.14, 0) AS truncated_number
FROM dual;

-- Result:
--   3
--
-- Пример:
SELECT TRUNC(3.99, 0) AS truncated_number
FROM dual;

-- Result:
--   3
--
-- Поэтому TRUNC(number) и TRUNC(number, 0)
-- обычно дают одинаковый result.


-- ============================================================
-- Positive precision
-- ============================================================
-- Positive precision работает справа от decimal point.
--
-- Пример:
SELECT TRUNC(3.1415, 1) AS truncated_number
FROM dual;

-- Result:
--   3.1
--
-- Meaning:
--   оставить 1 digit после decimal point.
--
-- Пример:
SELECT TRUNC(3.1415, 2) AS truncated_number
FROM dual;

-- Result:
--   3.14
--
-- Meaning:
--   оставить 2 digits после decimal point.
--
-- Пример из начала файла:
SELECT TRUNC(3.1415, 3) AS truncated_number
FROM dual;

-- Result:
--   3.141
--
-- Почему:
--   нужно оставить 3 digits after decimal point;
--   fourth digit просто отбрасывается.


-- ============================================================
-- Precision table
-- ============================================================
-- Один и тот же number можно truncate по-разному.
--
-- Пример:
SELECT TRUNC(125.4567, 3) AS p3,
       TRUNC(125.4567, 2) AS p2,
       TRUNC(125.4567, 1) AS p1,
       TRUNC(125.4567, 0) AS p0
FROM dual;

-- Results:
--   p3 = 125.456
--   p2 = 125.45
--   p1 = 125.4
--   p0 = 125
--
-- Чем меньше precision,
-- тем больше decimal digits отбрасывается.


-- ============================================================
-- Negative precision
-- ============================================================
-- Negative precision работает слева от decimal point.
--
-- Это значит:
--   -1  оставляет number до tens;
--   -2  оставляет number до hundreds;
--   -3  оставляет number до thousands.
--
-- Пример из начала файла:
SELECT TRUNC(32526, -3) AS truncated_number
FROM dual;

-- Result:
--   32000
--
-- Почему:
--   precision = -3;
--   digits после thousands отбрасываются.
--
-- Пример:
SELECT TRUNC(325.26, -1) AS truncated_number
FROM dual;

-- Result:
--   320
--
-- Почему:
--   precision = -1;
--   ones and decimal part отбрасываются.


-- ============================================================
-- More negative precision examples
-- ============================================================
SELECT TRUNC(1549, -1) AS truncated_number
FROM dual;

-- Result:
--   1540
--
-- Truncated to tens.

SELECT TRUNC(1549, -2) AS truncated_number
FROM dual;

-- Result:
--   1500
--
-- Truncated to hundreds.

SELECT TRUNC(1549, -3) AS truncated_number
FROM dual;

-- Result:
--   1000
--
-- Truncated to thousands.


-- ============================================================
-- TRUNC does not round
-- ============================================================
-- Главная идея:
--   TRUNC does not round number.
--
-- Он не проверяет,
-- какая digit идет после нужной position.
--
-- Пример:
SELECT TRUNC(8.29, 1) AS truncated_number
FROM dual;

-- Result:
--   8.2
--
-- Пример:
SELECT TRUNC(8.25, 1) AS truncated_number
FROM dual;

-- Result:
--   8.2
--
-- Пример:
SELECT TRUNC(8.99, 1) AS truncated_number
FROM dual;

-- Result:
--   8.9
--
-- Почему:
--   TRUNC оставляет нужное количество digits
--   и отбрасывает остальное.


-- ============================================================
-- TRUNC with salary expression
-- ============================================================
-- TRUNC можно применять к numeric expression.
--
-- Пример из начала файла:
SELECT salary AS original_salary,
       salary * 3.14 AS multiplied_salary,
       TRUNC(salary * 3.14) AS truncated_salary
FROM employees;

-- Meaning:
--   salary * 3.14 сначала calculated;
--   потом TRUNC убирает decimal part.
--
-- Важно:
--   original salary в table не меняется.
--   truncated_salary существует только в output.


-- ============================================================
-- TRUNC with column
-- ============================================================
-- TRUNC можно использовать с numeric column.
--
-- Пример:
SELECT employee_id,
       salary,
       TRUNC(salary, -3) AS salary_truncated_to_thousands
FROM employees;

-- Meaning:
--   показать salary;
--   рядом показать salary truncated to thousands.
--
-- Если salary = 24500,
-- TRUNC(salary, -3) вернет:
--   24000
--
-- Если salary = 24999,
-- TRUNC(salary, -3) вернет:
--   24000
--
-- Digits после thousands просто отбрасываются.


-- ============================================================
-- TRUNC in SELECT list
-- ============================================================
-- TRUNC часто используется в SELECT list.
--
-- Пример:
SELECT employee_id,
       salary,
       TRUNC(salary * 1.10, 2) AS salary_plus_10_percent
FROM employees;

-- Meaning:
--   salary * 1.10 calculates new value;
--   TRUNC(..., 2) leaves 2 digits after decimal point.
--
-- Это только calculated output.
-- Table employees не изменяется.


-- ============================================================
-- TRUNC with alias
-- ============================================================
-- Для TRUNC expression лучше давать alias.
--
-- Пример:
SELECT TRUNC(3.1415, 2) AS truncated_value
FROM dual;

-- Alias:
--   truncated_value
--
-- Без alias output column может называться длинно:
--   TRUNC(3.1415,2)
--
-- С alias result set читать легче.


-- ============================================================
-- TRUNC in WHERE
-- ============================================================
-- TRUNC можно использовать в WHERE condition.
--
-- Пример:
SELECT employee_id,
       first_name,
       salary
FROM employees
WHERE TRUNC(salary, -3) = 10000;

-- Meaning:
--   salary truncated to thousands;
--   потом result сравнивается с 10000.
--
-- Пример:
--   salary 10000, 10050, 10999
--   after TRUNC(salary, -3) become 10000.
--
-- Важно:
--   function в WHERE применяется к rows.
--   В больших tables это может влиять на performance.
--   Детали performance будут отдельной темой.


-- ============================================================
-- TRUNC with calculated number from dates
-- ============================================================
-- В Oracle difference между двумя dates
-- может дать number of days.
--
-- Пример из начала файла:
SELECT first_name,
       TRUNC((SYSDATE - hire_date) * employee_id) AS truncated_result
FROM employees;

-- Meaning:
--   SYSDATE - hire_date returns number of days;
--   result умножается на employee_id;
--   TRUNC убирает decimal part у итогового numeric expression.
--
-- В этом примере TRUNC работает не с date directly,
-- а с number, который получился после date subtraction.
--
-- TRUNC(date) будет отдельной темой.


-- ============================================================
-- TRUNC with negative numbers
-- ============================================================
-- TRUNC можно применять и к negative numbers.
--
-- Пример:
SELECT TRUNC(-3.14) AS truncated_number
FROM dual;

-- Result:
--   -3
--
-- Пример:
SELECT TRUNC(-3.99) AS truncated_number
FROM dual;

-- Result:
--   -3
--
-- Почему:
--   decimal part отбрасывается;
--   number становится ближе к zero.


-- ============================================================
-- Negative precision with negative numbers
-- ============================================================
-- Negative precision также работает с negative numbers.
--
-- Пример:
SELECT TRUNC(-1549, -2) AS truncated_number
FROM dual;

-- Result:
--   -1500
--
-- Почему:
--   digits после hundreds отбрасываются;
--   result moves toward zero.


-- ============================================================
-- TRUNC keeps number type
-- ============================================================
-- TRUNC returns NUMBER.
--
-- Пример:
SELECT TRUNC(10.75, 1) AS truncated_number
FROM dual;

-- Result:
--   10.7
--
-- Это numeric result.
-- Его можно использовать в numeric expressions.
--
-- Пример:
SELECT TRUNC(10.75, 1) + 5 AS calculated_result
FROM dual;

-- Result:
--   15.7


-- ============================================================
-- TRUNC does not format output visually
-- ============================================================
-- TRUNC changes numeric value by cutting digits,
-- но не является formatting tool.
--
-- Пример:
SELECT TRUNC(10.00, 2) AS truncated_number
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
-- TRUNC with NULL
-- ============================================================
-- Если number_value is NULL,
-- result будет NULL.
--
-- Пример:
SELECT TRUNC(NULL) AS truncated_number
FROM dual;

-- Result:
--   NULL
--
-- Если precision is NULL,
-- result тоже будет NULL.
--
-- Пример:
SELECT TRUNC(3.1415, NULL) AS truncated_number
FROM dual;

-- Result:
--   NULL


-- ============================================================
-- TRUNC with decimal precision from expression
-- ============================================================
-- number_value может быть expression.
--
-- Пример:
SELECT TRUNC((100 / 3), 2) AS truncated_number
FROM dual;

-- Result:
--   33.33
--
-- Почему:
--   100 / 3 gives long decimal result;
--   TRUNC(..., 2) leaves 2 digits after decimal point.


-- ============================================================
-- TRUNC with different precision values
-- ============================================================
SELECT TRUNC(9876.54321, 4) AS result
FROM dual;

-- Result:
--   9876.5432

SELECT TRUNC(9876.54321, 3) AS result
FROM dual;

-- Result:
--   9876.543

SELECT TRUNC(9876.54321, 2) AS result
FROM dual;

-- Result:
--   9876.54

SELECT TRUNC(9876.54321, 1) AS result
FROM dual;

-- Result:
--   9876.5

SELECT TRUNC(9876.54321, 0) AS result
FROM dual;

-- Result:
--   9876

SELECT TRUNC(9876.54321, -1) AS result
FROM dual;

-- Result:
--   9870

SELECT TRUNC(9876.54321, -2) AS result
FROM dual;

-- Result:
--   9800

SELECT TRUNC(9876.54321, -3) AS result
FROM dual;

-- Result:
--   9000


-- ============================================================
-- Common use case: calculated money values
-- ============================================================
-- TRUNC можно использовать,
-- когда calculation дает decimal result,
-- а нужно оставить только определенное количество digits.
--
-- Пример:
SELECT salary,
       salary / 12 AS monthly_value,
       TRUNC(salary / 12, 2) AS monthly_value_truncated
FROM employees;

-- Meaning:
--   salary / 12 может дать many decimal digits;
--   TRUNC(..., 2) оставляет 2 digits after decimal point.
--
-- Важно:
--   это учебный пример.
--   Реальные money calculations могут иметь свои правила.


-- ============================================================
-- Common use case: approximate category value
-- ============================================================
-- Иногда удобно показать value без мелких digits.
--
-- Пример:
SELECT employee_id,
       salary,
       TRUNC(salary, -3) AS salary_thousand_value
FROM employees;

-- Meaning:
--   salary_thousand_value показывает salary,
--   у которого digits после thousands removed.
--
-- Это просто calculated value в SELECT list.


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
       TRUNC(salary * commission_pct, 2) AS truncated_commission
FROM employees;

-- Meaning:
--   raw_commission может иметь extra decimal digits;
--   truncated_commission показывает result без extra digits
--   after second decimal place.
--
-- Если commission_pct is NULL,
-- expression result будет NULL.


-- ============================================================
-- TRUNC and arithmetic order
-- ============================================================
-- TRUNC применяется после того,
-- как expression внутри parentheses calculated.
--
-- Пример:
SELECT TRUNC((10 + 5) / 4, 2) AS truncated_number
FROM dual;

-- Result:
--   3.75
--
-- Почему:
--   10 + 5 = 15;
--   15 / 4 = 3.75;
--   TRUNC(3.75, 2) = 3.75.
--
-- Пример:
SELECT TRUNC((10 + 5) / 4, 1) AS truncated_number
FROM dual;

-- Result:
--   3.7


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что TRUNC округляет number.
--    Нет, TRUNC отбрасывает лишние digits.
--
-- 2. Путать positive и negative precision.
--    Positive precision работает справа от decimal point.
--    Negative precision работает слева от decimal point.
--
-- 3. Забывать, что omitted precision means 0.
--    TRUNC(3.14) = TRUNC(3.14, 0)
--
-- 4. Думать, что TRUNC changes table data.
--    SELECT with TRUNC only returns result set.
--
-- 5. Использовать TRUNC в WHERE без понимания performance.
--    Function применяется к rows.
--
-- 6. Думать, что numeric TRUNC is date formatting.
--    В этом уроке TRUNC works with NUMBER.


-- ============================================================
-- Practice
-- ============================================================
-- 1. Отбрось decimal part:
SELECT TRUNC(45.67) AS result
FROM dual;

-- 2. Оставь 1 digit after decimal point:
SELECT TRUNC(45.67, 1) AS result
FROM dual;

-- 3. Оставь 2 digits after decimal point:
SELECT TRUNC(45.678, 2) AS result
FROM dual;

-- 4. Оставь number до tens:
SELECT TRUNC(4567, -1) AS result
FROM dual;

-- 5. Оставь number до hundreds:
SELECT TRUNC(4567, -2) AS result
FROM dual;

-- 6. Truncate salary до thousands:
SELECT salary,
       TRUNC(salary, -3) AS truncated_salary
FROM employees;

-- 7. Truncate calculated expression:
SELECT salary,
       TRUNC(salary * 1.15, 2) AS increased_salary
FROM employees;


-- ============================================================
-- Mini summary
-- ============================================================
-- TRUNC cuts off digits from numbers.
--
-- Syntax:
--   TRUNC(number_value, precision)
--
-- Short syntax:
--   TRUNC(number_value)
--
-- Important:
--   omitted precision means precision = 0;
--   precision = 0 removes decimal part;
--   positive precision keeps digits after decimal point;
--   negative precision cuts digits before decimal point;
--   TRUNC does not round;
--   TRUNC returns NUMBER;
--   TRUNC can work with numeric expressions;
--   SELECT with TRUNC does not change table data.
