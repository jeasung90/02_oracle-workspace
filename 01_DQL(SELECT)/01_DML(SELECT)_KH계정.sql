/*
    <SELECT>
    ������ ��ȸ�� �� ���Ǵ� ����
    
    >>RESULT SET : SELCT���� �߿� ��ȸ�� ����� (��, ��ȸ�� ����� ������ �ǹ�!)
    
    [ǥ����]
    SELECT ��ȸ�ϰ����ϴ� �÷�1, �÷�2, . . . . FROM ���̺��
    
    �ݵ�� �����ϴ� �÷����� ����Ѵ�!! ���� �÷� ���� ������!!
*/

-- EMPLOYEE ���̺��� ��� �÷� ��ȸ (*) ��ȸ
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM JOB;
-------------------------�ǽ� ����----------------------------
--1. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;
--2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT;
--3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    SELECT�� �÷��� �ۼ� �κп� ������� ��� ����(�̶�, �������� ��� ��ȸ)
*/
--EMPLOYEE ���̺��� �����, ����� ����(�޿�*12)
SELECT EMP_NAME, SALARY*12 
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ� , ����, ���ʽ� ���Ե� ����(�޿�+���ʽ�*�޿�)*12
SELECT EMP_NAME, SALARY, BONUS, SALARY*12 AS ����, ((SALARY*BONUS)+SALARY)*12 AS �ѿ���
FROM EMPLOYEE;
--> ������� ���� �� NULL ���� ������ ��� ��������� ����� ������ NULL �̵�

--EMPLOYEE ���̺��� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE �� �����, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���� ������ ���� ����!

--*���ó��� : SYSDATE
SELECT EMP_NAME AS �̸�, HIRE_DATE AS �Ի���, SYSDATE - HIRE_DATE AS �ٹ��ϼ�
FROM EMPLOYEE;
-- DATE - DATE : ���� ������� �� ������ ����!
-- ��, ���� �������� ������ DATE ���� ��/��/��/��/��/�� ������ �ð����������� ������ �ϱ� ����!
-- �Լ� ���� �ϸ� ����� ��� Ȯ�� ���� => ���߿� ���!
-----------------------------------------------------------------------------------------
/*
 <�÷��� ��Ī �����ϱ�>
 ��������� �ϰԵǸ� �÷��� ��������.. �̶� �÷������� ��Ī �ο��ؼ� ����ϰ� ������
    
    [ǥ����]
    �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
    
    AS ���̵� �Ⱥ��̵� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� �ֵ���ǥ�� �������
*/

SELECT EMP_NAME as "��� ��", SALARY AS �޿� , SALARY*12 AS "����(��)" , (SALARY+SALARY*BONUS)*12 "�� �ҵ�(���ʽ�����)"
FROM EMPLOYEE;
-------------------------------------------------------------------------------------------------------
/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT ���� ���ͷ��� �����ϸ� ��ġ ���̺� �� �����ϴ� ������ ó�� ��ȸ ����
    ��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ��µ�
*/

--EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;

/*
    <���� ������ : ||>
    ���� �÷������� ��ġ �ϳ��� �÷��� �� ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� ����    
    
    System.out.println("num�� �� : " + num);
*/
-- ���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT EMP_NO || EMP_NAME || SALARY || '��' AS ����
FROM EMPLOYEE;

--�÷����� ���ͷ��� ����
-- XXX �� ������ XXX�� �Դϴ�. => �÷��� ��Ī : �޿�����
SELECT EMP_NAME || ' �� ������ ' || SALARY || ' �Դϴ�.' AS �޿�����
FROM EMPLOYEE;
----------------------------------------------------------------------------
/*
    < DISTINCT>
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ���
    --���� �츮 ȸ�翡 � ������ ������� �����ϴ��� �ñ���.
*/

SELECT JOB_CODE
FROM EMPLOYEE;  -- ����� 23���� ������ ���� ��ȸ�� ��

--EMPLOYEE �� �����ڵ�(�ߺ�����) ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --�ߺ� ���� �� 7�ุ ��ȸ

--������� � �μ��� �����ִ��� �ñ��ϴ�
SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE; --NULL : ���� �μ���ġ �ȵ� ���

--���� ���� : DINTINCT �� SELECT ���� �� �ѹ��� ��� ����
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) ������ ��� �ߺ� �Ǻ�

---------------------------------------------------------------------
/*
    <WHERE ��
    ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �̶� WHERE ���� ���ǽ��� ���� �ϰ� ��
    ���ǽĿ����� �پ��� �����ڵ� ��� ����!
    
    [ǥ����]
    SELECT �÷�1, �÷�2, ...
    FROM ���̺��
    WHERE ���ǽ�;
    
    [�񱳿�����]
    >, <, >=, <=        --> ��Һ�
    =                   --> �����
    !=, ^=, <>          --> �������� ������ ��
*/

