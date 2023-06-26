/*
    <SELECT>
    데이터 조회할 때 사용되는 구문
    
    >>RESULT SET : SELCT문들 중에 조회된 결과물 (즉, 조회된 행들의 집합을 의미!)
    
    [표현법]
    SELECT 조회하고자하는 컬럼1, 컬럼2, . . . . FROM 테이블명
    
    반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류남!!
*/

-- EMPLOYEE 테이블의 모든 컬럼 조회 (*) 조회
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM JOB;
-------------------------실습 문제----------------------------
--1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;
--2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;
--3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬럼명 작성 부분에 산술연산 기술 가능(이때, 산술연산된 결과 조회)
*/
--EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12)
SELECT EMP_NAME, SALARY*12 
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여, 보너스 , 연봉, 보너스 포함된 연봉(급여+보너스*급여)*12
SELECT EMP_NAME, SALARY, BONUS, SALARY*12 AS 연봉, ((SALARY*BONUS)+SALARY)*12 AS 총연봉
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산한 결과값 마저도 NULL 이됨

--EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 에 사원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식 끼리도 연산 가능!

--*오늘날자 : SYSDATE
SELECT EMP_NAME AS 이름, HIRE_DATE AS 입사일, SYSDATE - HIRE_DATE AS 근무일수
FROM EMPLOYEE;
-- DATE - DATE : 연산 결과값은 일 단위가 맞음!
-- 단, 값이 지저분한 이유는 DATE 형식 년/월/일/시/분/초 단위로 시간정보까지도 관리를 하기 때문!
-- 함수 적용 하면 깔끔한 결과 확인 가능 => 나중에 배움!
-----------------------------------------------------------------------------------------
/*
 <컬럼명에 별칭 지정하기>
 산술연산을 하게되면 컬럼명 지저분함.. 이때 컬럼명으로 별칭 부여해서 깔끔하게 보여줌
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 쌍따옴표로 묶어야함
*/

SELECT EMP_NAME as "사원 명", SALARY AS 급여 , SALARY*12 AS "연봉(원)" , (SALARY+SALARY*BONUS)*12 "총 소득(보너스포함)"
FROM EMPLOYEE;
-------------------------------------------------------------------------------------------------------
/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT 절에 리터럴을 제시하면 마치 테이블 상에 존재하는 데이터 처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력됨
*/

--EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;

/*
    <연결 연산자 : ||>
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음    
    
    System.out.println("num의 값 : " + num);
*/
-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_NO || EMP_NAME || SALARY || '원' AS ㅎㅇ
FROM EMPLOYEE;

--컬럼값과 리터럴값 연결
-- XXX 의 월급은 XXX원 입니다. => 컬럼명 별칭 : 급여정보
SELECT EMP_NAME || ' 의 월급은 ' || SALARY || ' 입니다.' AS 급여정보
FROM EMPLOYEE;
----------------------------------------------------------------------------
/*
    < DISTINCT>
    컬럼에 중복된 값들을 한 번씩만 표현하고자 할 때 사용
    --현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금함.
*/

SELECT JOB_CODE
FROM EMPLOYEE;  -- 현재는 23명의 직급이 전부 조회가 됨

