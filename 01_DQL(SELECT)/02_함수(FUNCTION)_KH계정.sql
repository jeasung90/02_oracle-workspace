-- 저장하기
/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어드려서 함수를 실행한 결과를 반환함
    
    - 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴(매 행 마다 함수 실행 결과 반봔)
    - 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT 절에 단일행 함수, 그룹 함수 같이 사용 못함!!
    왜? 결과 행의 개수가 다르기 때문

    >> 함수식을 기술 할 수 있는 위치 : SELCET절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
 
*/

/*
    < 문자 처리 함수 >
    
    ●LENGTH / LENGTHB   => 결과값 NUMBER타입
    
    LENGTH(컬럼|'문자열값')  : 해당 문자열 값의 글자 수 반환
    LENGTHB(컬럼|'문자열값') : 해당 문자열 값의 바이트 수 반환
    
    '김', '나', 'ㄱ'  한 글자당 3BYTE
    영문자, 숫자 특문  한 글자당 1BYTE
*/

SELECT SYSDATE
FROM DUAL; -- 가상테이블! 테이블 쓸 거 없을때 쓰는것!

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
    EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM employee; -- 매행마다 다 실행되고 있음 ! -> 단일행 함수


/*
    < INSTR > 
    특정 문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼|'문자열','찾고자하는 문자', ['찾을위치 시작값',[순번]]) => 결과값은 NUMBER 타입!!
    - 위치 찾아줌
    찾을위치의 시작값
    1  : 앞에서부터 찾겠다.
    -1 : 뒤에서부터 찾겠다.
*/

SELECT INSTR('AABAACAABBAA','B')FROM DUAL; -- 찾을 위치의 시작값은 1 기본값 => 앞에서부타 찾음, 순번도 1 기본값
SELECT INSTR('AABAACAABBAA','B',1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1)FROM DUAL;
-- 2번째 있는 'B'를 찾아 줘라
SELECT INSTR('AABAACAABBAA','B',1,2)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1,3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'_',1,1) AS "_위치", INSTR(EMAIL,'@') AS "@위치"
FROM employee; 

-- INSTR 매행마다 값을 리턴함 단일행 함수

---------------------------------------------------------------------------------

/*
    < SUBSTR >
    문자열에서 특정 문자열을 추출해서 반환 (자바에서 subtring() 메소드와 유사)
    
    3) => 결과값이 CHARACTER 타입
    - STRING    : 문자타입컬럼 또는 '문자열값'
    - POSITION  : 문자열을 추출할 시작 위치값
    - LENGTH    : 추출할 문자 개수 (생량시 끝까지 의미)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY',-8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1)AS "성별"
FROM employee;

-- 여자 사원만 조회
SELECT EMP_NAME
FROM employee
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

-- 남자 사원만 조회
SELECT EMP_NAME
FROM employee
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3') -- 주민번호에서 XXXXXX - 에서 '-'는 숫자열 아님 그러나 내부적으로 자동 형변환 돼버림
ORDER BY 1; -- 기본적으로 오름차순이다

-- 함수 중첩사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL ,'@')-1)AS "아이디"
FROM employee;

--------------------------------------------------------------------------------------------------------------

/*
    ● LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LPAD / RPAD ( STRING, 최종적으로 반환할 문자의 길이, [텃붙이고자 하는 문자])
    
    문자열에 더붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이 만큰의 문자열을 반환
*/

SELECT EMP_NAME, RPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략시 기본값이 공백
FROM employee;


SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM employee;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM employee;

