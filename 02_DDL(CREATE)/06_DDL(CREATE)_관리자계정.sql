/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ ����(ALTER), ���� ��ü�� ����(DROP) �ϴ� ���
    ��, ���� ������ �� �� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE)
                                 �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER)
                                 ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM), �����(USER)
                                 
    
    <CREATE>
    ��ü�� ������ �����ϴ� ����
*/

/*
    1.���̺� ����
    -���̺��̶�? ��(ROW) �� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���ؼ� �����!!
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��!)
            
    [ǥ����]
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        .....
    );
    
    * �ڷ���
    - ���� -(�ѱ� �ѱ��ڴ� 3����Ʈ)
    CHAR(����Ʈ ũ��) | VARCHAR2(����Ʈ ũ��) => �ݵ�� ũ�� ���� �ؾ���
    > CHAR : �ִ� 2000����Ʈ ���� ���� ���� . . ������ ���� �ȿ����� �����  / ���� ���� (������ ũ�⺸�� �� ���� ���� ���͵� �������� ä����!)
             ������ ���ڼ��� �����͸��� ��� ��� ��� => �Ϲ������� '��'����. (YN / MF)
             
    > VARCHAR2 : �ִ� 4000����Ʈ CHAR�� 2�� . ���� ����(��� ���� ���� ������ ũ�Ⱑ ������)
                 �� ������ �����Ͱ� ������ �𸣴� ��� + �� ��
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
*/

--ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

--���� ���̺�����ϴٰ� �÷��� ��Ÿ�� �߻��ߴٸ�?
--���ļ� �ٽ� ����� �ɱ�? ���� �����ϰ� �ٽ� �������Ԥ�
--DROP TABLE ���̺��;

--������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺��
--[����] USER_TABLES: ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����

SELECT * FROM USER_TABLES;

--[����] USER_TAB_COLUMNS : �� ����ڰ� ������ �ִ� ���̺���� ��� �÷� �� �� ����
SELECT * FROM USER_TAB_COLUMNS;

-------------------------------------------------------------------------------
/*
    2.�÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    [ǥ����]
    COMMENT ON COLUMN IS '�ּ�����'
*/

--�߸� �ۼ��ؼ� �������� ��� ���� �� �ٽ� �����ϸ� ��
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

--���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;

--���̺� ������ �߰���Ű�� ���� (DML : INSERT) �̶� �ڼ��ϰ� ���
--INSERT INTO ���̺�� VALUES(��1, ��2, ��3,.....);

--INSERT INTO MEMBER VALUES(1, 'user01' ,'pass01','ȫ�浿'); �� �Է� ���ϸ� ������
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'AAA@NAVER.COM', '20/12/30');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2, 'user02' ,'pass02','ȫ���', '��', NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--��ȿ���� ���� �����Ͱ� ��������.. ���� ������ �ɾ���ߵ�

---------------------------------------------------------------------------
/*
    <�������� CONSTRAINTS>
    -���ϴ� �����Ͱ� (��ȿ�� ������ ��) �� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    -������ ���Ἲ ������ �������� �Ѵ�!
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, foreign key
*/

/*
    * NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���
    ����/ ������ NULL���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2������ ����(�÷�������� / ���̺������)
    * NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ�
*/

--�÷�������� : �÷��� �ڷ��� ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES
(1,'USER01','PASS01','�����','��','NULL',NULL);

