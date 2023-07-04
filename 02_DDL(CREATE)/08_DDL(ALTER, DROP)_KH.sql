/*
    DDL ( DATE DEFINITION LANGUAGE ) : ������ ���� ���
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ����
    
    < ALTER >
    ��ü�� �����ϴ� ����
    
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����!
    
    * ������ �ֿ�
    1) �÷� �߰�/����/����
    2) �������� �߰�/���� --> ������ �Ұ� (�����ϰ��� �Ѵ٤��� ������ �� ������ �߰�)
    3) �÷���/�������Ǹ�/���̺� ����
*/

--  1) �÷� �߰�/����/����
-- 1.1) �÷� �߰�(ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] ��������
-- DEPT_COPY�� CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL�� ä����

-- LNAME �÷� �߰� (�⺻���� ������ü��)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

-- 1.2) �÷� ����(MODIFY)
--> �ڷ��� ����      : MODIFY �÷��� �ٲٰ��� �ϴ� �ڷ���
--> DEFAULT �� ���� : MODIFY �÷��� DEFAULT �ٲٰ��� �ϴ� �⺻ ��

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- �̰� ������! �̹� �����Ͱ� ���ڰ� �ƴѰ͵� �������
-- �����ϴ� �����Ͱ� ����߸� �̷��� �ٲ� �� ����

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- ��͵� �����߻�!! �̹� ����ִ� �����Ͱ� ������ �ٲٷ��� ����Ʈ���� ũ�⶧����

---------------- �׽�Ʈ --------------------------
-- DEPT_COPY
-- 1. DEPT_TITLE �÷��� VARCHAR2(50)����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
-- 2. LOCATION_ID �÷�  VARCHAR2(4)����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
-- 3. LNAME �÷��� �⺻���� '�̱�'����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';

-- ���� ���� ����
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(5)
MODIFY LNAME DEFAULT '����';
-- ����Ʈ���� �ٲ۴ٰ� �ؼ� �̹��� �߰��� �����Ͱ� �ٲ�� ���� �ƴϴ�!

-- 1.3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷�
-- ������ ���� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 �κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- ���� �����
--ALTER TABLE DEPT_COPT2 DROP COLUMN CNAME DROP LNAME;
-- �ȵ� 

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- 12983. 00000 -  "cannot drop all columns in a table"
-- �� ���� �� ���� �ּ� �ϳ��� �÷��� ���ƾ���
DROP TABLE DEPT_COPY2;

-------------------------------------------------------------------------------------
-- 2) �������� �߰� / ����
/*
    2.1) �������� �߰�
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KET : ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(�÷���)]
    UNIQUE      : ADD UNIQUE
    CHECK       : ADD CHECK (�÷��� ���� ���� [IN (�����ѹ���, ������ ����,...)]
    NOT NULL    : MODIFY �÷��� NOT NULL | NULL => �̰ž��� �� ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] ��������
*/

-- DEPT_ID�� PRIMARY KEY �߰�
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPT_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCPY_UQ UNIQUE (DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
-- DEPT_TITLE �� UEIQUE �������� �߰�
-- LNAME �� NN �������� �߰�

-- 2.2) �������� ���� : DROP CONSTRAINT �������Ǹ�
-- NOT NULL �������� MODIFY �÷��� NULL �� ����

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPT_PK;
ALTER TABLE DEPT_COPY 
 DROP CONSTRAINT DCPY_UQ
 MODIFY LNAME NULL;
 
 -------------------------------------------------------------------------
 -- 3) �÷���/ �������Ǹ�/ ���̺�� ���� (RENAME)
 -- 3.1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
 
 -- DEPY_TITLE => DEPT_NAME
 ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
 
 -- 3.2) �������Ǹ� ���� : RENAME CONSTRAINT ���� �������Ǹ� TO �ٲ� �������Ǹ�
 -- SYS_C007206 => DCOPY_LID_NN
 ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007206 TO DCOPY_LID_NN;
 
 -- 3.3) ���̺�� ���� : RENAME �������̺�� TO ���ο����̺��
 -- ALTER TABLE �ش����̺�� RENAME TO ���������̺��;
 ALTER TABLE DEPT_COPY RENAME  TO DEPT_JOMBE;
 
 ----------------------------------------------------------------------------------
 /*
    < DROP >
    ���̺��� �����ϴ� ����
 */
 
 -- ���̺� ����
 DROP TABLE DEPT_JOMBE; -- ���� ���� �����... ��� ���Ҵ�
 
 -- ��, ��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� ���� �ȵ�
 -- ���࿡ �����ϰ��� �Ѵٸ�
 -- ���1. �ڽ����̺��� ���� ���� �� �� �θ����̺� �����ϴ� ��� (�ʹ� ���� �ϰ��� ����)
 -- ���2. �׳� �θ����̺� �����ϴµ� �������Ǳ��� ���� �����ϴ� ��� (����...)
 --     DROP TABLE ���̺�� CASCADE CONSTRAINT;

 
 
 
 
 
 
 
 
 
 
 