/*
    DQL ( QUERT 데이터 질의 언어 ) : SELECT
    
    ★DML ( MANIPULATION 데이터 조작 언어 ) :[SELECT], INSERT, UPDATE, DELETE
    
    ★DDL ( DEFINITION 데이터 정의 언어 ) : CREATE, ALTER, DROP
    
    ★DCL ( CONTROL 데이터 제어 언어 ) : GRANT, REVIKE
    
    TCL ( TRANSACTION 트렌젝션 제어 언어 ) : COMMIT, ROLLBACK
    
    < DML : DATE MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 값을 삽입(INSERT) 하거나, 수정(UPDATE) 하거나, 삭제(DELETE)하는 구문
*/

/*
    1. INSERT
        테이블의 새로운 행을 추가하는 구문
        
    [표현법]
    1) INSERT INTO 테이블명 VALUES(값1,값2,...);
        테이블에 모든 컬럼에 대한 값을 직접 제시해서 한 행 INSERT 하고자 할 때 사용
        컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!!
        
        부족하게 값을 제시했을 경우 =>  not enough values 오류!
        너무많이 값을 제시했을 경우 =>  too many values 오류!
        
    2) INSERT INTO 테이블명 (컬럼명, 컬렴명, ...) VALUES (값, 값,...);
        테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용
         그래도 한 행 단위로 추가되기 때문에
         선택이 안된 컬럼은 기본적으로 NULL이 들어감!!
         => 제약조건 NOT NULL인 컬럼은 반드시 선택해서 값 제시해야 함!
         단, DEFAULT 값이 있는 경우 NULL이 아닌 DEFAULT 값이 들어간다!  
*/

INSERT INTO employee
VALUES (900,'이지은','930101-1234567','NOW_93@KH.OR.KR','01045678912',
        'D1','J7','S3',6000000,0.5,200,SYSDATE,NULL,DEFAULT);

select * FROM employee
WHERE EMP_ID = 900;

INSERT INTO employee(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL, HIRE_DATE)
VALUES(901,'숯이','940706-2345678','J1','S2',SYSDATE);

select * FROM employee
WHERE EMP_ID = 901;
-- EMT_YN은 디폴드값으로 들어갔음!

INSERT
    INTO employee
        (
          EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
        )
VALUES
        (
          901
        , '숯이'
        , '940706-2456789'
        , 'J1'
        , 'S2'
        , SYSDATE
        );
-------------------------------------------------------------------------------------------
/*
    3) INSERT INTO 테이블명 (서브쿼리);
        VALUES로 값 직접 명시하는거 대신에
        서브쿼리 조회된 결과값을 통째로 INSERT 가능!
*/

-- 새로운 세이블 셋팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER PRIMARY KEY ,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM employee
LEFT JOIN department ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01; 

DROP TABLE EMP_O1;
--------------------------------------------------------------------------------------------
/*
    2. INSERT ALL
    
*/
--> 우선 테스트 할 테이블 만들기!

CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM employee
WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM employee
WHERE 1=0;

SELECT * FROM EMP_DEPT;
SELECT * FROM emp_manager;

-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM employee
WHERE DEPT_CODE = 'D1'; 

/*
    [표현식]
    INSERT ALL 
    INTO 테이블명1, VALUES(컬럼명,컬럼명...)
    INTO 테이블명2, VALUES(컬럼명,컬럼명...)
    서브쿼리;
*/

INSERT ALL 
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME,DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM employee
WHERE DEPT_CODE = 'D1';

-- * 조건을 사용해서 각 테이블에 INSERT 가능? 

-- 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블

-- 테이블 구조만 배껴서 만들기
CREATE TABLE EMP_OLD
    AS SELECT EMP_ID, EMP_NAME, hire_date, SALARY
       FROM employee
       WHERE 1=0;
       
-- 2000년도 이후에 입사한 입사자들에 대한 정보 담을 테이블

CREATE TABLE EMP_NEW
    AS SELECT EMP_ID, EMP_NAME, hire_date, SALARY
       FROM employee
       WHERE 1=0;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    [표현식]
    INSERT ALL
    WHEN 조건1 THEN
        INTO 테이블명1 VLAUES(컬럼명, 컬럼명...)
    WHEN 조건2 THEN
        INTO 테이블명1 VLAUES(컬럼명, 컬럼명...)
    서브쿼리;
*/
INSERT ALL
    WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID,EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, hire_date, SALARY
FROM employee;

SELECT * FROM EMP_OLD; -- 8
SELECT * FROM EMP_NEW; -- 17

-----------------------------------------------------------------------------------------

