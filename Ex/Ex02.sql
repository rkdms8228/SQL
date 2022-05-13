--=========================--
/* SELECT | FROM 절 */

--모든 컬럼 조회하기
select *
from employees;


--원하는 컬럼만 조회하기
select employee_id, first_name, last_name
from employees;


--예제
--사원의 이름(first_name)과 전화번호, 입사일, 급여를 출력하세요.
select first_name, phone_number, hire_date, salary
from employees;


--예제
--사원의 사원 번호, 이름(first_name), 성(last_name), 급여, 전화번호, 이메일, 입사일을 출력하세요.
select first_name
          , last_name
          , salary
          , phone_number
          , email
          , hire_date
from employees;


--출력할 때 컬럼명 별명 사용하기
--사원의 이름(first_name)과 전화번호, 입사일, 급여를 출력하세요.
select first_name "이름"
          , phone_number "전화번호"
          , hire_date "입사일"
          , salary "연봉"
from employees;


--출력할 때 컬럼명 별명 사용하기
--사원의 사원 번호, 이름(first_name), 성(last_name), 급여, 전화번호, 이메일, 입사일을 출력하세요.
select first_name as 이름
          , last_name as 성
          , salary as 연봉
          , phone_number as hp --기본적으로 대문자로 표기됨
          , email "email" --소문자로 표기하려면 큰따옴표를 이용하여야 함
          , hire_date "입 사 일" --공백을 넣어야 하는 상황도 큰따옴표가 필요함 | as에서는 공백을 인식하지 못 함
from employees;


--연결 연산자(컬럼 붙이기)
select first_name || last_name
from employees;

select first_name || ' ' || last_name
from employees;

select first_name || 'hire date is ' || hire_date "입사일"
from employees;


--산술 연산자
select first_name
          , salary
          , salary*12
          , (salary+300)*12
from employees;


--전체 직원의 정보를 출력하세요.(이름 성명 급여 연봉 연봉2 전화번호)
select first_name || '-' || last_name "name"
          , salary
          , salary*12
          , (salary*12)+5000
          , phone_number
from employees;


--=========================--

/* WHERE 절 */

select *
from employees
where department_id = 10;

-----------------------------------------------------------------

/* and | between and */

--예제
--연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요.
select first_name || '-' || last_name "name"
          , salary
from employees
where salary >= 15000;

--*조건 2개 이상일 때 한꺼번에 조회하기*
--연봉이 14000 이상 17000이하인 사원들의 이름과 월급을 출력하세요.
select *
from employees
where salary >= 14000
and salary <= 17000;

--BETWEEN 연산자로 특정 구간 값 출력하기(and에 비해 느림)
select first_name || '-' || last_name "name"
          , salary
from employees
where salary between 14000 and 17000;

-----------------------------------------------------------------

/* and */

--예제
-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요.
select first_name || '-' || last_name "name"
          , hire_date
from employees
where hire_date >= '07/01/01';

--*조건 2개 이상일 때 한꺼번에 조회하기*
--입사일이 04/01/01에서 05/12/31 사이인 사원들의 이름과 입사일을 출력하세요.
select first_name || '-' || last_name "name"
          , hire_date
from employees
where hire_date >= '04/01/01' and hire_date <= '05/12/31';

-----------------------------------------------------------------

/* = */

--예제
--이름이 Lex인 직원의 이름과 연봉을 출력하세요.
select first_name || '-' || last_name "name"
          , salary
from employees
where first_name = 'Lex';

-----------------------------------------------------------------

/* in */

--예제
--이름이 Neena, Lex, John인 직원의 이름과 연봉을 출력하세요.
select first_name || '-' || last_name as name
          , salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

--in으로 출력하기
select first_name || '-' || last_name as name
          , salary
from employees
where first_name in ('Neena', 'Lex', 'John');

-----------------------------------------------------------------

/* in */

--예제
--연봉이 2100, 3100, 4100인 직원의 이름과 연봉을 출력하세요.
select first_name || '-' || last_name as name
          , salary
from employees
where salary = '2100'
or salary = '3100'
or salary = '4100'
or salary = '5100';

