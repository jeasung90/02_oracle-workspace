/*
    * DDL (DATA DEFINITION LANGUAGE) : µ¥ÀÌÅÍ Á¤ÀÇ ¾ð¾î
    ¿À¶óÅ¬¿¡¼­ Á¦°øÇÏ´Â °´Ã¼(OBJECT)¸¦ »õ·ÎÀÌ ¸¸µé°í(CREATE), ±¸Á¶¸¦ º¯°æ(ALTER), ±¸Á¶ ÀÚÃ¼¸¦ »èÁ¦(DROP) ÇÏ´Â ¾ð¾î
    Áï, ½ÇÁ¦ µ¥ÀÌÅÍ °ª ÀÌ ¾Æ´Ñ ±¸Á¶ ÀÚÃ¼¸¦ Á¤ÀÇÇÏ´Â ¾ð¾î
    ÁÖ·Î DB°ü¸®ÀÚ, ¼³°èÀÚ°¡ »ç¿ëÇÔ
    
    ¿À¶óÅ¬¿¡¼­ Á¦°øÇÏ´Â °´Ã¼(±¸Á¶) : Å×ÀÌºí(TABLE), ºä(VIEW), ½ÃÄö½º(SEQUENCE)
                                 ÀÎµ¦½º(INDEX), ÆÐÅ°Áö(PACKAGE), Æ®¸®°Å(TRIGGER)
                                 ÇÁ·Î½ÃÁ®(PROCEDURE), ÇÔ¼ö(FUNCTION), µ¿ÀÇ¾î(SYNONYM), »ç¿ëÀÚ(USER)
                                 
    
    <CREATE>
    °´Ã¼¸¦ »õ·ÎÀÌ »ý¼ºÇÏ´Â ±¸¹®
*/

/*
    1.Å×ÀÌºí »ý¼º
    -Å×ÀÌºíÀÌ¶õ? Çà(ROW) °ú ¿­(COLUMN)·Î ±¸¼ºµÇ´Â °¡Àå ±âº»ÀûÀÎ µ¥ÀÌÅÍº£ÀÌ½º °´Ã¼
                ¸ðµç µ¥ÀÌÅÍµéÀº Å×ÀÌºíÀ» ÅëÇØ¼­ ÀúÀåµÊ!!
                (DBMS ¿ë¾î Áß ÇÏ³ª·Î, µ¥ÀÌÅÍ¸¦ ÀÏÁ¾ÀÇ Ç¥ ÇüÅÂ·Î Ç¥ÇöÇÑ °Í!)
            
    [Ç¥Çö½Ä]
    CREATE TABLE Å×ÀÌºí¸í(
        ÄÃ·³¸í ÀÚ·áÇü(Å©±â),
        ÄÃ·³¸í ÀÚ·áÇü(Å©±â),
        ÄÃ·³¸í ÀÚ·áÇü,
        .....
    );
    
    * ÀÚ·áÇü
    - ¹®ÀÚ -(ÇÑ±Û ÇÑ±ÛÀÚ´ç 3¹ÙÀÌÆ®)
    CHAR(¹ÙÀÌÆ® Å©±â) | VARCHAR2(¹ÙÀÌÆ® Å©±â) => ¹Ýµå½Ã Å©±â ÁöÁ¤ ÇØ¾ßÇÔ
    > CHAR : ÃÖ´ë 2000¹ÙÀÌÆ® ±îÁö ÁöÁ¤ °¡´É . . ÁöÁ¤ÇÑ ¹üÀ§ ¾È¿¡¼­¸¸ ½á¾ßÇÔ  / °íÁ¤ ±æÀÌ (ÁöÁ¤ÇÑ Å©±âº¸´Ù ´õ ÀûÀº °ªÀÌ µé¾î¿Íµµ °ø¹éÀ¸·Î Ã¤¿öÁü!)
             °íÁ¤µÈ ±ÛÀÚ¼öÀÇ µ¥ÀÌÅÍ¸¸ÀÌ ´ã±æ °æ¿ì »ç¿ë => ÀÏ¹ÝÀûÀ¸·Î 'ÇÑ'±ÛÀÚ. (YN / MF)
             
    > VARCHAR2 : ÃÖ´ë 4000¹ÙÀÌÆ® CHAR°¡ 2°³ . °¡º¯ ±æÀÌ(´ã±ä °ª¿¡ µû¶ó¼­ °ø°£ÀÇ Å©±â°¡ ¸ÂÃçÁü)
                 ¸î ±ÛÀÚÀÇ µ¥ÀÌÅÍ°¡ µé¾î¿ÃÁö ¸ð¸£´Â °æ¿ì + ±ä ±Û
    
    - ¼ýÀÚ (NUMBER)
    
    - ³¯Â¥ (DATE)
*/

