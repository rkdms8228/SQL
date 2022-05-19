--테이블 삭제
drop table book;
drop table author;

--시퀀스 삭제
DROP SEQUENCE book;

--시퀀스 삭제
DROP SEQUENCE author;

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
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직 두 사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-08-04', 5);

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

--마지막 commit했던 시점으로 돌려줌
--하지만 테이블 관리만 해당(테이블, 시퀀스를 삭제한 것은 해당 안 됨)
rollback;

/** 데이터 저장 **/
commit;

--테이블 관리(DML) - UPDATE
update author
set author_desc = '서울특별시'
where author_id = 5;

--author 테이블에서 기안84 데이터를 삭제
delete from author
where author_id = 4;
-->book과 author 테이블이 author_id로 연동되어 있어서 author에서 단독으로 삭제를 시도할 시 삭제되지 않음

--테이블 합쳐서 조회
select *
from book b, author a
where b.author_id = a.author_id;
