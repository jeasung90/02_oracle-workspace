/*
    < VIEW 뷰 >
    
    SELECT문 (쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 그긴 SELECT문을 매번 다시 기술할 필요 없음!!)
    임시테이블 같은 존재 ( 실제 데이터가 담겨있는 건 아님!!) => 보여주기용
    물리적인 테이블 : 실제!
    논리적인 테이블 : 가상! => 뷰는 논리적인 테이블이다!
*/

-- 뷰를 만들기 위한 복잡한 쿼리문 작성
-- 관리자페이지

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '한국';
-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '러시아';
-- '일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE)
WHERE national_name = '일본';


--------------------------------------------------------------------------------
/*
    1. VIEW 생성 방법
    
    [표현식]
    CERATE VIEW 뷰명
    AS 서브쿼리;
    
    [OR REPLACE] : 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새로이 뷰를 생성하고,
                            기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
*/

CREATE VIEW VW_EMP
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE);
-- 01031. 00000 -  "insufficient privileges"
-- privileges : 권한 => 권한이 없다는 거임

-- 관리자 계정에 접속해서 권한 부여
GRANT CREATE VIEW TO KH;

-- 이건 실제있는 테이블이 아님! 그래서 가상, 논리테이블인거임
SELECT * FROM vw_emp;

-- 아래와 같은 맥락
SELECT * 
FROM (  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national.national_name
        FROM EMPLOYEE
        JOIN department ON ( DEPT_ID = DEPT_CODE)
        JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
        JOIN national USING ( NATIONAL_CODE)
);

-- 한국 러시아 일본 근무하는 사원
SELECT * 
FROM vw_emp
WHERE national_name = '한국';

-- [참고]
SELECT * 
FROM  USER_VIEWS;

-- 만약 뷰에 뭘 하나 더 추가하고 싶을경우
CREATE OR REPLACE VIEW VW_EMP
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, national_name, BONUS
FROM EMPLOYEE
JOIN department ON ( DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN national USING ( NATIONAL_CODE);
-- 00955. 00000 -  "name is already used by an existing object"
-- 이미 해당 이름을 사용하는 뷰가 있다고 에러가 남!!
SELECT * FROM vw_emp;

-----------------------------------------------------------------------------------
/*
    * 뷰 컬럼에 별칭 부여
    서브쿼리의 SELECT절 함수식이나 산술연산식이 기술되어 있을 경우 반드시 별칭 지정 해야됨!!
*/

-- 전 사원의 사번, 이름, 직급명, 성별(남/여), 근무년수를 조회할 수 있는 SELECT문을 뷰(VW_EMP_JOB)로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') AS "성별(남/녀)", 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS 근무년수
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);

SELECT *
FROM vw_emp_job;

-- 아래와 같은 방식으로도 별칭 부여 가능하다
CREATE OR REPLACE VIEW VW_EMP_JOB(사번,이름,직급명,성별,근무년수) -- 단, 모든컬럼에 대해서 별칭 부여해야함!!
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') , 
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);
        
SELECT 이름, 직급명
FROM vw_emp_job
WHERE 성별 = '여';
        
SELECT *
FROM vw_emp_job
WHERE 근무년수 >= 20;
        
-- 뷰를 삭제하고자 한다면 
DROP VIEW VW_EMP_JOB;
        
 -------------------------------------------------------------------------------
 -- 생성된 뷰를 이요해서 DML(INSERT, UPDATE, DELETE)사용 가능
 -- 뷰를 통해 조작하더라도 실제 데이터가 담겨있는 베이스테이블에 반영됨
 -- 근데 잘 안되는 경우가 많아서 실제로 많이 쓰지는 않음
        
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM vw_job; -- 논리적인 테이블 (실제 데이터가 담겨있지 않다)
SELECT * FROM JOB; -- 베이스 테이블 (실제 데이터가 담겨있음)

-- 뷰를 통해서 INSERT
INSERT INTO vw_job VALUES('J8','인턴');
        
-- 뷰를 통해서 UPDATE
UPDATE vw_job SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';
        
-- 뷰를 통해서 DELETE
DELETE
FROM VW_JOB
WHERE JOB_CODE = 'J8';

/*
    * 단, DML 명령어로 조작이 불가능한 경우가 더 많음
    1) 뷰에 정의되어있지 않은 컬럼을 조작하려고 하는 경우
    2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우 => 경우에 따라 다름
    3) 산술연산식 또는 함수식으로 뷰가 정의되어있는 겅우
    4) 그룹함수나 GROUP BY 절이 포함된 경우
    5) DISTINCT 구문이 포함된 경우
    6) JOIN을 이용해서 여러 테이블을 연결시켜놓은 경우
    => 뷰는 조회하려고 만든거라서 DML은 하지말자!!
*/
        
        
-- 1) 뷰에 정의되어있지 않은 컬럼을 조작하려고 하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
    FROM JOB;
SELECT * FROM vw_job;
-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES ('J8','인턴스');
-- ORA-00904: "JOB_NAME": invalid identifier

-- UPDATE (에러)
UPDATE VW_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';

-- DELETE
DELETE FROM vw_job
WHERE JOB_NAME = '사원';

-- 2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL 제약조건이 지정되어 있는 경우 => 경우에 따라 다름
CREATE OR  REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB VALUES ('인턴'); -- 실제 베이스 테이블에 INSERT 시 ( NULL,'인턴') 추가한거다
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- UPDATE -- 가능
UPDATE vw_job
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';

-- DELETE (이 데이터를 쓰고 있는 자식데이타가 존재하기 때ㅑ문에 삭제 제한 / 단, 없다면 삭제 가능!!)
DELETE VW_JOB 
WHERE JOB_NAME = '사원';

