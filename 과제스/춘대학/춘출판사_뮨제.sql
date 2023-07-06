--3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM TB_BOOK
WHERE LENGTH(BOOK_NM)>= 25;

--4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
SELECT writer_nm,OFFICE_TELNO,HOME_TELNO,MOBILE_NO   FROM(
SELECT *
FROM tb_writer
WHERE MOBILE_NO LIKE '019%'
AND writer_nm LIKE '��%'
ORDER BY writer_nm)
WHERE ROWNUM =1;
--�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

--5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
--���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT  COUNT(*) AS "�۰�(��)"
FROM tb_book_author
WHERE COMPOSE_TYPE = '�ű�'
GROUP BY COMPOSE_TYPE;
--6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
--���°� ��ϵ��� ���� ���� ������ ��)
SELECT COMPOSE_TYPE, COUNT(*)
FROM tb_book_author
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;
--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM, ISSUE_DATE,PUBLISHER_NM
FROM(
SELECT BOOK_NM, ISSUE_DATE,PUBLISHER_NM
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� ��
--��)
SELECT "�۰� �̸�", "�� ��"
FROM (
  SELECT WRITER_NM AS "�۰� �̸�", COUNT(*) AS "�� ��"
  FROM tb_book_author
  JOIN tb_writer USING (WRITER_NO)
  GROUP BY WRITER_NM
  ORDER BY 2 DESC
)
WHERE ROWNUM <=3;

--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
--������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
UPDATE tb_writer
SET EMAIL_ADDR ;
SELECT WRITER_NM, ISSUE_DATE
FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
JOIN TB_WRITER USING (WRITER_NO)

-- 1. ������ ���� ������ 2. �۰��� �´°� �̰� �������� �ѹ��� �־���Ѵ�.

--10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
--�� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
--(Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
--��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)








































































