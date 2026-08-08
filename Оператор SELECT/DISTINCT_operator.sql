-- ============================================================
-- DISTINCT operator
-- ============================================================
-- DISTINCT      - используется для получения уникальных rows
--                 в result set.
--
-- Простыми словами:
--   DISTINCT убирает duplicates из результата SELECT.
--
-- Важно:
--   DISTINCT не меняет данные в table.
--   DISTINCT влияет только на output query.
--
-- Без DISTINCT:
--   SELECT может вернуть повторяющиеся значения.
--
-- С DISTINCT:
--   SELECT возвращает только уникальные значения
--   или уникальные комбинации значений.


-- ============================================================
-- Basic syntax
-- ============================================================
-- Синтаксис:
--   SELECT DISTINCT column_name
--   FROM table_name;
--
-- Для нескольких columns:
--   SELECT DISTINCT column_name1,
--                   column_name2
--   FROM table_name;
--
-- DISTINCT пишется сразу после SELECT.
--
-- Правильно:
--   SELECT DISTINCT job_id
--   FROM job_history;
--
-- Неправильно:
--   SELECT job_id DISTINCT
--   FROM job_history;


-- ============================================================
-- DISTINCT with one column
-- ============================================================
-- Пример:
SELECT DISTINCT job_id
FROM job_history;

-- Этот query показывает уникальные job_id из job_history.
--
-- Если в table есть такие rows:
--
--   JOB_ID
--   --------
--   IT_PROG
--   IT_PROG
--   SA_REP
--   SA_REP
--   AD_ASST
--
-- Тогда SELECT DISTINCT вернет:
--
--   JOB_ID
--   --------
--   IT_PROG
--   SA_REP
--   AD_ASST
--
-- Повторяющиеся значения будут убраны из result set.


-- ============================================================
-- SELECT vs SELECT DISTINCT
-- ============================================================
-- Обычный SELECT:
SELECT job_id
FROM job_history;

-- Может вернуть duplicates:
--   IT_PROG
--   IT_PROG
--   SA_REP
--   SA_REP
--
-- SELECT DISTINCT:
SELECT DISTINCT job_id
FROM job_history;

-- Вернет unique values:
--   IT_PROG
--   SA_REP
--
-- Главное отличие:
--   SELECT показывает все matching rows.
--   SELECT DISTINCT убирает duplicate rows из output.


-- ============================================================
-- DISTINCT with multiple columns
-- ============================================================
-- DISTINCT можно применять к комбинации columns.
--
-- Пример:
SELECT DISTINCT job_id,
                department_id
FROM job_history;

-- Важно:
--   DISTINCT работает на всю строку result set,
--   а не только на первую column.
--
-- То есть уникальной должна быть комбинация:
--   job_id + department_id
--
-- Пример данных:
--
--   JOB_ID    | DEPARTMENT_ID
--   ----------+---------------
--   IT_PROG   | 60
--   IT_PROG   | 60
--   IT_PROG   | 90
--   SA_REP    | 80
--   SA_REP    | 80
--
-- Query:
--   SELECT DISTINCT job_id,
--                   department_id
--   FROM job_history;
--
-- Result:
--
--   JOB_ID    | DEPARTMENT_ID
--   ----------+---------------
--   IT_PROG   | 60
--   IT_PROG   | 90
--   SA_REP    | 80
--
-- Почему IT_PROG повторился?
--   Потому что combination разная:
--     IT_PROG + 60
--     IT_PROG + 90


-- ============================================================
-- DISTINCT and column order
-- ============================================================
-- Порядок columns влияет на внешний вид result set,
-- но не меняет смысл уникальности combination.
--
-- Пример 1:
SELECT DISTINCT job_id,
                department_id
FROM job_history;

-- Result columns:
--   job_id
--   department_id
--
-- Пример 2:
SELECT DISTINCT department_id,
                job_id
FROM job_history;

-- Result columns:
--   department_id
--   job_id
--
-- В обоих случаях Oracle убирает duplicate combinations.
-- Но columns будут показаны в том порядке,
-- который указан в SELECT list.


