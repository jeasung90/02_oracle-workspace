--1
SELECT DEPARTMENT_NAME AS "학과 명", category AS "계열"
FROM tb_department;
--2
SELECT DEPARTMENT_NAME || '의 정원은 '||capacity ||'명 입니다.' AS "학과별 정원"
FROM tb_department;

SELECT DEPARTMENT_NAME, department_no
FROM tb_department
WHERE DEPARTMENT_NAME = '국어국문학과';

SELECT STUDENT_NAME 
FROM tb_student
WHERE ABSENCE_YN = 'Y' AND department_no = 001 
AND SUBSTR(student_ssn,8,1)=2;

SELECT STUDENT_NAME 
FROM tb_student
WHERE STUDENT_NO IN('A513079','A513090', 'A513091', 'A513110', 'A513119');

SELECT DEPARTMENT_NAME AS "학과 명", category AS "계열"
FROM tb_department
WHERE capacity >= 20 AND capacity <=30;

SELECT PROFESSOR_NAME
FROM tb_professor
WHERE DEPARTMENT_NO IS NULL;

SELECT STUDENT_NAME 
FROM tb_student
JOIN tb_department USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME IS NULL;

SELECT PREATTENDING_CLASS_NO
FROM tb_class
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

SELECT DISTINCT(CATEGORY)
FROM tb_department;

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'N' AND SUBSTR(STUDENT_ADDRESS,1,2) IN ('전주')
AND SUBSTR( ENTRANCE_DATE,1,2)='02';


SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD')AS 입학년도
FROM tb_student;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM tb_professor
WHERE NOT professor_name LIKE '___';

SELECT PROFESSOR_NAME AS 교수이름, ABS(FLOOR(MONTHS_BETWEEN(TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'RR/MM/DD'), SYSDATE)/12)+1) AS 나이
FROM tb_professor
WHERE SUBSTR(PROFESSOR_SSN,8,1)IN('1','3')
ORDER BY 2;

SELECT SUBSTR(PROFESSOR_NAME,2,6) AS 이름
FROM tb_professor;

-- 왜 다른지 모르겠습니다. 5번
SELECT STUDENT_NO, STUDENT_NAME --,EXTRACT(YEAR FROM ENTRANCE_DATE/*입학날*/) -EXTRACT(YEAR FROM TO_DATE( SUBSTR(STUDENT_SSN/*태어난년*/,1,2),'RR')) AS 입학때만나이
FROM tb_student
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE/*입학날*/) -EXTRACT(YEAR FROM TO_DATE( SUBSTR(STUDENT_SSN/*태어난년*/,1,2),'RR')) > 19;
--WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RR/MM/DD'))/12)+1 >19;




SELECT TO_CHAR(DATE '2020-12-25', 'DAY') FROM DUAL;


-- 7번 YY는 20xx이구 RR은 50년 전은 20xx이구요 이후는  19XX 입니다.

SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM tb_student
WHERE student_no NOT LIKE 'A%';

SELECT ROUND(AVG(POINT),1) AS 평점
FROM tb_grade
WHERE student_no = 'A517178';

SELECT DEPARTMENT_NO AS 학과번호,COUNT(*) AS "학생수(명)"
FROM tb_student
GROUP BY DEPARTMENT_NO
ORDER BY 1;

SELECT COUNT(*)
FROM tb_student
WHERE COACH_PROFESSOR_NO IS NULL;

SELECT SUBSTR(TERM_NO ,1,4)AS 년도, ROUND(AVG(POINT),1) AS 평점
FROM tb_grade 
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO ,1,4) 
ORDER BY 1;

SELECT DEPARTMENT_NO,
       SUM(CASE WHEN ABSENCE_YN = 'Y' THEN 1 ELSE 0 END) AS Y_COUNT
FROM tb_student
GROUP BY DEPARTMENT_NO
ORDER BY 1;
/*
SELECT STUDENT_NAME ,
FROM tb_student
*/
SELECT STUDENT_NAME, COUNT(*) 
FROM tb_student
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME;

SELECT SUBSTR(term_no,1,4)AS 년도, 
        NVL(SUBSTR(term_no,5,2),' '),
        ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY Rollup(SUBSTR(term_no,1,4) ,SUBSTR(term_no,5,2))
ORDER BY 1;
-- 합계의 NULL 어케 하쥬?


--------------------------------------------------------------------------------
-- 1.
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS 주소지
FROM tb_student
ORDER BY 1;

-- 2. 
SELECT STUDENT_NAME, STUDENT_SSN
FROM tb_student
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC ;

