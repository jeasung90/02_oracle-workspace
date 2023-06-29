/*
    �� �������� ( SUBQUERY )
    - �ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    - ���� SQL���� ���� ���� ��Ȱ�� �ϴ� ������
*/

-- ���� �������� ����1
-- ���ö ����̶� ���� �μ��� ���� ����� ��ȸ�ϰ� ����

-- 1) ���� ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM employee
WHERE EMP_NAME = '���ö'; -- D9

-- 2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM employee
WHERE DEPT_CODE = 'D9';

-- > ���� 2�ܰ踦 �ϳ��� ����������
SELECT EMP_NAME
FROM employee
WHERE DEPT_CODE = 
            (SELECT DEPT_CODE
             FROM employee
             WHERE EMP_NAME = '���ö');

-- ���� �������� ����2
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE   SALARY >= (SELECT AVG(SALARY)
                   FROM employee);

----------------------------------------------------------------------------------
/*
    �� ���������� ����
     �������� ������ ������� ���� ��̳��� ���� �з���
     
     - ������ ��������         : ���������� ��ȸ�� ������� ������ ������ 1���� ��(���� �ѿ�)
     - ������ ��������         : ���������� ��ȸ�� ������� ������ ������ �϶� (������ �ѿ�)
     - ���߿� ��������         : ���������� ��ȸ�� ������� �� �������� �÷��� �������� �� ( ���� ���� �� ) 
     - ������ ���߿� ��������   : ���������� ��ȸ�� ������� ������ �����÷��� �� (������ ������)
     
     >> �������� ������ ���� �տ� �ٴ� �����ڰ� �޶���!!
*/

/*
    1. ������ �������� ( SINGLE ROW SUBQUERY )
    ���������� ��ȸ ������� ������ ������ 1���� �� (���� �ѿ�)
    �Ϲ� �� ������ ��� ����
    =, !=, ^=, <, >, <=, >= ....
*/
-- 1) �� ������ ��ձ޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
-- ������
SELECT EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE salary < ( SELECT AVG(SALARY)
                FROM employee);

-- 2) ���� �޿��� �޴� ����� ���,�̸�,�޿�,�Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE SALARY = (
SELECT MIN(SALARY)
FROM employee);

-- 3) ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ� ,�޿�
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM employee
WHERE SALARY > (
    SELECT SALARY
    FROM employee
    WHERE EMP_NAME = '���ö');


-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY, DEPT_TITLE
FROM employee, department
WHERE (DEPT_CODE = DEPT_ID)
    AND SALARY < (
                    SELECT SALARY
                    FROM employee
                    WHERE EMP_NAME = '���ö');

-->> ANSI ����
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY, DEPT_TITLE
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE SALARY < (
                    SELECT SALARY
                    FROM employee
                    WHERE EMP_NAME = '���ö');

-- 4) �μ��� �޿� ���� ���� ū�μ��� �μ��ڵ�, �޿��� ��
-- 4.1) �μ��� �޿��� �߿����� ū �� �ϳ��� ��ȸ

SELECT  MAX(SUM(SALARY))
FROM employee
GROUP BY DEPT_CODE; -- 17700000

-- 4.2) �μ��� �޿��� ���� 17700000���� �μ� ��ȸ (�μ��ڵ� �޿� ��)
SELECT DEPT_CODE, SUM(SALARY)
FROM employee
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (  SELECT  MAX(SUM(SALARY))
                        FROM employee
                        GROUP BY DEPT_CODE);

-- ���� �غ���

-- 1. ������ ����� ���� �μ������� ���, �����, ����, �Ի���, �μ���
-- ��, �������� ����
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM employee , department
WHERE DEPT_CODE = DEPT_ID 
 AND DEPT_CODE = ( SELECT DEPT_CODE
                   FROM employee
                   WHERE EMP_NAME ='������')
 AND NOT EMP_NAME = '������';
-->> ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM employee 
JOIN department ON (DEPT_CODE = DEPT_ID )
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                   FROM employee
                   WHERE EMP_NAME ='������')
 AND NOT EMP_NAME = '������';
