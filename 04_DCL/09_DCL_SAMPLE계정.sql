CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(30)
);
-- CREATE TABLE 할 수 있는 권한이 없어서 문제 발생!
-- 3.1) CREATE TABLE 권한 받기
-- 3.2) TABLESPACE 할당 받기

SELECT * FROM test;
INSERT INTO TEST VALUES(10,'바보');
-- CREATE TABLE 권한 받으면 바로 조작 가능

------------------------------------------------------------
-- KH계정에 있는 EMPLOYEE 테이블에 접근
-- 근데 조회할 수 있는 권한이 없어서 안됨..

-- 4. SELECT ON KH.EMPLOYEE 권한 부여 받음
SELECT * FROM KH.EMPLOYEE;

-- 5. INSERT ON KN.DEPARTMENT 권한 부여 받음
INSERT INTO KH.DEPARTMENT 
VALUES('D0','회계부','L1');
SELECT * FROM KH.DEPARTMENT;

















