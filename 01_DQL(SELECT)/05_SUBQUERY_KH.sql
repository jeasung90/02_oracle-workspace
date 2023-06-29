/*
    ● 서브쿼리 ( SUBQUERY )
    - 하나의 SQL문 안에 포함된 또 다른 SELECT문
    - 메인 SQL문을 위해 보조 역활을 하는 쿼리문
*/

-- 간단 서브쿼리 예시1
-- 노옹철 사원이랑 같은 부서에 속한 사원들 조회하고 싶음

-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM employee
WHERE EMP_NAME = '노옹철'; -- D9

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM employee
WHERE DEPT_CODE = 'D9';

-- > 위의 2단계를 하나의 쿼리문으로
SELECT EMP_NAME
FROM employee
WHERE DEPT_CODE = 
            (SELECT DEPT_CODE
             FROM employee
             WHERE EMP_NAME = '노옹철');

-- 간단 서브쿼리 예시2
-- 전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE   SALARY >= (SELECT AVG(SALARY)
                   FROM employee);

----------------------------------------------------------------------------------
/*
    ● 서브쿼리의 구분
     서브쿼리 수행한 결과값이 몇행 몇열이나에 따라서 분류됨
     
     - 단일행 서브쿼리         : 서브쿼리의 조회의 결과값의 갯수가 오로지 1개일 때(한행 한열)
     - 다중행 서브쿼리         : 서브쿼리의 조회의 결과값이 갯수가 여러행 일때 (여러행 한열)
     - 다중열 서브쿼리         : 서브쿼리의 조회의 결과값이 한 행이지만 컬럼이 여러개일 때 ( 한행 여러 열 ) 
     - 다중행 다중열 서브쿼리   : 서브쿼리의 조회의 결과값이 여러행 여러컬럼일 때 (여러행 여러열)
     
     >> 서브쿼리 종류에 따라서 앞에 붙는 연산자가 달라짐!!
*/

/*
    1. 단일행 서브쿼리 ( SINGLE ROW SUBQUERY )
    서브쿼리의 조회 결과값의 개수가 오로지 1개일 때 (한행 한열)
    일반 비교 연산자 사용 가능
    =, !=, ^=, <, >, <=, >= ....
*/
-- 1) 전 직원의 평균급여보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
-- 단일행
SELECT EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE salary < ( SELECT AVG(SALARY)
                FROM employee);

-- 2) 최저 급여를 받는 사원의 사번,이름,급여,입사일
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE SALARY = (
SELECT MIN(SALARY)
FROM employee);

-- 3) 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드 ,급여
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM employee
WHERE SALARY > (
    SELECT SALARY
    FROM employee
    WHERE EMP_NAME = '노옹철');


-->> 오라클 조인 전용
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY, DEPT_TITLE
FROM employee, department
WHERE (DEPT_CODE = DEPT_ID)
    AND SALARY < (
                    SELECT SALARY
                    FROM employee
                    WHERE EMP_NAME = '노옹철');

-->> ANSI 조인
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY, DEPT_TITLE
FROM employee
JOIN department ON (DEPT_CODE = DEPT_ID)
WHERE SALARY < (
                    SELECT SALARY
                    FROM employee
                    WHERE EMP_NAME = '노옹철');

-- 4) 부서별 급여 합이 가장 큰부서의 부서코드, 급여의 합
-- 4.1) 부서별 급여합 중에서도 큰 값 하나만 조회

SELECT  MAX(SUM(SALARY))
FROM employee
GROUP BY DEPT_CODE; -- 17700000

-- 4.2) 부서별 급여의 합이 17700000원인 부서 조회 (부서코드 급여 합)
SELECT DEPT_CODE, SUM(SALARY)
FROM employee
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (  SELECT  MAX(SUM(SALARY))
                        FROM employee
                        GROUP BY DEPT_CODE);

-- 직접 해보기

-- 1. 전지연 사원과 같은 부서원들의 사번, 사원명, 전번, 입사일, 부서명
-- 단, 전지연은 제외
-->> 오라클 전용
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM employee , department
WHERE DEPT_CODE = DEPT_ID 
 AND DEPT_CODE = ( SELECT DEPT_CODE
                   FROM employee
                   WHERE EMP_NAME ='전지연')
 AND NOT EMP_NAME = '전지연';
-->> ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM employee 
JOIN department ON (DEPT_CODE = DEPT_ID )
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                   FROM employee
                   WHERE EMP_NAME ='전지연')
 AND NOT EMP_NAME = '전지연';