--È¸¿ø¿¡ ´ëÇÑ µ¥ÀÌÅÍ¸¦ ´ã±â À§ÇÑ Å×ÀÌºí MEMBER »ý¼ºÇÏ±â
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

--¸¸¾à Å×ÀÌºí»ý¼ºÇÏ´Ù°¡ ÄÃ·³¸í¿¡ ¿ÀÅ¸°¡ ¹ß»ýÇß´Ù¸é?
--°íÃÄ¼­ ´Ù½Ã ¸¸µé¸é µÉ±î? ¤¤¤¤ »èÁ¦ÇÏ°í ´Ù½Ã ¸¸µé¾î¾ßÇÔ¤»
--DROP TABLE Å×ÀÌºí¸í;

--µ¥ÀÌÅÍ µñ¼Å³Ê¸® : ´Ù¾çÇÑ °´Ã¼µéÀÇ Á¤º¸¸¦ ÀúÀåÇÏ°í ÀÖ´Â ½Ã½ºÅÛ Å×ÀÌºíµé
--[Âü°í] USER_TABLES: ÇöÀç ÀÌ °èÁ¤ÀÌ °¡Áö°í ÀÖ´Â Å×ÀÌºí ±¸Á¶ º¼ ¼ö ÀÖÀ½

SELECT * FROM USER_TABLES;

--[Âü°í] USER_TAB_COLUMNS : ÀÌ »ç¿ëÀÚ°¡ °¡Áö°í ÀÖ´Â Å×ÀÌºí»óÀÇ ¸ðµç ÄÃ·³ º¼ ¼ö ÀÖÀ½
SELECT * FROM USER_TAB_COLUMNS;

-------------------------------------------------------------------------------
/*
    2.ÄÃ·³¿¡ ÁÖ¼® ´Þ±â (ÄÃ·³¿¡ ´ëÇÑ ¼³¸í°°Àº°Å)
    
    [Ç¥Çö¹ý]
    COMMENT ON COLUMN IS 'ÁÖ¼®³»¿ë'
*/

--Àß¸ø ÀÛ¼ºÇØ¼­ ½ÇÇàÇßÀ» °æ¿ì ¼öÁ¤ ÈÄ ´Ù½Ã ½ÇÇàÇÏ¸é µÊ
COMMENT ON COLUMN MEMBER.MEM_NO IS 'È¸¿ø¹ö³ë';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'È¸¿ø¹øÈ£';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'È¸¿ø¾ÆÀÌµð';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'È¸¿øºñ¹Ð¹øÈ£';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'È¸¿ø¸í';
COMMENT ON COLUMN MEMBER.GENDER IS '¼ºº°(³²/¿©)';
COMMENT ON COLUMN MEMBER.PHONE IS 'ÀüÈ­¹øÈ£';
COMMENT ON COLUMN MEMBER.EMAIL IS 'ÀÌ¸ÞÀÏ';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'È¸¿ø°¡ÀÔÀÏ';

--Å×ÀÌºíÀ» »èÁ¦ÇÏ°íÀÚ ÇÒ ¶§ : DROP TABLE Å×ÀÌºí¸í;

--Å×ÀÌºí¿¡ µ¥ÀÌÅÍ Ãß°¡½ÃÅ°´Â ±¸¹® (DML : INSERT) ÀÌ¶§ ÀÚ¼¼ÇÏ°Ô ¹è¿ò
--INSERT INTO Å×ÀÌºí¸í VALUES(°ª1, °ª2, °ª3,.....);

--INSERT INTO MEMBER VALUES(1, 'user01' ,'pass01','È«±æµ¿'); ´Ù ÀÔ·Â ¾ÈÇÏ¸é ¿¡·¯³²
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', 'È«±æµ¿', '³²', '010-1111-2222', 'AAA@NAVER.COM', '20/12/30');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(2, 'user02' ,'pass02','È«±æ³à', '¿©', NULL, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--À¯È¿ÇÏÁö ¾ÊÀº µ¥ÀÌÅÍ°¡ µé¾î°¡°íÀÖÀ½.. ¹º°¡ Á¶°ÇÀ» °É¾îÁà¾ßµÊ

---------------------------------------------------------------------------
/*
    <Á¦¾àÁ¶°Ç CONSTRAINTS>
    -¿øÇÏ´Â µ¥ÀÌÅÍ°ª (À¯È¿ÇÑ Çü½ÄÀÇ °ª) ¸¸ À¯ÁöÇÏ±â À§ÇØ¼­ Æ¯Á¤ ÄÃ·³¿¡ ¼³Á¤ÇÏ´Â Á¦¾àÁ¶°Ç
    -µ¥ÀÌÅÍ ¹«°á¼º º¸ÀåÀ» ¸ñÀûÀ¸·Î ÇÑ´Ù!
    
    * Á¾·ù : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, foreign key
*/