--EMPLOYEE 에 직급코드(중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; --중복 제거 됨 7행만 조회

--사원들이 어떤 부서에 속해있는지 궁금하다
SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE; --NULL : 아직 부서배치 안된 사람

--유의 사항 : DINTINCT 는 SELECT 절에 딱 한번만 기술 가능
SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 묶어서 중복 판별

---------------------------------------------------------------------
/*
    <WHERE 절
    조회하고자 하는 테이블로부터 특정 조건에 마족하는 데이터만을 조회하고자 할 때 사용
    이때 WHERE 절에 조건식을 제시 하게 됨
    조건식에서는 다양한 연산자들 사용 가능!
    
    [표현식]
    SELECT 컬럼1, 컬럼2, ...
    FROM 테이블명
    WHERE 조건식;
    
    [비교연산자]
    >, <, >=, <=        --> 대소비교
    =                   --> 동등비교
    !=, ^=, <>          --> 동등하지 않은지 비교
*/

-- EMPLOYEE 에서 부서코드가 'D9' 인 사원들만 조회(이때 , 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE 에서 부서코드가 'D1' 인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 에서 부서코드가 'D1' 이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1';
--WHERE DEPT_CODE ^= 'D1';
WHERE DEPT_CODE <> 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 에서 재직중(ENT_YN 컬럽값이 'N' 인) 사원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN='N';

--------------------------실습문제--------------------------------------------
--1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함) 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY*12 AS 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY*12 AS 연봉 , DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉*12 >= 50000000; 오류!! (WHERE 절 에서는 SELECT 절에 작성된 별칭 사용 불가!!)

--쿼리 실행 순서
--FROM절 => WHERE절 => SELECT 절

--3. 직급코드 'J3' 이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 부서코드가 'D9' 이면서 급여가 500만원 이상인 사원들의 사번, 사원명,급여,부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
AND SALARY >= 5000000;

-- 부서코드가 'D6' 이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
OR SALARY >= 3000000;

-- 급여가 350만원이상 600만원이하를 받는 사원들의 사원명, 사번 , 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY >=3500000 AND SALARY <= 6000000;
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--------------------------------------------------------------------
/*
    <BETWEEN AND>
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A (값1) AND B(값2)
    => 해당 컬럼의 값이 A 이상이고 B 이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--위의 쿼리 범위 밖의 사람들 조회하고 싶다면? 350미만 + 600초과
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
--NOT : 논리부정연산자 => 자바에서의 !
--컬럼명 앞 또는 BETWEEN 앞에 기입가능!

--입사일이 '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'; -- DATE 형식은 대소비교 가능

-------------------------------------------------------------------------------------

/*
    < LIKE >
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    
    -특정패턴 제시시 '%', '_' 를 와일드 카드로 사용할 수 있음
    
    >> '%' : 0글자 이상 
    EX) 비교대상컬럼 LIKE '문자%'  => 비교대상의 컬럼값이 문자로 "시작" 되는걸 조회
    EX) 비교대상컬럼 LIKE '%문자'  => 비교대상의 컬럼값이 문자로 "끝" 나는걸 조회
    EX) 비교대상컬럼 LIKE '%하%'  => 비교대상의 컬럼값이 '하' 가 들어가있는걸 조회
    
    >>'_' : 1글자 이상
    EX) 비교대상컬럼 LIKE '_문자'   => 비교대상의 컬럼값에 문자앞에 무조건 한글자만 올 경우 조회
        비교대상컬럼 LIKE '__문자'  => 비교대상의 컬럼값에 문자앞에 무조건 두글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_'  => 비교대상의 컬럼값에 문자 앞과 문자 뒤에 무조건 한글자씩 올 경우
*/

-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원들 중 이름이 '하' 로 끝나는 사원들의 사원명,주민번호,전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하';

-- 사원들 중 이름에 '하' 가 들어가는 사원들의 사원명,주민번호,전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 하 인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1 인 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- ** 특이케이스
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번,이름,이메일 조회
--EX) SIM_BS@KH.OR.KR SUN_DI@KH.OR.KR
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '__%';
-- 와일드 카드로 사용되고있는 문자와 컬럼값에 담긴 문자가 동일하기 떄문에 제대로 조회 안됨
--> 어떤게 와일드카드고 어떤게 데이터 값인지 구분지어야됨
--> 데이터값으로 취급하고자 하는 값 앞에 나만의 와일드카드를 제시하고 나만의 와일드카드를 옵션으로 등록해야함
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- 위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$';
---------------------------------------------------------------------
-- 1. EMPLOYEE에서 이름이 '연' 으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';
-- 2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '__0%';
-- 3. EMPLOYEE에서 이름에 '하' 가 포함되어 있고 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;
-- 4. DEPARTMENT에서 해외영업부인 부서들의 코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
---------------------------------------------------------------------------
SELECT BONUS
FROM employee;

/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우 NULL값 비교에 사용되는 연산자
    
*/