-- 3.
SELECT STUDENT_NAME AS 학생이름 , STUDENT_NO AS 학번 ,STUDENT_ADDRESS AS "거주지 주소"
FROM tb_student
WHERE SUBSTR(STUDENT_NO,1,2) <= '99' AND SUBSTR(STUDENT_ADDRESS,1,3) IN('경기도','강원도');

--4.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM tb_professor
WHERE DEPARTMENT_NO = '005'
ORDER BY 2;

-- 5.
SELECT STUDENT_NO,POINT
FROM tb_grade
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100';

-- 6.
SELECT s.STUDENT_NO, s.STUDENT_NAME, d.DEPARTMENT_NAME
FROM tb_student s
JOIN tb_department d ON s.department_no = d.department_no
ORDER BY 2;


-- 7. 
select CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN tb_department USING(DEPARTMENT_NO);

-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR CP
JOIN tb_class C USING(CLASS_NO)
JOIN tb_professor P USING (PROFESSOR_NO)
ORDER BY 2;

-- 9.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR CP
JOIN tb_class C USING(CLASS_NO)
JOIN tb_professor P USING (PROFESSOR_NO)
JOIN tb_department D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회'
ORDER BY 2;

-- 10.
SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(G.POINT),1)
FROM tb_student
JOIN tb_grade G USING (STUDENT_NO)
JOIN tb_department USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- 11. 
SELECT DEPARTMENT_NAME , STUDENT_NAME ,PROFESSOR_NAME
FROM tb_student
JOIN tb_department USING (DEPARTMENT_NO)
JOIN tb_professor P  ON (tb_student.coach_professor_no = P.professor_no)
--JOIN tb_professor   USING (DEPARTMENT_NO)
WHERE STUDENT_NO = 'A313047';

-- 12.
SELECT DISTINCT  STUDENT_NAME , TERM_NO AS TERM_NAME
FROM tb_student 
JOIN tb_department  USING (DEPARTMENT_NO)
JOIN tb_grade G USING (STUDENT_NO )
JOIN tb_class USING (CLASS_NO)
WHERE TERM_NO LIKE '2007%'
AND CLASS_NAME = '인간관계론';

-- 13.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM tb_department
JOIN tb_class USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;

-- 14. 1. 서반아어학과, 2. 지도교수 없음 미지정으로
SELECT STUDENT_NAME AS 학생이름, NVL(PROFESSOR_NAME,'지도교수 미지정') AS 지도교수
FROM tb_student
JOIN tb_department USING(DEPARTMENT_NO)
LEFT JOIN tb_professor ON (COACH_PROFESSOR_NO  = PROFESSOR_NO)
WHERE DEPARTMENT_NAME = '서반아어학과';

-- 15. 1.휴학생 아냐 , 2. 평점이 4.0이상,
SELECT STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME,ROUND(AVG(point),7) AS 평점
FROM tb_grade
JOIN tb_student USING(STUDENT_NO)
JOIN tb_department USING(DEPARTMENT_NO)
WHERE tb_student.absence_yn = 'N'
HAVING ROUND(AVG(point),7) >= 4.0
GROUP BY STUDENT_NO,STUDENT_NAME,DEPARTMENT_NAME
ORDER BY 1;

-- 16. 1. 환경조경학과 , 과목별 평점
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM tb_grade
JOIN tb_class C USING (CLASS_NO)
JOIN tb_department D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE D.DEPARTMENT_NAME  = '환경조경학과' 
AND POINT IS NOT NULL
AND CLASS_TYPE = '전공선택'
GROUP BY CLASS_NO, CLASS_NAME;

-- 17. 1. 최경희 학생 과 같은 과
SELECT STUDENT_NAME, NVL(STUDENT_ADDRESS,' ')
FROM tb_student
JOIN tb_department USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = (
                            SELECT DEPARTMENT_NAME
                            FROM tb_department
                            JOIN tb_student USING(DEPARTMENT_NO)
                            WHERE STUDENT_NAME = '최경희');

-- 18. 
SELECT STUDENT_NO, STUDENT_NAME
FROM(
SELECT ROWNUM,STUDENT_NO, STUDENT_NAME
FROM(
SELECT STUDENT_NO, STUDENT_NAME , AVG(POINT)
FROM tb_grade
JOIN tb_student USING(STUDENT_NO)
JOIN tb_department USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME 
ORDER BY 3 DESC)
)
WHERE ROWNUM <= 1;

-- 19. 1.환경조경학과 의 계열학과별 평균점수
SELECT DEPARTMENT_NAME , AVG(POINT)
FROM tb_grade
JOIN tb_student USING(STUDENT_NO)
JOIN tb_department USING(DEPARTMENT_NO)
WHERE CATEGORY = (
                    SELECT CATEGORY
                    FROM tb_department
                    WHERE DEPARTMENT_NAME = '환경조경학과')