SELECT RPAD('850101-2',14,'*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM employee;

SELECT EMP_NAME ,SUBSTR(EMP_NO,1,8)||'******'
FROM employee;

----------------------------------------------------------------------
/*
    LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM / RTRIM (STRING,['제거할문자들']=> 생략하면 공백제거
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 문자열 반환
*/

SELECT LTRIM('                  바   보 ')FROM DUAL; --왼쪽에서부터 공백을 찾아 제거하고 공백아닌 문자가 나오면 종료
SELECT LTRIM('123123KH123','123')FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC')FROM DUAL; -- 한글자씩 비교해서 제거 패턴은 상관없음

SELECT RTRIM('5782KH123','1234567890')FROM DUAL;
SELECT RTRIM(LTRIM('5782KH123','1234567890'),'1234567890')FROM DUAL;

/*
    ● TRIM
    문자열의 앞 / 뒤 / 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    
    TRIM([LEADING, TRAILING, BOTH] 제거하고자 하는 문자들 FROM] STRING)
    
*/

-- 기본적으로는 양쪽에 있는 문자들 다 찾아서 제거
SELECT TRIM('          K  H       ')FROM DUAL; - 앞과뒤의 공간 제거
SELECT TRIM('Z'FROM'ZZZZZZZZKZZZZHZZZ')FROM DUAL;

--SELECT TRIM('ZZZZZZZZKZZZZHZZZ','Z')FROM DUAL; -- 안됨
SELECT TRIM(LEADING'Z'FROM'ZZZZKHZZZZZ')FROM DUAL; -- LEADING : 앞 => LTRIM과 유사
SELECT TRIM(TRAILING 'Z'FROM'ZZZZKHZZZZ')FROM DUAL; -- TRAILING : 뒤 => RTRIM과 유사
SELECT TRIM(BOTH 'Z'FROM'ZZZZKHZZZZ')FROM DUAL;-- BOTH : 양쪽 => 생략시 기본값

/*
    ● LOWER / UPPER / INITCAP
    
     LOWER / UPPER / INITCAP (STRIN) => 결과값은 CHARACTER 타입
    
    LOWER   : 다 소문자로 변경한 문자열 반환(자바에서의 toLowercast() 메소드와 유사)
    UPPER   : 다 대문자로 변경한 문자열 반환(자바에서의 toUpercast() 메소드와 유사)
    INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
    
*/

SELECT LOWER('Wellcome to my world')from dual;
SELECT upPER('Wellcome to my world')from dual;
SELECT INITCAP('Wellcome to my world')from dual;

-------------------------------------------------------------------------------------
/*
    ● CONCAT
    문자열 두개 전달받아 하나로 합친 후 결과 반환
    
    CONCAT(STRING, STRING) => 결과값 CHARACTER 타입
    
*/

SELECT CONCAT('ABC','초콜릿') FROM DUAL;
SELECT 'ABC'||'초콜릿' FROM DUAL; 

-- SELECT CONCAT('ABC','초콜릿','123') FROM DUAL; - 안됨 오류 발생 2개초과의 연산자를 받을 수 없음
SELECT 'ABC'||'초콜릿'||'123' FROM DUAL;

-------------------------------------------------------------

/*
    ● REPLACE
    
    REPLACE (STRING , 바뀔문자, 바꾼문자 ) => 결과값은  CHARACTER

*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
    < 숫자 처리 함수 >
    
    1. ABS
        숫자의 절대값을 구해주는 함수
    
    ABS(NUMBUR) => 결과값 NUMBUR 타입
    
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7)FROM DUAL;

/*
    2. MOD
    두 수를 나눈 나머지값을 반환해주는 함수
    
    MOD(NUM,NUM) => 결과값도 NUMBER 타입
*/

SELECT MOD(10,3)FROM DUAL;
SELECT MOD(10.9,3)FROM DUAL;

/*
    3. ROUND
    반올림한 결과를 반환
    
    ROUND(NUM , [위치]) => 결과값 NUMBUR
    
*/

SELECT ROUND(123.456)FROM DUAL;-- 위치 생략시 0번째 자리부터
SELECT ROUND(123.456,1)FROM DUAL;
SELECT ROUND(123.456,5)FROM DUAL; -- 그대로 나옴
SELECT ROUND(123.456,-1)FROM DUAL;
SELECT ROUND(123.456,-2)FROM DUAL;

/*
    4. CEIL(NUM)
    올림처리 해주는 함수
*/
SELECT CEIL(123.125)FROM DUAL; -- 5이상 아니어도 그냥올림!! 위치지정 불가

/*
    5. FLOOR
    소수점 아래 버림처리하는 함수
    
    FLOOR(NUM)
*/
SELECT FLOOR(123.152)FROM DUAL;-- 무조건 버림 위치지정 불가능함!
--------------------------------------------------------------------------------
/*
    6. TRUNC (절삭하다)
    위치 지정 가능한 버림처리 해주는 함수
*/
SELECT TRUNC(123.346)FROM DUAL; -- 위치지정 안하면 FLOOR이랑 동일함
SELECT TRUNC(123.346,1)FROM DUAL;-- 소수점 아래 첫째 자리까지 표현하고 싶다

------------------------------------------------------------------------------------
/*
    < 날짜 처리 함수 >
*/

-- ● SYSDATE : 시스템 날찌 및 시간 반환
SELECT SYSDATE FROM DUAL;
-- ● MONTHS_BETWEEN (DATE1,DATE2) : 두 날짜 사이의 개월 수 내부적으로 DATE1 - DATE2 후 나누기 30,31이 진행될거임
-- => 결과값은 NUMBER 타입
-- EMPLOYEE 에서 사원며으 입사일, 근무일수, 근무개월수
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE -- 가능하나 지저분함
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,FLOOR( SYSDATE - HIRE_DATE ) || '일' AS "근무일수"
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE,FLOOR( SYSDATE - HIRE_DATE ) || '일' AS "근무일수",
 FLOOR(MONTHS_BETWEEN( SYSDATE , HIRE_DATE ) ) ||'개월' AS "근무개월수"
FROM EMPLOYEE;

-- ● ADD_MONTHS(DATE,NUM) : 특정 날짜에서 해당 숫자만큼 개월수를 더해서 날짜리턴
--=> 결과값 DATE 타입
SELECT ADD_MONTHS(SYSDATE,6)FROM DUAL;

-- 사원명, 입사일, 입사 후 6개월 된 날짜
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE , 6 ) AS "수습끝난날"
FROM EMPLOYEE;