--------------------------------------------------------------------------------------
/*
    2. 다중행 서브쿼리 ( MULTI ROW SUBQUERY )
    서브쿼리를 수행한 결과값이 여러 행 일때 (컬럼(열)DATAPUMP은 한개)
    
    
    - IN 서브쿼리 : 여려개의 결과값 중에서 한대라도 일치하는 값이 있다면
    
    - > ANY 서브쿼리 : 여러개의 결과값 중에서 "한개라도" 클 경우 (여러개의 결과값 중에서 가장 작은값보다 클 경우)
    - < ANY 서브쿼리 : 여러개의 결과값 중에서 "한개라도" 작을 경우 (여러개의 결과값 중에서 가장 큰값보다 작을 경우)
    
    비교대상 > ANY (값1, 값2, 값3)
    비교대상 > 값1 OR 비교대상 > 값2 OR 비교대상 > 값3
    
    - > ALL 서브쿼리 : 여러개의 '모든' 결과값들보다 클 경우
    - < ALL 서브쿼리 : 여러개의 '모든' 결과값들보다 작을 경우 
    비교대상 > 값1 AND 비교대상 > 값2 AND 비교대상 > 값3
    
*/

-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의  사번,사원명, 직급코드, 급여
-- 1.1) 유재식 또는 윤은해 사원의 직급 조회

SELECT JOB_CODE
FROM employee 
WHERE EMP_NAME IN ('유재식','윤은해'); --J3 J7

-- 1.2) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM employee 
                    WHERE EMP_NAME IN ('유재식','윤은해')); -- =이라고 쓰면 에러남!! 여러행으로 조회됐기 때문
                        -- 만악에 결과값이 여러개 나올 것 같으면 그냥 IN으로 가는게 좋다!

-- 사원 => 대리 => 과장 => 차장 => 부장...
-- 2) 대리 직급임에도 과장직급 급여들중 최소 급여보다 많이 받는 직원 조회 (사번, 이름 , 직급, 급여)

-- 단일행 서브쿼리
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, SALARY
FROM employee E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '대리'
AND SALARY > ( SELECT MIN(SALARY)
                FROM employee E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND J.JOB_NAME = '과장');
-- 다중행 서브쿼리
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, SALARY
FROM employee E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '대리'
AND SALARY >ANY ( SELECT SALARY
                FROM employee E , JOB J
                WHERE E.JOB_CODE = J.JOB_CODE
                AND J.JOB_NAME = '과장');

-- 3) 과장직급임에도 불구하고 차장직급인 사원들의 모든 급여보다도 더 많이 받는 사원들의 (사번, 이름, 직급명, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM employee E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '과장'
AND SALARY > ALL (
                   SELECT SALARY
                   FROM employee E
                   JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
                   WHERE JOB_NAME = '차장');

---------------------------------------------------------------------------------------
/*
    3. 다중열 서브쿼리
    결과값은 한 행이지만 나열된 컬럼수가 여러개인 경우
*/

-- 1) 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회(사원명, 부서코드, 직급코드, 입사일자)
-- 단일행 서브쿼리 ** 2개의 서브쿼리로 작성할 것!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM employee
WHERE DEPT_CODE = ( SELECT DEPT_CODE 
                            FROM employee
                            WHERE EMP_NAME = '하이유')
AND  JOB_CODE  =( SELECT JOB_CODE
                            FROM employee
                            WHERE EMP_NAME = '하이유');


SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM employee
WHERE (DEPT_CODE, JOB_CODE ) = (SELECT DEPT_CODE, JOB_CODE
                            FROM employee
                            WHERE EMP_NAME = '하이유');


-- 박나라 사원과 같은 직급코드 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번
SELECT EMP_ID,EMP_NAME, DEPT_CODE, MANAGER_ID
FROM employee
WHERE (DEPT_CODE, MANAGER_ID) = ( SELECT DEPT_CODE, MANAGER_ID
                                  FROM employee
                                  WHERE EMP_NAME='박나라');

------------------------------------------------------------------------------------
/*
    4. 대중행 다중열 서브쿼리
    서브쿼리 조회 결과값이 여러행 여려열 인 경우
*/

-- 1)  각 직급별로 최고급여를 받는 사원 조회 (사번, 사원명, 직급코드,급여)
-->> 각 직급별 최소 급여 조회
SELECT job_code, MIN(SALARY)
FROM employee
GROUP BY job_code;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM employee
WHERE (job_code ,SALARY )IN(SELECT job_code, MIN(SALARY)
                         FROM employee
                         GROUP BY job_code) ;
                         
-- 2) 각 부서별로 최고급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE (DEPT_CODE, SALARY) IN ( SELECT DEPT_CODE, MAX(SALARY)
                                FROM employee
                                GROUP BY DEPT_CODE);
