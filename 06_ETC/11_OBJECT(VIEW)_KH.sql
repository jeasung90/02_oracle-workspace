/*
    < VIEW �� >
    
    SELECT�� (������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �ױ� SELECT���� �Ź� �ٽ� ����� �ʿ� ����!!)
    �ӽ����̺� ���� ���� ( ���� �����Ͱ� ����ִ� �� �ƴ�!!) => �����ֱ��
    �������� ���̺� : ����!
    ������ ���̺� : ����! => ��� ������ ���̺��̴�!
*/

-- �並 ����� ���� ������ ������ �ۼ�
-- ������������

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '�ѱ�';
-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '���þ�';
-- '�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '�Ϻ�';


--------------------------------------------------------------------------------
/*
    1. VIEW ���� ���
    
    [ǥ����]
    CERATE VIEW ���
    AS ��������;
    
    [OR REPLACE] : �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ������ �並 �����ϰ�,
                            ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 ����(����)�ϴ� �ɼ�
*/

CREATE VIEW VW_EMP
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE);
-- 01031. 00000 -  "insufficient privileges"
-- privileges : ���� => ������ ���ٴ� ����

-- ������ ������ �����ؼ� ���� �ο�
GRANT CREATE VIEW TO KH;

-- �̰� �����ִ� ���̺��� �ƴ�! �׷��� ����, �����̺��ΰ���
SELECT * FROM vw_emp;

-- �Ʒ��� ���� �ƶ�
SELECT * 
FROM (  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
        FROM EMPLOYEE
        JOIN department ON ( DEPT_ID = DEPT_CODE)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN national USING ( NATIONAL_CODE)
);

-- �ѱ� ���þ� �Ϻ� �ٹ��ϴ� ���
SELECT * 
FROM vw_emp
WHERE national_name = '�ѱ�';

-- [����]
SELECT * 
FROM  USER_VIEWS;

-- ���� �信 �� �ϳ� �� �߰��ϰ� �������
CREATE OR REPLACE VIEW VW_EMP
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national_name, BONUS
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE);
-- 00955. 00000 -  "name is already used by an existing object"
-- �̹� �ش� �̸��� ����ϴ� �䰡 �ִٰ� ������ ��!!
SELECT * FROM vw_emp;

-----------------------------------------------------------------------------------
/*
    * �� �÷��� ��Ī �ο�
    ���������� SELECT�� �Լ����̳� ���������� ����Ǿ� ���� ��� �ݵ�� ��Ī ���� �ؾߵ�!!
*/

-- �� ����� ���, �̸�, ���޸�, ����(��/��), �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��(VW_EMP_JOB)�� ����
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS "����(��/��)", 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS �ٹ����
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);

SELECT *
FROM vw_emp_job;

-- �Ʒ��� ���� ������ε� ��Ī �ο� �����ϴ�
CREATE OR REPLACE VIEW VW_EMP_JOB(���,�̸�,���޸�,����,�ٹ����) -- ��, ����÷��� ���ؼ� ��Ī �ο��ؾ���!!
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') , 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);
        
SELECT �̸�, ���޸�
FROM vw_emp_job
WHERE ���� = '��';
        
SELECT *
FROM vw_emp_job
WHERE �ٹ���� >= 20;
        
-- �並 �����ϰ��� �Ѵٸ� 
DROP VIEW VW_EMP_JOB;
        
 -------------------------------------------------------------------------------
 -- ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE)��� ����
 -- �並 ���� �����ϴ��� ���� �����Ͱ� ����ִ� ���̽����̺� �ݿ���
 -- �ٵ� �� �ȵǴ� ��찡 ���Ƽ� ������ ���� ������ ����
        
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM vw_job; -- ������ ���̺� (���� �����Ͱ� ������� �ʴ�)
SELECT * FROM JOB; -- ���̽� ���̺� (���� �����Ͱ� �������)

-- �並 ���ؼ� INSERT
INSERT INTO vw_job VALUES('J8','����');
        
-- �並 ���ؼ� UPDATE
UPDATE vw_job SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';
        
-- �並 ���ؼ� DELETE
DELETE
FROM VW_JOB
WHERE JOB_CODE = 'J8';

/*
    * ��, DML ��ɾ�� ������ �Ұ����� ��찡 �� ����
    1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� => ��쿡 ���� �ٸ�
    3) �������� �Ǵ� �Լ������� �䰡 ���ǵǾ��ִ� �Ͽ�
    4) �׷��Լ��� GROUP BY ���� ���Ե� ���
    5) DISTINCT ������ ���Ե� ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ���
    => ��� ��ȸ�Ϸ��� ����Ŷ� DML�� ��������!!
*/
        
        
-- 1) �信 ���ǵǾ����� ���� �÷��� �����Ϸ��� �ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
    FROM JOB;
SELECT * FROM vw_job;
-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES ('J8','���Ͻ�');
-- ORA-00904: "JOB_NAME": invalid identifier

-- UPDATE (����)
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';

-- DELETE
DELETE FROM vw_job
WHERE JOB_NAME = '���';

-- 2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽����̺� �� NOT NULL ���������� �����Ǿ� �ִ� ��� => ��쿡 ���� �ٸ�
CREATE OR  REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB VALUES ('����'); -- ���� ���̽� ���̺� INSERT �� ( NULL,'����') �߰��ѰŴ�
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE -- ����
UPDATE vw_job
SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '���';

