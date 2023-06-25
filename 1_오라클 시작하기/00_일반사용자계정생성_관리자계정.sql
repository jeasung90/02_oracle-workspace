--한줄 짜리 주석

/*
여러줄 
주석
*/

--현재 모든 계정들에 대해서 조회하는 명령문
 select * from dba_users; --이건 관리자 계정으로 들어왔기 때문에 보인다
 --명령문 하나 실행! 위쪽의 삼각형 재생버튼 클릭 or ctrl + enter 누르면 실행됨
 
 
 --일반 사용자 계정 생성하는 구문 ! 오로지 관리자 계정에서만 할 수 있음!
 -- [표현법] CREATE USER 계정명 identified by 비밀번호
 create user kh identified by kh; -- 계정명은 대소문자를 안가림 / 비번은 소문자로!!
 
 --위에서 생성된 일반 사용자 계정에게 최소한의 권한 (데이터관리 ,접속 등) 부여
 -- [표현법] grant 권한1, 권한2, ... to 계정명
 grant RESOURCE, CONNECT to KH;
 
