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