--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE comm IS NOT NULL;

--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE comm = '0' OR comm IS NULL;
--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE MGR IS  NULL;
--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
SELECT *
FROM EMP
ORDER BY SAL DESC;
--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT *
FROM EMP
ORDER BY SAL ASC, SAL DESC;
--6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO,ENAME,JOB,HIREDATE
FROM EMP
ORDER BY 4;
--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO,ENAME
FROM EMP
ORDER BY EMPNO DESC;
--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ
SELECT EMPNO,HIREDATE,ENAME,SAL
FROM EMP
ORDER BY 1 , HIREDATE;
--(�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
--9. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE FROM DUAL;
--10. EMP���̺��� ���, �����, �޿� ��ȸ
--(��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME,TRUNC(SAL / 100)AS "�޿�100����"-- RTRIM(SAL,'0')
FROM EMP
ORDER BY 3;
--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE MOD( EMPNO, 2)=1;
--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME,SUBSTR(HIREDATE,1,2) AS "�Ի�⵵",SUBSTR(HIREDATE,4,2) AS "�Ի��"
FROM EMP;
--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate LIKE '____9%';
--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate LIKE '81%';
--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE ENAME LIKE '%E';
--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
--16-1. LIKE ���
SELECT *
FROM emp
WHERE ENAME LIKE '__R%';
--16-2. SUBSTR() �Լ� ���
SELECT *
FROM emp
WHERE SUBSTR(ENAME,3,1) = 'R';
--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, HIREDATE + INTERVAL '40' YEAR AS "�Ի��Ϸκ��� 40�� ��"
FROM emp;
--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 38*12;
--19. ���� ��¥���� �⵵�� ����
SELECT /* SUBSTR(SYSDATE, 1,2)*/  EXTRACT(YEAR FROM SYSDATE)||'��' AS "���س⵵" FROM DUAL;