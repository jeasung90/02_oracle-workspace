SELECT * FROM employee;

SELECT * FROM employee
WHERE EMP_NAME = '������';
SELECT * FROM department 
WHERE DEPT_ID='D9'; --L1
SELECT * FROM location
WHERE LOCAL_CODE = 'L1'; --KO
SELECT * FROM national
WHERE national_code = 'KO'; -- D9

/*
    < JOIN > �ڡڡ�
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽��� �ּ����� �����ͷΰ������� ���̺� �����͸� ��� ���� (�ߺ��� �ּ�ȭ�ϱ� ���� �ִ��� �ɰ��� ������)
    
    -- � ����� � �μ��� �����ִ��� ������!
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ���
        ( ������ �� ��ȸ�� �ؿ��°� �ƴ϶� �� ���̺� ������ν��� �����͸� ��Ī�ؼ� ��ȸ ���Ѿ���!!)
        
            JOIN ũ�� "����Ŭ ���뱸��"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ)=> �ƽ�Ű�ڵ�ǥ ����� ��ü
                                (JOIN ��� ����)
                ����Ŭ ���뱸��                           ANSI����
            --------------------------------------------------------
                   �����            |     ���� ����( [INNER] JOIN ) => JOIN USING/ ON
                ( EQUAL JOIN )          |    �ڿ� ����( NATURAL JOIN ) => JOIN USING
            --------------------------------------------------------------------------
                   ��������             |     ���� �ܺ����� ( LEFT OUTER JOIN )
                ( LEFT OUTER )           |    ������ �ܺ����� ( RIGHT OUTER JOIN )
               ( RIGHT OUTER )           |    ��ü �ܺ����� ( FULL OUTER JOIN )
            ----------------------------------------------------------------------------
                ��ü����( SELF JOIN)       |    JOIN ON
         (�߾Ⱦ�) �� ����( NON EQUAL JOIN) |  
         -----------------------------------------------------------------------------       
  
*/


SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM employee;

SELECT DEPT_ID, DEPT_TITLE
FROM department;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ �ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM employee;

SELECT JOB_CODE ,JOB_NAME 
FROM JOB;

/*
    1. ����� ( EQUAL JOIN ) / �������� ( INNER JOIN )
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ( == ��ġ�ϴ� ���� ���� ���� ��ȸ���� ����)
*/

-->> ����Ŭ ���� ����
--  FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (, �����ڷ�)
--  WHERE ���� ��Ī��ų �÷�(�����)�� ���� ������ ������

-- 1) ������ �� �÷����� �ٸ� ��� ( EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID )
-- ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_CODE, DEPT_TITLE
FROM employee, department
WHERE DEPT_CODE = DEPT_ID;
-- ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ��
-- DEPT_CODE �� NULL �� ��� ��ȸ X, DEPT_ID�� D3,D4,D7 ��ȸx

-- 2) ������ �� �÷����� ���� ���  ( EMPLOYEE : JOB_CODE, DEPARTMENT : JOB_CODE )
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM employee, JOB
WHERE JOB_CODE = JOB_CODE; -- ����
-- ambiguosly : �ָ��ϴ�, ��ȣ�ϴ�.


-- 2.1) �ذ��� : ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM employee, JOB
WHERE employee.JOB_CODE = JOB.JOB_CODE;

-- 2.2) �ذ��� : ���̺��� ��Ī�� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM employee E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-->> ANSI ����
-- FROM���� ������ �Ǵ� ���̺� �ϳ� ��� �� ��
-- JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���
-- JOIN USING, JOIN ON

-- 1) ������ �� �÷����� �ٸ���� ( EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID )
-- ������ JOIN ON �������θ� ��� ����!!!
-- ���, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM employee 
JOIN department  ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ���  ( EMPLOYEE : JOB_CODE, DEPARTMENT : JOB_CODE )
-- JOIN ON, JOIN USING ���� ��밡��
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM employee 
JOIN JOB ON (JOB_CODE = JOB_CODE);

-- 2.1) �ذ��� : ���̺�� �Ǵ� ��Ī�� �̿��ؼ� �ϴ� ���
SELECT  EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM employee E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- 2.2) �ذ��� : JOIN USING ���� ����ϴ� ��� ( �� �÷����� ��ġ�Ҷ��� ��� ����)
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM employee 
JOIN JOB USING (JOB_CODE);

--- [ ������� ] ------ ( ������ �� �Ⱦ� )
-- �ڿ�����( NATURAL JOIN ) : �� ���̺��� ������ �÷��� �� ���� ������ ���
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM employee 
NATURAL JOIN JOB;


-- �߰����� ���ǵ� �翬 ���� ������!
-- ������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ

-->> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM employee E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND JOB_NAME = '�븮';

-->>  ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY -- 4
FROM employee -- 1
JOIN JOB USING(JOB_CODE) -- 2
WHERE JOB_NAME = '�븮'; -- 3

----------------------------------- �ǽ� ---------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM employee , department 
WHERE DEPT_CODE = DEPT_ID 
    AND DEPT_TITLE = '�λ������';

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM employee 
JOIN department  ON (DEPT_CODE = DEPT_ID )
WHERE DEPT_TITLE = '�λ������';

--2. DEPARTMENT�� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-->> ����Ŭ ���� ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID,LOCAL_NAME
FROM department,location
WHERE (LOCATION_ID = LOCAL_CODE);