INSERT INTO MEM_NOTNULL VALUES
(2,'USER02','NULL','�̰���','��','NULL',AA@NAVER.COM;
--�ǵ��ߴ���� ������!!!(NOT NULL �������ǿ� ����Ǿ� �����߻�)

INSERT INTO MEM_NOTNULL
VALUES(2, 'USER01', 'PASS01', '�̽¿�', NULL, NULL, NULL);
--> ���̵� �ߺ��Ǿ��������� �ұ��ϰ� �߰����� �Ф�

--------------------------------------------------------------
/*
    * UNSNIZUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ���� ����
    ����/ ������ ������ �ִ� �����Ͱ� �� �ߺ����� ������ ������
*/

CREATE TABLE MEM_UNIQUE( -- �÷��������
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT *
FROM MEM_UNIQUE;

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- ���̺������
    --NOT NULL(MEM_PWD) --> �̰� �ȵ� �÷��󺧽����θ� �� NOT NULL��
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '�̰���', null, null, null);
--ORA-00001: unique constraint (DDL.SYS_C007062) violated
--> UNIQUE �������ǿ� ����Ǿ���! INSERT ����
--> ���������� �������Ǹ����� �˷���!! (Ư�� �÷��� ������� �ִ��� ���� �˷����� ����!)
--> ���� �ľ��ϱ� �����!
--> �������� �ο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع���

/*
    * �������� �ο� �� �������Ǹ� ���� �����ִ� ���
    
    >�÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] ��������
        �÷��� �ڷ���
    );
    
    >���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���
        [CONSTRAINT �������Ǹ�] ��������(��÷�?)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�̰���', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass02', '�̽¿�', '��', null, null);
--> ������ ��ȿ�� ���� �ƴѰ� ���͵� �� INSERT�� �ȴ�. => �̷��� �ȵ�..

---------------------------------------------------------------------------------------
/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����
    �ش� ���ǿ� �����ϴ� �����Ͱ��� ��� �� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN('��','��')) --���̺������
);


SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1,'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_CHECK VALUES(2,'user02', 'pass02', '�̰���', '��', null, null);
--ORA-02290: check constraint (DDL.SYS_C007072) violated 
--check �������ǿ� ����Ʊ� ������ ���� �߻�

INSERT INTO MEM_CHECK VALUES(2,'user02', 'pass02', '�̰���', NULL, null, null);
--���� GENDER �÷��� �����Ͱ��� �ְ��� �Ѵٸ� CHECK�������ǿ� �����ϴ� ���� �־�ߵ�
--NOT NULL �ƴϸ� NULL �� �����ϱ���!!

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '�̽¿�', '��', null, null);
--ȸ����ȣ�� �����ص� ���������� insert �Ź���...

------------------------------------------------------------------------------------
/*
    * PRIMARY KEY(�⺻Ű) �������� => PK
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
    
    EX) ȸ����ȣ, �й�, �����ȣ, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ������ȣ
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������.
    
    * ���ǻ��� : �� ���̺�� ������ !!! �Ѱ��� ����
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)
);
SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1,'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_PRI VALUES(1,'user02', 'pass02', '�̰���', '��', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- �⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������� ����)

INSERT INTO MEM_PRI VALUES(NULL,'user02', 'pass02', '�̰���', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL�� ������ �� �� (NOT NULL �������� �����)

INSERT INTO MEM_PRI VALUES(2,'user02', 'pass02', '�̰���', '��', null, null);


CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO,MEM_ID) -- ��� PRIMARY KEY ���� ���� �ο�(����Ű)
);
-- ORA-02260: table can have only one primary key
-- �⺻Ű�� �ϳ��� �ϼ�

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 
VALUES(1,'user01', 'pass01', '�����', '��', null, null);
INSERT INTO MEM_PRI2
VALUES(1,'user02', 'pass02', '�̰���', '��', null, null);
INSERT INTO MEM_PRI2 
VALUES(2,'user02', 'pass02', '�̝���', '��', null, null);
INSERT INTO MEM_PRI2 
VALUES(NULL,'user02', 'pass02', '�̝�����', '��', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷����� ���� NULL�� ������� ����!

-- ����Ű ��� ���� (���ϱ�, ���ƿ�, ����)
-- ���ϱ� : �� ��ǰ�� ������ �ѹ��� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY (MEM_NO, PRODUCT_NAME)
    );
    
SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE); -- �����߻�!! �ѹ��� ���ؾ� ��
INSERT INTO TB_LIKE VALUES(2,'����',SYSDATE);

--------------------------------------------------------------------------------
-- ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10,'�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20,'���ȸ��');
INSERT INTO MEM_GRADE VALUES(30,'��ģȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- ȸ���� ��׹�ȣ�� ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','��ȫ��','��',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','��Ĳ��',NULL,NULL,NULL,10);
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','������','��',NULL,NULL,40);
-- ��ȿ�� ȸ����� ��ȣ�� �ƴԿ��� �ұ��ϰ� �� INSERT ��....

------------------------------------------------------------------------------------
/*
    �� FOREIGN KEY (�ܷ�Ű) ��������
    �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷�
    --> �ٸ� ���̺��� �����Ѵٴ� ǥ��
    --> �ַ� FOREIGN KEY �������ǿ� ���� ���̺��� ���谡 ������!
    
    > �÷��������
    �÷��� �ڷ��� [CONSTRAINT �������Ǹ�]REFERENCES ������ ���̺��[(������ �÷���)] -- ������ �÷��� �Ⱦ��� �ڵ����� �⺻Ű�� ����
    
    > ���̺������
    [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)]
    
    -- > ������ �÷��� ������ ���̺� PRIMARY KEY�� ������ �÷����� �ڵ���Ī
*/
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) -- �÷��������
    -- FOREIGKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','��ȫ��','��',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','��Ĳ��',NULL,NULL,NULL,10);
--INSERT INTO MEM VALUES ( 3, 'USER03','PASS03','������','��',NULL,NULL,40);
-- ORA-02291: integrity constraint (DDL.SYS_C007160) violated - parent key not fou
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','������','��',NULL,NULL,20);
INSERT INTO MEM
VALUES ( 4, 'USER04','PASS04','��ûȲ',NULL,NULL,NULL,10);

-- MEM_GRADE (�θ����̺�) MEM (�ڽ����̺�)
-- �̋� �θ����̺�(MEM_GRADE)���� �����Ͱ��� ������ ��� � ������ �߻��ұ�?
-- ������ ���� : DELETE FROM ���̺�� WHERE ����;

--> MEM_GRADE ���̺��� 10�� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (DDL.SYS_C007160) violated - child record found
--> �ڽ����̺� (MEM)�� 10 �̶�� ���� ����ϰ� �ֱ� ������ ������ �ȵ�!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
--> �ڽ����̺� (MEM)�� 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ �ߵ�!!

