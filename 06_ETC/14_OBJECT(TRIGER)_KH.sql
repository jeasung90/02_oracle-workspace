/*
    < Ʈ���� TRIGER >
    
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� ���ص� �� �ִ� ��ü
    
    EX)
    ȸ��Ż��� ������ ȸ�����̺� �����͸� DELETE �� ��ٷ� Ż���� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���ؾߵȴ�!
    �Ű�Ƚ���� ������ ���� �Ѿ����� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� ������ �ش� ��ǰ�� ���� ������ �Ź� ����(UPDATE)�ؾ� �� ��
    
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
        > BEFORE TRIGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
        > AFTER TRIGER  : ���� ������ ���̺� �̺�Ƽ�� ����� �Ŀ� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
        > STATEMENT TRIGER(����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
        > ROW TRIGER(�� Ʈ����) : �ش� SQL���� ������ �� ���� �Ź� Ʈ���� ����
                                (FOR EACH ROW �ɼ� ����ؾߵ�)
                > : OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE (������ �ڷ�)
                > : NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)
                
    [ǥ����]
    CREATE [OR REPLACE] TRIGER Ʈ���Ÿ�
    (BEFORE | AFTER) (INSERT | UPDATE | DELETE)  ON ���̺��
    [FOR EACH ROW]
    �ڵ����� ������ ����;
     �� [DECLARE
            ��������]
        BEGIN
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ����������(�ڵ�����) ������ ����)
        [EXCEPTION
            ����ó������;]
        END;
        /
*/

-- EMP���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ��µǴ� Ʈ����
CREATE OR REPLACE TRIGGER TRG_01
BEFORE INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.put_line('���Ի���� ȯ���մϴ�!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
    VALUES(500, '������','830101-2222222','D7','J7','S2',SYSDATE);
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
    VALUES(501, '����','940101-2222222','D7','J7','S2',SYSDATE);

SELECT * FROM EMPLOYEE;
-----------------------------------------------------------------------------------------

-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� ������ ����

-- 1.1 ��ǰ�� ���� ����Ʈ�� ������ ���̺� (TB_RPODUCT)

CREATE TABLE  TB_PROUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(40) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER NOT NULL,
    STOCK NUMBER DEFAULT 0
);

SELECT * FROM tb_prouct;

-- 1.2 ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ �߻�Ű�ô� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 1.3 ���� ������ �߰�
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, 'Ȩ����', '����', 1400,500);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, 'S23', '�Ｚ', 1400000,DEFAULT);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, '���̻�15�ڷ�', '�ֻ�', 1800000,10);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, '�ѷ���', '����', 1400000,20);

-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ�������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODEATIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PROUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���'))
);
    
SELECT * FROM tb_prodeatil;

-- �̷¹�ȣ�� �Ź� ���ο� ��ȣ �߻����Ѽ� �� �� �ְ� �����ִ� ������ ( SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� �԰�
INSERT INTO tb_prodeatil VALUES(seq_dcode.nextval,200,SYSDATE,10,'�԰�');

-- 200�� ��ǰ�� �������� 10 ����
UPDATE tb_prouct
SET STOCK = STOCK +10
WHERE PCODE = 200;

-- 210�� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO tb_prodeatil
VALUES (seq_dcode.nextval, 210,SYSDATE,5,'���');

-- 210����ǰ�� ������ 5 ����
UPDATE tb_prouct
SET STOCK = STOCK -5 
WHERE PCODE= 210;

-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�

INSERT INTO tb_prodeatil
VALUES (seq_dcode.nextval, 205,SYSDATE,20,'�԰�');

-- 205�� ��ǰ�� �������� 20 ����
UPDATE tb_prouct
SET STOCK = STOCK +20
WHERE PCODE= 205; -- �߸�����...

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� ����
/*
    -- ��ǰ�� �԰�� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PROUCT
    SET STOCK = STOCK + �����԰�� ����(INSERT ����  �ڷ��� AMOUNT ��)
    WHERE PCODE = �԰�� ��ǰ ��ȣ(INSERT���� �ڷ��� PCODE��)
    
    -- ��ǰ�� ���� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PROUCT
    SET STOCK = STOCK - �������� ����(INSERT ����  �ڷ��� AMOUNT ��)
    WHERE PCODE = ���� ��ǰ ��ȣ(INSERT���� �ڷ��� PCODE��)
*/

-- :NEW �����

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON tb_prodeatil
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� = ������ ����
    IF (:NEW.STATUS = '�԰�') 
        THEN 
            UPDATE tb_prouct 
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
            DBMS_OUTPUT.put_line('���������� �԰�ó���Ǿ����ϴ�.');

    END IF;
    
    -- ��ǰ�� ���� ��� => ������ ����
    IF (:NEW.STATUS = '���') 
        THEN 
            UPDATE tb_prouct 
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
            DBMS_OUTPUT.put_line('���������� ���ó���Ǿ����ϴ�.');
    END IF;
END;
/
-- 210�� ��ǰ�� ���ó�¥�� 7�� ���
INSERT INTO tb_prodeatil
VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,7,'���');

--200�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO tb_prodeatil
VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,100,'�԰�');