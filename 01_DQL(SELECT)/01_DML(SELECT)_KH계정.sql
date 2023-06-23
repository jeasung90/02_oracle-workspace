/*
    <SELECT>
    ������ ��ȸ�� �� ���Ǵ� ����
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� ����� (��, ��ȸ�� ����� ������ �ǹ�)
    
    [ǥ����]
    SESELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ... 
    FROM ���̺��;
    
    * �ݵ�� �����ϴ� �÷����� ����Ѵ�!! ���� �÷� ���� ������!!

*/

-- EMPLOYEE ���̺��� ��� �÷�(*) ��ȸ
-- SELECT EMP_ID, EMP_NAME �÷��� ������ ��� ���� ����
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� �� ��ȸ�ϰ� �ʹ�
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB;
---------------- �ǽ����� ----------------------
-- 1. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT *
FROM department;

-- 3. DEPARTMENT ���̺��� �μ��ڵ� �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM department;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM employee;

/*
    <�÷����� ���� �������>
    SELECT �� �÷��� �ۼ� �κп� ������� ��� ����(�̶�, ��������� �� ����� ��ȸ�� ��)
    
*/
-- EMPLOYEE ���̺��� �����, ����� ����(�޿�*12) ��ȸ
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ��� ���Խ�Ų ����((�޿�+���ʽ�*�޿�)*12)
SELECT EMP_NAME, SALARY ,BONUS, SALARY * 12,((SALARY + BONUS * SALARY )*12)
FROM EMPLOYEE;
--> ������� ���� �� NULL ���� ������ ��� ��������� ����� ������ NULL�� ����

-- EMPLOYEE ���̺��� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�
-- DATE ���� ������ ���� ����
-- * ���ó�¥ : SYSDATE : ������� �ϴ����� ����!
-- ��, ���� �������� ������ DATE������ ��/��/��/��/��/�� ������ �ð����������� �����ϰ� �ֱ� ������
-- �Լ������ϸ� ����� ��� Ȯ�� ���� => ���߿� ��� TRUNC(SYSDATE

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

---------------------------------------------------------
/*
    <Ŀ���� ��Ī�� �����ϱ�>
    ��������� �ϰ� �Ǹ� �÷����� ����������.. �̶� �÷������� ��Ī�� �ο��ؼ� ����ϰ� �����ִ� �뵵
    
     [ǥ����] ��
     �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
     
     AS�� ���̵� �Ⱥ��̵� �ο��ϰ��� �ϴ� ��Ī�� ���⳪ Ư�����ڰ� ���Ե� ��� �ݵ�� �ֵ�����""�� ����� ��!!
*/

SELECT EMP_NAME �����, SALARY AS "�޿�", SALARY*12 "����(��)", (SALARY + SALARY * BONUS)*12 AS " �� �ҵ�(���ʽ�����)"
FROM employee;

----------------------------------------------------------------
/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')
    
    SELECT ���� ���ͷ��� �����ϸ� ��ġ ���̺���� �����ϴ� ������ó�� ��ȸ�� �����ϴ�
    ��ȸ�� RESULT SET �� ��� �࿡ �ݺ������� ���� ���
    
*/

-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_NO, EMP_NAME, SALARY, '��'AS ����
FROM employee;

/*
    < ���� ������ : || >
    ���� �÷������� ��ġ �ϳ��� �÷��� �� ó�� �����ϰų�, �÷����� ���ͷ��� ���� �� �� ����
    System.out.println("num�� �� : " + nun");
    */

-- ���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ
SELECT emp_no || emp_name || SALARY
FROM employee;

-- �÷����� ���ͷ� ���� ����
-- xxx�� ������ xx�� �Դϴ�. => �÷����� ��Ī : �޿�����
SELECT emp_name || '�� ������ ' || SALARY || '�� �Դϴ�.' AS �޿�����
FROM employee;

---------------------------------------------------------
/*
    < DISTINCT > 
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ���
*/
-- ���� ȸ�翡�� � ������ ������� �����ϴ��� ������.
SELECT JOB_CODE
FROM JOB; -- ����� 23���� ������ ���� ��ȸ��.

-- EPLOYEE ���̺� �����ڵ�(�ߺ�����) ��ȸ

SELECT DISTINCT JOB_CODE
FROM JOB; -- �ߺ� ���� �ż� 7�ุ ��ȸ��

-- ������� � �μ��� �����ִ��� ������.
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL : ���� �μ���ġ �ȵ� ���

-- ���� ���� : DISTINCT�� SELECT���� �� �ѹ��� ��� ����
/* ������ ���°� ����
SELECT DISTINCT JOB_CODE,DISTUNCT DEPT_CODE
FROM employee;
*/
SELECT DISTINCT JOB_CODE,DEPT_CODE 
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) ������ ��, �Ѵ� �ߺ��ϰ�� ������Ŵ

