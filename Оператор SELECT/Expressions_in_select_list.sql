-- ============================================================
-- Expressions in SELECT list
-- ============================================================
-- Expression     - выражение, которое Oracle вычисляет
--                  и показывает в result set.
--
-- Expression можно писать в SELECT list вместе с обычными columns.
--
-- Синтаксис:
--   SELECT column_name,
--          expression
--   FROM table_name;
--
-- Пример:
SELECT salary,
       salary * 10
FROM employees;

-- Здесь:
--   salary      - обычная column.
--   salary * 10 - expression.
--
-- Важно:
--   Expression не меняет данные в table.
--   Oracle только вычисляет новое значение для output.


-- ============================================================
-- Numeric expressions
-- ============================================================
-- Numeric expression - выражение с numbers.
--
-- Основные arithmetic operators:
--   +  addition
--   -  subtraction
--   *  multiplication
--   /  division
--
-- Пример:
SELECT salary,
       salary + 500,
       salary - 100,
       salary * 12,
       salary / 2
FROM employees;

-- salary + 500 - salary increased by 500.
-- salary - 100 - salary decreased by 100.
-- salary * 12  - annual salary.
-- salary / 2   - half salary.
--
-- Table employees не меняется.
-- Это только вычисления в result set.


-- ============================================================
-- Expression with columns and numbers
-- ============================================================
-- Expression может использовать column и fixed number.
--
-- Пример:
SELECT first_name,
       salary,
       salary * 1.5
FROM employees;

-- salary * 1.5 означает:
--   увеличить salary на 50%.
--
-- Лучше дать expression понятное имя через alias:
SELECT first_name,
       salary,
       salary * 1.5 AS increased_salary
FROM employees;


-- ============================================================
-- Expression with multiple columns
-- ============================================================
-- Expression может использовать несколько columns.
--
-- Пример:
SELECT employee_id,
       salary,
       commission_pct,
       salary * commission_pct
FROM employees;

-- Здесь expression:
--   salary * commission_pct
--
-- Oracle берет значения salary и commission_pct
-- из одной и той же row и вычисляет result.
--
-- Другой пример:
SELECT employee_id,
       salary,
       salary + 1000 AS new_salary
FROM employees;


-- ============================================================
-- Operator precedence
-- ============================================================
-- Oracle считает arithmetic expressions по обычному порядку:
--
--   1. parentheses
--   2. multiplication and division
--   3. addition and subtraction
--
-- Пример:
SELECT salary,
       salary + 100 * 12 AS result_value
FROM employees;

-- Сначала:
--   100 * 12
--
-- Потом:
--   salary + 1200
--
-- Если нужен другой порядок, используй parentheses:
SELECT salary,
       (salary + 100) * 12 AS result_value
FROM employees;

-- Здесь сначала:
--   salary + 100
--
-- Потом:
--   result * 12


-- ============================================================
-- Expressions and NULL
-- ============================================================
-- NULL          - отсутствие значения.
--
-- Если expression использует NULL,
-- результат часто тоже будет NULL.
--
-- Пример:
SELECT commission_pct,
       commission_pct / 2
FROM employees;

-- Если commission_pct = NULL,
-- то commission_pct / 2 тоже будет NULL.
--
-- Другой пример:
SELECT salary,
       commission_pct,
       salary * commission_pct AS commission_amount
FROM employees;

-- Если commission_pct = NULL,
-- commission_amount будет NULL.
--
-- Чтобы заменить NULL на 0, можно использовать NVL:
SELECT salary,
       commission_pct,
       salary * NVL(commission_pct, 0) AS commission_amount
FROM employees;

-- NVL(commission_pct, 0) означает:
--   если commission_pct is NULL, использовать 0.
--
-- Это все еще expression в SELECT list.


-- ============================================================
-- DATE expressions
-- ============================================================
-- С DATE можно делать date arithmetic.
--
-- В Oracle:
--   DATE + number = date plus number of days.
--   DATE - number = date minus number of days.
--   DATE - DATE   = number of days between dates.
--
-- Пример: добавить 7 дней.
SELECT start_date,
       start_date + 7
FROM job_history;

-- start_date + 7 означает:
--   дата через 7 дней после start_date.
--
-- Пример: найти количество дней между dates.
SELECT start_date,
       end_date,
       end_date - start_date
FROM job_history;

-- end_date - start_date возвращает number of days.
--
-- Если нужно считать период включая start_date и end_date:
SELECT start_date,
       end_date,
       (end_date - start_date) + 1
FROM job_history;

-- Почему + 1?
--   Если start_date = 01-Aug
--   и end_date = 01-Aug,
--   разница end_date - start_date = 0.
--
-- Но если считать сам день 01-Aug,
-- количество дней должно быть 1.


-- ============================================================
-- TIMESTAMP expressions
-- ============================================================
-- TIMESTAMP хранит дату, время и доли секунды.
--
-- Для TIMESTAMP обычно используют INTERVAL,
-- а не простое + 7 как с DATE.
--
-- Пример:
--   SELECT SYSTIMESTAMP,
--          SYSTIMESTAMP + INTERVAL '7' DAY AS after_7_days
--   FROM dual;
--
-- Пример разницы:
--   SELECT end_timestamp - start_timestamp AS duration
--   FROM some_table;
--
-- Разница между TIMESTAMP values обычно дает INTERVAL.
--
-- В этом файле реальные examples выше используют job_history,
-- где start_date и end_date обычно имеют тип DATE.