/*
    * NOT NULL Á¦¾àÁ¶°Ç
    ÇØ´ç ÄÃ·³¿¡ ¹Ýµå½Ã °ªÀÌ Á¸ÀçÇØ¾ß¸¸ ÇÒ °æ¿ì (Áï, ÇØ´ç ÄÃ·³¿¡ Àý´ë NULLÀÌ µé¾î¿Í¼­´Â ¾ÈµÇ´Â °æ¿ì
    »ðÀÔ/ ¼öÁ¤½Ã NULL°ªÀ» Çã¿ëÇÏÁö ¾Êµµ·Ï Á¦ÇÑ
    
    Á¦¾à Á¶°ÇÀ» ºÎ¿©ÇÏ´Â ¹æ½ÄÀº Å©°Ô 2°¡Áö°¡ ÀÖÀ½(ÄÃ·³·¹º§¹æ½Ä / Å×ÀÌºí·¹º§¹æ½Ä)
    * NOT NULL Á¦¾àÁ¶°ÇÀº ¿À·ÎÁö ÄÃ·³·¹º§¹æ½Ä ¹Û¿¡ ¾ÈµÊ
*/

--ÄÃ·³·¹º§¹æ½Ä : ÄÃ·³¸í ÀÚ·áÇü Á¦¾àÁ¶°Ç
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES
(1,'USER01','PASS01','¼ÕÈï¹Î','³²','NULL',NULL);