-- ===================================
/*
    < WHERE �� >
    ��ȸ �ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸� ��ȸ�ϰ��� �� �� ���
    �� �� WHERE���� ���ǽ��� �����ϰ� ��
    ���ǽĿ����� �پ��� �����ڵ� ��� ����!!

    [ǥ����]
    SELECT �÷�1, �÷�2�� ....
    FROM ���̺��
    WHERE ���ǽ�
    
    [�񱳿�����]
    >, <, >=, <=  --> ��Һ�
    =             --> �����
    !=, ^=, <>    --> �������� ������ ��    
*/

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�μ��� ����鸸 ��ȸ(�̶�, ��� �÷� ��ȸ)
SELECT *
FROM employee
WHERE DEPT_CODE = 'D9'; -- ��ҹ��� ������

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� ������� ������ �޿�, �μ��ڵ� �� ��ȸ
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM employee
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE ���� �μ��ڵ尡 'D1'�� �ƴѻ������ ����� ������ �μ��ڵ�
SELECT EMP_ID, EMP_NAME ,DEPT_CODE
FROM employee
--WHERE DEPT_CODE != 'D1'; -- NULL�� �ȳ���
WHERE DEPT_CODE <> 'D1'; -- ����

-- �޿��� 400���� �̻��� ������� ������, �μ��ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > '4000000' ;

-- employee���� �������� ������� ���, �̸�, �Ի���
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM employee
WHERE ENT_YN = 'N' ;

--------------------------�ǽ�����----------------------------------------------
-- 1. �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ����(���ʽ� ������)
SELECT EMP_NAME,  SALARY, HIRE_DATE, SALARY *12||'��' AS "����"
FROM employee
WHERE SALARY > '3000000' ;
-- 2. ������ 5000���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ
SELECT EMP_NAME,  SALARY|| '��' AS "����", SALARY *12||'��' AS "����" , DEPT_CODE
FROM employee
WHERE SALARY *12> '50000000' ;
--WHERE ���� *12> '50000000' ; (WHERE�� ������ SELECT���� �ۼ��� ��Ī ��� �Ұ�!!)

/*      ���� ���� ����
     FROM�� => WHERE�� => SELECT��
*/

-- 3. �����ڵ尡'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩��
SELECT EMP_ID, EMP_NAME,DEPT_CODE,  ENT_YN
FROM employee
WHERE DEPT_CODE != 'J3' ;
 
-- �μ��ڵ尡 'D9'�μ� �̸鼭 �޿��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY , DEPT_CODE
FROM employee
WHERE DEPT_CODE ='D9' AND SALARY > '5000000';

-- �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- �޿��� 350���� �̻� 600���� ���� �޴� ������� �����,���,�޿���ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
--WHERE 3500000 <= AND SALARY <=6000000 ; �����߻�
--WHERE 3500000 <= SALARY AND SALARY <=6000000 ;
WHERE SALARY >=3500000 AND SALARY <=6000000 ; -- �Ϲ������δ� �� ������ �Ѵ�!

