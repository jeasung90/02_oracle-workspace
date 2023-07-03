/*
    DQL ( QUERT ������ ���� ��� ) : SELECT
    
    ��DML ( MANIPULATION ������ ���� ��� ) :[SELECT], INSERT, UPDATE, DELETE
    
    ��DDL ( DEFINITION ������ ���� ��� ) : CREATE, ALTER, DROP
    
    ��DCL ( CONTROL ������ ���� ��� ) : GRANT, REVIKE
    
    TCL ( TRANSACTION Ʈ������ ���� ��� ) : COMMIT, ROLLBACK
    
    < DML : DATE MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���� ����(INSERT) �ϰų�, ����(UPDATE) �ϰų�, ����(DELETE)�ϴ� ����
*/

/*
    1. INSERT
        ���̺��� ���ο� ���� �߰��ϴ� ����
        
    [ǥ����]
    1) INSERT INTO ���̺�� VALUES(��1,��2,...);
        ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
        �÷� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!!
        
        �����ϰ� ���� �������� ��� =>  not enough values ����!
        �ʹ����� ���� �������� ��� =>  too many values ����!
        
    2) INSERT INTO ���̺�� (�÷���, �÷Ÿ�, ...) VALUES (��, ��,...);
        ���̺� ���� ������ �÷��� ���� ���� INSERT �� �� ���
         �׷��� �� �� ������ �߰��Ǳ� ������
         ������ �ȵ� �÷��� �⺻������ NULL�� ��!!
         => �������� NOT NULL�� �÷��� �ݵ�� �����ؼ� �� �����ؾ� ��!
         ��, DEFAULT ���� �ִ� ��� NULL�� �ƴ� DEFAULT ���� ����!  
*/

INSERT INTO employee
VALUES (900,'������','930101-1234567','NOW_93@KH.OR.KR','01045678912',
        'D1','J7','S3',6000000,0.5,200,SYSDATE,NULL,DEFAULT);

select * FROM employee
WHERE EMP_ID = 900;

INSERT INTO employee(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL, HIRE_DATE)
VALUES(901,'����','940706-2345678','J1','S2',SYSDATE);

select * FROM employee
WHERE EMP_ID = 901;
-- EMT_YN�� �����尪���� ����!

INSERT
    INTO employee
        (
          EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (
          901
        , '����'
        , '940706-2456789'
        , 'J1'
        , 'S2'
        , SYSDATE
        );
-------------------------------------------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������);
        VALUES�� �� ���� ����ϴ°� ��ſ�
        �������� ��ȸ�� ������� ��°�� INSERT ����!
*/

-- ���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER PRIMARY KEY ,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ��� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01; 

DROP TABLE EMP_O1;
--------------------------------------------------------------------------------------------
/*
    2. INSERT ALL
    
*/
--> �켱 �׽�Ʈ �� ���̺� �����!

CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM employee
WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM employee
WHERE 1=0;

SELECT * FROM EMP_DEPT;
SELECT * FROM emp_manager;

-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM employee
WHERE DEPT_CODE = 'D1'; 

/*
    [ǥ����]
    INSERT ALL 
    INTO ���̺��1, VALUES(�÷���,�÷���...)
    INTO ���̺��2, VALUES(�÷���,�÷���...)
    ��������;
*/

INSERT ALL 
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME,DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM employee
WHERE DEPT_CODE = 'D1';

-- * ������ ����ؼ� �� ���̺� INSERT ����? 

-- 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�

-- ���̺� ������ �貸�� �����
CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, hire_date, SALARY
       FROM employee
       WHERE 1=0;
       
-- 2000�⵵ ���Ŀ� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�

CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, hire_date, SALARY
       FROM employee
       WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    [ǥ����]
    INSERT ALL
    WHEN ����1 THEN
        INTO ���̺��1 VLAUES(�÷���, �÷���...)
    WHEN ����2 THEN
        INTO ���̺��1 VLAUES(�÷���, �÷���...)
    ��������;
*/
INSERT ALL
    WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID,EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, hire_date, SALARY
FROM employee;

SELECT * FROM EMP_OLD; -- 8
SELECT * FROM EMP_NEW; -- 17

-----------------------------------------------------------------------------------------

/*
    3. UPDATE
    ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        .....       --> �������� �÷��� ���ú��� ����!(,�� �����ؾ���!! AND�ƴ�!!)
    [WHERE ����];    --> �����ϸ� ��ü ���� ��� ���� �����Ͱ� ����ȴ�!! �׷��� �� ���� ����!!
*/