--> �ڽ����̺� �̹� ����ϰ� �ִ� ���� �������
--> �θ����̺�κ��� ������ ������ �ȵǰ� �ϴ� "��������"�ɼ��� �ɷ�����!

ROLLBACK; -- Ŀ�������� �������� ����

SELECT * FROM MEM_GRADE;

-----------------------------------------------------------------------------------------------------------
/*
    �ڽ� ���̺� ������ �ܷ�Ű ���������� �ο��� �� �����ɼ� ��������
    * �����ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ����̺� ���� 
             ��� ó���Ұ����� ������ �� �ִ� �ɼ�
    - ON DELETE RESTRICTED (�⺻��) : �������ѿɼ�����, �ڽ� �����ͷ� ���̴� �θ����ʹ� ���� �ȵǰԲ� !
    - ON DELETE SET NULL : �θ����͸� ������ �ش� �����͸� ���� �ִ� �ڽ��������� ���� NULL�� ����
    - ON DELETE CASCADE : �θ����͸� ������ �ش� �����͸� ���� �ִ� �ڽ� �����͵� ���� ������Ŵ
*/

DROP TABLE MEM;

-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL -- �÷��������
    -- FOREIGKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);


INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','��ȫ��','��',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','��Ĳ��',NULL,NULL,NULL,10);
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','������','��',NULL,NULL,20);
INSERT INTO MEM
VALUES ( 4, 'USER04','PASS04','��ûȲ',NULL,NULL,NULL,10);

SELECT * FROM MEM;

COMMIT;

-- 10�� ��� ����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- �� ������!! (��, 10�� �����ִ� �ڽĵ������� ���� NULL�� ����)

ROLLBACK;

-- ON DELETE CASCADE
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- �÷��������
);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

/*
    < DEFAULT �⺻�� > ** �������� �ƴ� **
    �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �⺻���� INSERT�ϰ��� �� �� �����ص� �� �ִ� ��
*/
    
    DROP TABLE MEMBER;
    
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEMBER;

-- INSERT INTO ���̺�� VALUES(��1, ��2,...)

INSERT INTO MEMBER VALUES (1,'��ȫ��',20,'�౸','22/01/01');
INSERT INTO MEMBER VALUES (2, '��Ĳ��', NULL,NULL,NULL);
INSERT INTO MEMBER VALUES (3, '������', NULL,DEFAULT,DEFAULT); -- ���� ������ ����Ʈ������ ���°�..


-- INSERT INTO ���̺��(�÷���, �÷���) VALUES (��1, ��2);
-- NOT NULL�ΰ��� �� �ۼ��ؾ���
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES (4,'�ϭ�Ȳ');
-- ���õ��� ���� �÷� �⺻������ NULL�� ��
-- ��, �ش� �÷��� DEFAULT ���� ���� ��� NULL�� �ƴ� DEFAULT ���� ����.!

--=================================================================================================================

/*
     !!!!!!!!!!!!!!!!! KH ���������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     < SUBQUERY�� �̿��� ���̺� ���� >
     ���̺� ���� �ߴ� ����
     
     [ ǥ���� ]
     CREATE TABLE ���̺��
     AS ��������;
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ����
CREATE TABLE EMPLOYEE_COPY 
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
--> �÷�, �����Ͱ�, �������� ���� ��� NOT NULL�� �����


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
   FROM EMPLOYEE--���̺��� ������ �������� �ʹ�.
   WHERE 1 = 0; -- ������ FALSE�� ���� : �������� �����ϰ��� �� �� ���̴� ���� (������ ���� �ʿ� ���� ��)

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS ������
FROM EMPLOYEE
WHERE 1=1;
-- ORA-00998: must name this expression with a column alias
-- alias : ��Ī
--> �������� SELECT ���� ����� �Ǵ� �Լ��� ����� ��� �ݵ�� ��Ī�� �����ؾߵ�!

SELECT * FROM EMPLOYEE_COPY3;

----------------------------------------------------------------------------------------------------------------
/*
    * ���̺� �� ������ �Ŀ� �ڴʰ� �������� �߰��Ǵ� ���
    
    ALTER TABLE ���̺�� ������ ����
    
    - PRIMARY KEY  : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY  : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���)REFERENCES ���������̺��[(������ �÷���)];
    - UNIQUE       : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK        : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL     : ALTER TABLE ���̺�� MODIFY �÷Ÿ� NOT NULL; ** �ణ Ư����
*/

-- ���������� �̿��ؼ� ������ ���̺� NN �������� ���� ���� �ȵ�!
-- EMPLOYEE_COPY ���̺� PRIMARY KEY �������� �߰�(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

SELECT * FROM EMPLOYEE_COPY;

-- EMPLYEE ���̺� DEPT_CODE�� �ܷ�Ű �������� �߰� (�����ϴ� ���̺�(�θ�) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- �����ϸ� �θ����̺��� PK�� �ڵ� ��Ī��

-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰�
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB ;
-- EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű �������� �߰� (SAL_GRADE)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL)REFERENCES SAL_GRADE;
-- DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű ���� �߰� (LOCATION)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);

SELECT * FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES('S1','�׽�Ʈ��','S1');














































