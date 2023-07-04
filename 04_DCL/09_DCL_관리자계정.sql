/*
    < DCL : DATE CONTROL LANGUAGE >
    ������ ���� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ���� ȸ��(REVOKE)�ϴ� ����
    
    > �ý��� ����
        : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    > ��ü���� ����
        : Ư�� ��ü���� ������ �� �ִ� ����
*/

/*
    * �ý��� ���� ����
    - CREATE SESSION  : ���� �� �� �ִ� ����
    - CREATE TABLE    : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW     : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : �������� ������ �� �ִ� ����
    ----------        : �Ϻδ� Ŀ��Ʈ �ȿ� ���ԵǾ� ����
*/

-- 1. SAMPLE / SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- ����: ���� -�׽�Ʈ ����: ORA-01017: invalid username/password; logon denied

--�ý��� ���� 2. ������ ���� CREAT SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;
GRANT CONNECT TO SAMPLE; -- �Ѵ� �Ȱ��� ������ �� �ְ� ���ִ� ���� �ο�

--�ý��� ���� 3.1) ���̺��� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

--�ý��� ���� 3.2) TABLESAPACE �Ҵ� ( SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

--------------------------------------------------------------------------------------
/*
    * ��ü���� ����
    
    Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
    
    ��������    Ư�� ��ü
    SELECT  TABLE, VIEW, SEQUENCE
    INSERT  TABLE, VIEW
    UPDATE  TABLE, VIEW
    DELETE  TABLE, VIEW
    .....
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ����
    
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE; -- �̴��ı�

/*
    < �� ROLE >
    - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT  : ���� �� �� �ִ� ����  CREATE SESSION
    RESOURCE : Ư�� ��ü���� ������ �� �ִ� ���� CREATE TABLE, CREATE SEQUENCE...
    
*/ 

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNEC T','RESOURCE')
ORDER BY 1;