-- ● ENXT_DAY(DATE,요일): 특정날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
--=> 결과값 DATE 타입
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금요일')FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금')FROM DUAL;
-- 1.일요일, 2. 월요일 ........
SELECT SYSDATE, NEXT_DAY(SYSDATE,7)FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY')FROM DUAL; -- 현재 언어가 KOREAN 이기 때문에 못알아 먹음

-- 언어변경

SELECT * FROM NLS_SESSION_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- ● LAST_DAY(DATE) : 해당 월의 마지막 날짜를 구해서 반환
--=> 결과값 DATE 타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 사원명, 입사일, 입사한달의 마지막날짜, 입사한 달의 근무한 일수
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    ● EXTRACT : 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수
    
    EXTRACT(YEAR FORM DATE)     : 년도만 추출
    EXTRACT(MONTH FORM DATE)    : 달만 추출
    EXTRACT(DAY FORM DATE)      : 일만 추출
    => 결과값은 NUMBER 타입
*/

-- 사원명, 입사년도, 입사월, 입사일 조회

SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도","입사월","입사일";

/*
    < 형변환 함수 >
    
    ● TO_CHAR : 숫자타입 또는 날짜타입의 값을 문자타입으로 변환시켜주는 함수
    
    TO_CHAR(숫자|날짜,[포멧]) => 결과값은 CHARACTER 타입
    
*/
-- 숫자타입 -> 문자타입
SELECT TO_CHAR(1234) FROM DUAL; -- 문자 '1234'로 바뀜
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5칸짜리로 공간 확보, 오른쪽 정렬, 빈칸 공백
SELECT TO_CHAR(1234,'00000') FROM DUAL;
SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- 현재 설정된 나라(LOCAL)의 화폐단위로 출력
SELECT TO_CHAR(1234,'$99999') FROM DUAL;

SELECT TO_CHAR(1234,'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')
FROM EMPLOYEE;

-- 날짜 타입 => 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 클릭해보면 다름 
SELECT TO_CHAR(SYSDATE,'PM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON,YYYY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YY-MM-DD')
FROM EMPLOYEE;

-- EX) 1990년 2월 6일 형식으로 
SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YY"년"MM"월"DD"일"')AS "입사날짜" -- 없는 포멧 제시할떄는 ""로 묶기
FROM EMPLOYEE;

-- 년도와 관련된 포멧
SELECT TO_CHAR(SYSDATE,'YYYY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'RRRR')FROM DUAL; -- 50년대 이후는 1900년대로 표현
SELECT TO_CHAR(SYSDATE,'RR')FROM DUAL;

-- 월과 관련된 포멧
SELECT
TO_CHAR(SYSDATE,'MM'),
TO_CHAR(SYSDATE,'MON'),
TO_CHAR(SYSDATE,'MONTH'),
TO_CHAR(SYSDATE,'RM')
FROM DUAL;

-- 일과 관련된 포멧
SELECT
TO_CHAR(SYSDATE,'DDDD'), -- 올해 기준으로 오늘이 며칠째인지
TO_CHAR(SYSDATE,'DD'),   -- 월 기준으로 오늘이 며칠째인지
TO_CHAR(SYSDATE,'D'),    -- 주 기준으로 오늘이 며칠째인지
FROM DUAL;

-- 요일과 관련된 포멧
SELECT
TO_CHAR(SYSDATE,'DAY'), -- 월요일
TO_CHAR(SYSDATE,'DY'),  -- 월
FROM DUAL;


--------------------------------------------------------------

/*
    ● TO_DATE
    
    TO_DATE(숫자|문자, [포멧])
*/
SELECT TO_DATE(20100101)FROM DUAL;
SELECT TO_DATE(100101)FROM DUAL;

SELECT TO_DATE(070101)FROM DUAL;--에러
SELECT TO_DATE('070101')FROM DUAL; -- 숫자타입은 첫글짜가 묶어서 문자타입으로 변경해야함

SELECT TO_DATE('041030 143000','YYMMDD HH24MISS')FROM DUAL;

SELECT TO_DATE('140630','YYMMDD')FROM DUAL; -- 2098 => 무조건 현재세기로 반영 무조건 20붙임
SELECT TO_DATE('980630','RRMMDD')FROM DUAL; -- 1998로 나옴
-- RR: 해당 두자리 년도 값이 50미만일 경우 현재 세기반영, 50이상일 경우 이전세기 반영

/*
    ● TO_NUMBUR : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자,[포멧]) => NUMBER값
*/

SELECT TO_NUMBER('0512456')FROM DUAL;  -- 0이 빠져서 숫자타입으로 변환 맞음

SELECT '100000'+'5500' FROM DUAL; -- 오라클에서는 자동형변환 잘 돼있음

SELECT '100,000'+'5,500' FROM DUAL; -- 오류남!! 숫자만 있어야 자동형변환 됨!
SELECT TO_NUMBER('10,000,000','99,999,999')+ TO_NUMBER('55,000','99,999')FROM DUAL; -

/*
    < NULL 처리 함수 )
*/
-- NVL(컬럼, 해당 컬럼이 NULL일 경우 반환할 값)
SELECT EMP_NAME, NVL(BONUS,0)
FROM EMPLOYEE;

-- 전 사원의 이름 보너스 포함 연봉
SELECT EMP_NAME,( SALARY + SALARY * NVL(BONUS,0))*12
FROM EMPLOYEE;

SELECT DEPT_CODE, NVL(DEPT_CODE, '부서없음')
FROM EMPLOYEE;

-- NVL2(컬럼 ,반환값1, 반환값2)
-- 컬럼값이 존재할경우 반환값 1 반환 
-- 컬럼값이 NULL일 경우 반환값 2 반환

SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7,0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '부서있음', '부서없음')
FROM EMPLOYEE;

