create database Airline;
use Airline;
create table Flights(
FLno int primary key,
Ffrom varchar(50),
Tto varchar(50),
Distance int,
Departs time,
Arrives time,
Price int);

create table Aircraft(
Aid int primary key,
Aname varchar(50),
Cruising_range int);

create table Employee(
Eid int primary key,
Ename varchar(50),
Salary int);

create table Certified(
Eid int,
Aid int,
foreign key(Aid) references Aircraft(Aid) on update cascade on delete cascade,
foreign key(Eid) references Employee(Eid) on update cascade on delete cascade);


insert into Employee values
(101,'Avinash',50000),
(102,'Lokesh',60000),
(103,'Rakesh',70000),
(104,'Santhosh',82000),
(105,'Tilak',5000);

insert into Aircraft values
(1,'Airbus',2000),
(2,'Boeing',700),
(3,'JetAirways',550),
(4,'Indigo',5000),
(5,'Boeing',4500),
(6,'Airbus',2200);

insert into Certified values
(101,2),(101,4),(101,5),
(101,6),(102,1),(102,3),
(102,5),(103,2),(103,3),
(103,5),(103,6),(104,6),
(104,1),(104,3),(105,3);

insert into Flights values
(1,'Banglore','New Delhi',500,'6:00','9:00',5000),
(2,'Banglore','Chennai',300,'7:00','8:30',3000),
(3,'Trivandrum','New Delhi',800,'8:00','11:30',6000),
(4,'Banglore','Frankfurt',10000,'6:00','23:30',50000),
(5,'Kolkata','New Delhi',2400,'11:00','3:30',9000),
(6,'Banglore','Frankfurt',8000,'9:00','23:00',40000);

#QUERIES:
#1
select A.Aname from Aircraft A,Certified C,Employee E 
where A.Aid=C.Aid and C.Eid=E.Eid and not existS(select *from Employee E1
where E1.Eid=E.Eid and E1.salary<80000);

#2
select C.Eid,MAX(Cruising_range) from Certified C,Aircraft A
where C.Aid=A.Aid group by C.Eid having COUNT(*)>2;

#3
select distinct E.Ename from Employee E 
where E.salary <(select MIN(f.price) from Flights F
where F.Ffrom='Banglore' and F.Tto='Frankfurt');

#4
select A.Aid, A.Aname,avg(E.salary) from Aircraft A, Employee E, Certified C
where A.Aid=C.Aid and C.Eid=E.Eid and A.Cruising_range>1000
group by A.Aid, A.Aname;

#5
select distinct E.Ename
from Employee E,Aircraft A,Certified C
where E.Eid=C.Eid and C.Aid=A.Aid and A.Aname='Boeing';

#6
select A.Aid from Aircraft A 
where A.Cruising_range>(select MIN(F.Distance) from Flights F
where F.Ffrom='Banglore' and F.Tto='New Delhi');