/* ������ �ٲ�� �����߻�
SELECT EMP_NAME,  SALARY|| '��' AS "����", SALARY *12||'��' AS "����" , DEPT_CODE
WHERE SALARY *12> '50000000' 
FROM employee;
*/

/*
    < BETWEEN AND >  WHERE ������
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ������ �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    => �ش��÷��� ���� A(��1)�̻��̰� B(��2) ������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- ���� ���� ���� ���� ������� ��ȸ�ϰ� �ʹٸ�? 350�̸� + 600�ʰ�

SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
--WHERE SALARY < 3500000 OR SALARY >6000000;    ��� 1
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000; ��� 2
WHERE SALARY NOT BETWEEN 3500000 AND 6000000; --��� 3
-- NOT : ������������ => �ڹٿ����� !
-- �÷��� �� �Ǵ� BETWEEN �տ� ���� ����!

-- �Ի����� '90/01/01' ~ '01/01/01'
SELECT *
FROM employee
-- WHERE HIRE_DATE>= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE ������ ��Һ� ����
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--------------------------------------------------------------------------

/*
    < LIKE >
    ���ϰ��� �ϴ� Ŀ������ ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷� LIKE 'Ư������'
    
    -Ư������ ���ý� '%', '_'�� ���ϵ� ī��� ����� �� ����
    
    >> '%' : ���� �̻�
    EX) �񱳴���÷� LIKE '����%' => �񱳴���� �÷����� ���ڷ� "����"�Ǵ°� ��ȸ
        �񱳴���÷� LIKE '%����' => �񱳴���� �÷����� ���ڷ� "��"���°� ��ȸ
        �񱳴���÷� LIKE '%��%'  => �񱳴���� �÷����� ���ڰ� "����"�Ǵ°� ��ȸ(Ű���� �˻�)
  
    >> '_' : 1���� �λ�
    EX) �񱳴���÷� LIKE '_����'  => �񱳴���� Ŀ������ ���ھտ� ������ �� ���ڸ� �� ��� ��ȸ
        �񱳴���÷� LIKE '__����' => �񱳴���� �÷����� ���ڿ��� ������ �α� �ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_' => �񱳴���� �÷����� ���� �հ� ���� �ڿ� ������ �� ���ھ� �� ��� ��ȸ



*/
-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '��%';

-- ����� �� ���� �Ϸ� ������ ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%��';

-- �̸��߿� �ϰ� ���c�� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%��%';

-- �̸��� ��� ���ڰ� "��"�� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME,  PHONE
FROM employee
WHERE EMP_NAME LIKE '_��_';

-- ��ȭ��ȣ�� 3��° �ڸ��� 1�� ������� ���, �����, ����, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM employee
WHERE PHONE LIKE '__1%';

-- ** Ư�����̽� (���� ���ɼ� ����)
-- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸���
SELECT EMP_ID, EMP_NAME,  EMAIL
FROM employee
WHERE EMAIL LIKE '____%'; -- ���ߴ� ��� ���� ����!!
-- ���ϵ�ī��� ���ǰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸ �ȵ�
---> ��� ���ϵ�ī��� ��� ������ ������ ��������ߵ�!
---> ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ� ������ ���ϵ�ī�带 ESCAPE OPTION ���� ����ؾ� ��!!
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- ���� ������� �ƴ� �� ���� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';

--------------------------�ǽ�����------------------------------
-- 1. EMLPOYEE ���̺��� �̸��� '��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '%��';

-- 2. EMLPOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ���� ��ȸ
SELECT EMP_NAME,PHONE
FROM employee
WHERE NOT PHONE LIKE '010%';

-- 3. EMLPOYEE ���̺��� �̸��� '��'�� ���ԵǾ� �ְ� �޿��� 240���� �̻��� ������� ������ �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM employee
WHERE EMP_NAME LIKE '%��%' AND salary >= 2400000;

-- 4. DEPARTMENT ���� �ؿ� �������� �μ����� �ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM department
WHERE dept_title LIKE '�ؿܿ���%';