--in으로 출력하기
select first_name || '-' || last_name as name
          , salary
from employees
where salary in ('2100', '3100', '4100', '5100');

-----------------------------------------------------------------

/* % */

--예제
--이름(first_name)에 L을 포함한 직원의 이름, 성, 급여 출력하세요.
select first_name, last_name, salary
from employees
where first_name like 'L%'; --%는 앞 또는 뒤에 무엇이 오든 상관없다는 것으로 쓰임

--이름에 am을 포함한 사원의 이름과 연봉을 출력하세요.
select first_name || '-' || last_name
          , salary
from employees
where first_name like '%am%';

--이름의 두 번째 글자가 a 인 사원의 이름과 연봉을 출력하세요.
select first_name || '-' || last_name
          , salary
from employees
where first_name like '_a%';

--이름의 네 번째 글자가 a 인 사원의 이름을 출력하세요.
select first_name || '-' || last_name
from employees
where first_name like '___a%';

--이름이 4글자인 사원 중 끝에서 두 번째 글자가 a인 사원의 이름을 출력하세요.
select first_name || '-' || last_name as name
from employees
where first_name like '%a_';

-----------------------------------------------------------------

/* is null | is not null */

--primary key는 어떠한 것과도 겹치지 않는 값을 뜻함**
--예제
select first_name, salary, commission_pct
from employees
where commission_pct is null; 

--커미션 비율이 있는 사원의 이름과 연봉 커미션 비율을 출력하세요.
select first_name || '-' || last_name as name
          , salary
          , commission_pct
from employees
where commission_pct is not null;

--담당 매니저가 없고 커미션 비율이 없는 직원의 이름을 출력하세요.
select first_name || '-' || last_name as name
from employees
where commission_pct is null
and manager_id is null;

-----------------------------------------------------------------


--=========================--

/* ORDER BY 절 */

select first_name
          , salary
from employees
order by salary desc; --내림차순(큰 수부터 작은 수로)

select first_name
          , salary
from employees
order by salary asc; --오름차순(작은 수부터 큰 수로)

/* 기본 오름차순*/
--한글: 가, 나, 다, 라, 마...
--영어: A, B, C, D, E...
--숫자: 1, 2, 3, 4, 5...
--날짜: 오래된 날짜에서 최근 날짜
--(정렬 조건이 복수일 때는 , 로 구분)

--급여가 9000이상인 직원의 이름과 급여 출력하세요.(단, 급여를 내림차순으로 출력)
select first_name
          , salary
from employees
where salary >= 9000
order by salary desc;

-----------------------------------------------------------------

--예제
--부서 번호를 오름차순으로 정렬하고 부서 번호, 급여, 이름을 출력하세요.
select department_id
          , salary
          , first_name
from employees
order by department_id asc;

--급여가 10000이상인 직원의 이름, 급여를 급여가 큰 직원부터 출력하세요.
select first_name
          , salary
from employees
where salary >=10000
order by salary desc;

--부서 번호를 오름차순으로 정렬하고 부서 번호가 같으면 급여가 높은 사람부터 부서 번호, 급여, 이름을 출력하세요.
select department_id
          , salary
          , first_name
from employees
order by department_id asc, salary desc; --(정렬 조건 복수로 컴마 [,] 사용)

-----------------------------------------------------------------


--=========================--

/* 단일행 함수 */

/* 문자 함수 */
/* INITCAP (컬럼명 | 첫글자만 대문자) */

--부서 번호 100인 직원의 이메일 주소와 부서 번호를 출력하세요.
select email
          , initcap(email)
          , department_id
from employees
where department_id = 100;

-----------------------------------------------------------------

/* 문자 함수 */
/* LOWER (컬럼명) | UPPER (컬럼명) */

select first_name
          , lower(first_name) lower --as 생략 가능
          , upper(first_name) upper
from employees
where department_id = 100;

-----------------------------------------------------------------

/* 문자 함수 */
/* SUBSTR (컬럼명, 시작 위치, 글자 수) */

select first_name
          , substr(first_name, 1, 3) --글자의 수가 문자보다 클 때는 모든 글자 출력됨
          , substr(first_name, -3, 2) --시작 위치 -는 뒤에서부터 시작 | 원하는 글자 수보다 문자가 부족할 때는 출력되는 문자까지만 나옴
