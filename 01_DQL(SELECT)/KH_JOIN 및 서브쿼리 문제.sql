--1.
SELECT EMP_NAME, EMP_NO, D.DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
JOIN JOB USING(JOB_CODE)
WHERE EMP_NO LIKE '7%'
AND SUBSTR(EMP_NO,8,1)=2
AND EMP_NAME LIKE '��%';

--2. 
SELECT ROWNUM, EMP_ID, EMP_NAME, CONCAT('20',SUBSTR(SYSDATE,1,2)) - CONCAT('19',SUBSTR(EMP_NO,1,2)) AS"����", DEPT_TITLE, JOB_NAME
FROM (SELECT EMP_ID, EMP_NAME , EMP_NO, D.DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN JOB USING(JOB_CODE)
ORDER BY EMP_NO DESC)
WHERE ROWNUM <=1;

--3. 
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

--4. 
SELECT EMP_NAME, JOB_NAME, DEPT_CODE ,DEPT_TITLE
FROM EMPLOYEE E 
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE DEPT_CODE IN('D5','D6');

--5. 
SELECT EMP_NAME, BONUS, DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE BONUS IS NOT NULL;

--6.
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE;

--7.
SELECT EMP_NAME, DEPT_TITLE ,LOCAL_NAME,NATIONAL_NAME
            FROM EMPLOYEE E 
            JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
            JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
            JOIN NATIONAL USING(NATIONAL_CODE)
            WHERE NATIONAL_NAME IN('�ѱ�','�Ϻ�');


--8. 
SELECT E.EMP_NAME, E.DEPT_CODE, M.EMP_NAME
FROM EMPLOYEE E JOIN EMPLOYEE M 
ON E.DEPT_CODE = M.DEPT_CODE(+)
ORDER BY DEPT_CODE;



--9. 
SELECT EMP_NAME, JOB_NAME,SALARY
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL
AND JOB_CODE IN('J4', 'J7');

--10. 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME,HIRE_DATE, ROWNUM
FROM(SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME,HIRE_DATE,(SALARY + SALARY *NVL(BONUS, '0') )*12 AS ����
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN JOB USING (JOB_CODE)
    ORDER BY  ���� DESC
    )
WHERE ROWNUM <=5;



 
 --11. 
SELECT DEPT_TITLE,SUM(SALARY)
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > 
((SELECT SUM(SALARY)
FROM employee)*0.2)
ORDER BY 2 DESC;

-- 12. 
SELECT DEPT_TITLE,SUM(SALARY)
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;


