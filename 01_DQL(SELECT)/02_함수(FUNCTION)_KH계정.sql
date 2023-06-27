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

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7)FROM DUAL;

/*
    2. MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    MOD(NUM,NUM) => ������� NUMBER Ÿ��
*/

SELECT MOD(10,3)FROM DUAL;
SELECT MOD(10.9,3)FROM DUAL;

/*
    3. ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUM , [��ġ]) => ����� NUMBUR
    
*/

SELECT ROUND(123.456)FROM DUAL;-- ��ġ ������ 0��° �ڸ�����
SELECT ROUND(123.456,1)FROM DUAL;
SELECT ROUND(123.456,5)FROM DUAL; -- �״�� ����
SELECT ROUND(123.456,-1)FROM DUAL;
SELECT ROUND(123.456,-2)FROM DUAL;

/*
    4. CEIL(NUM)
    �ø�ó�� ���ִ� �Լ�
*/
SELECT CEIL(123.125)FROM DUAL; -- 5�̻� �ƴϾ �׳ɿø�!! ��ġ���� �Ұ�

/*
    5. FLOOR
    �Ҽ��� �Ʒ� ����ó���ϴ� �Լ�
    
    FLOOR(NUM)
*/
SELECT FLOOR(123.152)FROM DUAL;-- ������ ���� ��ġ���� �Ұ�����!
--------------------------------------------------------------------------------
/*
    6. TRUNC (�����ϴ�)
    ��ġ ���� ������ ����ó�� ���ִ� �Լ�
*/
SELECT TRUNC(123.346)FROM DUAL; -- ��ġ���� ���ϸ� FLOOR�̶� ������
SELECT TRUNC(123.346,1)FROM DUAL;-- �Ҽ��� �Ʒ� ù° �ڸ����� ǥ���ϰ� �ʹ�

------------------------------------------------------------------------------------
/*
    < ��¥ ó�� �Լ� >
*/

-- �� SYSDATE : �ý��� ���� �� �ð� ��ȯ
SELECT SYSDATE FROM DUAL;
-- �� MONTHS_BETWEEN (DATE1,DATE2) : �� ��¥ ������ ���� �� ���������� DATE1 - DATE2 �� ������ 30,31�� ����ɰ���
-- => ������� NUMBER Ÿ��
-- EMPLOYEE ���� ������� �Ի���, �ٹ��ϼ�, �ٹ�������
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE -- �����ϳ� ��������
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,FLOOR( SYSDATE - HIRE_DATE ) || '��' AS "�ٹ��ϼ�"
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,FLOOR( SYSDATE - HIRE_DATE ) || '��' AS "�ٹ��ϼ�",
 FLOOR(MONTHS_BETWEEN( SYSDATE , HIRE_DATE ) ) ||'����' AS "�ٹ�������"
FROM EMPLOYEE;

-- �� ADD_MONTHS(DATE,NUM) : Ư�� ��¥���� �ش� ���ڸ�ŭ �������� ���ؼ� ��¥����
--=> ����� DATE Ÿ��
SELECT ADD_MONTHS(SYSDATE,6)FROM DUAL;

-- �����, �Ի���, �Ի� �� 6���� �� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE , 6 ) AS "����������"
FROM EMPLOYEE;

-- �� ENXT_DAY(DATE,����): Ư����¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
--=> ����� DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE,'�ݿ���')FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��')FROM DUAL;
-- 1.�Ͽ���, 2. ������ ........
SELECT SYSDATE, NEXT_DAY(SYSDATE,7)FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY')FROM DUAL; -- ���� �� KOREAN �̱� ������ ���˾� ����

-- ����

SELECT * FROM NLS_SESSION_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- �� LAST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
--=> ����� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- �����, �Ի���, �Ի��Ѵ��� ��������¥, �Ի��� ���� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    �� EXTRACT : Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    EXTRACT(YEAR FORM DATE)     : �⵵�� ����
    EXTRACT(MONTH FORM DATE)    : �޸� ����
    EXTRACT(DAY FORM DATE)      : �ϸ� ����
    => ������� NUMBER Ÿ��
*/

-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ

SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵","�Ի��","�Ի���";

/*
    < ����ȯ �Լ� >
    
    �� TO_CHAR : ����Ÿ�� �Ǵ� ��¥Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_CHAR(����|��¥,[����]) => ������� CHARACTER Ÿ��
    
*/
-- ����Ÿ�� -> ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL; -- ���� '1234'�� �ٲ�
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ¥���� ���� Ȯ��, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234,'00000') FROM DUAL;
SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- ���� ������ ����(LOCAL)�� ȭ������� ���
SELECT TO_CHAR(1234,'$99999') FROM DUAL;

SELECT TO_CHAR(1234,'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')
FROM EMPLOYEE;

-- ��¥ Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- Ŭ���غ��� �ٸ� 
SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON,YYYY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YY-MM-DD')
FROM EMPLOYEE;

-- EX) 1990�� 2�� 6�� �������� 
SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YY"��"MM"��"DD"��"')AS "�Ի糯¥" -- ���� ���� �����ҋ��� ""�� ����
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE,'YYYY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'RRRR')FROM DUAL; -- 50��� ���Ĵ� 1900���� ǥ��
SELECT TO_CHAR(SYSDATE,'RR')FROM DUAL;

-- ���� ���õ� ����
SELECT
TO_CHAR(SYSDATE,'MM'),
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE,'MONTH'),
TO_CHAR(SYSDATE,'RM')
FROM DUAL;