-- NULLIF(비교대상1,비교대상2)
-- 두개의 값이 일치하면 NULL 반환
-- 두개의 값이 일치하지 않으면 비고대상 1 반환
SELECT NULLIF('123','123')FROM DUAL;
SELECT NULLIF('123','456')FROM DUAL;

/*
    < 선택 함수 >
    
    ● DECODE(비교하고자 하는 대상(컬럼|산술연산|함수식)
*/
-- 사번, 사원명, 주민번호
SELECT EMP_ID,EMP_NAME,EMP_NO, SUBSTR(EMP_NO,8,1),
DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') AS 성별
FROM EMPLOYEE;

-- 직원들 급여 조회시 각 직급별로 인상해서 조회
-- J7인 사원은 급여 10%인상 (SALART * 1.1)
-- J6인 사원은 급여 15%인상 (SALART * 1.15)
-- J5인 사원은 급여 20%인상 (SALART * 1.2)
-- 그외의 사원은 급여 5%인상 (SALART * 1.05)

-- 사원명, 직급코드, 기존급여, 인상된급여
SELECT EMP_NAME, JOB_CODE, SALARY,
    DECODE(JOB_CODE, 'J7', SALARY *1.1,
                     'J6', SALARY *1.15,
                     'J5', SALARY *1.2,
                      SALARY *1.05) AS "인상된급여"
FROM EMPLOYEE;

/*
    ● CASE WHEN THEN
    
    CASE WHEN 조건식 1 THEN 결과값 1
         WHEN 조건식 2 THEN 결과값 2
         .....
         ELSE 결과값 N
    END
    
    자바에서 IF - ELSE IF - ELSE 문
*/

SELECT EMP_NAME, SALARY,
    CASE WHEN SALARY >= 5000000 THEN '고급개발자'
         WHEN SALARY >= 3500000 THEN '초급개발자'
         ELSE '초급'
         END AS "레벌"
FROM EMPLOYEE;

-----------------------< 그룹함수 >----------------------------
-- 1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계를 구해서 반환해주는 함수

-- 전사원의 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 전체사원이 한 그룹으로 묶임

-- 남자 사원들의 총 급여
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1','3');

-- 부서코드가 D5인 사원들의 총 연봉의 합
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(여러타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
SELECT MIN(EMP_NAME), MIN(SALARY),MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(여러타입) : 해당 컬럼값들 중에 가장 큰값을 구해서 반환
SELECT MAX(EMP_NAME), MAX(SALARY),MAX(HIRE_DATE)-- , EMP_NAME
FROM EMPLOYEE;

-- 5. COUNT (*|컬럼|DISTINCT컬럼) : 조회된 행 개수를 세서 반환
--    COUNT(*) : 조회된 결과의 모든 행 개수를 세서 반환
--    COUNT(컬럼): 제시한 해당 컬럼값이 NULL아닌것만 세줌
--    COUNT(DISTINCT컬럼) : 해당 컬럼값 중복을 제거 한 후 행 게수 세서 반환

SELECT COUNT(*)
FROM EMPLOYEE;

-- 여자사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)IN('2','4');

SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- 부서배치 받은 사원
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 현재 사원들이 몇개의 부서에 분포되어 있는지
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;




