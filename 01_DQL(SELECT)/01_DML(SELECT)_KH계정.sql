/*
    <SELECT>
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SESELECT 조회하고자 하는 컬럼1, 컬럼2, ... 
    FROM 테이블명;
    
    * 반드시 존재하는 컬럼으로 써야한다!! 없는 컬럼 쓰면 오류남!!

*/

-- EMPLOYEE 테이블의 모든 컬럼(*) 조회
-- SELECT EMP_ID, EMP_NAME 컬럼이 많으면 모두 쓰기 힘듬
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 만 조회하고 싶다
SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB;
---------------- 실습문제 ----------------------
-- 1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM department;

-- 3. DEPARTMENT 테이블의 부서코드 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM department;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM employee;

/*
    <컬럼값을 통한 산술연산>
    SELECT 절 컬럼명 작성 부분에 상술연산 기술 가능(이때, 산술연산이 된 결과가 조회가 됨)
    
*/
-- EMPLOYEE 테이블의 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 급여, 보너스, 연봉, 보너스를 포함시킨 연봉((급여+보너스*급여)*12)
SELECT EMP_NAME, SALARY ,BONUS, SALARY * 12,((SALARY + BONUS * SALARY )*12)
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL 값이 존재할 경우 산술연산한 결과값 마저도 NULL로 나옴

-- EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사원명, 입사일, 근무일수
-- DATE 형식 끼리도 연산 가능
-- * 오늘날짜 : SYSDATE : 결과값은 일단위가 맞음!
-- 단, 값이 지저분한 이유는 DATE형식이 년/월/일/시/분/초 단위로 시간정보까지도 관리하고 있기 때문에
-- 함수적용하면 깔끔한 결과 확인 가능 => 나중에 배움 TRUNC(SYSDATE

SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

---------------------------------------------------------
/*
    <커럼명에 별칭을 지정하기>
    산술연산을 하게 되면 컬럼명이 지저분해짐.. 이때 컬럼명으로 별칭을 부여해서 깔끔하게 보여주는 용도
    
     [표현법] ★
     컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
     
     AS를 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기나 특수문자가 포함될 경우 반드시 쌍따움포""로 묶어야 함!!
*/

SELECT EMP_NAME 사원명, SALARY AS "급여", SALARY*12 "연봉(원)", (SALARY + SALARY * BONUS)*12 AS " 총 소득(보너스포함)"
FROM employee;

----------------------------------------------------------------
/*
    <리터럴>
    임의로 지정한 문자열('')
    
    SELECT 절에 리터럴을 제시하면 마치 테이블상의 존재하는 데이터처럼 조회가 가능하다
    조회된 RESULT SET 의 모든 행에 반복적으로 같이 출력
    
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_NO, EMP_NAME, SALARY, '원'AS 단위
FROM employee;

/*
    < 연결 연산자 : || >
    여러 컬럼값들을 마치 하나의 컬럼인 것 처럼 연결하거나, 컬럼값과 리터럴을 연결 할 수 있음
    System.out.println("num의 값 : " + nun");
    */

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT emp_no || emp_name || SALARY
FROM employee;

-- 컬럼값과 리터럴 값을 연결
-- xxx의 월급은 xx원 입니다. => 컬럼명의 별칭 : 급여정보
SELECT emp_name || '의 월급은 ' || SALARY || '원 입니다.' AS 급여정보
FROM employee;

---------------------------------------------------------
/*
    < DISTINCT > 
    컬럼에 중복된 값들을 한 번씩만 표현하고자 할 때 사용
*/
-- 현재 회사에서 어떤 직급의 사람들이 존재하는지 굼굼함.
SELECT JOB_CODE
FROM JOB; -- 현재는 23명의 직급이 전부 조회됨.

-- EPLOYEE 테이블에 직업코드(중복제거) 조회

SELECT DISTINCT JOB_CODE
FROM JOB; -- 중복 제거 돼서 7행만 조회됨

-- 사원들이 어떤 부서에 속해있는지 굼굼함.
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- NULL : 아직 부서배치 안된 사람

-- 유의 사항 : DISTINCT는 SELECT절에 딱 한번만 기술 가능
/* 여러번 쓰는건 오류
SELECT DISTINCT JOB_CODE,DISTUNCT DEPT_CODE
FROM employee;
*/
SELECT DISTINCT JOB_CODE,DEPT_CODE 
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 즉, 둘다 중복일경우 삭제시킴

-- ===================================
/*
    < WHERE 절 >
    조회 하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만 조회하고자 할 때 사용
    이 때 WHERE절에 조건식을 제시하게 됨
    조건식에서는 다양한 연산자들 사용 가능!!

    [표현식]
    SELECT 컬럼1, 컬럼2ㅡ ....
    FROM 테이블명
    WHERE 조건식
    
    [비교연산자]
    >, <, >=, <=  --> 대소비교
    =             --> 동등비교
    !=, ^=, <>    --> 동등하지 않은지 비교    
*/

-- EMPLOYEE 테이블에서 부서코드가 'D9'부서인 사람들만 조회(이때, 모든 컬럼 조회)
SELECT *
FROM employee
WHERE DEPT_CODE = 'D9'; -- 대소문자 구분함

-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원들의 사원명과 급여, 부서코드 만 조회
SELECT EMP_NAME,SALARY,DEPT_CODE
FROM employee
WHERE DEPT_CODE = 'D1';

-- EMPLOYEE 에서 부서코드가 'D1'이 아닌사원들의 사번과 사원명과 부서코드
SELECT EMP_ID, EMP_NAME ,DEPT_CODE
FROM employee
--WHERE DEPT_CODE != 'D1'; -- NULL은 안나옴
WHERE DEPT_CODE <> 'D1'; -- 같음

-- 급여가 400만원 이상의 사원들의 사원명과, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE SALARY > '4000000' ;

-- employee에서 재직중인 사원들의 사번, 이름, 입사일
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM employee
WHERE ENT_YN = 'N' ;

--------------------------실습문제----------------------------------------------
-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(보너스 미포함)
SELECT EMP_NAME,  SALARY, HIRE_DATE, SALARY *12||'원' AS "연봉"
FROM employee
WHERE SALARY > '3000000' ;
-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME,  SALARY|| '원' AS "월급", SALARY *12||'원' AS "연봉" , DEPT_CODE
FROM employee
WHERE SALARY *12> '50000000' ;
--WHERE 연봉 *12> '50000000' ; (WHERE절 에서는 SELECT절에 작성된 별칭 사용 불가!!)

/*      쿼리 실행 순서
     FROM절 => WHERE절 => SELECT절
*/

-- 3. 직급코드가'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부
SELECT EMP_ID, EMP_NAME,DEPT_CODE,  ENT_YN
FROM employee
WHERE DEPT_CODE != 'J3' ;
 
-- 부서코드가 'D9'부서 이면서 급여가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY , DEPT_CODE
FROM employee
WHERE DEPT_CODE ='D9' AND SALARY > '5000000';

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM employee
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하 받는 사원들의 사원명,사번,급여조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
--WHERE 3500000 <= AND SALARY <=6000000 ; 오류발생
--WHERE 3500000 <= SALARY AND SALARY <=6000000 ;
WHERE SALARY >=3500000 AND SALARY <=6000000 ; -- 일반적으로는 이 순서로 한다!

/* 순서가 바뀌면 오류발생
SELECT EMP_NAME,  SALARY|| '원' AS "월급", SALARY *12||'원' AS "연봉" , DEPT_CODE
WHERE SALARY *12> '50000000' 
FROM employee;
*/

/*
    < BETWEEN AND >  WHERE 절에서
    조건식에서 사용되는 구문
    몇 이상 및 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    => 해당컬럼의 값이 A(값1)이상이고 B(값2) 이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 위의 쿼리 범위 밖의 사람들을 조회하고 싶다면? 350미만 + 600초과

SELECT EMP_NAME, EMP_ID, SALARY
FROM employee
--WHERE SALARY < 3500000 OR SALARY >6000000;    방법 1
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000; 방법 2
WHERE SALARY NOT BETWEEN 3500000 AND 6000000; --방법 3
-- NOT : 논리부정연산자 => 자바에서의 !
-- 컬럼명 앞 또는 BETWEEN 앞에 기입 가능!

-- 입사일이 '90/01/01' ~ '01/01/01'
SELECT *
FROM employee
-- WHERE HIRE_DATE>= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE 형식은 대소비교 가능
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--------------------------------------------------------------------------

/*
    < LIKE >
    비교하고자 하는 커럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    
    -특정패턴 제시싯 '%', '_'를 와일드 카드로 사용할 수 있음
    
    >> '%' : 글자 이상
    EX) 비교대상컬럼 LIKE '문자%' => 비교대상의 컬럼값이 문자로 "시작"되는걸 조회
        비교대상컬럼 LIKE '%문자' => 비교대상의 컬럼값이 문자로 "끝"나는걸 조회
        비교대상컬럼 LIKE '%하%'  => 비교대상의 컬럼값에 문자가 "포함"되는걸 조회(키워드 검색)
  
    >> '_' : 1글자 인상
    EX) 비교대상컬럼 LIKE '_문자'  => 비교대상의 커럼값에 문자앞에 무조건 한 글자만 올 경우 조회
        비교대상컬럼 LIKE '__문자' => 비교대상의 컬럼값에 문자옆에 무조건 두글 자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_' => 비교대상의 컬럼값에 문자 앞과 문자 뒤에 무조건 한 글자씩 올 경우 조회



*/
-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '전%';

-- 사원들 중 성이 하로 끝나는 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%하';

-- 이름중에 하가 포홤된 사람들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM employee
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 "하"인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME,  PHONE
FROM employee
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전번, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM employee
WHERE PHONE LIKE '__1%';

-- ** 특이케이스 (시험 가능성 높음)
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름, 이메일
SELECT EMP_ID, EMP_NAME,  EMAIL
FROM employee
WHERE EMAIL LIKE '____%'; -- 원했던 결과 도출 못함!!
-- 와일드카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회 안됨
---> 어떤게 와일드카드고 어떤게 데이터 값인지 구분지어야됨!
---> 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고 나만의 와일드카드를 ESCAPE OPTION 으로 등록해야 됨!!
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- 위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM employee
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';

--------------------------실습문제------------------------------
-- 1. EMLPOYEE 테이블에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM employee
WHERE EMP_NAME LIKE '%연';

-- 2. EMLPOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전번 조회
SELECT EMP_NAME,PHONE
FROM employee
WHERE NOT PHONE LIKE '010%';

-- 3. EMLPOYEE 테이블에서 이름에 '하'가 포함되어 있고 급여가 240만원 이상인 사원들의 사원명과 급여 조회
SELECT EMP_NAME, SALARY
FROM employee
WHERE EMP_NAME LIKE '%하%' AND salary >= 2400000;

-- 4. DEPARTMENT 에서 해외 영업부인 부서들의 코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM department
WHERE dept_title LIKE '해외영업%';







