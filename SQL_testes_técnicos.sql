CREATE TABLE emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;


insert into emp values(1,'Maria',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Joao',14000,5,48,200,'IT','Male');
insert into emp values(3,'Lua',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Norma',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Rodrigo',15000,6,55,200,'IT','Male');
insert into emp values(6,'Felipe',15600,2,14,200,'IT','Male');=
insert into emp values(8,'Marcos',7200,2,12,200,'IT','Male');
insert into emp values(9,'Davi',7000,6,51,300,'HR','Male');
insert into emp values(10,'Daniel',8000,6,50,300,'HR','Male');
insert into emp values(11,'Ielvo',4000,1,31,500,'Ops','Male');
insert into emp values(1,'Maria',14300,4,39,100,'Analytics','Female');
insert into emp values(3,'Lua',12100,4,37,100,'Analytics','Female');
insert into emp values(3,'Lua',12100,4,37,100,null,'Female');

select * from emp order by emp_id;



--1 ) Retorne somente ou as linhas duplicadas na tabela

select emp_id, count(emp_id)
from emp e
group by emp_id
order by emp_id;

select emp_id, count(emp_id) as quantidade
from emp e
group by emp_id
having count(emp_id) > 1;



-- 2) Imprima as informações do funcionário com maior salário do departamento de TI 

select * from emp;

-- 1) Encontrar o maior salário
-- 2) somente do departamento de ti

with maior_salario as (
	select max(salary)
	from emp
	where dep_name='IT'
) select *  from emp e where salary = (select * from maior_salario)
  and dep_name = 'IT'


--3 ) Como deletar linhas duplicadas?

select * from emp;
  
  
  with cte as (
  	select emp_id, count(emp_id) as quantidade
	from emp e
	group by emp_id
	having count(emp_id) > 1
  ) delete from emp where emp_id in (select emp_id from cte)
  
  
with cte as (
	select emp_id, 
	row_number () over (partition by emp_id order by emp_id) as rn
	from emp
) delete from emp where emp.emp_id = (select cte.emp_id from cte where rn > 1)
  
  
  select * from emp
  

-- 4) explique a diferença entre Rank, dense, row_function


-- Rank atribui um valor de rank para cada linha do conjunto particionado

select *
,
rank () over (order by salary desc) as ranks,
dense_rank () over (order by salary desc) as dense_ranks,
row_number () over (order by salary desc) as row_numbers
from emp;



-- 5) Encontre funcionários com salários maiores que a média de todos

-- obtem a média dos salarios

with average_salary(avg_salary) as (
	select avg(salary)
	from emp
) 

select e.emp_name,
	   e.salary,
	   av.avg_salary
from emp e, average_salary av
where e.salary > av.avg_salary
	   



-- 6) Quais funcionarios não tem departamento cadastrado

select * from emp

select *
from emp e 
where dep_id is null

select *
from emp e
where dep_name is null

-- 7) Retorne o funcionario com maior salario de cada departamento

with cte as (
	select emp.*, 
	dense_rank () over (partition by dep_id order by salary desc) as dr
from emp
where dep_name is not null
)








-- 8) Altere o relatorio para imprimir M quando for Male ou F quando for Female

select emp.emp_name,
	   emp.gender,
	   case when emp.gender ='Male' then 'M'
	   	    when emp.gender = 'Female' then 'F'
	   	    end as gender
from emp;







-- 9) Explique a diferença entre DISTINCT e GROUP BY clause

select distinct emp_name
from emp;

select emp_name, sum(1)
from emp e 
group by emp_name;















--10) Union vs Union All

	
-- UNION
''' O comando UNION é usado para selecionar informações de duas tabelas, bem parecido com o JOIN. 
Porém quando usamos o UNION todas as colunas selecionadas precisam ser do mesmo tipo de dados nas duas tabelas. 
No comando UNION, apenas valores distintos são retornados. '''

-- UNION ALL
'''O UNION ALL é bem parecido com o UNION, exceto que o UNION ALL retorna todos os valores (valores duplicados).

A diferença entre o UNION e o UNION ALL é que o UNION ALL não elimina os valores duplicados, ao invés disso ele pega todos os valores de todas as tabelas ligadas e coloca no resultado que você especificou na sua query.

O comando UNION faz um SELECT DISTINCT nos resultados obtidos. Quando você sabe que todos os resultados são distintos, use o UNION ALL, para obter os resultados mais rápido.
'''