from employees
where department_id = 100;

-----------------------------------------------------------------

/* 문자 함수 */
/* LPAD (컬럼명, 자리 수, ‘채울 문자’) / RPAD(컬럼명, 자리 수, ‘채울 문자’) */

select first_name
          , lpad(first_name, 10, '*') --왼쪽 채우기
          , rpad(first_name, 10, '*') --오른쪽 채우기
          , rpad(lpad(first_name, 10, '*'), 15, '*') --양쪽 채우기(실험해 보는 것으로 정확하지 않음)
from employees;

-----------------------------------------------------------------

/* 문자 함수 */
/* REPLACE (컬럼명, 문자1, 문자2) */

--문자1을 문자2로 바꾸는 법
select first_name
          , replace(first_name, 'a', '*') 
from employees
where department_id =100;

--두 번째 글자부터 문자 3개를 *로 바꾸기
select first_name
          , replace(first_name, 'a', '*')
          ,substr (first_name, 2, 3)
          , replace(first_name, substr (first_name, 2, 3), '***')
from employees
where department_id =100;

-----------------------------------------------------------------

/* 숫자 함수 */
/* ROUND (숫자, 출력을 원하는 소수점 아래 자리 수까지 반올림하여 출력) */
select round (123.456, 1) r1
         ,  round (123.556, 0) r0
         ,  round (125.456, -1) "r-1" --마이너스로 쓰면 일의 자리까지 올라감
from dual;

-----------------------------------------------------------------

/* 숫자 함수 */
/* TRUNC (숫자, 출력을 원하는 소수점 아래 자리 수까지 버림하여 출력)  */
select trunc (123.456, 1) t1
         ,  trunc (123.556, 0) t0
         ,  trunc (125.456, -1) "t-1" --마이너스로 쓰면 일의 자리까지 올라감
from dual;

-----------------------------------------------------------------

/* 날짜 함수 */
/*  SYSDATE() */

--현재의 날짜
select sysdate
from dual;

-----------------------------------------------------------------

/* 날짜 함수 */
/* MONTH_BETWEEN (d1, d2) */

-- d1 날짜와 d2 날짜의 개월 수를 출력하는 함수
select months_between ('22/05/12', '22/04/12') 
from dual;

select months_between (sysdate, hire_date) 
from employees
where department_id = 110;

-----------------------------------------------------------------

/* 변환 함수 */
/* TO_CHAR(숫자, ‘출력 모양’) */

--숫자형을 문자형으로 변환
select first_name
          , to_char (salary*12, '$99999999') "SAL9" --9의 개수만큼 자리 수 출력
          , to_char (salary*12, '$09999999') "SAL0" --빈자리 채울 때는 0으로 표시
          , to_char (salary*12, '$99,999,999') "SAL," --천단위 표시
          , to_char (salary*12, '$99999.99') "SAL." --소수점 자리도 표시 | 숫자 자리 수가 부족하면 #으로 표기됨
from employees;

--날짜형을 문자형으로 변환
select sysdate
          , to_char (sysdate, 'YYYY')
          , to_char (sysdate, 'YY')
          , to_char (sysdate, 'MM')
          , to_char (sysdate, 'MON')
          , to_char (sysdate, 'MONTH')
          , to_char (sysdate, 'DD')
          , to_char (sysdate, 'DAY')
          , to_char (sysdate, 'DDTH')
          , to_char (sysdate, 'HH24')
          , to_char (sysdate, 'HH')
          , to_char (sysdate, 'MI')
          , to_char (sysdate, 'SS')
from dual;

-----------------------------------------------------------------

/* 일반 함수 */
/* NVL (컬럼명, null일 때 값) | NVL2(컬럼명, null이 아닐 때 값, null일 때 값) */
select first_name
          , commission_pct
          , nvl (commission_pct, 0)
          , nvl2 (commission_pct, 100, 0)
from employees;

-----------------------------------------------------------------

--TEST--
select next_day ('2022/05/12','금요일') 
from dual;