-- ============================================================
-- Text expressions
-- ============================================================
-- Text expression - выражение со strings.
--
-- В Oracle оператор || соединяет strings.
--
-- Пример:
SELECT first_name || ' ' || last_name
FROM employees;

-- Если:
--   first_name = 'Steven'
--   last_name  = 'King'
--
-- Result:
--   Steven King
--
-- Еще пример:
SELECT 'Employee: ' || first_name || ' ' || last_name
FROM employees;

-- 'Employee: ' - это string literal.
-- String literal пишется в single quotes.


-- ============================================================
-- Alias for expressions
-- ============================================================
-- Alias         - альтернативное имя для column или expression
--                 в result set.
--
-- Alias делает output понятнее.
--
-- Пример без alias:
SELECT first_name || ' ' || last_name
FROM employees;

-- Column name в output может быть длинным и неудобным:
--   FIRST_NAME||''||LAST_NAME
--
-- Пример с alias:
SELECT first_name || ' ' || last_name AS full_name
FROM employees;

-- Теперь result column называется:
--   FULL_NAME
--
-- AS можно не писать:
SELECT first_name || ' ' || last_name full_name
FROM employees;

-- Но в учебном коде AS часто понятнее.


-- ============================================================
-- Alias with double quotes
-- ============================================================
-- Если alias содержит spaces,
-- используй double quotes.
--
-- Пример:
SELECT start_date,
       end_date,
       (end_date - start_date) + 1 AS "Count of days"
FROM job_history;

-- Alias:
--   "Count of days"
--
-- Double quotes сохраняют spaces и letter case.
--
-- Еще пример:
SELECT salary * 12 AS "Annual Salary"
FROM employees;

-- Без double quotes лучше использовать underscore:
SELECT salary * 12 AS annual_salary
FROM employees;


-- ============================================================
-- Literal expressions
-- ============================================================
-- Literal - значение, написанное прямо в query.
--
-- Number literal:
SELECT 100 AS number_value
FROM dual;

-- String literal:
SELECT 'Hello Oracle' AS message
FROM dual;

-- Date literal через TO_DATE:
SELECT TO_DATE('2026-08-08', 'YYYY-MM-DD') AS lesson_date
FROM dual;

-- DUAL - специальная one-row table в Oracle.
-- Ее удобно использовать,
-- когда expression не зависит от business table.


-- ============================================================
-- Expressions with parentheses
-- ============================================================
-- Parentheses делают expression понятнее.
--
-- Пример:
SELECT salary,
       salary + salary * 0.10 AS salary_with_bonus
FROM employees;

-- Это означает:
--   salary + (salary * 0.10)
--
-- То же самое можно написать явно:
SELECT salary,
       salary + (salary * 0.10) AS salary_with_bonus
FROM employees;

-- Если нужно сначала сложить:
SELECT salary,
       (salary + 1000) * 12 AS annual_salary_after_increase
FROM employees;


-- ============================================================
-- Formatting expressions
-- ============================================================
-- Если expression короткий, можно писать в одну строку:
SELECT salary * 12 AS annual_salary
FROM employees;

-- Если expression длинный, лучше форматировать аккуратно:
SELECT first_name || ' ' || last_name AS full_name,
       (end_date - start_date) + 1 AS days_count
FROM job_history;

-- Важно:
--   В SELECT list между columns/expressions ставится comma.
--   После последнего expression comma не ставится.
--
-- Неправильно:
--   SELECT first_name,
--          salary * 12,
--   FROM employees;
--
-- Правильно:
--   SELECT first_name,
--          salary * 12
--   FROM employees;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что expression меняет table.
--    Expression только вычисляется для result set.
--
-- 2. Забывать alias для сложного expression.
--    Без alias output может быть неудобным.
--
-- 3. Не учитывать NULL.
--    salary * commission_pct может вернуть NULL,
--    если commission_pct is NULL.
--
-- 4. Путать DATE и TIMESTAMP arithmetic.
--    DATE + 7 работает как plus 7 days.
--    Для TIMESTAMP обычно используют INTERVAL.
--
-- 5. Забывать spaces вокруг ||.
--    Лучше:
--      first_name || ' ' || last_name
--
-- 6. Ставить comma после последнего expression.
--
-- 7. Использовать double quotes для string values.
--    String:
--      'Hello'
--
--    Alias with spaces:
--      "Annual Salary"


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи salary и salary * 12.
--   Дай expression alias annual_salary.
--
-- Task 2:
--   Выведи first_name, salary и salary * 1.5.
--   Дай expression alias increased_salary.
--
-- Task 3:
--   Выведи commission_pct и commission_pct / 2.
--   Посмотри, что происходит с NULL.
--
-- Task 4:
--   Выведи salary * NVL(commission_pct, 0)
--   с alias commission_amount.
--
-- Task 5:
--   Выведи start_date и start_date + 7 из job_history.
--
-- Task 6:
--   Выведи start_date, end_date
--   и количество дней между ними:
--     (end_date - start_date) + 1
--
-- Task 7:
--   Выведи full_name:
--     first_name || ' ' || last_name
--
-- Task 8:
--   Выведи literal 'Hello Oracle' из dual
--   с alias message.


-- ============================================================
-- Summary
-- ============================================================
-- Expression in SELECT list:
--   вычисляется Oracle;
--   отображается в result set;
--   не меняет table data.
--
-- Expression может быть:
--   numeric expression;
--   date expression;
--   text expression;
--   literal expression;
--   expression with NULL handling;
--   expression with alias.
--
-- Главное:
--   SELECT list может содержать не только columns,
--   но и значения, которые Oracle вычисляет во время query.
