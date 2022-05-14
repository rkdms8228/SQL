/*** 집계(통계) SQL 문제 ***/

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 1 */
--매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요.
select count(*)
from employees
where manager_id is not null;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 2 */
--직원 중에 최고 임금(salary)과 최저 임금을 “최고임금, “최저 임금” 프로젝션 타이틀로 함께 출력해 보세요.
--두 임금의 차이는 얼마인가요?  “최고 임금 ? 최저 임금”이란 타이틀로 함께 출력해 보세요.
select  max (salary) "최고 임금"
          , min (salary) "최저 임금"
from employees;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 3 */
--마지막으로 신입사원이 들어온 날은 언제입니까? 다음 형식으로 출력해 주세요.
--예) 2014년 07월 10일
select to_char (max (hire_date), 'YYYY"년" MM"월" DD"일"') hire_date
from employees;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 4 */
--부서별로 평균 임금, 최고 임금, 최저 임금을 부서 아이디(department_id)와 함께 출력합니다.
--정렬 순서는 부서 번호(department_id) 내림차순입니다.
select  department_id
           , avg(salary)
           , max (salary)
           , min (salary)
from employees
group by department_id
order by department_id desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 5 */
--업무(job_id)별로 평균 임금, 최고 임금, 최저 임금을 업무 아이디(job_id)와 함께 출력하고
--정렬 순서는 최저 임금 내림차순, 평균 임금(소수점 반올림) 오름차순 순입니다. (정렬 순서는 최소 임금 2500 구간일 때 확인해 볼 것)
select  job_id
           , avg(round (salary))
           , max (salary)
           , min (salary)
from employees
group by job_id
order by max (salary) desc, avg(round (salary)) asc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 6 */
--가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해 주세요.
--예) 2001-01-13 토요일 
select min (to_char (hire_date, 'YYYY"년" MM"월" DD"일" day')) hire_date
from employees;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 7 */
--평균 임금과 최저 임금의 차이가 2000미만인 부서(department_id), 평균 임금, 최저 임금 그리고 (평균 임금 ? 최저 임금)를
--(평균 임금 ? 최저 임금)의 내림차순으로 정렬해서 출력하세요.
select department_id
          , avg(salary)
          , min (salary)
          ,  avg(salary) - min (salary)
from employees
group by department_id
having avg(salary) - min (salary) < 2000
order by  avg(salary) - min (salary) desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 8 */
--업무(JOBS)별로 최고 임금과 최저 임금의 차이를 출력해 보세요.
--차이를 확인할 수 있도록 내림차순으로 정렬하세요.
select  job_id
           , max_salary - min_salary salary
from jobs
order by max_salary - min_salary desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 9 */
--2005년 이후 입사자 중 관리자별로 평균 급여 최소 급여 최대 급여를 알아보려고 한다.
--출력은 관리자별로 평균 급여가 5000이상 중에 평균 급여 최소 급여 최대 급여를 출력합니다.
--평균 급여의 내림차순으로 정렬하고 평균 급여는 소수점 첫 째짜리에서 반올림하여 출력합니다.
select manager_id
          , hire_date
          , round (avg (salary), 1) avg
          , min (salary) min
          , max (salary) max
from employees
having round (avg (salary), 1) >= 5000
and hire_date >= '05/01/01'
group by manager_id, hire_date
order by round (avg (salary), 1) desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 10 */
--아래 회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
--입사일이 02/12/31일 이전이면 '창립 맴버', 03년은 '03년 입사’, 04년은 ‘04년 입사’ 
--이후 입사자는 ‘상장 이후 입사’ optDate 컬럼의 데이터로 출력하세요.
--정렬은 입사일로 오름차순으로 정렬합니다.
select first_name || ' ' || last_name "이름"
          , hire_date "입사일"
          , phone_number "전화 번호"
          , salary "급여"
          , case when hire_date < '02/12/31' then '창립맴버'
                    when hire_date > '02/12/31' then '03년입사'
                    when hire_date > '03/12/31' then '04년입사'
                    else '상장이후입사'
            end optDate
from employees
order by hire_date asc;

-----------------------------------------------------------------------------------------------------------------------------------


