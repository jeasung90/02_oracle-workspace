-- 저장먼져 하기
----------------------- 문제 1 --------------------------------
-- 보너스를 받지는 않지만 부서배치는 된 사원 조회
SELECT *
 FROM employee
 WHERE BONUS == NULL AND DEPT_CODE != NULL;
 -- WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;

-- 문제점 : NULL값 비교할때는 단순한 일반 비교연산자를 통해 비교할 수 없음!
-- 해결방법 : IN NULL / IS NOT NULL 연산자 이용해서 비교해야함!

-- 조치한 SQL문
SELECT *
FROM employee
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;


----------------------- 문제 2 --------------------------------

-- 검색하고자 하는 내용
-- JOB_CODE J7이거나 J6이면서 SALARY값이 200만원 이상
-- BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS 를 조회하려고 한다
-- 정상적으로 조회가 잘 된다면 실행결과는 2행 이어야 한다

-- 위의 내용을 실행하려고 잗성한 SQL문은 아래와 같음
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM employee
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE '____%' AND BONUS IS  NULL ;


-- 위의 SQL문 실행시 원하는 결과가 제대로 조회되지 않는다 어떤 문제점들(5개)가 있는지
/*
1. JOB_CODE J7이거나 J6인 조건은 OR로 비교하는데 OR은 AND보다 연산순위가 낮아서 나중에 연한사게되 제대로 나오지 않는다
- OR연산자와 AND 연산자가 나열되어 있는 경우 AND 연산자가 먼저 수행됨 문제에서 요구한 내용되로 OR연산이 먼져 수행되어야 할 경우 ()로 우선순위를 높여준다.
2. EMP_NO를 통해 여자를 찾는 조건이 없다
-여자에 대한 조건이 누락되어있음
3. 급여값이 200만원 이상인데 초과로 >로 표시되어 있으 200만원인 값은 나오지 않는다
-급여값에 비교가 잘못되어 있다>이 아닌 >-로 비교해야함
4. 이메일에서 '_'앞에 3개가 있는걸 찾아야 하는데 _는 와일드카로드 이용되고 있기때문에 문자로 인식되지 않는다
- 이메일에 대한 비교할때 4번째 자리에 있는 _를 데이터값으로 취급하기 위해서는 새 와일드카드를 제시해야되고, 도 ESCAPE 로 등록까지 해야됨
5. 보너스가 있는 사람을 찾아야 하는데 IS NULL 은 NULL 인 값을 찾는 식이다.
-보너스가 있는 이라는 조건에 IS NULL이 아니라 IS NOT NULL 로 비교해야함
*/
-- 모두 찾아서 서술해볼것! 그리고 조치된 완벽한 SQL문을 작성해볼것


SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM employee
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6' )AND SALARY > 2000000
AND EMAIL LIKE '___$_%' ESCAPE '$'  AND BONUS IS NOT NULL AND /* EMP_NO LIKE '_______2%' */ 
SUBSTR(EMP_NO,8,1)IN('2','4');

--=================================문제 3==============================-=========--

-- [계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비번;

-- 계정명 : SCOTT, 비번 : TIGER 계정을 생성하고 싶다!
-- 이 때 일반 사용자계정인 KH계정에 접속해서 CREATE USER SCOTT; 로 실행하니 문제 발생!

-- 문제점 1. 사용자 계정 생성은 무조건 관리자계정에서만 가능
-- 문제점 2. SQL문 잘못돼있음!! 비번까지 입력해야함!

-- 조치내용 1. 관리자 계정에 접속
-- 조치내용 2. CREATE USER SCOTT IDENTIFIED BY TIGER;

-- 위의 SQL(CREATE)문만 실행 후 접속을 만들어 접속을 하려고 했더니 실패!
-- 뿐만 아니라 해당 계정에 테이블 생성 같은것도 되지 않음 왜??

-- 문제점 1. 사용자 게정 생성 후 최소한의 권한 부여해야함!!

-- 조치내용 . GRANT CONNECT, RESOURCE TO SCOTT; 구문 실행해서 권한 부여













