-- DELETE (�� �����͸� ���� �ִ� �ڽĵ���Ÿ�� �����ϱ� �������� ���� ���� / ��, ���ٸ� ���� ����!!)
DELETE VW_JOB 
WHERE JOB_NAME = '���';

-- 3) �������� �Ǵ� �Լ������� �䰡 ���ǵǾ��ִ� �Ͽ�
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS ����
    FROM employee;
    
SELECT * FROM vw_emp_sal; -- �����̺�
SELECT * FROM EMPLOYEE; -- ���̽����̺�

INSERT INTO vw_emp_sal VALUES (400,'������',50000000,600000000);
-- 01733. 00000 -  "virtual column not allowed here"
-- EMPLOYEE ���� �����̶�� ���̺��� ����!!

-- UPDATE 
-- 200�� ����� ������ 8000�������� 
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200;

-- 200�� ����� �޿��� 700��������
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;-- ���� 

-- DELETE (����)
DELETE FROM vw_emp_sal
WHERE ���� = 72000000;

-- 4) �׷��Լ��� GROUP BY ���� ���Ե� ���
CREATE OR REPLACE VIEW VW_GPDE
AS SELECT DEPT_CODE, SUM(SALARY) AS �հ� , FLOOR(AVG(SALARY)) AS ���
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- �Ӛ�^^

-- INSERT (����)
INSERT INTO vw_gpde VALUES ('D3',8000000,4000000);
-- ������ EMP�� �ֱⰡ �ָ���.. �׷��� �ȵ�

-- UPDATE 
UPDATE vw_gpde
SET �հ� = 800000
WHERE DEPT_CODE = 'D1';
-- �̰͵� ���� ��� �����ϱⰡ �ָ���

-- DELETE 
DELETE 
FROM vw_gpde
WHERE �հ� = 5210000;
-- �̰͵� ���� ��� �����ϱⰡ �ָ���

-- 5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT  JOB_CODE
    FROM EMPLOYEE;
    
SELECT * FROM vw_dt_job;

-- INSERT
INSERT INTO vw_dt_job VALUES ('J8'); -- �Ӵ�

-- UPDATE
UPDATE vw_dt_job 
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7'; -- �Ӵ�

-- DELETE 
DELETE  FROM vw_dt_job
WHERE JOB_CODE = 'J7'; -- �Ӵ�

-- 6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ���
CREATE OR REPLACE VIEW VW_JOIN
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN department ON ( DEPT_CODE = DEPT_ID);
    
 
    
SELECT * FROM VW_JOIN;
 
-- INSERT
INSERT INTO VW_JOIN VALUES (300,'����','�ѹ���'); -- �Ӵ�

-- UPDATE 
UPDATE vw_join 
SET EMP_NAME = '������'
WHERE EMP_ID = 200; -- ����
-- UPDATE 2
UPDATE vw_join 
SET DEPT_TITLE = '������'
WHERE EMP_ID = 200; -- �Ӵ�
-- EMP���� DEPT_TITLE �� ����

-- DELETE 
DELETE FROM VW_JOIN
WHERE EMP_ID = 200;-- ����
        
---------------------------------------------------------------------------------------
/*
    * VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE | NOFORCE(�⺻��)] VEIW ���
    AS ��������
    [WITH CHECK OPTION]
    [WITH READ ONLY]; => ������ ��ȸ�� ����
    
    1. RO REPLACE : ������ ������ �䰡 ���� ��� ���Ž�Ű��, ������ ������ ������Ŵ
    2. FORCE | NOFROCE 
        > FORCE     : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ�
        > NOFORCE   : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 �����ǰ� �ϴ�
    3. WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�� �����ϵ���
    4. WITH READ ONLY    : �信 ���ؼ� ��ȸ�� ������ ��� ( DML �Ұ����� )
        
*/
        
-- 2) FORCE | NOFROCE 
--    NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̾�߸� �䰡 �����ǰ� �ϴ� (������ �⺻��)
CREATE OR REPLACE /* NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE,TNAME, TCONTENY
FROM TT;
-- ORA-00942: table or view does not exist
-- �ش� ���̺��� ��� ������!

-- FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �����ǰ� �ϴ�
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE,TNAME, TCONTENT
FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_EMP;-- ��ȸ�� �ȵ�
-- TT ���̺� �����ؾ߸� �� ������ �並 Ȱ�� ����

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);

-- 3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ������ ���� �߻�
-- WITH CHECK OPTION ���ְ�
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VW_EMP;
  
-- 200�� ����� �޿��� 200�������� ���� (�������l ���ǿ� �������� �ʴ� ������ ���� �õ� )
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;
 
-- WITH CHECK OPTION �ְ� 
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;
    
SELECT * FROM VW_EMP; 
  
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200; -- ������ : ���������� ����� ���ǿ� �������� �ʱ� ������ ���� �Ұ�
  
UPDATE VW_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200;  -- ���������� ����� ���ǿ� ���յǱ� ������ ���氡��

-- 4) WITH READ ONLY : ���� ���� ��ȸ�� ���� (DML�� ���� �Ұ�)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;

-- DELETE 
DELETE FROM VW_EMP
WHERE EMP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view
-- �б�������














