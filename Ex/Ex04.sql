--=========================--

/* SubQuery */
/* 단일행 */
--‘Den’보다 급여가 높은 사람의 이름과 급여는?
select first_name
          , salary
from employees
where salary > (select salary
                        from employees
                        where first_name = 'Den'); --SubQuery


--[단일행 연산자 : = , > , >=, < , <=, <>(같지 않다)]--


--급여를 가장 적게 받는 사람의 이름, 급여, 사원 번호는?
select first_name
          , salary
          , employee_id
from employees
where salary <= (select min (salary)
                          from employees);

--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요.
select first_name
          , salary
          , employee_id
from employees
where salary < (select avg (salary)
                        from employees);

-----------------------------------------------------------------
              
/* SubQuery */ 
/* 다중행 */
--IN
--부서 번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요.
select first_name
          , salary
          , employee_id
from employees
where salary in (select salary
                          from employees
                          where department_id = 110);


--[다중행 연산자: IN(=), ANY(or), ALL(and)]--


--IN
--각 부서별로 최고 급여를 받는 사원을 출력하세요.
select department_id
          , employee_id
          , first_name || ' ' || last_name "FULL NAME"
          , salary
from employees
where (salary, department_id) in (select max (salary)
                                                               , department_id
                                                     from employees
                                                     group by department_id)
order by department_id asc;

-----------------------------------------------------------------

/* 다중행 */
--ANY
--부서 번호가 110인 직원의 급여보다 큰 모든 직원들의 사번, 이름, 급여를 출력하세요.
select first_name
          , salary
          , employee_id
from employees
where salary >any (select salary
                              from employees
                              where department_id = '110');
                              
-->부서 번호 110번인 직원이 두 명이므로 표본이 두개이다.
-->해서 ANY는 급여 12008, 8300 두 값 중 하나라도 넘는다면 결과값에 나온다.

-----------------------------------------------------------------

/* 다중행 */
--ALL <--> ANY 비교
--부서 번호가 110인 직원의 급여보다 큰 모든 직원들의 사번, 이름, 급여를 출력하세요.
select first_name
          , salary
          , employee_id
from employees
where salary >all (select salary
                            from employees
                            where department_id = '110');

-->부서 번호 110번인 직원이 두 명이므로 표본이 두개이다.
-->ALL은 급여 12008, 8300 두 값 모두 넘어야만 결과값에 나온다.

-----------------------------------------------------------------

/* 다중행 */
--조건절에서 비교 vs 테이블에서 조인

--각 부서별로 최고 급여를 받는 사원을 출력하세요.
--조건절에서 비교
select department_id
          , employee_id
          , first_name
          , salary
from employees
where (department_id, salary) in (select department_id
                                                               , max (salary)
                                                     from employees
                                                     group by department_id)
order by department_id asc;

--각 부서별로 최고 급여를 받는 사원을 출력하세요.
--테이블에서 조인
select e.department_id
          , e.employee_id
          , e.first_name
          , e.salary
from employees e, (select department_id
                                         , max (salary) salary
                               from employees
                               group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary
order by department_id asc;

-----------------------------------------------------------------


--=========================--

/* rownum */ 

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
select rn
          , first_name
          , salary
from (select rownum rn
                    , first_name
                    , salary
          from (select first_name
                              , salary
                    from employees
                    order by salary desc)
          )
where rn >=1
and rn <= 5;

--오류 예시
select rownum --순위를 매기는 곳
          , first_name
          , salary
from (select first_name
                    , salary
          from employees
          order by salary desc)
where rn >=2 --조건을 검사하는 곳
and rn <= 5;

-->동시에 순위와 조건을 순서대로 작업을 하니 다음의 결과값이 계속 1번째로 매겨져서 값이 출력되지 않음

-----------------------------------------------------------------

--07년에 입사한 직원 중 급여가 많은 직원 3등에서 7등의 이름, 급여, 입사일은?
select rn
          , first_name
          , salary
          , hire_date
from (select rownum rn
                   , first_name
                   , salary
                   , hire_date
           from (select first_name
                               , salary
                               , hire_date
                      from employees
                      where to_char (hire_date, 'YYYY') = '2007'
                      order by salary desc)
          )
where rn >=3
and rn <= 7;

-----------------------------------------------------------------


