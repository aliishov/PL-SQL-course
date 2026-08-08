 SET SERVEROUTPUT ON;

-- Task 1: Declare Variables
DECLARE
    v_employee_id NUMBER(10);
    v_first_name  VARCHAR2(50);
    v_salary      NUMBER(10, 2);
    v_hire_date   DATE;
    v_is_active   BOOLEAN;
BEGIN
-- Task 2: Initialize variables and print them using DBMS_OUTPUT
    v_employee_id := 100;
    v_first_name := 'Raul';
    v_salary := 1850.00;
    v_hire_date := TO_DATE('2026-08-10', 'YYYY-MM-DD');
    v_is_active := TRUE;
    
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('Hire date: ' || TO_CHAR(v_hire_date, 'DD.MM.YYYY'));
    
    IF v_is_active THEN
        DBMS_OUTPUT.PUT_LINE('Is active: TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Is active: FALSE');
    END IF;
END;

-- Task 3: NVL on v_bonus
DECLARE
    v_salary NUMBER(10) := 1850;
    v_bonus  NUMBER(10);
    v_result NUMBER(10);
BEGIN
    v_result := v_salary + NVL(v_bonus, 0);
    DBMS_OUTPUT.PUT_LINE('Salary with bonus: ' || v_result);
END;

-- Task 4: Change VARCHAR2 to DATE
DECLARE
    v_v_date VARCHAR2(10) := '2026-08-07';
    v_d_date DATE;
BEGIN
    v_d_date := TO_DATE(v_v_date, 'YYYY-MM-DD');
    DBMS_OUTPUT.PUT_LINE('DATE: ' || TO_CHAR(v_d_date, 'DD.MM.YYYY'));
END;

-- Task 5: Adding SUBTYPEs
DECLARE
    SUBTYPE t_money IS NUMBER(12, 2);
    
    v_money_1     t_money := 1000.23;
    v_money_2     t_money := 1231.12;
    v_total_money t_money;
BEGIN
    v_total_money := v_money_1 + v_money_2;
    DBMS_OUTPUT.PUT_LINE('Total money: ' || v_total_money);
END;

-- Task 6: Creating and filling RECORD
DEClARE
    TYPE t_employee_info IS RECORD (
        employee_id NUMBER(10),
        full_name   VARCHAR2(100),
        salary      NUMBER(10, 2)
    );
    
    v_employee t_employee_info;
BEGIN
    v_employee.employee_id := 1;
    v_employee.full_name   := 'Raul Alishov';
    v_employee.salary      := 1850.00;
    
    DBMS_OUTPUT.PUT_LINE('Full name: ' || v_employee.full_name);
END;

-- Task 7: Filling Associative array and printing values using loop
DECLARE
    TYPE t_names IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    
    v_names t_names;
    
    i PLS_INTEGER;
BEGIN
    v_names(1) := 'Raul';
    v_names(2) := 'Zaur';
    v_names(3) := 'Ceyla';
    
    i := v_names.FIRST;
    
    WHILE i IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(i || ': ' || v_names(i));
        
        i := v_names.NEXT(i);
    END LOOP;
END;

    