/*
    3. UPDATE
    테이블에 기록되어있는 기존의 데이터를 수정하는 구문
    
    [표현식]
    UPDATE 테이블명
    SET 컬럼명 = 바꿀값,
        컬럼명 = 바꿀값,
        .....       --> 여러개의 컬럼값 동시변경 가능!(,로 나열해야함!! AND아님!!)
    [WHERE 조건];    --> 생략하면 전체 행의 모든 행의 데이터가 변경된다!! 그래서 꼭 조건 쓰자!!
*/

-- 복사본 테이블 만든 후 작업
CREATE TABLE DEPT_COPY
    AS SELECT * FROM department;
    
SELECT * FROM dept_copy; -- >.0  \(~.<)/

-- D9 부서의 부서명을 '전략기획팀'으로 수정
UPDATE dept_copy 
    SET DEPT_TITLE = '전략기획팀' --총무부
    WHERE DEPT_ID = 'D9';


-- 우선 복사본 떠서 진행
CREATE TABLE EMP_SALARY 
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, NVL(BONUS,0)AS BONUS, (SALARY + SALARY * NVL(BONUS,0))*12 AS 보너스연봉
FROM employee;

SELECT * FROM EMP_SALARY; 

-- 노옹철 급여 100 변경
UPDATE EMP_SALARY
    SET SALARY = 1000000
    WHERE EMP_NAME ='노옹철'; --370
-- 선동일 급여 700 , 보너스 0.2 변경
UPDATE EMP_SALARY
    SET SALARY = 7000000,BONUS = 0.2
    WHERE EMP_NAME ='선동일'; -- 800, 0.3
    -- 전체사원의 급여 10 인상 
UPDATE EMP_SALARY
     SET SALARY = (SALARY * 1.1 );

UPDATE EMP_SALARY
    SET 보너스연봉  = (SALARY + SALARY * BONUS)*12
    WHERE EMP_NAME = '숯이';


SELECT * FROM EMP_SALARY;

-- *  UPDATE시 서브쿼리 사용 가능
/*
    UPDATE 테이블명
    SET 컬럼명 = (바꿀값 => 서브쿼리)
    WHERE 조건식;
*/
-- 방명수 사원의 급여와 보너스 값을 누재식사원의 급여와 보너스 값으로 변경
UPDATE emp_salary
 SET SALARY = ( SELECT SALARY
               FROM EMP_SALARY
               WHERE EMP_NAME = '유재식'),
     BONUS =( SELECT BONUS
               FROM EMP_SALARY
               WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME = '방명수';

-- 다중열 서브쿼리
UPDATE emp_salary
 SET (SALARY,BONUS) = ( SELECT SALARYM, BONUS
               FROM EMP_SALARY
               WHERE EMP_NAME = '유재식')
 WHERE EMP_NAME = '방명수';

-- ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경

-- ASIA 지역에서 근무하는 사원들을 조회

UPDATE EMP_SALARY
    SET BONUS = 0.3
WHERE EMP_ID  IN (
        SELECT EMP_ID
        FROM EMP_SALARY 
        JOIN department  ON (DEPT_CODE = DEPT_ID)
        JOIN location ON (LOCATION_ID = LOCAL_CODE)
        WHERE LOCAL_NAME LIKE 'ASIA%'
    );
SELECT * FROM EMP_SALARY;

------------------------------------------------------------------------------------
-- UPDATE 시에도 해당 컬럼에 대한 제약조건 위배되면 안됨!
-- 사번이 200번인 사원의 이름을 NULL로 변경

UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;
--ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL 제약 위배!!

-- 노옹철 사원의 직급코드 J9로 변경
UPDATE EMPLOYEE
SET JOB_CODE = 'D9'
WHERE EMP_NAME = '노옹철';
-- ORA-02291: integrity constraint (KH.SYS_C007192) violated - parent key not found
-- FOREIGN KEY 제약조건 위배!!
/*
    4. DELETE
        테이블에 기록된 데이터를 삭제하는 구문 (한 행 단위로 삭제 됨)
        
    [표현식]
    DELETE FROM 테이블명
    [WHERE 조건]; --> WHERE절 제시 안하면 전체 행 삭제!
*/

-- 차은우 사원의 데이터 지우기

DELETE FROM employee
WHERE EMP_NAME = '숯이';

SELECT * FROM EMPLOYEE;

 -- DEPT_ID가 D1인 부서를 삭제
 DELETE FROM department
 WHERE DEPT_ID = 'D1';
-- ORA-02292: integrity constraint (KH.SYS_C007191) violated - child record found
-- 외래키 제약 조건
-- D1을 가져다 쓰는 자식데이터가 있기 때문에 삭제 안됨!!

-- DEPT_CODE = D3 인경우삭제

DELETE FROM department
WHERE DEPT_ID = 'D3';
SELECT * FROM department;

-- * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문
--              DELETE보다 수행속도가 빠름
--              별도의 조건 제시 불가, 롤백 불가하다
-- [표현식] TRUNCATE TABLE 테이블명

SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;




