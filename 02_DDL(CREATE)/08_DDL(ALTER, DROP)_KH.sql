/*
    DDL ( DATE DEFINITION LANGUAGE ) : 데이터 정의 언어
    
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP) 하는 구문
    
    < ALTER >
    객체를 변경하는 구문
    
    [표현식]
    ALTER TABLE 테이블명 변경할 내용!
    
    * 변경할 애용
    1) 컬럼 추가/수정/삭제
    2) 제약조건 추가/삭제 --> 수정은 불가 (수정하고자 한다ㅏ면 삭제한 후 새로이 추가)
    3) 컬럼명/제약조건명/테이블 수정
*/

--  1) 컬럼 추가/수정/삭제
-- 1.1) 컬럼 추가(ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값] 제약조건
-- DEPT_COPY에 CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 만들어지고 기본적으로 NULL이 채워짐

-- LNAME 컬럼 추가 (기본값을 지정한체로)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

-- 1.2) 컬럼 수정(MODIFY)
--> 자료형 수정      : MODIFY 컬럼명 바꾸고자 하는 자료형
--> DEFAULT 값 수정 : MODIFY 컬럼명 DEFAULT 바꾸고자 하는 기본 값

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- 이건 오류남! 이미 데이터가 숫자가 아닌것도 들어있음
-- 존재하는 데이터가 없어야만 이렇게 바꿀 수 있음

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- 어것도 오류발생!! 이미 담겨있는 데이터가 새로이 바꾸려는 바이트보다 크기때문에

---------------- 테스트 --------------------------
-- DEPT_COPY
-- 1. DEPT_TITLE 컬럼을 VARCHAR2(50)으로
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);
-- 2. LOCATION_ID 컬럼  VARCHAR2(4)으로
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);
-- 3. LNAME 컬럼의 기본값을 '미국'으로
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';

-- 다중 변경 가능
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(5)
MODIFY LNAME DEFAULT '영국';
-- 디폴트값을 바꾼다고 해서 이번에 추가된 데이터가 바뀌는 것은 아니다!

-- 1.3) 컬럼 식제 (DROP COLUMN) : DROP COLUMN 삭제하고자 하는 컬럼
-- 삭제를 위한 복사본 테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- 다중 지우기
--ALTER TABLE DEPT_COPT2 DROP COLUMN CNAME DROP LNAME;
-- 안됨 

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- 12983. 00000 -  "cannot drop all columns in a table"
-- 다 지울 수 없음 최소 하나의 컬럼은 남아야함
DROP TABLE DEPT_COPY2;

-------------------------------------------------------------------------------------
-- 2) 제약조건 추가 / 삭제
/*
    2.1) 제약조건 추가
    PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
    FOREIGN KET : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(컬럼명)]
    UNIQUE      : ADD UNIQUE
    CHECK       : ADD CHECK (컬럼에 대한 조건 [IN (가능한문자, 가능한 문자,...)]
    NOT NULL    : MODIFY 컬럼명 NOT NULL | NULL => 이거쓰면 널 허용
    
    제약조건명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건
*/

-- DEPT_ID에 PRIMARY KEY 추가
ALTER TABLE DEPT_COPY 
ADD CONSTRAINT DCOPT_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCPY_UQ UNIQUE (DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;
-- DEPT_TITLE 에 UEIQUE 제약조건 추가
-- LNAME 엔 NN 제약조건 추가

-- 2.2) 제약조건 삭제 : DROP CONSTRAINT 제약조건명
-- NOT NULL 삭제말고 MODIFY 컬럼명 NULL 로 간다

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPT_PK;
ALTER TABLE DEPT_COPY 
 DROP CONSTRAINT DCPY_UQ
 MODIFY LNAME NULL;
 
 -------------------------------------------------------------------------
 -- 3) 컬럼명/ 제약조건명/ 테이블명 변경 (RENAME)
 -- 3.1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
 
 -- DEPY_TITLE => DEPT_NAME
 ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
 
 -- 3.2) 제약조건명 변경 : RENAME CONSTRAINT 기존 제약조건명 TO 바꿀 제약조건명
 -- SYS_C007206 => DCOPY_LID_NN
 ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007206 TO DCOPY_LID_NN;
 
 -- 3.3) 테이블명 변경 : RENAME 기존테이블명 TO 새로운테이블명
 -- ALTER TABLE 해당테이블명 RENAME TO 변결할테이블명;
 ALTER TABLE DEPT_COPY RENAME  TO DEPT_JOMBE;
 
 ----------------------------------------------------------------------------------
 /*
    < DROP >
    테이블을 삭제하는 구문
 */
 
 -- 테이블 삭제
 DROP TABLE DEPT_JOMBE; -- 이제 편히 쉬어라... 고생 많았다
 
 -- 단, 어딘가에서 참조되고 있는 부모테이블은 함부로 삭제 안됨
 -- 만약에 삭제하고자 한다면
 -- 방법1. 자식테이블을 먼저 삭제 한 후 부모테이블 삭제하는 방법 (너무 끔찍 일가족 몰살)
 -- 방법2. 그냥 부모테이블만 삭제하는데 제약조건까지 같이 삭제하는 방법 (차라리...)
 --     DROP TABLE 테이블명 CASCADE CONSTRAINT;

 
 
 
 
 
 
 
 
 
 
 