INSERT INTO MEM_NOTNULL VALUES
(2,'USER02','NULL','ÀÌ°­ÀÎ','¿©','NULL',AA@NAVER.COM;
--ÀÇµµÇß´ø´ë·Î ¿À·ù³²!!!(NOT NULL Á¦¾àÁ¶°Ç¿¡ À§¹èµÇ¾î ¿À·ù¹ß»ý)

INSERT INTO MEM_NOTNULL
VALUES(2, 'USER01', 'PASS01', 'ÀÌ½Â¿ì', NULL, NULL, NULL);
--> ¾ÆÀÌµð°¡ Áßº¹µÇ¾îÀÖÀ½¿¡µµ ºÒ±¸ÇÏ°í Ãß°¡°¡µÊ ¤Ð¤Ð

--------------------------------------------------------------
/*
    * UNSNIZUE Á¦¾àÁ¶°Ç
    ÇØ´ç ÄÃ·³¿¡ Áßº¹µÈ °ªÀÌ µé¾î°¡¼­´Â ¾È µÉ °æ¿ì
    ÄÃ·³°ª¿¡ Áßº¹°ªÀ» Á¦ÇÑÇÏ´Â Á¦¾à Á¶°Ç
    »ðÀÔ/ ¼öÁ¤½Ã ±âÁ¸¿¡ ÀÖ´Â µ¥ÀÌÅÍ°ª Áß Áßº¹°ªÀÌ ÀÖÀ¸¸é ¿À·û¤±
*/

CREATE TABLE MEM_UNIQUE( -- ÄÃ·³·¹º§¹æ½Ä
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT *
FROM MEM_UNIQUE;

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- Å×ÀÌºí·¹º§¹æ½Ä
    --NOT NULL(MEM_PWD) --> ÀÌ°Ç ¾ÈµÊ ÄÃ·³¶óº§½ÄÀ¸·Î¸¸ µÊ NOT NULLÀº
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '¼ÕÈï¹Î', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', 'ÀÌ°­ÀÎ', null, null, null);
--ORA-00001: unique constraint (DDL.SYS_C007062) violated
--> UNIQUE Á¦¾àÁ¶°Ç¿¡ À§¹èµÇ¾úÀ½! INSERT ½ÇÆÐ
--> ¿À·ù±¸¹®À» Á¦¾àÁ¶°Ç¸íÀ¸·Î ¾Ë·ÁÁÜ!! (Æ¯Á¤ ÄÃ·³¿¡ ¾î¶²¹®Á¦°¡ ÀÖ´ÂÁö »ó¼¼È÷ ¾Ë·ÁÁÖÁö ¾ÊÀ½!)
--> ½±°Ô ÆÄ¾ÇÇÏ±â ¾î·Á¿ò!
--> Á¦¾àÁ¶°Ç ºÎ¿©½Ã Á¦¾àÁ¶°Ç¸íÀ» ÁöÁ¤ÇØÁÖÁö ¾ÊÀ¸¸é ½Ã½ºÅÛ¿¡¼­ ÀÓÀÇÀÇ Á¦¾àÁ¶°Ç¸íÀ» ºÎ¿©ÇØ¹ö¸²

/*
    * Á¦¾àÁ¶°Ç ºÎ¿© ½Ã Á¦¾àÁ¶°Ç¸í ±îÁö Áö¾îÁÖ´Â ¹æ¹ý
    
    >ÄÃ·³·¹º§¹æ½Ä
    CREATE TABLE Å×ÀÌºí¸í(
        ÄÃ·³¸í ÀÚ·áÇü [CONSTRAINT Á¦¾àÁ¶°Ç¸í] Á¦¾àÁ¶°Ç
        ÄÃ·³¸í ÀÚ·áÇü
    );
    
    >Å×ÀÌºí·¹º§¹æ½Ä
    CREATE TABLE Å×ÀÌºí¸í(
        ÄÃ·³¸í ÀÚ·áÇü,
        ÄÃ·³¸í ÀÚ·áÇü
        [CONSTRAINT Á¦¾àÁ¶°Ç¸í] Á¦¾àÁ¶°Ç(¾î¶²ÄÃ·³?)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '¼ÕÈï¹Î', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', 'ÀÌ°­ÀÎ', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass02', 'ÀÌ½Â¿ì', '¤¤', null, null);
--> ¼ºº°¿¡ À¯È¿ÇÑ °ªÀÌ ¾Æ´Ñ°Ô µé¾î¿Íµµ Àß INSERT°¡ µÈ´Ù. => ÀÌ·¯¸é ¾ÈµÊ..

---------------------------------------------------------------------------------------
/*
    * CHECK(Á¶°Ç½Ä) Á¦¾àÁ¶°Ç
    ÇØ´ç ÄÃ·³¿¡ µé¾î¿Ã ¼ö ÀÖ´Â °ª¿¡ ´ëÇÑ Á¶°ÇÀ» Á¦½ÃÇØµÑ ¼ö ÀÖÀ½
    ÇØ´ç Á¶°Ç¿¡ ¸¸Á·ÇÏ´Â µ¥ÀÌÅÍ°ª¸¸ ´ã±æ ¼ö ÀÖÀ½
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN('³²','¿©')) --Å×ÀÌºí·¹º§¹æ½Ä
);


SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1,'user01', 'pass01', '¼ÕÈï¹Î', '³²', null, null);
INSERT INTO MEM_CHECK VALUES(2,'user02', 'pass02', 'ÀÌ°­ÀÎ', '¤¤', null, null);
--ORA-02290: check constraint (DDL.SYS_C007072) violated 
--check Á¦¾àÁ¶°Ç¿¡ À§¹èµÆ±â ¶§¹®¿¡ ¿À·ù ¹ß»ý

INSERT INTO MEM_CHECK VALUES(2,'user02', 'pass02', 'ÀÌ°­ÀÎ', NULL, null, null);
--¸¸ÀÏ GENDER ÄÃ·³¿¡ µ¥ÀÌÅÍ°ªÀ» ³Ö°íÀÚ ÇÑ´Ù¸é CHECKÁ¦¾àÁ¶°Ç¿¡ ¸¸Á·ÇÏ´Â °ªÀ» ³Ö¾î¾ßµÊ
--NOT NULL ¾Æ´Ï¸é NULL µµ °¡´ÉÇÏ±äÇÔ!!

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', 'ÀÌ½Â¿ì', '¿©', null, null);
--È¸¿ø¹øÈ£°¡ µ¿ÀÏÇØµµ ¼º°øÀûÀ¸·Î insert µÅ¹ö¸²...

------------------------------------------------------------------------------------
/*
    * PRIMARY KEY(±âº»Å°) Á¦¾àÁ¶°Ç => PK
    Å×ÀÌºí¿¡¼­ °¢ ÇàµéÀ» ½Äº°ÇÏ±â À§ÇØ »ç¿ëµÉ ÄÃ·³¿¡ ºÎ¿©ÇÏ´Â Á¦¾àÁ¶°Ç (½Äº°ÀÚÀÇ ¿ªÇÒ)
    
    EX) È¸¿ø¹øÈ£, ÇÐ¹ø, »ç¿ø¹øÈ£, ºÎ¼­ÄÚµå, Á÷±ÞÄÚµå, ÁÖ¹®¹øÈ£, ¿¹¾à¹øÈ£, ¿î¼ÛÀå¹øÈ£
    
    PRIMARY KEY Á¦¾àÁ¶°ÇÀ» ºÎ¿©ÇÏ¸é ±× ÄÃ·³¿¡ ÀÚµ¿À¸·Î NOT NULL + UNIQUE Á¦¾àÁ¶°ÇÀ» °¡Áø´Ù.
    
    * À¯ÀÇ»çÇ× : ÇÑ Å×ÀÌºí´ç ¿À·ÎÁö !!! ÇÑ°³¸¸ °¡´É
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) UNIQUE NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)
);
SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1,'user01', 'pass01', '¼ÕÈï¹Î', '³²', null, null);
INSERT INTO MEM_PRI VALUES(1,'user02', 'pass02', 'ÀÌ°­ÀÎ', '³²', null, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- ±âº»Å°¿¡ Áßº¹°ªÀ» ´ãÀ¸·Á°í ÇÒ ¶§ (UNIQUE Á¦¾àÁ¶°Ç À§¹Ý)

INSERT INTO MEM_PRI VALUES(NULL,'user02', 'pass02', 'ÀÌ°­ÀÎ', '³²', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- ±âº»Å°¿¡ NULLÀ» ´ãÀ¸·Á ÇÒ ¶§ (NOT NULL Á¦¾àÁ¶°Ç À§¹èµÊ)

INSERT INTO MEM_PRI VALUES(2,'user02', 'pass02', 'ÀÌ°­ÀÎ', '³²', null, null);


CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO,MEM_ID) -- ¹­¾î¼­ PRIMARY KEY Á¦¾à Á¶°Ç ºÎ¿©(º¹ÇÕÅ°)
);
-- ORA-02260: table can have only one primary key
-- ±âº»Å°´Â ÇÏ³ª¸¸ ÇÏ¼À

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2 
VALUES(1,'user01', 'pass01', '¼ÕÈï¹Î', '³²', null, null);
INSERT INTO MEM_PRI2
VALUES(1,'user02', 'pass02', 'ÀÌ°­ÀÎ', '³²', null, null);
INSERT INTO MEM_PRI2 
VALUES(2,'user02', 'pass02', 'ÀÌ¿ö', '³²', null, null);
INSERT INTO MEM_PRI2 
VALUES(NULL,'user02', 'pass02', 'ÀÌ¿öÅõ', '³²', null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY·Î ”¾¿©ÀÖ´Â °¢ ÄÃ·³¿¡´Â Àý´ë NULLÀ» Çã¿ëÇÏÁö ¾ÊÀ½!

-- º¹ÇÕÅ° »ç¿ë ¿¹½Ã (ÂòÇÏ±â, ÁÁ¾Æ¿ä, ±¸µ¶)
-- ÂòÇÏ±â : ÇÑ »óÇ°Àº ¿À·ÎÁö ÇÑ¹ø¸¸ ÂòÇÒ ¼ö ÀÖÀ½
-- ¾î¶² È¸¿øÀÌ ¾î¶² »óÇ°À» ÂòÇÏ´ÂÁö¿¡ ´ëÇÑ µ¥ÀÌÅÍ¸¦ º¸°üÇÏ´Â Å×ÀÌºí

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY (MEM_NO, PRODUCT_NAME)
    );
    
SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1,'°¨ÀÚ',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'°í±¸¸¶',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'°¨ÀÚ',SYSDATE); -- ¿¡·¯¹ß»ý!! ÇÑ¹ø¸¸ ÂòÇØ¾ß µÊ
INSERT INTO TB_LIKE VALUES(2,'°¨ÀÚ',SYSDATE);

--------------------------------------------------------------------------------
-- È¸¿øµî±Þ¿¡ ´ëÇÑ µ¥ÀÌÅÍ¸¦ µû·Î º¸°üÇÏ´Â Å×ÀÌºí
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10,'ÀÏ¹ÝÈ¸¿ø');
INSERT INTO MEM_GRADE VALUES(20,'¿ì¼öÈ¸¿ø');
INSERT INTO MEM_GRADE VALUES(30,'¹ÌÄ£È¸¿ø');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- È¸¿øÀÇ µî±×¹øÈ£¸¦ °°ÀÌ º¸°üÇÒ ÄÃ·³
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','½ðÈ«¹Î','³²',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','¸®Ä²ÀÎ',NULL,NULL,NULL,10);
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','¸®¿ö','³²',NULL,NULL,40);
-- À¯È¿ÇÑ È¸¿øµî±Þ ¹øÈ£°¡ ¾Æ´Ô¿¡µµ ºÒ±¸ÇÏ°í Àß INSERT µÊ....

------------------------------------------------------------------------------------
/*
    ¡Ü FOREIGN KEY (¿Ü·¡Å°) Á¦¾àÁ¶°Ç
    ´Ù¸¥ Å×ÀÌºí¿¡ Á¸ÀçÇÏ´Â °ª¸¸ µé¾î¿Í¾ß µÇ´Â Æ¯Á¤ ÄÃ·³
    --> ´Ù¸¥ Å×ÀÌºíÀ» ÂüÁ¶ÇÑ´Ù´Â Ç¥Çö
    --> ÁÖ·Î FOREIGN KEY Á¦¾àÁ¶°Ç¿¡ ÀÇÇØ Å×ÀÌºí°£ÀÇ °ü°è°¡ Çü¼ºµÊ!
    
    > ÄÃ·³·¹º§¹æ½Ä
    ÄÃ·³¸í ÀÚ·áÇü [CONSTRAINT Á¦¾àÁ¶°Ç¸í]REFERENCES ÂüÁ¶ÇÒ Å×ÀÌºí¸í[(ÂüÁ¶ÇÒ ÄÃ·³¸í)] -- ÂüÁ¶ÇÒ ÄÃ·³¸í ¾È¾²¸é ÀÚµ¿À¸·Î ±âº»Å°·Î ÀâÈû
    
    > Å×ÀÌºí·¹º§¹æ½Ä
    [CONSTRAINT Á¦¾àÁ¶°Ç¸í] FOREIGN KEY(ÄÃ·³¸í) REFERENCES ÂüÁ¶ÇÒ Å×ÀÌºí¸í[(ÂüÁ¶ÇÒ ÄÃ·³¸í)]
    
    -- > ÂüÁ¶ÇÒ ÄÃ·³¸í »ý·«½Ã Å×ÀÌºí PRIMARY KEY·Î ÁöÁ¤µÈ ÄÃ·³À¸·Î ÀÚµ¿¸ÅÄª
*/
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) -- ÄÃ·³·¹º§¹æ½Ä
    -- FOREIGKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','½ðÈ«¹Î','³²',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','¸®Ä²ÀÎ',NULL,NULL,NULL,10);
