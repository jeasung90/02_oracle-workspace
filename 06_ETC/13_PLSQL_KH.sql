/*
    < PL / SQL >
    PROCEDUERE LANGUAGE EXTENSION TO SAL
    
    오라클 자체에 내장되어 있는 절차적 언어
    SQL 문장내에서 변수의 정의, 조건처리(IF), 반복처리(FOOP, FOR, WHILE)등을 지원하면 SQL의 단점 보완
    다수의 SQL문을 한 번에 실행할 가능 (BLOCK 구조) + 예외처리도 가능
    
    * PL/ SQL 구조
    - [선언부]     : DECLARE로 시작, 변수나 상수를 선언 및 초기화 하는 구문
    - 실행부       : BEGIN으로 시작, 무조건 있어야 함! SQL문 또는 제어문(조건문, 반복문)등의 로직을 기술하는 부분
    - [예외처리부]  : EXCEPTION으로 시작, 예외 발생시 해결하기 위한 구문을 미리 기술해둘 수 있는 구문
*/
  
  SET SERVEROUTPUT ON;
    
    -- * 간단하게 화면에 HELLO ORACLE 출력! HELLO WORLD 출력했던 것 처럼...
BEGIN
    -- System.out.println("hello oracle");
    DBMS_OUTPUT.put_line('HELLO ORACLE');
END;
/

-------------------------------------------------------------------------------------------
/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간 (선언과 동시에 초기화도 가능)
    일반타입변수, 레퍼런스타입변수, ROW타입변수
    
    1.1) 일반타입변수 선언 및 초기화
        [표현식] 변수명 [CONSTANT-> T상수가 됨] 자료형[:= 값];
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- EID := 800;
    --ENAME := '이지은';
    
    EID := &번호;
    ENAME := '&이름';
    
    DBMS_OUTPUT.put_line('EID: ' || EID);
    DBMS_OUTPUT.put_line('ENAME: ' || ENAME);
    DBMS_OUTPUT.put_line('PI: ' || PI);
END;
/