-- ============================================================
-- DISTINCT and NULL
-- ============================================================
-- Если column содержит NULL,
-- DISTINCT считает повторяющиеся NULL как одно unique value.
--
-- Пример:
--
--   DEPARTMENT_ID
--   -------------
--   60
--   60
--   NULL
--   NULL
--   90
--
-- Query:
--   SELECT DISTINCT department_id
--   FROM job_history;
--
-- Result:
--   60
--   90
--   NULL
--
-- Важно:
--   Для DISTINCT два NULL в одной column
--   не выводятся как два отдельных значения.
--
-- Но не путай это с comparison:
--   NULL = NULL не является TRUE в обычном comparison.


-- ============================================================
-- DISTINCT with expressions
-- ============================================================
-- DISTINCT можно использовать не только с columns,
-- но и с expressions.
--
-- Пример:
SELECT DISTINCT job_id || '-' || department_id AS job_department
FROM job_history;

-- Oracle сначала вычисляет expression,
-- потом убирает duplicate expression values.
--
-- Еще пример:
SELECT DISTINCT employee_id
FROM job_history;

-- Здесь получаем список employees,
-- у которых есть записи в job_history.


-- ============================================================
-- DISTINCT is not for changing table
-- ============================================================
-- DISTINCT не удаляет duplicates из table.
--
-- Пример:
SELECT DISTINCT job_id
FROM job_history;

-- Этот query только показывает unique job_id.
--
-- Он не делает:
--   DELETE
--   UPDATE
--   INSERT
--
-- Данные в job_history остаются такими же.


-- ============================================================
-- DISTINCT and performance
-- ============================================================
-- DISTINCT может требовать дополнительной работы от Oracle,
-- потому что database должна найти duplicate rows
-- и убрать их из output.
--
-- Поэтому не нужно писать DISTINCT автоматически в каждом query.
--
-- Используй DISTINCT, когда реально нужен unique result.
--
-- Хороший случай:
--   нужен список всех job_id без повторов.
--
-- Пример:
SELECT DISTINCT job_id
FROM job_history;
--
-- Плохая привычка:
--   добавлять DISTINCT просто потому что result содержит duplicates,
--   но не понимать причину duplicates.
--
-- В этом уроке мы рассматриваем только простой SELECT.
-- Более сложные причины duplicates будут понятнее в отдельных темах.


-- ============================================================
-- Common mistakes
-- ============================================================
-- 1. Писать DSITINCT вместо DISTINCT.
--    Правильно:
--      DISTINCT
--
-- 2. Ставить DISTINCT после column name.
--    Неправильно:
--      SELECT job_id DISTINCT
--      FROM job_history;
--
--    Правильно:
--      SELECT DISTINCT job_id
--      FROM job_history;
--
-- 3. Думать, что DISTINCT работает только на первую column.
--    На самом деле DISTINCT работает на всю result row.
--
-- 4. Думать, что DISTINCT удаляет duplicates из table.
--    DISTINCT только меняет result set.
--
-- 5. Использовать DISTINCT без причины.
--    Если duplicates важны для смысла данных,
--    DISTINCT может скрыть полезную информацию.


-- ============================================================
-- Practice tasks
-- ============================================================
-- Task 1:
--   Выведи все job_id из job_history без DISTINCT.
--
-- Task 2:
--   Выведи уникальные job_id из job_history.
--
-- Task 3:
--   Выведи уникальные employee_id из job_history.
--
-- Task 4:
--   Выведи уникальные department_id из job_history.
--
-- Task 5:
--   Выведи уникальные combinations:
--     job_id
--     department_id
--
-- Task 6:
--   Объясни своими словами:
--     почему SELECT DISTINCT job_id, department_id
--     может вернуть один job_id несколько раз?


-- ============================================================
-- Summary
-- ============================================================
-- DISTINCT:
--   убирает duplicate rows из result set;
--   пишется сразу после SELECT;
--   работает на всю SELECT list;
--   не меняет данные в table;
--   нужен, когда нужен unique output.
--
-- One column:
--   SELECT DISTINCT job_id
--   FROM job_history;
--
-- Multiple columns:
--   SELECT DISTINCT job_id,
--                   department_id
--   FROM job_history;
--
-- Главное:
--   DISTINCT = unique result rows.
