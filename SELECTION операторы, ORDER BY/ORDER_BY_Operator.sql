-- ============================================================
-- ORDER BY operator
-- ============================================================
-- ORDER BY      - часть SELECT command, которая сортирует result set.
--
-- Простыми словами:
--   ORDER BY отвечает на вопрос:
--     "В каком порядке показать rows?"
--
-- ORDER BY не выбирает columns.
-- ORDER BY не фильтрует rows.
-- ORDER BY только меняет порядок rows в output.
--
-- Без ORDER BY database не обязана возвращать rows
-- в одном и том же порядке каждый раз.
--
-- Поэтому если порядок важен,
-- всегда пиши ORDER BY явно.


-- ============================================================
-- Basic syntax
-- ============================================================
-- Синтаксис:
--   SELECT column_name1,
--          column_name2
--   FROM table_name
--   WHERE condition
--   ORDER BY column_name;
--
-- Более общий синтаксис:
--   SELECT * | column(s) | expression(s)
--   FROM table_name
--   WHERE condition
--   ORDER BY column | expression | alias | numeric_position
--            ASC | DESC
--            NULLS FIRST | NULLS LAST;
--
-- WHERE не обязателен.
--
-- ORDER BY обычно пишется в конце SELECT statement.
--
-- Semicolon ставится после ORDER BY clause:
--   ORDER BY salary;


-- ============================================================
-- ORDER BY one column
-- ============================================================
-- Пример:
SELECT first_name,
       salary
FROM employees
ORDER BY salary;

-- Meaning:
--   показать first_name и salary;
--   отсортировать result set по salary.
--
-- Если direction не указан,
-- Oracle использует ASC by default.
--
-- То есть:
SELECT first_name,
       salary
FROM employees
ORDER BY salary;

-- То же самое, что:
SELECT first_name,
       salary
FROM employees
ORDER BY salary ASC;


-- ============================================================
-- ORDER BY with WHERE
-- ============================================================
-- WHERE фильтрует rows.
-- ORDER BY сортирует rows, которые остались после WHERE.
--
-- Пример:
SELECT first_name,
       salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY salary;

-- Meaning:
--   1. взять rows из employees;
--   2. оставить только rows, где job_id = 'IT_PROG';
--   3. показать first_name и salary;
--   4. отсортировать result set по salary.
--
-- Важно:
--   ORDER BY влияет на порядок output.
--   ORDER BY не меняет количество rows.
--   ORDER BY не меняет список columns.


-- ============================================================
-- ORDER BY date column
-- ============================================================
-- Можно сортировать по DATE column.
--
-- Пример:
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY hire_date;

-- Meaning:
--   показать IT_PROG employees
--   и отсортировать их по hire_date.
--
-- Для DATE values:
--   earlier date идет раньше при ASC;
--   later date идет раньше при DESC.


-- ============================================================
-- ORDER BY text column
-- ============================================================
-- Можно сортировать по text column.
--
-- Пример:
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name;

-- Meaning:
--   отсортировать result set по first_name.
--
-- Text sorting зависит от правил сортировки database/session.
--
-- В простых учебных примерах можно думать так:
--   A раньше B;
--   B раньше C;
--   C раньше D.


-- ============================================================
-- ORDER BY column not in SELECT list
-- ============================================================
-- В обычном SELECT можно сортировать по column,
-- даже если она не показана в SELECT list.
--
-- Пример:
SELECT salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name;

-- Result set показывает:
--   salary
--   hire_date
--
-- Но сортировка идет по:
--   first_name
--
-- Это возможно,
-- потому что first_name есть в table employees.
--
-- Важно:
--   column может участвовать в ORDER BY,
--   даже если ее нет в output.


-- ============================================================
-- ASC
-- ============================================================
-- ASC           - ascending order.
--
-- Простыми словами:
--   ASC сортирует от меньшего к большему.
--
-- Для numbers:
--   1, 2, 3, 4 ...
--
-- Для text:
--   A, B, C ...
--
-- Для dates:
--   old dates first, newer dates later.
--
-- Пример:
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

-- ASC является default.
--
-- Эти queries одинаковы по direction:
--   ORDER BY first_name
--   ORDER BY first_name ASC


-- ============================================================
-- DESC
-- ============================================================
-- DESC          - descending order.
--
-- Простыми словами:
--   DESC сортирует от большего к меньшему.
--
-- Для numbers:
--   100, 90, 80 ...
--
-- Для text:
--   Z, Y, X ...
--
-- Для dates:
--   newer dates first, old dates later.
--
-- Пример:
SELECT first_name,
       salary,
       hire_date
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name DESC;

-- Еще пример:
SELECT first_name,
       salary
FROM employees
ORDER BY salary DESC;

-- Meaning:
--   employees с самой большой salary будут выше.