--INSERT INTO MEM VALUES ( 3, 'USER03','PASS03','¸®¿ö','³²',NULL,NULL,40);
-- ORA-02291: integrity constraint (DDL.SYS_C007160) violated - parent key not fou
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','¸®¿ö','³²',NULL,NULL,20);
INSERT INTO MEM
VALUES ( 4, 'USER04','PASS04','¿ÏÃ»È²',NULL,NULL,NULL,10);

-- MEM_GRADE (ºÎ¸ðÅ×ÀÌºí) MEM (ÀÚ½ÄÅ×ÀÌºí)
-- ÀÌ‹š ºÎ¸ðÅ×ÀÌºí(MEM_GRADE)¿¡¼­ µ¥ÀÌÅÍ°ªÀ» »èÁ¦ÇÒ °æ¿ì ¾î¶² ¹®Á¦°¡ ¹ß»ýÇÒ±î?
-- µ¥ÀÌÅÍ »èÁ¦ : DELETE FROM Å×ÀÌºí¸í WHERE Á¶°Ç;

--> MEM_GRADE Å×ÀÌºí¿¡¼­ 10¹ø »èÁ¦
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- ORA-02292: integrity constraint (DDL.SYS_C007160) violated - child record found
--> ÀÚ½ÄÅ×ÀÌºí (MEM)¿¡ 10 ÀÌ¶ó´Â °ªÀ» »ç¿ëÇÏ°í ÀÖ±â ¶§¹®¿¡ »èÁ¦°¡ ¾ÈµÊ!

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
--> ÀÚ½ÄÅ×ÀÌºí (MEM)¿¡ 30ÀÌ¶ó´Â °ªÀ» »ç¿ëÇÏ°í ÀÖÁö ¾Ê±â ¶§¹®¿¡ »èÁ¦°¡ ÀßµÊ!!

