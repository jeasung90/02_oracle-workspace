CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(30)
);
-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�!
-- 3.1) CREATE TABLE ���� �ޱ�
-- 3.2) TABLESPACE �Ҵ� �ޱ�

SELECT * FROM test;
INSERT INTO TEST VALUES(10,'�ٺ�');
-- CREATE TABLE ���� ������ �ٷ� ���� ����

------------------------------------------------------------
-- KH������ �ִ� EMPLOYEE ���̺� ����
-- �ٵ� ��ȸ�� �� �ִ� ������ ��� �ȵ�..

-- 4. SELECT ON KH.EMPLOYEE ���� �ο� ����
SELECT * FROM KH.EMPLOYEE;

-- 5. INSERT ON KN.DEPARTMENT ���� �ο� ����
INSERT INTO KH.DEPARTMENT 
VALUES('D0','ȸ���','L1');
SELECT * FROM KH.DEPARTMENT;

