-- ============================================================
-- ORDER BY expression
-- ============================================================
-- ORDER BY может сортировать по expression.
--
-- Expression не обязан быть отдельной column в table.
--
-- Пример:
SELECT last_name,
       salary,
       hire_date
FROM employees
WHERE employee_id > 120
ORDER BY salary * 12;

-- Meaning:
--   показать last_name, salary, hire_date;
--   отсортировать rows по annual salary expression.
--
-- Expression:
--   salary * 12
--
-- Table employees не меняется.
-- Oracle только использует expression для sorting.


-- ============================================================
-- ORDER BY expression from SELECT list
-- ============================================================
-- Expression можно показать в SELECT list
-- и использовать в ORDER BY.
--
-- Пример:
SELECT last_name,
       salary,
       salary * 12
FROM employees
WHERE employee_id > 120
ORDER BY salary * 12;

-- Здесь expression:
--   salary * 12
--
-- находится и в SELECT list,
-- и в ORDER BY.
--
-- Чтобы output был понятнее,
-- лучше дать expression alias.


-- ============================================================
-- ORDER BY alias
-- ============================================================
-- Alias из SELECT list можно использовать в ORDER BY.
--
-- Пример:
SELECT last_name,
       salary,
       salary * 12 AS annual_salary
FROM employees
WHERE employee_id > 120
ORDER BY annual_salary;

-- Meaning:
--   Oracle вычисляет salary * 12,
--   называет result annual_salary,
--   потом сортирует по annual_salary.
--
-- Alias делает query проще читать.
--
-- Еще пример:
SELECT first_name || ' ' || last_name AS full_name,
       salary
FROM employees
ORDER BY full_name;

-- Здесь sorting идет по alias full_name.


-- ============================================================
-- NULLS FIRST and NULLS LAST
-- ============================================================
-- NULLS FIRST   - NULL values идут в начале.
-- NULLS LAST    - NULL values идут в конце.
--
-- Пример:
SELECT *
FROM employees
ORDER BY commission_pct DESC NULLS LAST;

-- Meaning:
--   сортировать по commission_pct descending;
--   rows с NULL commission_pct поставить в конец.
--
-- Пример:
SELECT *
FROM employees
ORDER BY commission_pct DESC NULLS FIRST;

-- Meaning:
--   сортировать по commission_pct descending;
--   rows с NULL commission_pct поставить в начало.
--
-- Default behavior в Oracle:
--   ASC  обычно сортирует NULLS LAST.
--   DESC обычно сортирует NULLS FIRST.
--
-- Если порядок NULL важен,
-- лучше написать NULLS FIRST или NULLS LAST явно.


-- ============================================================
-- ORDER BY numeric position
-- ============================================================
-- Numeric position - номер expression/column в SELECT list.
--
-- Пример:
SELECT first_name,
       salary
FROM employees
ORDER BY 2;

-- Здесь:
--   1 = first_name
--   2 = salary
--
-- ORDER BY 2 означает:
--   сортировать по второй column в SELECT list,
--   то есть по salary.
--
-- Еще пример:
SELECT first_name,
       last_name,
       salary
FROM employees
ORDER BY 3 DESC;

-- Здесь:
--   3 = salary.
--
-- Важно:
--   Numeric position работает,
--   но может делать query менее понятным.
--
-- Часто лучше писать column name:
--   ORDER BY salary DESC
--
-- вместо:
--   ORDER BY 3 DESC


-- ============================================================
-- Composite sorting
-- ============================================================
-- Composite sorting - сортировка по нескольким columns/expressions.
--
-- Пример:
SELECT job_id,
       first_name,
       last_name,
       salary,
       hire_date
FROM employees
ORDER BY job_id DESC,
         last_name,
         salary DESC;

-- Как читать:
--   сначала сортировать по job_id DESC;
--   если job_id одинаковый, сортировать по last_name ASC;
--   если last_name тоже одинаковый, сортировать по salary DESC.
--
-- Для каждой sorting column можно указать свой direction:
--   job_id DESC
--   last_name ASC by default
--   salary DESC
--
-- Хорошая практика:
--   в composite sorting каждую sorting часть писать с новой строки,
--   если список длинный.


-- ============================================================
-- ORDER BY with alias and direction
-- ============================================================
-- Alias можно сортировать ASC или DESC.
--
-- Пример:
SELECT first_name,
       last_name,
       salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- Meaning:
--   показать annual_salary
--   и отсортировать от большего annual_salary к меньшему.
--
-- Еще пример:
SELECT first_name || ' ' || last_name AS full_name,
       hire_date
FROM employees
ORDER BY full_name ASC;


-- ============================================================
-- ORDER BY does not change table data
-- ============================================================
-- ORDER BY только сортирует output.
--
-- Пример:
SELECT first_name,
       salary
FROM employees
ORDER BY salary DESC;