--------------------------------------------------------------------------------------
/*
    2. ������ �������� ( MULTI ROW SUBQUERY )
    ���������� ������ ������� ���� �� �϶� (�÷�(��)DATAPUMP�� �Ѱ�)
    
    
    - IN �������� : �������� ����� �߿��� �Ѵ�� ��ġ�ϴ� ���� �ִٸ�
    
    - > ANY �������� : �������� ����� �߿��� "�Ѱ���" Ŭ ��� (�������� ����� �߿��� ���� ���������� Ŭ ���)
    - < ANY �������� : �������� ����� �߿��� "�Ѱ���" ���� ��� (�������� ����� �߿��� ���� ū������ ���� ���)
    
    �񱳴�� > ANY (��1, ��2, ��3)
    �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
    
    - > ALL �������� : �������� '���' ������麸�� Ŭ ���
    - < ALL �������� : �������� '���' ������麸�� ���� ��� 
    �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3
    
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ �������  ���,�����, �����ڵ�, �޿�
-- 1.1) ����� �Ǵ� ������ ����� ���� ��ȸ

SELECT JOB_CODE
FROM employee 
WHERE EMP_NAME IN ('�����','������'); --J3 J7

-- 1.2) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM employee 
                    WHERE EMP_NAME IN ('�����','������')); -- =�̶�� ���� ������!! ���������� ��ȸ�Ʊ� ����
                        -- ���ǿ� ������� ������ ���� �� ������ �׳� IN���� ���°� ����!

-- ��� => �븮 => ���� => ���� => ����...
-- 2) �븮 �����ӿ��� �������� �޿����� �ּ� �޿����� ���� �޴� ���� ��ȸ (���, �̸� , ����, �޿�)

-- ������ ��������
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, SALARY
FROM employee E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '�븮'
AND SALARY > ( SELECT MIN(SALARY)
                FROM employee E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND J.JOB_NAME = '����');
-- ������ ��������
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, SALARY
FROM employee E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '�븮'
AND SALARY >ANY ( SELECT SALARY
                FROM employee E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND J.JOB_NAME = '����');

-- 3) ���������ӿ��� �ұ��ϰ� ���������� ������� ��� �޿����ٵ� �� ���� �޴� ������� (���, �̸�, ���޸�, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM employee E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL (
                   SELECT SALARY
                   FROM employee E
                   JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
                   WHERE JOB_NAME = '����');

---------------------------------------------------------------------------------------
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �Ի�����)
-- ������ �������� ** 2���� ���������� �ۼ��� ��!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM employee
WHERE DEPT_CODE = ( SELECT DEPT_CODE 
                            FROM employee
                            WHERE EMP_NAME = '������')
AND  JOB_CODE  =( SELECT JOB_CODE
                            FROM employee
                            WHERE EMP_NAME = '������');


SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM employee
WHERE (DEPT_CODE, JOB_CODE ) = (SELECT DEPT_CODE, JOB_CODE
                            FROM employee
                            WHERE EMP_NAME = '������');


-- �ڳ��� ����� ���� �����ڵ� ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������
SELECT EMP_ID,EMP_NAME, DEPT_CODE, MANAGER_ID
FROM employee
WHERE (DEPT_CODE, MANAGER_ID) = ( SELECT DEPT_CODE, MANAGER_ID
                                  FROM employee
                                  WHERE EMP_NAME='�ڳ���');

------------------------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ������ ������ �� ���
*/

-- 1)  �� ���޺��� �ְ�޿��� �޴� ��� ��ȸ (���, �����, �����ڵ�,�޿�)
-->> �� ���޺� �ּ� �޿� ��ȸ
SELECT job_code, MIN(SALARY)
FROM employee
GROUP BY job_code;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE (job_code ,SALARY )IN(SELECT job_code, MIN(SALARY)
                         FROM employee
                         GROUP BY job_code) ;
                         
-- 2) �� �μ����� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE (DEPT_CODE, SALARY) IN ( SELECT DEPT_CODE, MAX(SALARY)
                                FROM employee
                                GROUP BY DEPT_CODE);
