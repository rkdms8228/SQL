/*** 서브 쿼리(SUBQUERY) SQL 문제 ***/

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 1 */
--평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시오. (56건)
select count (salary)
from employees
where salary < (select avg (salary)
                         from employees);

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 2 */
--평균 급여 이상, 최대 급여 이하의 월급을 받는 사원의 
--직원 번호(employee_id), 이름(first_name), 급여(salary), 평균 급여, 최대 급여를 급여의 오름차순으로 정렬하여 출력하세요. (51건)
select employee_id
          , first_name
          , salary
from employees
where salary >= (select avg (salary)
                          from employees)
and salary <= (select max (salary)
                       from employees)
order by salary asc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 3 */
--직원 중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
--도시 아이디(location_id), 거리명(street_address), 우편 번호(postal_code), 도시명(city), 주(state_province), 나라 아이디(country_id) 를 출력하세요. (1건)
select first_name
          , last_name
          , d.department_id
          , l.location_id
          , street_address
          , postal_code
          , city
          , state_province
          , country_id
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and (first_name, last_name) in (select first_name
                                                            , last_name
                                                 from employees
                                                 where first_name = 'Steven'
                                                 and last_name = 'King');

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 4 */
--job_id 가 'ST_MAN'인 직원의 급여보다 작은 직원의 사번, 이름, 급여를 급여의 내림차순으로 출력하세요. -ANY 연산자 사용 (74건)
select employee_id
          , first_name || ' ' || last_name "FULL NAME"
          , salary
from employees
where salary <any (select salary
                              from employees
                              where job_id = 'ST_MAN')
order by salary desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 5 */
--각 부서별로 최고의 급여를 받는 사원의 직원 번호(employee_id), 이름(first_name)과 급여(salary) 부서 번호(department_id)를 조회하세요.
--단, 조회 결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--조건절 비교, 테이블 조인 2가지 방법으로 작성하세요. (11건)

--조건절 비교
select employee_id
          , first_name
          , salary
          , department_id
from employees
where (salary, department_id) in (select max (salary)
                                                               , department_id
                                                     from employees
                                                     group by department_id)
order by salary desc;

--테이블 조인
select employee_id
          , first_name
          , e.salary
          , e.department_id
from employees e, (select max (salary) salary
                                         , department_id
                               from employees
                               group by department_id) s
where e.salary = s.salary
and e.department_id = s.department_id
order by salary desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 6 */
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총 합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오. (19건)
select j.job_title
          , e.salary
from employees e, jobs j
where salary in (select sum (salary)
                          from employees
                          group by job_id)
order by e.salary desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 7 */
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원 번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요. (38건)
select employee_id
          , first_name
          , e.salary
          , e.department_id
from employees e, (select avg (salary) salary
                                         , department_id
                                from employees
                                group by department_id) s
where e.salary > s.salary
and e.department_id = s.department_id;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 8 */
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요.
select rn
          , employee_id
          , first_name
          , salary
          , hire_date
from (select rownum rn
                    , employee_id
                    , first_name
                    , salary
                    , hire_date
          from (select employee_id
                              , first_name
                              , salary
                              , hire_date
                    from employees
                    order by hire_date desc)
          )
where rn >=11
and rn <= 15;

-----------------------------------------------------------------------------------------------------------------------------------