-- 3) 산술연산식 또는 함수식으로 뷰가 정의되어있는 겅우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS 연봉
    FROM employee;
    
SELECT * FROM vw_emp_sal; -- 논리테이블
SELECT * FROM EMPLOYEE; -- 베이스테이블

INSERT INTO vw_emp_sal VALUES (400,'이지은',50000000,600000000);
-- 01733. 00000 -  "virtual column not allowed here"
-- EMPLOYEE 에는 연봉이라는 테이블이 없음!!

-- UPDATE 
-- 200번 사원의 연봉을 8000만원으로 
UPDATE VW_EMP_SAL
SET 연봉 = 80000000
WHERE EMP_ID = 200;

-- 200번 사원의 급여를 700만원으로
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200;-- 성공 

-- DELETE (성공)
DELETE FROM vw_emp_sal
WHERE 연봉 = 72000000;

-- 4) 그룹함수나 GROUP BY 절이 포함된 경우
CREATE OR REPLACE VIEW VW_GPDE
AS SELECT DEPT_CODE, SUM(SALARY) AS 합계 , FLOOR(AVG(SALARY)) AS 평균
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 머슦^^

-- INSERT (에러)
INSERT INTO vw_gpde VALUES ('D3',8000000,4000000);
-- 실제로 EMP에 넣기가 애매함.. 그래서 안됨

-- UPDATE 
UPDATE vw_gpde
SET 합계 = 800000
WHERE DEPT_CODE = 'D1';
-- 이것도 딱히 어디를 수정하기가 애매함

-- DELETE 
DELETE 
FROM vw_gpde
WHERE 합계 = 5210000;
-- 이것도 딱히 어디를 삭제하기가 애매함

-- 5) DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT  JOB_CODE
    FROM EMPLOYEE;
    
SELECT * FROM vw_dt_job;

-- INSERT
INSERT INTO vw_dt_job VALUES ('J8'); -- 앙댐

-- UPDATE
UPDATE vw_dt_job 
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7'; -- 앙댐

-- DELETE 
DELETE  FROM vw_dt_job
WHERE JOB_CODE = 'J7'; -- 앙댐

-- 6) JOIN을 이용해서 여러 테이블을 연결시켜놓은 경우
CREATE OR REPLACE VIEW VW_JOIN
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN department ON ( DEPT_CODE = DEPT_ID);
    
 
    
SELECT * FROM VW_JOIN;
 
-- INSERT
INSERT INTO VW_JOIN VALUES (300,'숯이','총무부'); -- 앙댐

-- UPDATE 
UPDATE vw_join 
SET EMP_NAME = '선동이'
WHERE EMP_ID = 200; -- 가능
-- UPDATE 2
UPDATE vw_join 
SET DEPT_TITLE = '선동이'
WHERE EMP_ID = 200; -- 앙댐
-- EMP에는 DEPT_TITLE 이 없음

-- DELETE 
DELETE FROM VW_JOIN
WHERE EMP_ID = 200;-- 가능
        
---------------------------------------------------------------------------------------
/*
    * VIEW 옵션
    
    [상세표현식]
    CREATE [OR REPLACE] [FORCE | NOFORCE(기본값)] VEIW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY]; => 오로지 조회만 가능
    
    1. RO REPLACE : 기존에 동일한 뷰가 있을 경우 갱신시키고, 없으면 새로이 생성시킴
    2. FORCE | NOFROCE 
        > FORCE     : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는
        > NOFORCE   : 서브쿼리에 기술된 테이블이 존재하는 테이블이어야만 뷰가 생성되게 하는
    3. WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML을 가능하도록
    4. WITH READ ONLY    : 뷰에 대해서 조회만 가능한 기능 ( DML 불가능함 )
        
*/
        
-- 2) FORCE | NOFROCE 
--    NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이어야만 뷰가 생성되게 하는 (생략시 기본값)
CREATE OR REPLACE /* NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE,TNAME, TCONTENY
FROM TT;
-- ORA-00942: table or view does not exist
-- 해당 테이블이 없어서 오류남!

-- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성되게 하는
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE,TNAME, TCONTENT
FROM TT;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM VW_EMP;-- 조회는 안됨
-- TT 테이블 생성해야만 그 때부터 뷰를 활용 가능

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(30)
);

-- 3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정시 오류 발생
-- WITH CHECK OPTION 안주고
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VW_EMP;
  
-- 200번 사원의 급여를 200만원으로 변경 (서브쿼릐 조건에 부합하지 않는 값으로 변경 시도 )
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200;
 
-- WITH CHECK OPTION 주고 
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;
    
SELECT * FROM VW_EMP; 
  
UPDATE VW_EMP
SET SALARY = 2000000
WHERE EMP_ID = 200; -- 오류남 : 서브쿼리에 기술된 조건에 부합하지 않기 때문에 변경 불가
  
UPDATE VW_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200;  -- 서브쿼리에 기술한 조건에 부합되기 때문에 변경가능

-- 4) WITH READ ONLY : 뷰해 대해 조회만 가능 (DML문 수행 불가)
CREATE OR REPLACE VIEW VW_EMP
AS SELECT EMP_ID, EMP_NAME, BONUS
    FROM EMPLOYEE
    WHERE BONUS IS NOT NULL
WITH READ ONLY;

SELECT * FROM VW_EMP;

-- DELETE 
DELETE FROM VW_EMP
WHERE EMP_ID = 200;
-- ORA-42399: cannot perform a DML operation on a read-only view
-- 읽기전용임














