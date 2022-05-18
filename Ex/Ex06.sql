/* system */
/* 계정 관리 */ 

--계정 생성
create user webdb identified by 1234;

--권한 부여
grant resource, connect to webdb;

--비번 수정
alter user webdb identified by webdb;

--계정 삭제
drop user webdb cascade;

--계정 생성
create user webdb identified by webdb;

--권한 부여
grant resource, connect to webdb;