/*
    < PL / SQL >
    PROCEDUERE LANGUAGE EXTENSION TO SAL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    SQL ���峻���� ������ ����, ����ó��(IF), �ݺ�ó��(FOOP, FOR, WHILE)���� �����ϸ� SQL�� ���� ����
    �ټ��� SQL���� �� ���� ������ ���� (BLOCK ����) + ����ó���� ����
    
    * PL/ SQL ����
    - [�����]     : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ �ϴ� ����
    - �����       : BEGIN���� ����, ������ �־�� ��! SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�
    - [����ó����]  : EXCEPTION���� ����, ���� �߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/
  
  SET SERVEROUTPUT ON;
    
    -- * �����ϰ� ȭ�鿡 HELLO ORACLE ���! HELLO WORLD ����ߴ� �� ó��...
BEGIN
    -- System.out.println("hello oracle");
    DBMS_OUTPUT.put_line('HELLO ORACLE');
END;
/

-------------------------------------------------------------------------------------------
/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
    �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1.1) �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
        [ǥ����] ������ [CONSTANT-> T����� ��] �ڷ���[:= ��];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- EID := 800;
    --ENAME := '������';
    
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.put_line('EID: ' || EID);
    DBMS_OUTPUT.put_line('ENAME: ' || ENAME);
    DBMS_OUTPUT.put_line('PI: ' || PI);
END;
/

------------------------------------------------------------------------------------
-- 1.2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
--      [ǥ����] ������ ���������̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;   
BEGIN
--    EID := 300;
--    ENAME := '�ڱ��̸�';
--    SAL := 8000000;
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM employee
   -- WHERE EMP_ID = 200;
   WHERE EMP_ID = '&���';
    DBMS_OUTPUT.put_line('EID : ' || EID );
    DBMS_OUTPUT.put_line('ENAME : ' || ENAME);
    DBMS_OUTPUT.put_line('SAL : ' || SAL);
    
END;
/

----------------- �ǽ����� ------------------------------
/*
    ���۷���Ÿ�� ������ EID, EANEM, JCODE, SAL, DTITLE �� �����ϰ�
    �� �ڷ����� EMP,DPT ���̺� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ����� ��ȸ�� �� �� ������ ��Ƽ� ���
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE,SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN department ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.put_line('EID : ' || EID);
    DBMS_OUTPUT.put_line('ENAME : ' || ENAME);
    DBMS_OUTPUT.put_line('JCODE : ' || JCODE);
    DBMS_OUTPUT.put_line('SAL : ' || SAL );
    DBMS_OUTPUT.put_line('DTITLE : ' || DTITLE);

END;
/
    
---------------------------------------------------------------------------------
-- 1.3) ROWŸ�� ���� ����
--      ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
--      [ǥ����] ������ ���̺��%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * -- ����÷��� �ش��ϴ� ���� �־�� ��!
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
--    DBMS_OUTPUT.put_line(E);
      DBMS_OUTPUT.put_line('����� : ' || E.EMP_NAME);
      DBMS_OUTPUT.put_line('�޿� : ' || E.SALARY);
      DBMS_OUTPUT.put_line('���ʽ� : ' || NVL(E.BONUS,0));
END;
/
-------------------------------------------------------------------------------------
-- 2. BEGIN �����

-- < ���ǹ� >

-- 1) IF ���ǽ� THEN ���೻�� END IF; (�ܵ� IF��)

-- ��� �Է¹��� �� ���� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ��� 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.put_line('��� : ' || EID);
    DBMS_OUTPUT.put_line('�̸� : ' || ENAME);
    DBMS_OUTPUT.put_line('�޿� : ' || SAL);
    IF BONUS= 0
        THEN  DBMS_OUTPUT.put_line('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
     DBMS_OUTPUT.put_line('���ʽ� : ' || BONUS);
END;
/

-----------------------------------------------------------------------------------------------
-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.put_line('��� : ' || EID);
    DBMS_OUTPUT.put_line('�̸� : ' || ENAME);
    DBMS_OUTPUT.put_line('�޿� : ' || SAL);
    IF BONUS= 0
        THEN  DBMS_OUTPUT.put_line('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
     DBMS_OUTPUT.put_line('���ʽ� : ' || BONUS);
    END IF;
END;
/
------------- �ǽ����� -------------------------

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    
    -- �Ϲ�Ÿ�Ժ��� ( TEAM ���ڿ� ) �̵��� '������' �Ǵ� '�ؿ���' ���� ����
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&���';

    IF NCODE = 'KO' THEN
        TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.put_line('��� : ' || EID);
    DBMS_OUTPUT.put_line('�̸� : ' || ENAME);
    DBMS_OUTPUT.put_line('�μ� : ' || DTITLE);
    DBMS_OUTPUT.put_line('�Ҽ� : ' || TEAM);
END;
/

------------------------------------------------------------------------------------.
-- 3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ...... ELSE ���೻�� END IF
-- ������ �Է¹޾� SCORE ������ ���� �� ��
-- 90�� �̻��� A , 80���̻� B , 70�� �̻� C, 60�� �̻� D, 60�� �̸� F
-- GRADE ������ ����
-- ����� ������ XX���̰�, ������ X �����Դϴ�.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
    
BEGIN
    SCORE := '&����';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
     DBMS_OUTPUT.put_line('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '���� �Դϴ�.');
    
END;
/
-------------------------------------------------------------------------------------
-- 4) CASE �񱳴���� WHEN ������Ұ�1 THEN �����1 WHEN �񱳰�2   THEN ����� 2 .... ELSE �����  END;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- �μ��� ���� ����

BEGIN
    SELECT * 
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DNAME := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '�λ���'
        WHEN 'D2' THEN 'ȸ����'
        WHEN 'D3' THEN '��������'
        WHEN 'D4' THEN '����������'
        WHEN 'D9' THEN '�ѹ���'
        ELSE '�ؿܿ�����' 
    END;
    
    DBMS_OUTPUT.put_line(EMP.EMP_NAME||'���� '|| DNAME || '�Դϴ�');
END;
/
-------------------------------------------------------

-- 1. ����� ������ ���ϴ� PL / SQL �� �ۼ�, ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���
-- ���ʽ��� ������ ���ʽ� ������ ����
-- ���ʽ��� ������ ���� ����
-- ��¿���
-- �޿�, �̸�, ����

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    SALBON VARCHAR2(40);
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    IF BONUS IS NULL THEN SALBON := TO_CHAR(SAL,'L999,999,999') ;
    ELSE SALBON := TO_CHAR((SAL+SAL*BONUS)*12,'L999,999,999');
    END IF;

    DBMS_OUTPUT.put_line(ENAME || '�� ������'||SALBON||'�Դϴ�.');

END;
/























