--> ÀÚ½ÄÅ×ÀÌºí¿¡ ÀÌ¹Ì »ç¿ëÇÏ°í ÀÖ´Â °ªÀÌ ÀÖÀ»°æ¿ì
--> ºÎ¸ðÅ×ÀÌºí·ÎºÎÅÍ ¹«Á¶°Ç »èÁ¦°¡ ¾ÈµÇ°Ô ÇÏ´Â "»èÁ¦Á¦ÇÑ"¿É¼ÇÀÌ °É·ÁÀÖÀ½!

ROLLBACK; -- Ä¿¹ÔÀÌÀüÀÇ ½ÃÁ¡À¸·Î µ¹¸²

SELECT * FROM MEM_GRADE;

-----------------------------------------------------------------------------------------------------------
/*
    ÀÚ½Ä Å×ÀÌºí »ý¼º½Ã ¿Ü·¡Å° Á¦¾àÁ¶°ÇÀ» ºÎ¿©ÇÒ ¶§ »èÁ¦¿É¼Í ÁöÁ¤°¡´É
    * »èÁ¦¿É¼Ç : ºÎ¸ðÅ×ÀÌºíÀÇ µ¥ÀÌÅÍ »èÁ¦½Ã ±× µ¥ÀÌÅÍ¸¦ »ç¿ëÇÏ°í ÀÖ´Â ÀÚ½ÄÅ×ÀÌºí °ªÀ» 
             ¾î¶»°Ô Ã³¸®ÇÒ°ÍÀÎÁö ÁöÁ¤ÇÒ ¼ö ÀÖ´Â ¿É¼Ç
    - ON DELETE RESTRICTED (±âº»°ª) : »èÁ¦Á¦ÇÑ¿É¼ÇÀ¸·Î, ÀÚ½Ä µ¥ÀÌÅÍ·Î ¾²ÀÌ´Â ºÎ¸ðµ¥ÀÌÅÍ´Â »èÁ¦ ¾ÈµÇ°Ô²û !
    - ON DELETE SET NULL : ºÎ¸ðµ¥ÀÌÅÍ¸¦ »èÁ¦½Ã ÇØ´ç µ¥ÀÌÅÍ¸¦ ¾²°í ÀÖ´Â ÀÚ½ÄÅ×ÀÌÅÍÀÇ °ªÀ» NULL·Î º¯°æ
    - ON DELETE CASCADE : ºÎ¸ðµ¥ÀÌÅÍ¸¦ »èÁ¦½Ã ÇØ´ç µ¥ÀÌÅÍ¸¦ ¾²°í ÀÖ´Â ÀÚ½Ä µ¥ÀÌÅÍµµ °°ÀÌ »èÁ¦½ÃÅ´
*/

