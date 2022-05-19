/*** 혼합 SQL 문제 ***/

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 1 */
--담당 매니저가 배정되어 있으나 커미션 비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저 아이디, 커미션 비율, 월급을 출력하세요. (45건)
select first_name
          , manager_id
          , commission_pct
          , salary
from employees
where manager_id is not null
and commission_pct is null
and salary >3000;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 2 */
--각 부서별로 최고의 급여를 받는 사원의 직원 번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date),
--전화 번호(phone_number), 부서 번호(department_id) 를 조회하세요. 
-->조건절 비교 방법으로 작성하세요.
-->급여의 내림차순으로 정렬하세요.
-->입사일은 2001-01-13 토요일 형식으로 출력합니다.
-->전화 번호는 515-123-4567 형식으로 출력합니다. (11건)
select employee_id
          , first_name
          , salary
          , to_char (hire_date, 'YYYY-MM-DD day') hire_date
          , replace (phone_number, '.', '-')
          , department_id
from employees
where (salary, department_id) in (select max (salary)
                                                              , department_id
                                                    from employees
                                                    group by department_id);

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 3 */
--매니저별 담당 직원들의 평균 급여 최소 급여 최대 급여를 알아보려고 한다.
-->통계 대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자입니다.
-->매니저별 평균 급여가 5000이상만 출력합니다.
-->매니저별 평균 급여의 내림차순으로 출력합니다.
-->매니저별 평균 급여는 소수점 첫째자리에서 반올림합니다.
-->출력 내용은 매니저 아이디, 매니저 이름(first_name), 매니저별 평균 급여, 매니저별 최소 급여, 매니저별 최대 급여입니다. (9건)
select e.employee_id
          , e.first_name
          , m.avgsalary
          , m.maxsalary
          , m.minsalary
from employees e, (select round (avg (salary), 0) avgsalary
                                         , max (salary) maxsalary
                                         , min (salary) minsalary
                                         , manager_id
                               from employees
                               where hire_date >= '05/01/01'
                               group by manager_id) m
where e.employee_id = m.manager_id
and m.avgsalary >= 5000
order by m.avgsalary desc;

--간단한 셀프 조인 방법
select  man.employee_id
           , man.first_name
           , round (avg (emp.salary), 0) 
           , min (emp.salary)
           , max (emp.salary)
from employees emp, employees man
where emp.manager_id = man.employee_id
and emp.hire_date >= '2005/01/01'
group by man.employee_id, man.first_name
having round (avg (emp.salary), 0) >= 5000
order by round (avg (emp.salary), 0) desc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 4 */
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
-->부서가 없는 직원(Kimberely)도 표시합니다. (106명)
select emp.employee_id
          , emp.first_name
          , de.department_name
          , man.first_name
from employees emp, employees man, departments de
where emp.manager_id = man.employee_id
and emp.department_id = de.department_id(+);

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 5 */
--2005년 이후 입사한 직원 중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요.
select rn
          , employee_id
          , first_name
          , department_name
          , salary
          , hire_date
from (select rownum rn
                    , employee_id
                    , first_name
                    , department_name
                    , salary
                    , hire_date
           from (select employee_id
                               , first_name
                               , department_name
                               , salary
                               , hire_date
                      from employees, departments
                      where to_char (hire_date, 'YYYY') >= '2005'
                      order by hire_date asc)
                      )
where rn >= 11
and rn <=20;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 6 */
--가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
select first_name|| ' ' ||last_name fullname
          , salary
          , department_name
          , hire_date
from employees e, departments d
where hire_date = (select max (hire_date)
                              from employees)
and e.department_id = d.department_id;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 7 */
--평균 연봉(salary)이 가장 높은 부서 직원들의 직원 번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
select employee_id
          , first_name
          , last_name
          , job_title
          , e.salary
          , e.department_id
from employees e, jobs j, (select avg (salary)
                                                    , department_id
                                          from employees
                                          group by department_id
                                          having avg (salary) in (select max (avg (salary))
                                                                             from employees
                                                                             group by department_id)) ma
where e.job_id = j.job_id
and e.department_id = ma.department_id
order by employee_id asc;

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 8 */
--평균 급여(salary)가 가장 높은 부서는? 
select d.department_name
from employees e, departments d
where e.department_id = d.department_id
group by department_name
having avg (salary) in (select max (avg (salary))
                                   from employees e, departments d
                                   where e.department_id = d.department_id
                                   group by department_name);

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 9 */
--평균 급여(salary)가 가장 높은 지역은? 
select region_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id =r.region_id
group by region_name
having avg (salary) in (select max (avg (salary))
                                   from employees e, departments d, locations l, countries c, regions r
                                   where e.department_id = d.department_id
                                   and d.location_id = l.location_id
                                   and l.country_id = c.country_id
                                   and c.region_id =r.region_id
                                   group by region_name);

-----------------------------------------------------------------------------------------------------------------------------------

/* 문제 10 */
--평균 급여(salary)가 가장 높은 업무는? 
select job_title
from employees e, jobs j
where e.job_id = j.job_id
group by job_title
having avg (salary) in (select max (avg (salary))
                                   from employees e, jobs j
                                   where e.job_id = j.job_id
                                   group by job_title);

-----------------------------------------------------------------------------------------------------------------------------------