---------------------------------------------------------------------------------
/*
    5. 인라인 뷰 ( INLINE - VIEW )
    
    서브쿼리를 수행한 결과를 마치 테이블 처럼 사용!
*/

-- 사원들의 사번, 이름, 보너스포함연봉(별칭 : 연봉) , 부서코드 => 보너스 포함 연봉이 NULL 안나오게
-- 단, 보너스 포함 연봉이 3000만 이상인 사원들만 조회
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS 연봉 , DEPT_CODE
FROM employee
WHERE (SALARY + SALARY * NVL(BONUS,'0'))*12  > 30000000;
-- 이걸 마치 존재하는 테이블인거 마냥 사용할 수 있음 !! 그게 인라인뷰

SELECT * /* 조회한 내용에 관해서만 쓸 수 있고 조회하지 않은 employee 안에 있는건 못쓴다 */
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY * NVL(BONUS,0))*12 AS 연봉 , DEPT_CODE
FROM employee
WHERE (SALARY + SALARY * NVL(BONUS,'0'))*12  > 30000000)
WHERE 연봉 >= 3000000;


-->> 인라인 뷰를 주로 사용하는 예 => TOP-N 분성 (상위 몇개만 보여주고 싶을 때 => BEST 상품)

-- 전 직원 중 급여가 가장 높은 상위 5명망 조회
-- * ROWNUM : 오라클 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT ROWNUM, EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC;
-- FROM -> SELECT ROWNUM (이 때 순번이 부여됨. 정렬도 하기전에 이미 순번 부여)
-- 뭔가 좀 이상함... 실행순서 때문..

SELECT  EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC;


SELECT ROWNUM,EMP_NAME, SALARY
FROM (SELECT  EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC)
WHERE ROWNUM <=5;         
-- ORDER BY 절이 다 수행된 결과를 가지고 ROWNUM 부여 후 추려야함!!

-- ROWNUM 이랑 전체컬럼 조회하고 싶음 => 별칭 부여하는 방법으로
SELECT ROWNUM,E.*
FROM (SELECT *-- EMP_NAME, SALARY
FROM employee
ORDER BY SALARY DESC) E
WHERE ROWNUM <=5;    


--------------------------------------------------------------------------
-- 1. 가장 최근에 입사한 사원 5명 조회(사원명,급여,입사일)
SELECT ROWNUM,EMP_NAME, SALARY, HIRE_DATE
FROM(
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <=5;  

-- 2. 각 부서별 평균급여가 가장 높은 3개부서 조회 (부서코드, 평균급여)
SELECT ROWNUM,DEPT_CODE, 평균
FROM(
        SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS 평균
        FROM employee
        GROUP BY DEPT_CODE
        ORDER BY FLOOR(AVG(SALARY)) DESC
)
WHERE ROWNUM <=3; 

-------------------------------------------------------------------------------------
/*
    ● 순위 매기는 함수 ( WINDOW FUNCTION )
    RANK() OVER(정렬기준)               |           DENSE_RANK() OVER(정렬기준)
    
    - RANK() OVRT(ORDER BY 컬럼) : 동일한 순위 이후의 등수를 동일한인원수 만큼 건너뛰고 순위 계산
                        EX) 공동 1위가 2명 그 다음 순위 3 위 => 1,1,3
    - DENSE_RANK() OVER(ORDER BY 컬럼) : 동일한 순위가 있다고 해도 그 다음 등수를 무조건 1씩 증가시킴                    
                        EX) 공동 1위가 2명이더라도 그 다음 순위를 2위 => 1,2,3\
    => 무조건 SELECT 절에서만 써야함
*/
SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS 순위
FROM employee;
-- 공동 19위가 2명 그 뒤의 순위는 21 => 마지막 순위랑 조회된 행 수랑 같음
SELECT EMP_NAME, SALARY,   DENSE_RANK() OVER(ORDER BY SALARY DESC)AS 순위
FROM employee;
-- 공동 19위 2명 그 뒤의 순위는 20 => 마지막 순위랑 조회된 행 수랑 다를 수 있음

-- 상위 5명만 조회
SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS 순위
FROM employee
WHERE RANK() OVER(ORDER BY SALARY DESC) <=5;


-- 인라인 뷰를 쓸 수 밖에 없음
SELECT EMP_NAME, SALARY,   순위
FROM (
        SELECT EMP_NAME, SALARY,   RANK() OVER(ORDER BY SALARY DESC)AS 순위
        FROM employee
)
where 순위 <=5;

