DROP TABLE MEM;

-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL -- ÄÃ·³·¹º§¹æ½Ä
    -- FOREIGKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);


INSERT INTO MEM
VALUES ( 1, 'USER01','PASS01','½ðÈ«¹Î','³²',NULL,NULL,NULL);
INSERT INTO MEM
VALUES ( 2, 'USER02','PASS02','¸®Ä²ÀÎ',NULL,NULL,NULL,10);
INSERT INTO MEM
VALUES ( 3, 'USER03','PASS03','¸®¿ö','³²',NULL,NULL,20);
INSERT INTO MEM
VALUES ( 4, 'USER04','PASS04','¿ÏÃ»È²',NULL,NULL,NULL,10);

SELECT * FROM MEM;

COMMIT;

-- 10¹ø µî±Þ »èÁ¦
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- Àß »èÁ¦µÊ!! (´Ü, 10À» ¾²°íÀÖ´ø ÀÚ½Äµ¥ÀÌÅÍÀÇ °ªÀº NULL·Î º¯°æ)

ROLLBACK;

-- ON DELETE CASCADE
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('³²','¿©')), -- ÄÃ·³·¹º§¹æ½Ä
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- ÄÃ·³·¹º§¹æ½Ä
);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

/*
    < DEFAULT ±âº»°ª > ** Á¦¾àÁ¶°Ç ¾Æ´Ô **
    ÄÃ·³À» ¼±Á¤ÇÏÁö ¾Ê°í INSERT½Ã NULLÀÌ ¾Æ´Ñ ±âº»°ªÀ» INSERTÇÏ°íÀÚ ÇÒ ¶§ ¼¼ÆÃÇØµÑ ¼ö ÀÖ´Â °ª
*/
    
    DROP TABLE MEMBER;
    
CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '¾øÀ½',
    ENROLL_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEMBER;

-- INSERT INTO Å×ÀÌºí¸í VALUES(°ª1, °ª2,...)

INSERT INTO MEMBER VALUES (1,'½ðÈ«¸à',20,'Ãà±¸','22/01/01');
INSERT INTO MEMBER VALUES (2, '¸®Ä²ÀÎ', NULL,NULL,NULL);
INSERT INTO MEMBER VALUES (3, '¸®¿ö', NULL,DEFAULT,DEFAULT); -- ³»°¡ ¼³ÀúÇÑ µðÆúÆ®°ªÀ¸·Î µé¾î´Â°¨..


-- INSERT INTO Å×ÀÌºí¸í(ÄÃ·³¸í, ÄÃ·³¸í) VALUES (°ª1, °ª2);
-- NOT NULLÀÎ°ÍÀº ²À ÀÛ¼ºÇØ¾ßÇÔ
INSERT INTO MEMBER (MEM_NO, MEM_NAME) VALUES (4,'¿Ï­ È²');
-- ¼±ÅÃµÇÁö ¾ÊÀº ÄÃ·³ ±âº»ÀûÀ¸·Î NULLÀÌ µé¾î°¨
-- ´Ü, ÇØ´ç ÄÃ·³¿¡ DEFAULT °ªÀÌ ÀÖÀ» °æ¿ì NULLÀÌ ¾Æ´Ñ DEFAULT °ªÀÌ µé¾î°£´Ù.!

--=================================================================================================================

/*
     !!!!!!!!!!!!!!!!! KH °èÁ¤¿¡¼­¸¸ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     < SUBQUERY¸¦ ÀÌ¿ëÇÑ Å×ÀÌºí »ý¼º >
     Å×ÀÌºí º¹»ç ¶ß´Â °³³ä
     
     [ Ç¥Çö½Ä ]
     CREATE TABLE Å×ÀÌºí¸í
     AS ¼­ºêÄõ¸®;
*/

