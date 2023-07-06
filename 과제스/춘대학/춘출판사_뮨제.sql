--3. 도서명이 25자 이상인 책 번호와 도서명을 화면에 출력하는 SQL 문을 작성하시오.
SELECT *
FROM TB_BOOK
WHERE LENGTH(BOOK_NM)>= 25;

--4. 휴대폰 번호가 ‘019’로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때 가장 먼저 표시되는 작가
SELECT writer_nm,OFFICE_TELNO,HOME_TELNO,MOBILE_NO   FROM(
SELECT *
FROM tb_writer
WHERE MOBILE_NO LIKE '019%'
AND writer_nm LIKE '김%'
ORDER BY writer_nm)
WHERE ROWNUM =1;
--이름과 사무실 전화번호, 집 전화번호, 휴대폰 전화번호를 표시하는 SQL 구문을 작성하시오.

--5. 저작 형태가 “옮김”에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구문을 작성하시오. (결과 헤더는
--“작가(명)”으로 표시되도록 할 것)
SELECT  COUNT(*) AS "작가(명)"
FROM tb_book_author
WHERE COMPOSE_TYPE = '옮김'
GROUP BY COMPOSE_TYPE;
--6. 300권 이상 등록된 도서의 저작 형태 및 등록된 도서 수량을 표시하는 SQL 구문을 작성하시오.(저작
--형태가 등록되지 않은 경우는 제외할 것)
SELECT COMPOSE_TYPE, COUNT(*)
FROM tb_book_author
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;
--7. 가장 최근에 발간된 최신작 이름과 발행일자, 출판사 이름을 표시하는 SQL 구문을 작성하시오.
SELECT BOOK_NM, ISSUE_DATE,PUBLISHER_NM
FROM(
SELECT BOOK_NM, ISSUE_DATE,PUBLISHER_NM
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

--8. 가장 많은 책을 쓴 작가 3명의 이름과 수량을 표시하되, 많이 쓴 순서대로 표시하는 SQL 구문을 작성하시오.
--단, 동명이인(同名異人) 작가는 없다고 가정한다. (결과 헤더는 “작가 이름”, “권 수”로 표시되도록 할
--것)
SELECT "작가 이름", "권 수"
FROM (
  SELECT WRITER_NM AS "작가 이름", COUNT(*) AS "권 수"
  FROM tb_book_author
  JOIN tb_writer USING (WRITER_NO)
  GROUP BY WRITER_NM
  ORDER BY 2 DESC
)
WHERE ROWNUM <=3;

--9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다. 누락된 등록일자 값을 각 작가의
--‘최초 출판도서의 발행일과 동일한 날짜’로 변경시키는 SQL 구문을 작성하시오. (COMMIT 처리할 것)
UPDATE tb_writer
SET EMAIL_ADDR ;
SELECT WRITER_NM, ISSUE_DATE
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)

-- 1. 출판일 제일 빠른거 2. 작가가 맞는거 이걸 다중으로 한번에 넣어야한다.

--10. 현재 도서저자 정보 테이블은 저서와 번역서를 구분 없이 관리하고 있다. 앞으로는 번역서는 따로 관리하려
--고 한다. 제시된 내용에 맞게 “TB_BOOK_ TRANSLATOR” 테이블을 생성하는 SQL 구문을 작성하시오. 
--(Primary Key 제약 조건 이름은 “PK_BOOK_TRANSLATOR”로 하고, Reference 제약 조건 이름은
--“FK_BOOK_TRANSLATOR_01”, “FK_BOOK_TRANSLATOR_02”로 할 것)








































