------------------------------------------------------------------------------------
-- 1.2) 레퍼런스 타입 변수 선언 및 초기화 (어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
--      [표현식] 변수명 참조할테이블명.컬럼명%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;   
BEGIN
--    EID := 300;
--    ENAME := '자기이름';
--    SAL := 8000000;
    -- 사번이 200번인 사원의 사번, 사원명, 급여 조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM employee
   -- WHERE EMP_ID = 200;
   WHERE EMP_ID = '&사번';
    DBMS_OUTPUT.put_line('EID : ' || EID );
    DBMS_OUTPUT.put_line('ENAME : ' || ENAME);
    DBMS_OUTPUT.put_line('SAL : ' || SAL);
    
END;
/

----------------- 실습문제 ------------------------------
/*
    레퍼런스타입 변수로 EID, EANEM, JCODE, SAL, DTITLE 을 선언하고
    각 자료형이 EMP,DPT 테이블 참조하도록
    
    사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명을 조회한 후 각 변수에 담아서 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE,SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN department ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.put_line('EID : ' || EID);
    DBMS_OUTPUT.put_line('ENAME : ' || ENAME);
    DBMS_OUTPUT.put_line('JCODE : ' || JCODE);
    DBMS_OUTPUT.put_line('SAL : ' || SAL );
    DBMS_OUTPUT.put_line('DTITLE : ' || DTITLE);

END;
/
    
---------------------------------------------------------------------------------
-- 1.3) ROW타입 변수 선언
--      테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
--      [표현식] 변수명 테이블명%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * -- 모든컬럼에 해당하는 값을 넣어야 함!
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
--    DBMS_OUTPUT.put_line(E);
      DBMS_OUTPUT.put_line('사원명 : ' || E.EMP_NAME);
      DBMS_OUTPUT.put_line('급여 : ' || E.SALARY);
      DBMS_OUTPUT.put_line('보너스 : ' || NVL(E.BONUS,0));
END;
/
-------------------------------------------------------------------------------------
-- 2. BEGIN 실행부

-- < 조건문 >

-- 1) IF 조건식 THEN 실행내용 END IF; (단독 IF문)

-- 사번 입력받은 후 새당 사원의 사번, 이름, 급여, 보너스율(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.put_line('사번 : ' || EID);
    DBMS_OUTPUT.put_line('이름 : ' || ENAME);
    DBMS_OUTPUT.put_line('급여 : ' || SAL);
    IF BONUS= 0
        THEN  DBMS_OUTPUT.put_line('보너스를 지급받지 않는 사원입니다.');
    END IF;
     DBMS_OUTPUT.put_line('보너스 : ' || BONUS);
END;
/

-----------------------------------------------------------------------------------------------
-- 2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.put_line('사번 : ' || EID);
    DBMS_OUTPUT.put_line('이름 : ' || ENAME);
    DBMS_OUTPUT.put_line('급여 : ' || SAL);
    IF BONUS= 0
        THEN  DBMS_OUTPUT.put_line('보너스를 지급받지 않는 사원입니다.');
    ELSE
     DBMS_OUTPUT.put_line('보너스 : ' || BONUS);
    END IF;
END;
/
------------- 실습문제 -------------------------

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    
    -- 일반타입변수 ( TEAM 문자열 ) 이따가 '국내팀' 또는 '해외팀' 담을 예정
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = '&사번';

    IF NCODE = 'KO' THEN
        TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.put_line('사번 : ' || EID);
    DBMS_OUTPUT.put_line('이름 : ' || ENAME);
    DBMS_OUTPUT.put_line('부서 : ' || DTITLE);
    DBMS_OUTPUT.put_line('소속 : ' || TEAM);
END;
/

------------------------------------------------------------------------------------.
-- 3) IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ...... ELSE 실행내용 END IF
-- 점수를 입력받아 SCORE 변수에 저장 한 후
-- 90점 이상은 A , 80점이상 B , 70점 이상 C, 60점 이상 D, 60점 미만 F
-- GRADE 변수에 저장
-- 당신의 점수는 XX점이고, 학점은 X 학점입니다.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
    
BEGIN
    SCORE := '&점수';
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
     DBMS_OUTPUT.put_line('당신의 점수는 ' || SCORE || '점이고, 학점은 ' || GRADE || '학점 입니다.');
    
END;
/
-------------------------------------------------------------------------------------
-- 4) CASE 비교대상자 WHEN 동등비교할값1 THEN 결과값1 WHEN 비교값2   THEN 결과값 2 .... ELSE 결과값  END;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- 부서명 보관 변수

BEGIN
    SELECT * 
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DNAME := CASE EMP.DEPT_CODE
        WHEN 'D1' THEN '인사팀'
        WHEN 'D2' THEN '회계팀'
        WHEN 'D3' THEN '마케팅팀'
        WHEN 'D4' THEN '국내영업팀'
        WHEN 'D9' THEN '총무팀'
        ELSE '해외영업팀' 
    END;
    
    DBMS_OUTPUT.put_line(EMP.EMP_NAME||'님은 '|| DNAME || '입니다');
END;
/
-------------------------------------------------------

-- 1. 사원의 연봉을 구하는 PL / SQL 블럭 작성, 보너스가 있는 사원은 보너스도 포함하여 계산
-- 보너스가 없으면 보너스 미포함 연봉
-- 보너스가 있으면 포함 연봉
-- 출력예씨
-- 급여, 이름, 연봉

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    SALBON VARCHAR2(40);
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF BONUS IS NULL THEN SALBON := TO_CHAR((SAL*12),'L999,999,999') ;
    ELSE SALBON := TO_CHAR((SAL+SAL*BONUS)*12,'L999,999,999');
    END IF;

    DBMS_OUTPUT.put_line(ENAME || '의 연봉은'||SALBON||'입니다.');

END;
/


DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SALARY NUMBER;
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF EMP.BONUS IS NULL THEN
        SALARY := EMP.SALARY * 12;
    ELSE
        SALARY := (EMP.SALARY + EMP.SALARY * EMP.BONUS) * 12;
    END IF;
    
    DBMS_OUTPUT.put_line(EMP.EMP_NAME || '님의 연봉은 ' || TO_CHAR(SALARY,'L999,999,999') || '입니다.');
END;
/

-------------------------------------------------------------------------------------
-- < 반복문 > 
/*
    1) BASIC LOOP문
    
    [ 표현식 ]
    LOOP
        반복적으로 실행할 구문
        * 반복문을 빠져나갈 수 있는 구문
    END LOOP;
    
    * 반복문을 빠져나갈 수  있는 구문 (2가지)
    1) IF 조건식 THEN EXIT END FI;
    2) EXIT THEN 조건식;
    
*/

-- 1 ~ 5 까지 순차적으로 1씩 증가
DECLARE
    I NUMBER :=1;
BEGIN
    
    LOOP
        DBMS_OUTPUT.put_line(I);
        I := I +1 ;
        
        IF I = 6 THEN EXIT; END IF;
    END LOOP;
END;
/

------------------------------------------------------------------------------------
/*
    2) FOR LOOP문
    
    [표현식]
    FOR 변수 IN [REVERSE -> 점점 작아지게 하고 싶으면..] 초기값..최종값
    LOOP
    
    END LOOP;
*/

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.put_line(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.put_line(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TATE DATE
);

SELECT * FROM TEST;

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
NOCACHE
NOCYCLE;

BEGIN
    FOR I IN 1..100 -- 기본적으로는 1씩 증가
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL,SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;

-----------------------------------------------------------------------------------
/*
    3) WHILE LOOP문
    
    [표현식]
    WHILE 반복문이 수행될 조건
    LOOP
        반복적으로 수행할 구문
    ENDLOOP
*/
DECLARE
    I NUMBER := 1;
BEGIN
    
    WHILE  I<6
    LOOP
        DBMS_OUTPUT.put_line(I);
        I := I+1;
    END LOOP;
    
END;
/
-----------------------------------------------------------------------------------
/*
    3. 예외처리부
    
    예외(EXCEPTION) : 실행 중 발생하는 오류
    
    [표현식]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ....
        WHEN OTHERS THEN 예외처리구문N;
        
        * 예외명에 뭘 써야할까?
        * 시스템 예외 (오라클에서 미리 정의해둔 예외)
        - NO_DATA_FOUND : SELECT 한 결과가 한 행도 없을 경우
        - TOO_MANY_ROWS : SELECT 한 결과가 여러행일 경우
        - ZERO_DIVEDE : 0으로 나눌 때
        - DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배됐을 경우
*/

-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력
DECLARE
    RESULT NUMBER;
BEGIN
    result := 10 / '&숫자';
    DBMS_OUTPUT.put_line('결과 : '||RESULT);
    
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.put_line('0으로 나눌 수 없습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.put_line('0으로 나눌 수 없습니다.');
END;
/
-- DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배됐을 경우
-- UNIQUE 제약조건 위반
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME = '노옹철';

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.put_line('이미 존재하는 사원');
END;
/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = '&사수사번';
    
    DBMS_OUTPUT.put_line('해당 사수의 이름은 : '||ENAME||', 사번은 :'||EID);

EXCEPTION
    WHEN TOO_MANY_ROWS THEN  DBMS_OUTPUT.put_line('너무 많은 행이 조회됐습니다.');
    WHEN NO_DATA_FOUND THEN  DBMS_OUTPUT.put_line('해당 사수를 가진 사원이 없습니다.');

    
END;
/





