-- �ϰ� ���õ� ����
SELECT
TO_CHAR(SYSDATE,'DDDD'), -- ���� �������� ������ ��ĥ°����
TO_CHAR(SYSDATE,'DD'),   -- �� �������� ������ ��ĥ°����
TO_CHAR(SYSDATE,'D'),    -- �� �������� ������ ��ĥ°����
FROM DUAL;

-- ���ϰ� ���õ� ����
SELECT
TO_CHAR(SYSDATE,'DAY'), -- ������
TO_CHAR(SYSDATE,'DY'),  -- ��
FROM DUAL;


--------------------------------------------------------------

/*
    �� TO_DATE
    
    TO_DATE(����|����, [����])
*/
SELECT TO_DATE(20100101)FROM DUAL;
SELECT TO_DATE(100101)FROM DUAL;

SELECT TO_DATE(070101)FROM DUAL;--����
SELECT TO_DATE('070101')FROM DUAL; -- ����Ÿ���� ù��¥�� ��� ����Ÿ������ �����ؾ���

SELECT TO_DATE('041030 143000','YYMMDD HH24MISS')FROM DUAL;

SELECT TO_DATE('140630','YYMMDD')FROM DUAL; -- 2098 => ������ ���缼��� �ݿ� ������ 20����
SELECT TO_DATE('980630','RRMMDD')FROM DUAL; -- 1998�� ����
-- RR: �ش� ���ڸ� �⵵ ���� 50�̸��� ��� ���� ����ݿ�, 50�̻��� ��� �������� �ݿ�

/*
    �� TO_NUMBUR : ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_NUMBER(����,[����]) => NUMBER��
*/

SELECT TO_NUMBER('0512456')FROM DUAL;  -- 0�� ������ ����Ÿ������ ��ȯ ����

SELECT '100000'+'5500' FROM DUAL; -- ����Ŭ������ �ڵ�����ȯ �� ������

SELECT '100,000'+'5,500' FROM DUAL; -- ������!! ���ڸ� �־�� �ڵ�����ȯ ��!
SELECT TO_NUMBER('10,000,000','99,999,999')+ TO_NUMBER('55,000','99,999')FROM DUAL; -

/*
    < NULL ó�� �Լ� )
*/
-- NVL(�÷�, �ش� �÷��� NULL�� ��� ��ȯ�� ��)
SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

-- �� ����� �̸� ���ʽ� ���� ����
SELECT EMP_NAME,( SALARY + SALARY * NVL(BONUS,0))*12
FROM EMPLOYEE;

SELECT DEPT_CODE, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

-- NVL2(�÷� ,��ȯ��1, ��ȯ��2)
-- �÷����� �����Ұ�� ��ȯ�� 1 ��ȯ 
-- �÷����� NULL�� ��� ��ȯ�� 2 ��ȯ

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7,0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

-- NULLIF(�񱳴��1,�񱳴��2)
-- �ΰ��� ���� ��ġ�ϸ� NULL ��ȯ
-- �ΰ��� ���� ��ġ���� ������ ����� 1 ��ȯ
SELECT NULLIF('123','123')FROM DUAL;
SELECT NULLIF('123','456')FROM DUAL;

/*
    < ���� �Լ� >
    
    �� DECODE(���ϰ��� �ϴ� ���(�÷�|�������|�Լ���)
*/
-- ���, �����, �ֹι�ȣ
SELECT EMP_ID,EMP_NAME,EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS ����
FROM EMPLOYEE;

-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿� 10%�λ� (SALART * 1.1)
-- J6�� ����� �޿� 15%�λ� (SALART * 1.15)
-- J5�� ����� �޿� 20%�λ� (SALART * 1.2)
-- �׿��� ����� �޿� 5%�λ� (SALART * 1.05)

-- �����, �����ڵ�, �����޿�, �λ�ȱ޿�
SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY *1.1,
                     'J6', SALARY *1.15,
                     'J5', SALARY *1.2,
                      SALARY *1.05) AS "�λ�ȱ޿�"
FROM EMPLOYEE;

/*
    �� CASE WHEN THEN
    
    CASE WHEN ���ǽ� 1 THEN ����� 1
         WHEN ���ǽ� 2 THEN ����� 2
         .....
         ELSE ����� N
    END
    
    �ڹٿ��� IF - ELSE IF - ELSE ��
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '��ް�����'
         WHEN SALARY >= 3500000 THEN '�ʱް�����'
         ELSE '�ʱ�'
         END AS "����"
FROM EMPLOYEE;

-----------------------< �׷��Լ� >----------------------------
-- 1. SUM(����Ÿ���÷�) : �ش� �÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�

-- ������� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE; -- ��ü����� �� �׷����� ����

-- ���� ������� �� �޿�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1','3');

-- �μ��ڵ尡 D5�� ������� �� ������ ��
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(����Ÿ��) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(����Ÿ��) : �ش� �÷����� �߿� ���� ���� �� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME), MIN(SALARY),MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(����Ÿ��) : �ش� �÷����� �߿� ���� ū���� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY),MAX(HIRE_DATE)-- , EMP_NAME
FROM EMPLOYEE;

-- 5. COUNT (*|�÷�|DISTINCT�÷�) : ��ȸ�� �� ������ ���� ��ȯ
--    COUNT(*) : ��ȸ�� ����� ��� �� ������ ���� ��ȯ
--    COUNT(�÷�): ������ �ش� �÷����� NULL�ƴѰ͸� ����
--    COUNT(DISTINCT�÷�) : �ش� �÷��� �ߺ��� ���� �� �� �� �Լ� ���� ��ȯ

SELECT COUNT(*)
FROM EMPLOYEE;

-- ���ڻ�� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)IN('2','4');

SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- �μ���ġ ���� ���
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ���� ������� ��� �μ��� �����Ǿ� �ִ���
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