-- EMPLOYEE ���� �μ��ڵ尡 'D9' �� ����鸸 ��ȸ(�̶� , ��� �÷� ��ȸ)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE ���� �μ��ڵ尡 'D1' �� ������� �����, �޿�, �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE ���� �μ��ڵ尡 'D1' �� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���� ������(ENT_YN �÷����� 'N' ��) ������� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN='N';

--------------------------�ǽ�����--------------------------------------------
--1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ� ������) ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS ����
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. ������ 5000���� �̻��� ������� �����, �޿�, ���� �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*12 AS ���� , DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE ����*12 >= 50000000; ����!! (WHERE �� ������ SELECT ���� �ۼ��� ��Ī ��� �Ұ�!!)

--���� ���� ����
--FROM�� => WHERE�� => SELECT ��

--3. �����ڵ� 'J3' �� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- �μ��ڵ尡 'D9' �̸鼭 �޿��� 500���� �̻��� ������� ���, �����,�޿�,�μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
AND SALARY >= 5000000;

-- �μ��ڵ尡 'D6' �̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
OR SALARY >= 3000000;

-- �޿��� 350�����̻� 600�������ϸ� �޴� ������� �����, ��� , �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY >=3500000 AND SALARY <= 6000000;
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--------------------------------------------------------------------
/*
    <BETWEEN AND>
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A (��1) AND B(��2)
    => �ش� �÷��� ���� A �̻��̰� B ������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--���� ���� ���� ���� ����� ��ȸ�ϰ� �ʹٸ�? 350�̸� + 600�ʰ�
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--NOT : ������������ => �ڹٿ����� !
--�÷��� �� �Ǵ� BETWEEN �տ� ���԰���!

--�Ի����� '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- DATE ������ ��Һ� ����

-------------------------------------------------------------------------------------

/*
    < LIKE >
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷� LIKE 'Ư������'
    
    -Ư������ ���ý� '%', '_' �� ���ϵ� ī��� ����� �� ����
    
    >> '%' : 0���� �̻� 
    EX) �񱳴���÷� LIKE '����%'  => �񱳴���� �÷����� ���ڷ� "����" �Ǵ°� ��ȸ
    EX) �񱳴���÷� LIKE '%����'  => �񱳴���� �÷����� ���ڷ� "��" ���°� ��ȸ
    EX) �񱳴���÷� LIKE '%��%'  => �񱳴���� �÷����� '��' �� ���ִ°� ��ȸ
    
    >>'_' : 1���� �̻�
    EX) �񱳴���÷� LIKE '_����'   => �񱳴���� �÷����� ���ھտ� ������ �ѱ��ڸ� �� ��� ��ȸ
        �񱳴���÷� LIKE '__����'  => �񱳴���� �÷����� ���ھտ� ������ �α��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_'  => �񱳴���� �÷����� ���� �հ� ���� �ڿ� ������ �ѱ��ھ� �� ���
*/

-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ����� �� �̸��� '��' �� ������ ������� �����,�ֹι�ȣ,��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- ����� �� �̸��� '��' �� ���� ������� �����,�ֹι�ȣ,��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� �� �� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ�� 3��° �ڸ��� 1 �� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** Ư�����̽�
-- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���,�̸�,�̸��� ��ȸ
--EX) SIM_BS@KH.OR.KR SUN_DI@KH.OR.KR
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '__%';
-- ���ϵ� ī��� ���ǰ��ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸ �ȵ�
--> ��� ���ϵ�ī��� ��� ������ ������ ��������ߵ�
--> �����Ͱ����� ����ϰ��� �ϴ� �� �տ� ������ ���ϵ�ī�带 �����ϰ� ������ ���ϵ�ī�带 �ɼ����� ����ؾ���
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- ���� ������� �ƴ� �� ���� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$';
---------------------------------------------------------------------
-- 1. EMPLOYEE���� �̸��� '��' ���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
-- 2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '__0%';
-- 3. EMPLOYEE���� �̸��� '��' �� ���ԵǾ� �ְ� �޿��� 240���� �̻��� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY >= 2400000;
-- 4. DEPARTMENT���� �ؿܿ������� �μ����� �ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
---------------------------------------------------------------------------
SELECT BONUS
FROM employee;

/*
    < IS NULL / IS NOT NULL >
    �÷����� NULL�� ���� ��� NULL�� �񱳿� ���Ǵ� ������
    
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS ���� NULL)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE  bonus = NULL; ���������� ��ȸ �ȵ� -- NULL �� = �� �񱳰� �ȵ�
WHERE BONUS IS NULL;



-- ���ʽ��� �޴� ����� (BONUS ����  NULL �� �ƴ� ) ��� , �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE BONUS != NULL; �ȵ�
-- WHERE NOT BONUS IS NULL;
WHERE BONUS IS NOT NULL;
-- NOT�� �÷��� �Ǵ� IS �ڿ� ��� ���� (IS �ڿ� �� ���� ��)

--  �� ����� ���� ������� �����, ������, �μ��ڵ�
SELECT EMP_NAME,MANAGER_ID, DEPT_CODE
FROM employee
WHERE manager_id IS NULL ;

-- �� �μ���ġ�� ���� ������ �ʾ����� (DEPT_CODE IS NULL), ���ʽ��� �޴� ���
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM employee
WHERE dept_code IS NULL AND BONUS IS NOT NULL;

---------------------------------------------------------------------------

/*
   < IN >
   �񱳴���÷����� ���� ������ ����߿� �����ϴ� ���� �ִ���
   
   [ ǥ���� ]
   WHERE �񱳴�� �÷� IN ('��1','��2', .........������);
*/

