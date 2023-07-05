/*
    < ������ : SEQUENCE >
    �ڵ����� ��ȣ�� �߻������ִ� ��Ȱ�� �ϴ� ��ü
    �������� ���������� �������� ������Ű�鼭 �������� (�⺻�����δ� 1�� ����)
    
    EX) ȸ����ȣ, �����ȣ, �Խñ۹�ȣ �� ���� ���ļ��� �ȵǴ� �����͵�...
*/

/*
    1. ������ ��ü ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    
    [�� ǥ����]
    CREATE SEQUENCE ��������
    [START WITH ���ۼ���]     -- ó�� �߻���Ű�� ���۰� ���� (�⺻�� 1)
    [INCREMENT BY ����]      -- � ������ų���� (�⺻�� 1)
    [MAXVALUE ����]          -- �ִ밪 ���� (�⺻�� �̳�ŭ...)
    [MINVALUE ����]          -- �ּҰ� ���� (�⺻�� 1)
    [CYCLE | NOCYCLE]        -- �� ��ȯ ���� ���� (�⺻�� NOCYCLE) => �ִ밪�� ��� ó������ �ٽ� ���ƿͼ� ������ �� �ְ���
    [NOCASHE | CASHE ����Ʈũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
    
     * ĳ�ø޸� : �ӽð���
                �̸� �߻��� ������ �����ؼ� �����صδ� ����
                �Ź� ȣ��� ������ ������ ��ȣ�� �����ϴ°� �ƴ϶�
                ĳ�� �޸� ������ �̸� ������ ������ ������ �� �� ���� (�ӵ��� ������)
                ������ �����Ǹ� => ĳ�� �޸𸮿� �̸� ������ ��ȣ���� �� ����
                ��ȣ�� �����ϰ� �ο� �ȵ� �� ������ Ȯ���� �� �ؾ���!!

    ���̺�� : TB_
    ���     : VW_
    ������   : SEQ_
    Ʈ����   : TRG_
*/

CREATE SEQUENCE SEQ_TEST;

-- [����] ���� ������ �����ϰ� �ִ� ���������� ������ ������ �� ��
SELECT *FROM USER_SEQUENCES;

-- ��ǥ����
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ���
    ��������.CURRVAL : ���� ������ �� (���������� ����������  ����� NEXTVAL�� ��)
    ��������.NEXTVAL : ���������� �������� �������Ѽ� �߻��� ��
                      ���� ������ ������ INCREMENT BY �� ��ŭ ������ ��
                      == ��������.CURRVAL + INCREMENT BY
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- *Action:   select NEXTVAL from the sequence before selecting CURRVAL

-- NEXTVAL�� �� �ѹ��� �������� �ʴ� �̻� CURRVAL �� �� ����!!
-- ��? ���������� ���������� ����� NEXTVAL ���̱� �빮!!

-- SELECT ������ ġ������!!

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300 : ���������� ������ NEXTVAL�� ��

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

SELECT * FROM user_sequences;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ������ MAXVALUE�� �ʰ��߱� ������ ���� �߻�! (����!)
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

/*
    3. ������ ���� ����
    
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]      -- � ������ų���� (�⺻�� 1)
    [MAXVALUE ����]          -- �ִ밪 ���� (�⺻�� �̳�ŭ...)
    [MINVALUE ����]          -- �ּҰ� ���� (�⺻�� 1)
    [CYCLE | NOCYCLE]        -- �� ��ȯ ���� ���� (�⺻�� NOCYCLE) => �ִ밪�� ��� ó������ �ٽ� ���ƿͼ� ������ �� �ְ���
    [NOCASHE | CASHE ����Ʈũ��] -- ĳ�ø޸� �Ҵ� (�⺻�� CACHE 20)
    
    ** START WITH�� ���� �Ұ�!!
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310+10 => 320

-- ������ ����
DROP SEQUENCE SEQ_EMPNO; 

--------------------------------------------------------------------------------
-- �����ȣ�� Ȱ���� ������ ����
CREATE SEQUENCE SEQ_EMPID
START WITH 400
NOCACHE;
DROP SEQUENCE SEQ_EMPID;
DELETE employee
WHERE EMP_ID = 402;

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
          seq_empid.nextval
        , 'ȫ�浿'
        , '111111-1111111'
        , 'J7'
        , 'S1'
        , SYSDATE
        );

SELECT * FROM EMPLOYEE;

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
          seq_empid.nextval
        , '����'
        , '940605-2145679'
        , 'J7'
        , 'S1'
        , SYSDATE
        );

















































