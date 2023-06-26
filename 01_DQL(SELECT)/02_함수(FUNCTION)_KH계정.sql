-- �����ϱ�
/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о����� �Լ��� ������ ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ����(�� �� ���� �Լ� ���� ��� �ݺ�)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� ������ �Լ�, �׷� �Լ� ���� ��� ����!!
    ��? ��� ���� ������ �ٸ��� ����

    >> �Լ����� ��� �� �� �ִ� ��ġ : SELCET��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
 
*/

/*
    < ���� ó�� �Լ� >
    
    ��LENGTH / LENGTHB   => ����� NUMBERŸ��
    
    LENGTH(�÷�|'���ڿ���')  : �ش� ���ڿ� ���� ���� �� ��ȯ
    LENGTHB(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��', '��', '��'  �� ���ڴ� 3BYTE
    ������, ���� Ư��  �� ���ڴ� 1BYTE
*/

SELECT SYSDATE
FROM DUAL; -- �������̺�! ���̺� �� �� ������ ���°�!

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
    EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM employee; -- ���ึ�� �� ����ǰ� ���� ! -> ������ �Լ�


/*
    < INSTR > 
    Ư�� ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�','ã�����ϴ� ����', ['ã����ġ ���۰�',[����]]) => ������� NUMBER Ÿ��!!
    - ��ġ ã����
    ã����ġ�� ���۰�
    1  : �տ������� ã�ڴ�.
    -1 : �ڿ������� ã�ڴ�.
*/

SELECT INSTR('AABAACAABBAA','B')FROM DUAL; -- ã�� ��ġ�� ���۰��� 1 �⺻�� => �տ�����Ÿ ã��, ������ 1 �⺻��
SELECT INSTR('AABAACAABBAA','B',1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1)FROM DUAL;
-- 2��° �ִ� 'B'�� ã�� ���
SELECT INSTR('AABAACAABBAA','B',1,2)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1,3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'_',1,1) AS "_��ġ", INSTR(EMAIL,'@') AS "@��ġ"
FROM employee; 

-- INSTR ���ึ�� ���� ������ ������ �Լ�

---------------------------------------------------------------------------------

/*
    < SUBSTR >
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� subtring() �޼ҵ�� ����)
    
    3) => ������� CHARACTER Ÿ��
    - STRING    : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION  : ���ڿ��� ������ ���� ��ġ��
    - LENGTH    : ������ ���� ���� (������ ������ �ǹ�)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',-8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1)AS "����"
FROM employee;

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM employee
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

-- ���� ����� ��ȸ
SELECT EMP_NAME
FROM employee
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3') -- �ֹι�ȣ���� XXXXXX - ���� '-'�� ���ڿ� �ƴ� �׷��� ���������� �ڵ� ����ȯ �Ź���
ORDER BY 1; -- �⺻������ ���������̴�

-- �Լ� ��ø���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL ,'@')-1)AS "���̵�"
FROM employee;

--------------------------------------------------------------------------------------------------------------

/*
    �� LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD / RPAD ( STRING, ���������� ��ȯ�� ������ ����, [�Ժ��̰��� �ϴ� ����])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���� ��ū�� ���ڿ��� ��ȯ
*/

SELECT EMP_NAME, RPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻���� ����
FROM employee;


SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM employee;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM employee;

SELECT RPAD('850101-2',14,'*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM employee;

SELECT EMP_NAME ,SUBSTR(EMP_NO,1,8)||'******'
FROM employee;

----------------------------------------------------------------------
/*
    LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM / RTRIM (STRING,['�����ҹ��ڵ�']=> �����ϸ� ��������
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('                  ��   �� ')FROM DUAL; --���ʿ������� ������ ã�� �����ϰ� ����ƴ� ���ڰ� ������ ����
SELECT LTRIM('123123KH123','123')FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC')FROM DUAL; -- �ѱ��ھ� ���ؼ� ���� ������ �������

SELECT RTRIM('5782KH123','1234567890')FROM DUAL;
SELECT RTRIM(LTRIM('5782KH123','1234567890'),'1234567890')FROM DUAL;

/*
    �� TRIM
    ���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    TRIM([LEADING, TRAILING, BOTH] �����ϰ��� �ϴ� ���ڵ� FROM] STRING)
    
*/

-- �⺻�����δ� ���ʿ� �ִ� ���ڵ� �� ã�Ƽ� ����
SELECT TRIM('          K  H       ')FROM DUAL; - �հ����� ���� ����
SELECT TRIM('Z'FROM'ZZZZZZZZKZZZZHZZZ')FROM DUAL;

--SELECT TRIM('ZZZZZZZZKZZZZHZZZ','Z')FROM DUAL; -- �ȵ�
SELECT TRIM(LEADING'Z'FROM'ZZZZKHZZZZZ')FROM DUAL; -- LEADING : �� => LTRIM�� ����
SELECT TRIM(TRAILING 'Z'FROM'ZZZZKHZZZZ')FROM DUAL; -- TRAILING : �� => RTRIM�� ����
SELECT TRIM(BOTH 'Z'FROM'ZZZZKHZZZZ')FROM DUAL;-- BOTH : ���� => ������ �⺻��

/*
    �� LOWER / UPPER / INITCAP
    
     LOWER / UPPER / INITCAP (STRIN) => ������� CHARACTER Ÿ��
    
    LOWER   : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ(�ڹٿ����� toLowercast() �޼ҵ�� ����)
    UPPER   : �� �빮�ڷ� ������ ���ڿ� ��ȯ(�ڹٿ����� toUpercast() �޼ҵ�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
    
*/

SELECT LOWER('Wellcome to my world')from dual;
SELECT upPER('Wellcome to my world')from dual;
SELECT INITCAP('Wellcome to my world')from dual;

-------------------------------------------------------------------------------------
/*
    �� CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING) => ����� CHARACTER Ÿ��
    
*/

SELECT CONCAT('ABC','���ݸ�') FROM DUAL;
SELECT 'ABC'||'���ݸ�' FROM DUAL; 

-- SELECT CONCAT('ABC','���ݸ�','123') FROM DUAL; - �ȵ� ���� �߻� 2���ʰ��� �����ڸ� ���� �� ����
SELECT 'ABC'||'���ݸ�'||'123' FROM DUAL;

-------------------------------------------------------------

/*
    �� REPLACE
    
    REPLACE (STRING , �ٲ���, �ٲ۹��� ) => �������  CHARACTER

*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
    < ���� ó�� �Լ� >
    
    1. ABS
        ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBUR) => ����� NUMBUR Ÿ��
    
*/

SE











