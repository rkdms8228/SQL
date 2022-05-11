/*select문 기본*/

select * 
from employees; /*줄 바꿈을 해도 이상 없음 | 마침표를 기준으로 인식*/

select * from departments;


select employee_id, first_name, phone_number from employees; /*컴마(,)를 기점으로 나눔 | 앞에 오는 순서부터 결과를 보여 줌*/