-- Этот query не меняет rows в employees.
-- Он не обновляет salary.
-- Он не переставляет rows внутри table permanently.
--
-- Он только показывает result set в нужном порядке.


-- ============================================================
-- Readable formatting
-- ============================================================
-- Однострочный query:
SELECT first_name, salary FROM employees ORDER BY salary DESC;

-- Работает, но читается хуже.
--
-- Лучше:
SELECT first_name,
       salary
FROM employees
ORDER BY salary DESC;

-- Для нескольких sorting keys:
SELECT job_id,
       first_name,
       last_name,
       salary
FROM employees
ORDER BY job_id,
         salary DESC,
         last_name;

-- Хорошая привычка:
--   ORDER BY писать после WHERE;
--   каждый sorting key можно переносить на новую строку;
--   direction писать явно, если порядок важен.


-- ============================================================
-- Simple examples
-- ============================================================
-- Sort by salary ascending:
SELECT first_name,
       salary
FROM employees
ORDER BY salary;

-- Sort by salary descending:
SELECT first_name,
       salary
FROM employees
ORDER BY salary DESC;

-- Sort filtered rows:
SELECT first_name,
       salary
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY salary;

-- Sort by date:
SELECT first_name,
       hire_date
FROM employees
ORDER BY hire_date DESC;

-- Sort by alias:
SELECT first_name,
       salary * 12 AS annual_salary
FROM employees
ORDER BY annual_salary DESC;

-- Sort NULL values explicitly:
SELECT employee_id,
       first_name,
       commission_pct
FROM employees
ORDER BY commission_pct DESC NULLS LAST;

-- Composite sorting:
SELECT job_id,
       first_name,
       last_name,
       salary
FROM employees
ORDER BY job_id,
         salary DESC,
         last_name;


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Думать, что rows всегда возвращаются в одном порядке.
--    Без ORDER BY порядок не гарантируется.
--
-- 2. Думать, что ORDER BY фильтрует rows.
--    Фильтрация rows делается в WHERE.
--    ORDER BY только сортирует result set.
--
-- 3. Думать, что ORDER BY меняет data в table.
--    ORDER BY только меняет порядок output.
--
-- 4. Забывать, что ASC - default.
--    ORDER BY salary
--    то же самое по direction, что:
--    ORDER BY salary ASC
--
-- 5. Использовать numeric position в сложных queries.
--    ORDER BY 4 DESC работает,
--    но ORDER BY salary DESC обычно понятнее.
--
-- 6. Не указывать NULLS FIRST / NULLS LAST,
--    когда порядок NULL values важен.
--
-- 7. Писать ORDER BY перед WHERE.
--
--    Неправильно:
--      SELECT first_name
--      FROM employees
--      ORDER BY salary
--      WHERE job_id = 'IT_PROG';
--
--    Правильно:
--      SELECT first_name
--      FROM employees
--      WHERE job_id = 'IT_PROG'
--      ORDER BY salary;


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи first_name и salary из employees.
--   Отсортируй по salary ascending.
--
-- Task 2:
--   Выведи first_name и salary из employees.
--   Отсортируй по salary descending.
--
-- Task 3:
--   Выведи first_name, salary, hire_date
--   для employees с job_id = 'IT_PROG'.
--   Отсортируй по hire_date.
--
-- Task 4:
--   Выведи salary и hire_date
--   для employees с job_id = 'IT_PROG'.
--   Отсортируй по first_name,
--   даже если first_name не находится в SELECT list.
--
-- Task 5:
--   Выведи last_name, salary и salary * 12
--   с alias annual_salary.
--   Отсортируй по annual_salary descending.
--
-- Task 6:
--   Выведи employees и отсортируй по commission_pct DESC,
--   но NULL values поставь в конец.
--
-- Task 7:
--   Выведи first_name и salary.
--   Используй ORDER BY 2.
--   Потом перепиши query через ORDER BY salary.
--
-- Task 8:
--   Сделай composite sorting:
--     job_id ascending;
--     salary descending;
--     last_name ascending.
--
-- Task 9:
--   Объясни своими словами:
--     что делает ORDER BY;
--     чем ASC отличается от DESC;
--     зачем нужны NULLS FIRST / NULLS LAST;
--     почему numeric position может быть менее понятной.


-- ============================================================
-- Summary
-- ============================================================
-- ORDER BY:
--   сортирует result set;
--   обычно пишется в конце SELECT statement;
--   не фильтрует rows;
--   не меняет table data.
--
-- ASC:
--   ascending order;
--   default direction.
--
-- DESC:
--   descending order.
--
-- Можно сортировать по:
--   column;
--   expression;
--   alias;
--   numeric position;
--   multiple columns/expressions.
--
-- Главное:
--   Если порядок rows важен,
--   всегда используй ORDER BY явно.

