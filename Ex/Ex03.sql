--=========================--
/* 그룹 함수 */
/* 합계 SUM() */
select sum (salary)
          , count (salary)
from employees;

-----------------------------------------------------------------

/* 그룹 함수 */
/* 총 건 수 COUNT() */
select count (*) --null 값 포함
          , count (commission_pct) --null 값 제외
          , count (manager_id)
from employees;

--급여가 16000이 넘는 사원 카운트
select count (*)
from employees
where salary > 16000;

-----------------------------------------------------------------

/* 그룹 함수 */
/* 평균 AVG() */
--null의 값은 빼고 계산됨
select avg (salary) --급여가 null인 사람은 평균 계산 제외
          , avg (nvl (salary, 0)) -- null인 값은 0으로 변경 후 평균 계산
          , count(*)
          , sum (salary)
from employees;

-----------------------------------------------------------------

/* 그룹 함수 */
/* MAX() | MIN() */
select max (salary)
          , min (salary)
from employees;

-----------------------------------------------------------------


--=========================--

/*  GROUP BY 절 */

--일반 출력
select first_name
from employees
where salary > 16000
order by salary desc;

--group by를 쓴 출력
select department_id --여러줄이 출력
          , avg (salary) --전체 값을 평균 내기 때문에 한 줄만 나옴
from employees
group by department_id --해서 부서별로 나오면 줄의 값이 동일해져서 avg와 같이 출력 가능해짐
order by department_id asc;

--group by를 쓴 출력2(심화)
select department_id
          , job_id
          , avg (salary)
          , sum (salary)
          , count (salary)
from employees
group by department_id, job_id
order by department_id asc;

--연봉(salary)의 합계가 20000이상인 부서의 부서 번호와 , 인원 수, 급여 합계를 출력하세요.
select department_id
         , count (*)
         , sum (salary)
from employees
--where sum (salary) >= 20000 where 절에는 그룹 함수를 쓸 수 없음
group by department_id;

-----------------------------------------------------------------


--=========================--

/* HAVING 절 */

--연봉(salary)의 합계가 20000이상인 부서의 부서 번호와 , 인원 수, 급여 합계를 출력하세요.
select department_id
         , count (*)
         , sum (salary)
from employees
group by department_id
having sum (salary) >= 20000
and sum (salary) <= 100000; --where 절 대체

select department_id
         , count (*)
         , sum (salary)
from employees
group by department_id
having sum (salary) >= 20000
and department_id = 90; --그룹 함수와 group by에 참여한 컬럼만 사용 가능

-----------------------------------------------------------------


--=========================--

/* CASE ~ END 문 */

select employee_id
          , first_name
          , job_id
          , salary
          , case when job_id = 'AC_ACCOUNT' then salary + salary*0.1 --CASE WHEN 조건 THEN 출력
                    when job_id = 'SA_REP' then salary + salary*0.2
                    when job_id = 'ST_CLERK' then salary + salary*0.3
                    else salary
          end realSalary --END “컬럼명”
from employees;

-----------------------------------------------------------------

/* CASE ~ END 문 */
/* DECODE 문 */
select employee_id
          , first_name
          , job_id
          , salary
          , decode  (job_id, 'AC_ACCOUNT', salary + salary*0.1
                                      , 'SA_REP', salary + salary*0.2
                                      , 'ST_CLERK', salary + salary*0.3
                         , salary) bonus
from employees;

-----------------------------------------------------------------

--예제
--직원의 이름, 부서, 팀을 출력하세요.
--팀은 코드로 결정하며 부서 코드가 10~50 이면 ‘A-TEAM’ 60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select first_name
          , department_id
          , case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
                    when department_id >= 60 and department_id <= 100 then  'B-TEAM'
                    when department_id >= 110 and department_id <= 150 then  'C-TEAM'
                    else '팀없음'
            end realDepartment
from employees;

-----------------------------------------------------------------


--=========================--

/* JOIN */

select first_name
          , em.department_id
          , department_name
          , de.department_id
from employees em, departments de --줄임 표시
where em.department_id = de.department_id;

select employee_id
          , first_name
          , salary
          , employees.department_id --어디에 포함된 department_id인지 정확한 표기가 필요함
from employees, departments
where employees.department_id = departments.department_id;

-----------------------------------------------------------------

--예제
--모든 직원 이름, 부서 이름, 업무명을 출력하세요.
select first_name
          , department_name
          , job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
and em.salary >= 7000; --null 값이 출력되지 않음으로 출력되게 옵션 추가

-----------------------------------------------------------------

/* JOIN */
/* left join */
--equi join 테이터 106개 --> null은 포함되지 않음
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em, departments de
where em.department_id = de.department_id;

--예제
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em left outer join departments de
on em.department_id = de.department_id;

--left join 오라클 표현법
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em, departments de
where em.department_id = de.department_id(+); --(+)은 null 포함

-----------------------------------------------------------------

/* JOIN */
/* right join */ 
--equi join 테이터 106개 --> null은 포함되지 않는다
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em, departments de
where em.department_id = de.department_id;

--예제
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em right outer join departments de
on em.department_id = de.department_id;

--right join 오라클 표현법
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id;

--right join --> left join
select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em right outer join departments de
on em.department_id = de.department_id;

select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from departments de left outer join employees em
on em.department_id = de.department_id;

-----------------------------------------------------------------

/* JOIN */
/* full outer join */

select em.first_name
          , em.department_id
          , de.department_name
          , de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;

-----------------------------------------------------------------

/* JOIN */
/* Self Join */
select emp.employee_id
         , emp.first_name
         , emp.salary
         , emp.phone_number
         , emp.manager_id
         , man.employee_id
         , man.first_name ManagerName
         , man.phone_number
from employees emp, employees man
where emp.manager_id = man.employee_id;

-----------------------------------------------------------------