GROUP BY DEPARTMENT_NAME;

---------------------------------------------------------------------------------

-- 1. 
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
    );

-- 2. 
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
    );
    
-- 3. 
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

-- 4. 
ALTER TABLE  TB_CLASS_TYPE MODIFY NAME NOT NULL;

-- 5. 
ALTER TABLE TB_CLASS_PROFESSOR 
MODIFY CLASS_NO VARCHAR2(10)
 MODIFY PROFESSOR_NO VARCHAR2(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);


-- 6 
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_PROFESSOR RENAME COLUMN CLASS_NO TO CLASS_PROFESSOR_CLASS_NO ;
ALTER TABLE TB_CLASS_PROFESSOR RENAME COLUMN PROFESSOR_NO TO CLASS_PROFESSOR_PROFESSOR_NO ;

-- 7. SYS_C007214
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007214 TO PK_CATEGORY_NAME;

-- 8. 
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT; 

-- 9. 
ALTER TABLE TB_DEPARTMENT ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10.
GRANT CREATE VIEW TO WORKBOOK;

CREATE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM tb_student;

SELECT * FROM "VW_학생일반정보";

-- 11. 
CREATE VIEW VW_지도면담
AS SELECT student_name, DEPARTMENT_NAME, PROFESSOR_NAME
    FROM tb_student
    JOIN tb_department USING(DEPARTMENT_NO)
    JOIN tb_professor ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
    ORDER BY DEPARTMENT_NAME;
    
SELECT * FROM "VW_지도면담";

-- 12.
CREATE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME , COUNT(STUDENT_NO) AS 학생수
    FROM tb_student
    JOIN tb_department USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;
    
DROP VIEW VW_학과별학생수;

SELECT * FROM "VW_학과별학생수";

-- 13. 
UPDATE VW_학생일반정보
SET STUDENT_NAME = '윤재성'
WHERE STUDENT_NO = 'A213046';

-- 14.
CREATE VIEW VW_학과별학생수
AS SELECT DEPARTMENT_NAME , COUNT(STUDENT_NO) AS 학생수
    FROM tb_student
    JOIN tb_department USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME
    WITH READ ONLY;


-- 15. 

SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM(
    SELECT CLASS_NO AS 과목번호, CLASS_NAME AS 과목이름, COUNT(STUDENT_NO)AS "누적수강생수(명)"
    FROM TB_GRADE
    JOIN TB_CLASS USING(CLASS_NO)
    JOIN tb_student USING( STUDENT_NO)
    WHERE TERM_NO >= '200501' AND TERM_NO <= '200912'
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC
)
WHERE ROWNUM <=3;

------------------------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE MODIFY NO NUMBER;
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);
-- 1. 
INSERT INTO tb_class_type VALUES(01,'전공필수');
INSERT INTO tb_class_type VALUES(02,'전공선택');
INSERT INTO tb_class_type VALUES(03,'교양필수');
INSERT INTO tb_class_type VALUES(04,'교양선택');
INSERT INTO tb_class_type VALUES(05,'논문지도');

-- 2.
CREATE TABLE TB_학생일반정보(
    STUD_NO VARCHAR2(20) PRIMARY KEY,
    STUD_NAME VARCHAR2(20),
    STUD_ADD VARCHAR2(50)
);

SELECT * FROM TB_학생일반정보;


INSERT INTO TB_학생일반정보 (STUD_NO, STUD_NAME, STUD_ADD)
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM tb_student;


-- 3. 
CREATE TABLE TB_국어국문학과(
    STUD_NO VARCHAR2(20) PRIMARY KEY,
    STUD_NAME VARCHAR2(20),
    STUD_BY NUMBER(4),
    PROF_NAME VARCHAR(20)
);

INSERT INTO TB_국어국문학과 (STUD_NO, STUD_NAME, STUD_BY, PROF_NAME)
SELECT STUDENT_NO, STUDENT_NAME, SUBSTR(STUDENT_SSN,1,2) + '1900' , PROFESSOR_NAME 
FROM tb_student
JOIN TB_DEPARTMENT USING ( DEPARTMENT_NO )
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO )
WHERE DEPARTMENT_NAME = '국어국문학과';

SELECT * FROM TB_국어국문학과;

-- 4.
UPDATE tb_department
SET CAPACITY = CAPACITY*1.1 ;

SELECT CAPACITY FROM tb_department;


-- 5.
UPDATE tb_student
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';

--6.
UPDATE tb_student
SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);

SELECT STUDENT_SSN FROM tb_student;

-- 7. 
UPDATE 