---------------------------------------------------------------------------------
/*
    5. �ζ��� �� ( INLINE - VIEW )
    
    ���������� ������ ����� ��ġ ���̺� ó�� ���!
*/

-- ������� ���, �̸�, ���ʽ����Կ���(��Ī : ����) , �μ��ڵ� => ���ʽ� ���� ������ NULL �ȳ�����
-- ��, ���ʽ� ���� ������ 3000�� �̻��� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS ���� , DEPT_CODE
FROM employee
WHERE (SALARY + SALARY * NVL(BONUS,'0'))*12  > 30000000;
-- �̰� ��ġ �����ϴ� ���̺��ΰ� ���� ����� �� ���� !! �װ� �ζ��κ�

SELECT * /* ��ȸ�� ���뿡 ���ؼ��� �� �� �ְ� ��ȸ���� ���� employee �ȿ� �ִ°� ������ */
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS ���� , DEPT_CODE
FROM employee
WHERE (SALARY + SALARY * NVL(BONUS,'0'))*12  > 30000000)
WHERE ���� >= 3000000;


-->> �ζ��� �並 �ַ� ����ϴ� �� => TOP-N �м� (���� ��� �����ְ� ���� �� => BEST ��ǰ)

-- �� ���� �� �޿��� ���� ���� ���� 5��� ��ȸ
-- * ROWNUM : ����Ŭ �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC;
-- FROM -> SELECT ROWNUM (�� �� ������ �ο���. ���ĵ� �ϱ����� �̹� ���� �ο�)
-- ���� �� �̻���... ������� ����..

SELECT  EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC;


SELECT ROWNUM,EMP_NAME, SALARY
FROM (SELECT  EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC)
WHERE ROWNUM <=5;         
-- ORDER BY ���� �� ����� ����� ������ ROWNUM �ο� �� �߷�����!!

-- ROWNUM �̶� ��ü�÷� ��ȸ�ϰ� ���� => ��Ī �ο��ϴ� �������
SELECT ROWNUM,E.*
FROM (SELECT *-- EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC) E
WHERE ROWNUM <=5;    


--------------------------------------------------------------------------
-- 1. ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����,�޿�,�Ի���)
SELECT ROWNUM,EMP_NAME, SALARY, HIRE_DATE
FROM(
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <=5;  

-- 2. �� �μ��� ��ձ޿��� ���� ���� 3���μ� ��ȸ (�μ��ڵ�, ��ձ޿�)
SELECT ROWNUM,DEPT_CODE, ���
FROM(
        SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS ���
        FROM employee
        GROUP BY DEPT_CODE
        ORDER BY FLOOR(AVG(SALARY)) DESC
)
WHERE ROWNUM <=3; 

-------------------------------------------------------------------------------------
/*
    �� ���� �ű�� �Լ� ( WINDOW FUNCTION )
    RANK() OVER(���ı���)               |           DENSE_RANK() OVER(���ı���)
    
    - RANK() OVRT(ORDER BY �÷�) : ������ ���� ������ ����� �������ο��� ��ŭ �ǳʶٰ� ���� ���
                        EX) ���� 1���� 2�� �� ���� ���� 3 �� => 1,1,3
    - DENSE_RANK() OVER(ORDER BY �÷�) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ                    
                        EX) ���� 1���� 2���̴��� �� ���� ������ 2�� => 1,2,3\
    => ������ SELECT �������� �����
*/
SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS ����
FROM employee;
-- ���� 19���� 2�� �� ���� ������ 21 => ������ ������ ��ȸ�� �� ���� ����
SELECT EMP_NAME, SALARY,   DENSE_RANK() OVER(ORDER BY SALARY DESC)AS ����
FROM employee;
-- ���� 19�� 2�� �� ���� ������ 20 => ������ ������ ��ȸ�� �� ���� �ٸ� �� ����

-- ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS ����
FROM employee
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5;


-- �ζ��� �並 �� �� �ۿ� ����
SELECT EMP_NAME, SALARY,   ����
FROM (
        SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS ����
        FROM employee
)
where ���� <=5;

















