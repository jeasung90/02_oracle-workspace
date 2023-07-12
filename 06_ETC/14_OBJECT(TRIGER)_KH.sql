/*
    < 트리거 TRIGER >
    
    내가 지정한 테이블에 INSERT, UPDATE, DELETE 등 DML문에 의해 변경사항이 생길 때
    (테이블에 이벤트가 발생했을 때)
    자동으로 매번 실행할 내용을 미리 정해둘 수 있는 객체
    
    EX)
    회원탈퇴시 기존의 회원테이블에 데이터를 DELETE 후 곧바로 탈퇴한 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리해야된다!
    신고횟수가 일정한 수를 넘었을때 묵시적으로 해당 회원을 블랙리스트로 처리되게끔
    입출고에 대한 데이터가 기록(INSERT)될 때마다 해당 상품에 대한 재고수량 매번 수정(UPDATE)해야 될 때
    
    * 트리거 종류
    - SQL문의 실행시기에 따른 분류
        > BEFORE TRIGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
        > AFTER TRIGER  : 내가 지정한 테이블에 이벤티가 발행된 후에 트리거 실행
    
    - SQL문에 의해 영향을 받는 각 행에 때른 분류
        > STATEMENT TRIGER(문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
        > ROW TRIGER(행 트리거) : 해당 SQL문을 실행할 때 마다 매번 트리거 실행
                                (FOR EACH ROW 옵션 기술해야됨)
                > : OLD - BEFORE UPDATE(수정전 자료), BEFORE DELETE (삭제전 자료)
                > : NEW - AFTER INSERT(추가된 자료), AFTER UPDATE(수정후 자료)
                
    [표현식]
    CREATE [OR REPLACE] TRIGER 트리거명
    (BEFORE | AFTER) (INSERT | UPDATE | DELETE)  ON 테이블명
    [FOR EACH ROW]
    자동으로 실행할 내용;
     ㄴ [DECLARE
            변수선언]
        BEGIN
            실행내용(해당 위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행할 구문)
        [EXCEPTION
            예외처리구문;]
        END;
        /
*/

-- EMP테이블에 새로운 행이 INSERT 될 때마다 자동으로 메세지 출력되는 트리거
CREATE OR REPLACE TRIGGER TRG_01
BEFORE INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.put_line('신입사원님 환영합니다!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
    VALUES(500, '한지민','830101-2222222','D7','J7','S2',SYSDATE);
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
    VALUES(501, '숯이','940101-2222222','D7','J7','S2',SYSDATE);

SELECT * FROM EMPLOYEE;
-----------------------------------------------------------------------------------------

-- 상품 입고 및 출고 관련 예시
-- >> 테스트를 위한 테이블 및 시퀀스 생성

-- 1.1 상품에 대한 데이트럴 보관할 테이블 (TB_RPODUCT)

CREATE TABLE  TB_PROUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(40) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER NOT NULL,
    STOCK NUMBER DEFAULT 0
);

SELECT * FROM tb_prouct;

-- 1.2 상품번호 중복 안되게끔 매번 새로운 번호 발생키시는 시퀀스(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 1.3 샘플 데이터 추가
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, '홈런볼', '해태', 1400,500);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, 'S23', '삼성', 1400000,DEFAULT);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, '아이뻐15쁘로', '애뽈', 1800000,10);
INSERT INTO TB_PROUCT VALUES (seq_pcode.nextval, '롤러블', '엘지', 1400000,20);

-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
-- 어떤 상품이 어떤 날짜에 몇개가 입고 또는 출고가 되어었는지에 대한 데이터를 기록하는 테이블
CREATE TABLE TB_PRODEATIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PROUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고'))
);
    
SELECT * FROM tb_prodeatil;

-- 이력번호로 매번 새로운 번호 발생시켜서 들어갈 수 있게 도와주는 시퀀스 ( SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200번 상품이 오늘날짜로 10개 입고
INSERT INTO tb_prodeatil VALUES(seq_dcode.nextval,200,SYSDATE,10,'입고');

-- 200번 상품의 재고수량을 10 증가
UPDATE tb_prouct
SET STOCK = STOCK +10
WHERE PCODE = 200;

-- 210번 상품이 오늘 날짜로 5개 출고
INSERT INTO tb_prodeatil
VALUES (seq_dcode.nextval, 210,SYSDATE,5,'출고');

-- 210번상품의 재고수량 5 감소
UPDATE tb_prouct
SET STOCK = STOCK -5 
WHERE PCODE= 210;

-- 205번 상품이 오늘 날짜로 20개 입고

INSERT INTO tb_prodeatil
VALUES (seq_dcode.nextval, 205,SYSDATE,20,'입고');

-- 205번 상품의 재고수량을 20 증가
UPDATE tb_prouct
SET STOCK = STOCK +20
WHERE PCODE= 205; -- 잘못기입...

-- TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
-- TB_PRODUCT 테이블에 매번 자동으로 재고수량 UPDATE 되게끔 트리거 정의
/*
    -- 상품이 입고된 경우 => 해당 상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PROUCT
    SET STOCK = STOCK + 현재입고된 수량(INSERT 가된  자료의 AMOUNT 값)
    WHERE PCODE = 입고된 상품 번호(INSERT가된 자료의 PCODE값)
    
    -- 상품이 출고된 경우 => 해당 상품 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PROUCT
    SET STOCK = STOCK - 현재출고된 수량(INSERT 가된  자료의 AMOUNT 값)
    WHERE PCODE = 출고된 상품 번호(INSERT가된 자료의 PCODE값)
*/

-- :NEW 써야함

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON tb_prodeatil
FOR EACH ROW
BEGIN
    -- 상품이 입고된 경우 = 재고수량 증가
    IF (:NEW.STATUS = '입고') 
        THEN 
            UPDATE tb_prouct 
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
            DBMS_OUTPUT.put_line('정상적으로 입고처리되었습니다.');

    END IF;
    
    -- 상품이 출고된 경우 => 재고수량 감소
    IF (:NEW.STATUS = '출고') 
        THEN 
            UPDATE tb_prouct 
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
            
            DBMS_OUTPUT.put_line('정상적으로 출고처리되었습니다.');
    END IF;
END;
/
-- 210번 상품이 오늘날짜로 7개 출고
INSERT INTO tb_prodeatil
VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,7,'출고');

--200번 상품이 오늘날짜로 100개 입고
INSERT INTO tb_prodeatil
VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,100,'입고');