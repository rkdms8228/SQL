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