-- �� �μ��ڵ尡 D6�̰ų�, D8�̰ų� D5�̰ų� �μ������� �̸�, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
-- WHERE dept_code = 'D6' OR dept_code = 'D8' OR dept_code = 'D5' ;
WHERE dept_code IN ('D5','D8','D5'); 

-- �� �� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code NOT IN ('D5','D8','D5'); 

--====================================================================
/*
    < ������ �켱 ���� >
    0. () 
    1. ��������� +, -, *, / 
    2. ���Ῥ���� ||
    3. �񱳿����� =, !=, <, >
    4. IS NULL / LIKE 'Ư������' / IN
    5. BETWEEN AND
    6. NOT (�� ������)
    7. AND (�� ������)
    8. OR  (�� ������) // AND �� �켱������ ���� �ʴ�
*/


-- �� �����ڵ尡 J7�̰ų� J2�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM employee
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2')AND SALARY >=2000000;
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000;
    -- ���� ���� OR�� AND���� �켱������ ���� ����� ���� ���� �ʴ´�.
-- WHERE JOB_CODE IN ('J7','J2') AND SALARY >= 2000000;


--------------------------- �ǽ����� ---------------------------------------------

-- 1. ����� ���� �μ���ġ�� ���� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, manager_id, DEPT_CODE
FROM employee
WHERE manager_id IS NULL AND DEPT_CODE IS NULL;
-- 2. ����(���ʽ� ������)�� 3000���� �̻��̰� ���ʽ��� ���� �ʴ� ������� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;
-- 3. �Ի����� 95/01/01 �̻��̰� �μ���ġ�� ���� ������� ���, �����, �Ի���, �μ��ڵ�
SELECT *
FROM employee
WHERE HIRE_DATE  > '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. �޿��� 200���� �̻� 500���� �����̸�, �Ի����� 01/01/01 �̻��̰� ���ʽ��� ���� �ʴ� �������
-- ���, �����, �޿�, �Ի���, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM employee
WHERE salary >= 2000000 AND  salary <= 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. ���ʽ��� ������ ������ NULL�� �ƴϰ� �̸��� '��'�� ���ԵǾ� �ִ� ������� ���, �����, �޿�, ���ʽ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME,SALARY, ((SALARY*BONUS)+SALARY)*12 AS "���ʽ� ���� ����"
FROM employee
WHERE BONUS IS NOT NULL AND EMP_NAME LIKE '%��%';

---------------------------------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY
FROM employee
WHERE DEPT_CODE IS NOT NULL;

--============================================================================================================

/*
    < ORDER BY �� > 
    ���� ������ ���� �强! �Ӹ� �ƴ϶� ������� ���� ���� �������� ����
    
    [ ǥ���� ] 
    SELECT ��ȸ�� �÷�, �÷�, �������� AS "��Ī",....
    FROM ��ȸ�ϰ��� �ϴ� ���̺��
    WHERE ���ǽ�
    ORDER BY �����ϰ� ���� �÷� | ��Ī ��� ���� | �÷����� [ASC|DESC] [NULLS FIRST(���� ���� ��) | NULL LAST (������)]
    
    - ASC         : �������� ���� ( ������ �⺻�� )
    - DESC        : �������� ����  
    
    - NULL FIRST  : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� �����͸� �� �տ� ��ġ ( ������ DESC �϶��� �⺻�� )
    - NULL LAST   : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� �ش� �����͸� �� �ڿ� ��ġ ( ������ ASC  �϶��� �⺻�� )
*/
SELECT *
FROM employee
-- ORDER BY BONUS; 
-- ORDER BY BONUS ASC;              -- �������� ������ �� �⺻������ NULLS LAST  ����!
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC NULLS LAST;  -- �������� ������ �� �⺻������ NULLS FIRST ����!
ORDER BY BONUS DESC, SALARY ASC;    -- ���ı��� ������ ���� ����(ù��° ������ �÷����� ������ ��� �ι�° ���� �÷������� ����)

-- �� ����� �����, ���� ��ȸ (�� �� �������� �������� ������ȸ)
SELECT EMP_NAME,  SALARY * 12 AS "����"
FROM employee
-- ORDER BY (SALARY * 12) DESC;
-- ORDER BY ���� DESC; -- ��Ī ��� ���� (������ ���Ƽ�)
ORDER BY 2 DESC;  -- Ŀ�� ������ ���ڷ� ��� �����ϴ�.SELECT ���� ��� ( �÷� �������� ū ���� ���Ұ�)



