-- EMPLOYEE Å×ÀÌºíÀ» º¹Á¦ÇÑ »õ·Î¿î Å×ÀÌºí »ý¼º
CREATE TABLE EMPLOYEE_COPY 
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
--> ÄÃ·³, µ¥ÀÌÅÍ°ª, Á¦¾àÁ¶°Ç °°Àº °æ¿ì NOT NULL¸¸ º¹»çµÊ


CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
   FROM EMPLOYEE--Å×ÀÌºíÀÇ ±¸Á¶¸¸ °¡Á®¿À°í ½Í´Ù.
   WHERE 1 = 0; -- ¹«Á¶°Ç FALSEÀÎ Á¶°Ç : ±¸Á¶¸¸À» º¹»çÇÏ°íÀÚ ÇÒ ¶§ ¾²ÀÌ´Â ±¸¹® (µ¥ÀÌÅÍ °ªÀº ÇÊ¿ä ¾øÀ» ¶§)

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS ¿¬ºÀ½º
FROM EMPLOYEE
WHERE 1=1;
-- ORA-00998: must name this expression with a column alias
-- alias : º°Äª
--> ¼­ºêÄõ¸® SELECT Àý¿¡ »ê¼ú½Ä ¶Ç´Â ÇÔ¼ö½Ä ±â¼úµÈ °æ¿ì ¹Ýµå½Ã º°ÄªÀ» ÁöÁ¤ÇØ¾ßµÊ!

SELECT * FROM EMPLOYEE_COPY3;

----------------------------------------------------------------------------------------------------------------
/*
    * Å×ÀÌºí ´Ù »ý¼ºµÈ ÈÄ¿¡ µÚ´Ê°Ô Á¦¾àÁ¶°Ç Ãß°¡µÇ´Â °æ¿ì
    
    ALTER TABLE Å×ÀÌºí¸í º¯°æÇÒ ³»¿ë
    
    - PRIMARY KEY  : ALTER TABLE Å×ÀÌºí¸í ADD PRIMARY KEY(ÄÃ·³¸í);
    - FOREIGN KEY  : ALTER TABLE Å×ÀÌºí¸í ADD FOREIGN KEY(ÄÃ·³¸í)REFERENCES ÂüÁ¶ÇÒÅ×ÀÌºí¸í[(ÂüÁ¶ÇÒ ÄÃ·³¸í)];
    - UNIQUE       : ALTER TABLE Å×ÀÌºí¸í ADD UNIQUE(ÄÃ·³¸í);
    - CHECK        : ALTER TABLE Å×ÀÌºí¸í ADD CHECK(ÄÃ·³¿¡ ´ëÇÑ Á¶°Ç½Ä);
    - NOT NULL     : ALTER TABLE Å×ÀÌºí¸í MODIFY ÄÃ·Å¸í NOT NULL; ** ¾à°£ Æ¯ÀÌÇÔ
*/

-- ¼­ºêÄõ¸®¸¦ ÀÌ¿ëÇØ¼­ º¹Á¦ÇÑ Å×ÀÌºí NN Á¦¾àÁ¶°Ç »©°í º¹Á¦ ¾ÈµÊ!
-- EMPLOYEE_COPY Å×ÀÌºí¿¡ PRIMARY KEY Á¦¾àÁ¶°Ç Ãß°¡(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

SELECT * FROM EMPLOYEE_COPY;

-- EMPLYEE Å×ÀÌºí¿¡ DEPT_CODE¿¡ ¿Ü·¡Å° Á¦¾àÁ¶°Ç Ãß°¡ (ÂüÁ¶ÇÏ´Â Å×ÀÌºí(ºÎ¸ð) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT; -- »ý·«ÇÏ¸é ºÎ¸ðÅ×ÀÌºíÀÇ PK·Î ÀÚµ¿ ¸ÅÄªµÊ

-- EMPLOYEE Å×ÀÌºí¿¡ JOB_CODE¿¡ ¿Ü·¡Å° Á¦¾àÁ¶°Ç Ãß°¡
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB ;
-- EMPLOYEE Å×ÀÌºí¿¡ SAL_LEVEL¿¡ ¿Ü·¡Å° Á¦¾àÁ¶°Ç Ãß°¡ (SAL_GRADE)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL)REFERENCES SAL_GRADE;
-- DEPARTMENT Å×ÀÌºí¿¡ LOCATION_ID¿¡ ¿Ü·¡Å° Á¦¾à Ãß°¡ (LOCATION)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);

SELECT * FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES('S1','Å×½ºÆ®ºÎ','S1');














































