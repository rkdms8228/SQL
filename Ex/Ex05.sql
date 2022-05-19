/* webdb */

--테이블, 컬럼 생성
create table book (
        book_id number(5)
        , title varchar2(50)
        , author varchar2(10)
        , pub_date date
);

--컬럼 추가
alter table book add (pubs varchar2(50));

--컬럼 수정
alter table book modify (title varchar2(100)); --글자수
alter table book rename column title to subject; --컬럼명

--컬럼 삭제
alter table book drop (author);

--테이블명 변경
rename book to article;

--테이블 삭제
drop table article;

select *
from article;

--author 테이블 만들기
create table author(
        author_id number (10)
        , author_name varchar2 (100) not null
        , author_desc varchar2 (500)
        , primary key (author_id)
);

--테이블 관리(DML) - INSERT(묵시적 방법)
--테이블 생성 시 정의한 순서에 따라 값 지정
insert into author
values (1, '박경리', '토지 작가');

--테이블 관리(DML) - UPDATE
update author
set author_desc = '토지 작가'
where author_id = 1;

--테이블 관리(DML) - INSERT(명시적 방법)
--컬럼 이름 명시적 사용하여 지정되지 않은 컬럼 NULL 자동 입력
insert into author (author_id, author_name)
values (2, '이문열');

--테이블 관리(DML) - INSERT(명시적 방법)
--컬럼 이름 명시적 사용하여 지정되지 않은 컬럼 NULL 자동 입력
insert into author (author_name, author_id)
values ('기안84', 3);

-------------------------------------------------------------------------------------------------------

--book 테이블 만들기
create table book (
        book_id number (10)
        , title varchar2 (100) not null
        , pubs varchar2 (100)
        , pub_date date
        , author_id number (10)
        , primary key (book_id)
        , CONSTRAINT book_fk
        FOREIGN KEY (author_id)
        REFERENCES author (author_id)
);

--테이블 관리(DML) - INSERT(묵시적 방법)
insert into book
values (1, '토지', '마로니에북스', '2012-08-15', 1);

--테이블 관리(DML) - INSERT(묵시적 방법)
insert into book
values (2, '삼국지', '민음사', '2002-03-01', 2);

--테이블 관리(DML) - UPDATE
update author
set author_desc = '삼국지 작가'
where author_id = 2;

--테이블 관리(DML) - UPDATE
update author
set author_name = '김경리'
where author_id = 1;

--데이터 삭제
delete from autor; --전체 데이터 삭제

delete from autor
where author_id = 1; --삭제할 데이터 설정

-------------------------------------------------------------------------------------------------------

--테이블 삭제
drop table author;
drop table book;

--전체 새로 생성
--author 테이블 만들기
create table author(
        author_id number (10)
        , author_name varchar2 (100) not null
        , author_desc varchar2 (500)
        , primary key (author_id)
);

--author 스퀀스 생성
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1
nocache;

--book 테이블 만들기
create table book (
        book_id number (10)
        , title varchar2 (100) not null
        , pubs varchar2 (100)
        , pub_date date
        , author_id number (10)
        , author_name varchar2 (10)
        , author_desc varchar2 (100)
        , primary key (book_id)
        , CONSTRAINT book_fk
        FOREIGN KEY (author_id)
        REFERENCES author (author_id)
);

--book 스퀀스 생성
CREATE SEQUENCE seq_book_id
INCREMENT BY 1
START WITH 1
nocache;

--author 테이블 관리(DML)
insert into author
values (seq_author_id.nextval, '김문열', '경북 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');

--book 테이블 관리(DML)
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1, '이문열', '경북 영양');

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1, '이문열', '경북 영양');

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2, '박경리', '경상남도 통영');

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3, '유시민', '17대 국회의원');

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4, '기안84', '기안동에서 산 84년생');

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5, '강풀', '온라인 만화가 1세대');

insert into book
values (seq_book_id.nextval, '오직 두 사람', '문학동네', '2017-05-04', 6, '김영하', '알쓸신잡');

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-08-04', 5, '강풀', '온라인 만화가 1세대');

--조회
select *
from author;

select *
from book;

--시퀀스 조회
select *
from USER_SEQUENCES;

--현재까지의 시퀀스(번호) 조회
select seq_author_id.currval
from dual;

--다음의 시퀀스(번호) 조회
select seq_author_id.nextval
from dual;

--시퀀스 삭제
DROP SEQUENCE seq_author_id;

--마지막 commit했던 시점으로 돌려줌
--하지만 테이블 관리만 해당(테이블, 시퀀스를 삭제한 것은 해당 안 됨)
rollback;

/** 데이터 저장 **/
commit;