-- ���纻 ���̺� ���� �� �۾�
CREATE TABLE DEPT_COPY
    AS SELECT * FROM department;
    
SELECT * FROM dept_copy; -- >.0  \(~.<)/

-- D9 �μ��� �μ����� '������ȹ��'���� ����
UPDATE dept_copy 
    SET DEPT_TITLE = '������ȹ��' --�ѹ���
    WHERE DEPT_ID = 'D9';


-- �켱 ���纻 ���� ����
CREATE TABLE EMP_SALARY 
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, NVL(BONUS,0)AS BONUS, (SALARY + SALARY * NVL(BONUS,0))*12 AS ���ʽ�����
FROM employee;

SELECT * FROM EMP_SALARY; 

-- ���ö �޿� 100 ����
UPDATE EMP_SALARY
    SET SALARY = 1000000
    WHERE EMP_NAME ='���ö'; --370
-- ������ �޿� 700 , ���ʽ� 0.2 ����
UPDATE EMP_SALARY
    SET SALARY = 7000000,BONUS = 0.2
    WHERE EMP_NAME ='������'; -- 800, 0.3
    -- ��ü����� �޿� 10 �λ� 
UPDATE EMP_SALARY
     SET SALARY = (SALARY * 1.1 );

UPDATE EMP_SALARY
    SET ���ʽ�����  = (SALARY + SALARY * BONUS)*12
    WHERE EMP_NAME = '����';


SELECT * FROM EMP_SALARY;

-- *  UPDATE�� �������� ��� ����
/*
    UPDATE ���̺��
    SET �÷��� = (�ٲܰ� => ��������)
    WHERE ���ǽ�;
*/
-- ���� ����� �޿��� ���ʽ� ���� ����Ļ���� �޿��� ���ʽ� ������ ����
UPDATE emp_salary
 SET SALARY = ( SELECT SALARY
               FROM EMP_SALARY
               WHERE EMP_NAME = '�����'),
     BONUS =( SELECT BONUS
               FROM EMP_SALARY
               WHERE EMP_NAME = '�����')
 WHERE EMP_NAME = '����';

-- ���߿� ��������
UPDATE emp_salary
 SET (SALARY,BONUS) = ( SELECT SALARYM, BONUS
               FROM EMP_SALARY
               WHERE EMP_NAME = '�����')
 WHERE EMP_NAME = '����';

-- ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����

-- ASIA �������� �ٹ��ϴ� ������� ��ȸ

UPDATE EMP_SALARY
    SET BONUS = 0.3
WHERE EMP_ID  IN (
        SELECT EMP_ID
        FROM EMP_SALARY 
        JOIN department  ON (DEPT_CODE = DEPT_ID)
        JOIN location ON (LOCATION_ID = LOCAL_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%'
    );
SELECT * FROM EMP_SALARY;

------------------------------------------------------------------------------------
-- UPDATE �ÿ��� �ش� �÷��� ���� �������� ����Ǹ� �ȵ�!
-- ����� 200���� ����� �̸��� NULL�� ����

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;
--ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL ���� ����!!

-- ���ö ����� �����ڵ� J9�� ����
UPDATE EMPLOYEE
SET JOB_CODE = 'D9'
WHERE EMP_NAME = '���ö';
-- ORA-02291: integrity constraint (KH.SYS_C007192) violated - parent key not found
-- FOREIGN KEY �������� ����!!
/*
    4. DELETE
        ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� �� ������ ���� ��)
        
    [ǥ����]
    DELETE FROM ���̺��
    [WHERE ����]; --> WHERE�� ���� ���ϸ� ��ü �� ����!
*/

-- ������ ����� ������ �����

DELETE FROM employee
WHERE EMP_NAME = '����';

SELECT * FROM EMPLOYEE;

 -- DEPT_ID�� D1�� �μ��� ����
 DELETE FROM department
 WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007191) violated - child record found
-- �ܷ�Ű ���� ����
-- D1�� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ���� �ȵ�!!

-- DEPT_CODE = D3 �ΰ�����

DELETE FROM department
WHERE DEPT_ID = 'D3';
SELECT * FROM department;

-- * TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
--              DELETE���� ����ӵ��� ����
--              ������ ���� ���� �Ұ�, �ѹ� �Ұ��ϴ�
-- [ǥ����] TRUNCATE TABLE ���̺��

SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;




