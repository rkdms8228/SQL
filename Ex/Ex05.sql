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