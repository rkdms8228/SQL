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


--단일행 연산자 : = , > , >=, < , <=, <>(같지 않다)--


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


--다중행 연산자: IN(=), ANY(or), ALL(and)--


--IN
--각 부서별로 최고급여를 받는 사원을 출력하세요.
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
--부서 번호 110번인 직원이 두 명이므로 표본이 두개이다.
--해서 ANY는 급여 12008, 8300 두 값 중 하나라도 넘는다면 결과값에 나온다.

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

--부서 번호 110번인 직원이 두 명이므로 표본이 두개이다.
--ALL은 급여 12008, 8300 두 값 모두 넘어야만 결과값에 나온다.

-----------------------------------------------------------------