-- 보너스를 받지 않는 사원(BONUS 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE  bonus = NULL; 정상적으로 죄회 안됨 -- NULL 은 = 로 비교가 안됨
WHERE BONUS IS NULL;



-- 보너스를 받는 사원의 (BONUS 값이  NULL 이 아닌 ) 사번 , 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
-- WHERE BONUS != NULL; 안됨
-- WHERE NOT BONUS IS NULL;
WHERE BONUS IS NOT NULL;
-- NOT은 컬럼멍 또는 IS 뒤에 사용 가능 (IS 뒤에 더 많이 씀)

--  ● 사수가 없는 사원들의 사원명, 사수사번, 부서코드
SELECT EMP_NAME,MANAGER_ID, DEPT_CODE
FROM employee
WHERE manager_id IS NULL ;

-- ● 부서배치를 아직 받지는 않았지만 (DEPT_CODE IS NULL), 보너스는 받는 사원
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM employee
WHERE dept_code IS NULL AND BONUS IS NOT NULL;

---------------------------------------------------------------------------

/*
   < IN >
   비교대상컬럼값이 내가 제사한 목록중에 일차하는 값이 있는지
   
   [ 표현법 ]
   WHERE 비교대상 컬럼 IN ('값1','값2', .........무제한);
*/

-- ● 부서코드가 D6이거나, D8이거나 D5이거나 부서원들의 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
-- WHERE dept_code = 'D6' OR dept_code = 'D8' OR dept_code = 'D5' ;
WHERE dept_code IN ('D5','D8','D5'); 

-- ● 그 외의 사람들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE dept_code NOT IN ('D5','D8','D5'); 

--====================================================================
/*
    < 연산자 우선 순위 >
    0. () 
    1. 산술연산자 +, -, *, / 
    2. 연결연산자 ||
    3. 비교연산자 =, !=, <, >
    4. IS NULL / LIKE '특정패턴' / IN
    5. BETWEEN AND
    6. NOT (논리 연산자)
    7. AND (논리 연산자)
    8. OR  (논리 연산자) // AND 랑 우선순위가 같지 않다
*/


-- ● 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM employee
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2')AND SALARY >=2000000;
-- WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >=2000000;
    -- 위의 식은 OR가 AND보다 우선순위가 낮아 제대로 식이 되지 않는다.
-- WHERE JOB_CODE IN ('J7','J2') AND SALARY >= 2000000;


--------------------------- 실습문제 ---------------------------------------------

-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, manager_id, DEPT_CODE
FROM employee
WHERE manager_id IS NULL AND DEPT_CODE IS NULL;
-- 2. 연봉(보너스 미포함)이 3000만원 이상이고 보너스를 받지 않는 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM employee
WHERE SALARY * 12 >= 30000000 AND BONUS IS NULL;
-- 3. 입사일이 95/01/01 이상이고 부서배치를 받은 사원들의 사번, 사원명, 입사일, 부서코드
SELECT *
FROM employee
WHERE HIRE_DATE  > '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하이며, 입사일이 01/01/01 이상이고 보너스를 받지 않는 사원들의
-- 사번, 사원명, 급여, 입사일, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM employee
WHERE salary >= 2000000 AND  salary <= 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;

-- 5. 보너스를 포함한 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 사번, 사원명, 급여, 보너스 포함 연봉 조회
SELECT EMP_ID, EMP_NAME,SALARY, ((SALARY*BONUS)+SALARY)*12 AS "보너스 포함 연봉"
FROM employee
WHERE BONUS IS NOT NULL AND EMP_NAME LIKE '%하%';

---------------------------------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY
FROM employee
WHERE DEPT_CODE IS NOT NULL;

--============================================================================================================

/*
    < ORDER BY 절 > 
    가장 마지막 절에 장성! 뿐만 아니라 실행순서 또한 가장 마지막에 실행
    
    [ 표현법 ] 
    SELECT 조회할 컬럼, 컬럼, 산술연산식 AS "별칭",....
    FROM 조회하고자 하는 테이블명
    WHERE 조건식
    ORDER BY 정렬하고 싶은 컬럼 | 별칭 사용 가능 | 컬럼순번 [ASC|DESC] [NULLS FIRST(널을 가장 위) | NULL LAST (마지막)]
    
    - ASC         : 오름차순 정렬 ( 생략시 기본값 )
    - DESC        : 내림차순 정렬  
    
    - NULL FIRST  : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 데이터를 맨 앞에 배치 ( 생략시 DESC 일때의 기본값 )
    - NULL LAST   : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 데이터를 맨 뒤에 배치 ( 생략시 ASC  일때의 기본값 )
*/
SELECT *
FROM employee
-- ORDER BY BONUS; 
-- ORDER BY BONUS ASC;              -- 오름차순 정렬일 때 기본적으로 NULLS LAST  구나!
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC NULLS LAST;  -- 내림차순 정렬일 때 기본적으로 NULLS FIRST 구나!
ORDER BY BONUS DESC, SALARY ASC;    -- 정렬기준 여러개 제시 가능(첫번째 기준의 컬럼값이 동일할 경우 두번째 기준 컬럼가지고 정렬)

-- 전 사원의 사원명, 연봉 조회 (이 때 연봉별로 내림차순 정렬조회)
SELECT EMP_NAME,  SALARY * 12 AS "연봉"
FROM employee
-- ORDER BY (SALARY * 12) DESC;
-- ORDER BY 연봉 DESC; -- 별칭 사용 가능 (순서가 낮아서)
ORDER BY 2 DESC;  -- 커럼 순번을 숫자로 사용 가능하다.SELECT 순번 사용 ( 컬럼 갯수보다 큰 숫자 사용불가)



























