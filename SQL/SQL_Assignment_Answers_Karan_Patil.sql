
use classicmodels;
--------------
-- Q1 a
select employeenumber, firstname, lastname from employees where jobtitle='sales rep' and reportsto=1102;

-- Q1 b
select distinct productline from products where productline like '%cars';

-- Q2 a
select customernumber, customername, 
case when country in ('usa','canada')then 'North America'
		when country in ('uk','france','germany') then 'Europe'
            else 'Other'
end as CustomerSegment
from customers;


-- Q3
select productcode, sum(quantityordered) as total_ordered from orderdetails  group by productcode order by total_ordered desc  limit 10;

-- Q3 b

select monthname(paymentdate), count(*) as total_payments  from payments group by monthname(paymentdate) having  total_payments > 20 order by total_payments desc ;

-- Q4

create database Custromers_Orders;
use Custromers_Orders;

Create table Customers(
customer_id  int auto_increment primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
Email varchar(255) unique,
phone_number varchar(20)
);

Create Table Orders(
order_id int auto_increment primary key,
customer_id int, 
order_date date,
Total_amount decimal(10,2) check(total_amount>0),
constraint customer_id foreign key(customer_id) references customers(customer_id)
)

-- Q5 a
select Country, count(*)as order_count
from customers inner join orders
on customers.customernumber=orders.customernumber group by country order by order_count desc limit 5;


-- Q6 a

create table project(
EmployeeID int auto_increment primary key,
FullName varchar(50) not null,
Gender varchar(10) check (gender in ('Male','Female')),
ManagerId int
);

Insert into project (FullName,Gender,ManagerId) values  ('Pranaya','Male',3),
														('Priyanka','Female',1),
                                                        ('Preety','Female',null),
                                                        ('Anurag','Male',1),
                                                        ('Sambit','Male',1),
                                                        ('Rajesh','Male',3),
                                                        ('Hina','Female',3);

select m1.Fullname as 'Manager Name', e1.fullname as 'Emp Name'
from project m1 join project e1
on m1.employeeid=e1.managerid order by m1.fullname ;


-- Q7 
use custromers_orders;

create table Facility(
Facility_id int,
Name varchar(100),
State varchar(100),
Country varchar(100)
);

alter table facility
modify column facility_id int auto_increment primary key;

alter table facility
add column city varchar(100) not null after name;


desc facility;


-- Q8
use classicmodels;

CREATE VIEW product_category_sales AS
select pl.productline, sum(od.quantityordered * od.priceEach ) as total_sales, count(distinct od.ordernumber)
from productlines pl join products p  join orderDetails od join orders o 
on pl.productline=p.productline and  od.productcode=p.productcode and o.ordernumber=od.ordernumber group by pl.productline;


select * from product_category_sales;


-- Q9 a

call Get_country_payments(2003, 'france');


-- Q10 a

select c.customername, count(o.ordernumber) as order_count , dense_rank() over ( order by count(o.ordernumber) desc) as order_freqeecy_rnk
from customers c inner join orders o 
on c.customernumber=o.customernumber group by c.customername;


-- Q10 b

select year(orderdate) as Year,monthname(orderdate) as Month,count(ordernumber) as 'Total Orders',
concat(round(
(count(ordernumber)-lag(count(ordernumber)) over (order by year(orderdate), month(orderdate)))
/lag(count(ordernumber)) over (order by year(orderdate), month(orderdate))*100
),'%') as 'YOY % change' 
from orders group by  year(orderdate), month(orderdate) order by year(orderdate), month(orderdate);


-- Q11 a



select productline, count(*) as Total from products 
where buyprice>(select avg(buyprice) from products) group by productline order by total desc;


-- Q12 a

create table Emp_EH(
EmpID int primary key not null,
EmpName varchar(50) not null,
EmailAdderss Varchar(100) unique
);

call exception1(1,'karan','k@gmail.com');
call exception1(null,'karan','k@gmail.com');
call exception1(2,'karan','k@gmail.com');



-- Q13 a

create table Emp_BIT(
Name varchar(50),
Occupation varchar(50),
working_date date,
Working_hours int
);

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  

INSERT INTO Emp_BIT VALUES
('karan', 'analyst', '2024-10-04', -12);


select * from emp_bit;
