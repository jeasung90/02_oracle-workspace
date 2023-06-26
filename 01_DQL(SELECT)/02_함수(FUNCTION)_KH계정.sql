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

SE