-->> ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID,LOCAL_NAME
FROM department 
JOIN LOCATION  ON (LOCATION_ID = LOCAL_CODE);

-- 3. ���ʽ��� ���� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM employee,department
WHERE (DEPT_CODE = DEPT_ID )
    AND BONUS IS NOT NULL;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID )
WHERE BONUS IS NOT NULL;
-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM employee,department
WHERE (DEPT_CODE = DEPT_ID )
    AND NOT DEPT_TITLE = '�ѹ���';

-->> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID )
WHERE NOT DEPT_TITLE = '�ѹ���';

-- ���� ���� DEPT_CODE�� NULL�ΰ��� ������ ����!

----------------------------------------------------------------------------------
/*
    2. ���� ���� / �ܺ� ���� ( OUTER JOIN )
    �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT �����ؾߵ�!! (������ �Ǵ� ���̺� ����)
*/

-- �����, �μ���, �޿�, ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID);
-- ���� �μ���ġ�� �ȵ� ��� 2�� ���� ������ ��ȸ�� �ȵ�!!
-- �μ��� ������ ����� ���� �μ� ���� ��쵵 ��ȸ�� �ȵ�!!

-- 1) LEFT [OUTER] JOIN : �ΰ��� ���̺� �� ���� ����� ���̺� �������� JOIN
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee -- �갡 ���� : �� �ִ°� ������ �� ����!!
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);
-- �μ���ġ�� ���� �ʾҴ� 2���� ��� ������ ��ȸ ��

-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee, department
WHERE DEPT_CODE = DEPT_ID(+); -- �������� ����� �ϴ� ���̺��� �ݴ��� �÷��ڿ�(+) ���̱�

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee
RIGHT JOIN department ON (DEPT_CODE = DEPT_ID);

-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee, department
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (��, ����Ŭ���뱸�����δ� �ȵ�)
-->> ANSI ���� �� ����

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM employee
FULL JOIN department ON (DEPT_CODE = DEPT_ID);

/*
    3. �� ���� ( NON EQUALS JOIN ) => �����
    ��Ī��ų �÷��� ���� ���� �ۼ��� '='(��ȣ)�� ������� �ʴ� JOIN��
    ANSI �������δ� JOIN ON�� ��� ����
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM employee;

-- �����, �޿�, �ִ���� �ѵ�
-->> ����Ŭ ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM employee, sal_grade
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM employee
JOIN sal_grade ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

----------------------------------------------------------------------------------
/*
    4. ��ü���� ( SELF JOIN )
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
*/
 
-- ��ü ����� ���, �����, ����μ��ڵ�  => employee E 
--           ����� ���, �����, ����μ��ڵ� => employee M

-->> ����Ŭ ����
SELECT E.EMP_ID AS ����ǻ�� ,E.EMP_NAME AS ����� , E.DEPT_CODE AS ����μ��ڵ�, 
    M.EMP_ID AS �����ȣ, M.EMP_NAME AS �����, M.DEPT_CODE AS ����μ��ڵ�
FROM employee E, employee M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-->> ANSI ����
SELECT E.EMP_ID AS ����ǻ�� ,E.EMP_NAME AS ����� , E.DEPT_CODE AS ����μ��ڵ�, 
    M.EMP_ID AS �����ȣ, M.EMP_NAME AS �����, M.DEPT_CODE AS ����μ��ڵ�
FROM employee E
LEFT JOIN employee M ON (E.MANAGER_ID = M.EMP_ID);

----------------------------------------------------------------------------------------
/*
    < ���� JOIN >
    2�� �̻��� ���̺��� ������ JOIN �� ��
*/

-- ���, �����, �μ���, ���޸�

-->> ����Ŭ ����
SELECT EMP_NO, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM employee E, department , JOB J
WHERE DEPT_CODE = DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI ����
SELECT EMP_NO, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
JOIN    JOB     USING (JOB_CODE);



-- ���, �����, �μ���, ������
-->> ����Ŭ ����
SELECT EMP_NO, EMP_NAME, DEPT_TITLE , LOCAL_NAME
FROM employee, department  , location 
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;

-->> ANSI 
SELECT EMP_NO, EMP_NAME, DEPT_TITLE , LOCAL_NAME
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
JOIN location ON (LOCATION_ID = LOCAL_CODE);

-------------------------------�ǽ� ------------------------------------------
-- 1. ���, �����, �μ���, ������, ������ ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM employee , department , location L , national N
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-->> ANSI 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
JOIN location L ON (LOCATION_ID = LOCAL_CODE)
JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE);
-- 2. ���, �����, �μ���, ������, ������, �ش� �޿���޿��� ���� �� �ִ� �ִ� �ݾ� ��ȸ
-->> ����Ŭ ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,MAX_SAL
FROM employee E, department , location L , national N , sal_grade S
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND E.SAL_LEVEL = S.SAL_LEVEL;
-->> ANSI 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM employee E
JOIN department ON (DEPT_CODE = DEPT_ID)
JOIN location L ON (LOCATION_ID = LOCAL_CODE)
JOIN national N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN sal_grade S ON (E.SAL_LEVEL = S.SAL_LEVEL);

--------------------------------------------------------------------------------
