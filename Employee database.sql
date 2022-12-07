create database Employee;
use Employee;
create table DEPT(
DeptNo int primary key,
Dname varchar(20),
Dloc varchar(15));
create table Project(
PNo int primary key,
Ploc varchar(15),
Pname varchar(20));
create table Employees(
EmpNo int primary key,
Ename varchar(20),
MGR_NO varchar(10),
Hiredate date,
Sal int,
DeptNo int,
foreign key(DeptNo) references DEPT(DeptNo) on delete cascade on update cascade);
create table Incentives(
EmpNo int,
Incentive_date date primary key,
Incentive_amount int,
foreign key(EmpNo) references Employees(EmpNo) on delete cascade on update cascade);
create table Assigned_to(
EmpNo int,
Pno int,
Job_role varchar(10),
foreign key(EmpNo) references Employees(EmpNo) on delete cascade on update cascade,
foreign key(Pno) references PRoject(Pno) on delete cascade on update cascade);

insert into Dept values
(10,'Marketing','Bangalore'),
(20,'HR','Mysore'),
(30,'IT','Chennai'),
(40,'Finance','Hyderabad'),
(50,'Accounts','Kolkata'),
(60,'Design','Mumbai'),
(70,'Logistics','Pune'),
(80,'Advertising','Delhi');
insert into Project values
(100,'Bangalore','Greed'),
(200,'Mysore','Envy'),
(300,'Chennai','Pride'),
(400,'Mumbai','Lust'),
(500,'Delhi','Gluttony'),
(600,'Hyderabad','Wrath'),
(700,'Kolkata','Sloth');
insert into Employees values
(01,'John',12,'2001-02-08',10000,80),
(02,'Lucifer',23,'2002-02-020',15000,10),
(03,'Michael',34,'2003-03-13',20000,30),
(04,'Jessi',45,'2004-05-19',25000,20),
(05,'Alesia',56,'2005-06-15',30000,50),
(06,'Taylor',67,'2006-08-06',35000,60),
(07,'Shawn',78,'2007-09-07',40000,40),
(08,'Camila',89,'2008-04-08',45000,10),
(09,'Jack',100,'2009-07-09',50000,20),
(10,'Abdul',112,'2010-11-10',55000,70);
insert into Incentives values
(08,'2021-06-15',1000),
(01,'2022-08-20',1500),
(06,'2021-04-30',2000),
(07,'2022-06-11',2500),
(02,'2021-05-17',3000),
(10,'2022-12-18',3500);
insert into Assigned_to values
(01,100,'Manager'),
(02,300,'Clerk'),
(03,200,'Supervisor'),
(04,600,'Assistant'),
(05,500,'Stock manager'),
(06,600,'Mechanic'),
(07,400,'Counselor'),
(08,100,'Chief Security'),
(09,300,'Engineer'),
(10,200,'Maid');

select EmpNo from Assigned_to A,Project P where A.Pno = P.PNo and 
P.Ploc in('Bangalore','Mysore','Hyderabad');

select  distinct(E.EmpNo) from Employees E,Incentives I where 
E.EmpNo not in(select EmpNo from Incentives);

select E.Ename,E.EmpNo,D.Dname,A.Job_role,D.Dloc,P.Ploc
from Employees E, DEPT D, Assigned_to A,Project P
where D.DeptNo = E.DeptNo and E.EmpNo = A.EmpNo and A.Pno = P.PNo
and P.Ploc = D.Dloc;