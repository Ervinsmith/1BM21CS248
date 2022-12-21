create database supplier;
use supplier;
create table supplier
(sid varchar(20) primary key,
sname varchar(20),
city varchar(20));
create table parts
(pid varchar(20) primary key,
pname varchar(20),
color varchar(20));
create table catalog
(sid varchar(20),
pid varchar(20),
cost varchar(20),
primary key(sid,pid),
foreign key(pid)references parts(pid) on delete cascade on update cascade,
foreign key(sid)references supplier(sid) on delete cascade on update cascade);
insert into supplier values
(10001,'acme widget','bangalore'),
(10002,'johns','kolkata'),
(10003,'vimal','mumbai'),
(10004,'reliance','delhi');
insert into parts values
(20001,'book','red'),
(20002,'pen','red'),
(20003,'pencil','green'),
(20004,'mobile','green'),
(20005,'charger','black');
insert into catalog values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

#QUERIES:
#1
select pname from parts where pid IN (select pid from catalog);

#2
select sname from
(select c.sname,count(distinct a.pid) as cnt from catalog a
left join parts b on a.pid=b.pid
left join supplier c on c.sid=a.sid group by 1) a
where cnt=(select count(distinct a.pid) from catalog a
left join parts b on a.pid=b.pid);

#3
select distinct sname from
(select c.sname,b.pname,b.color from catalog a
left join parts b on a.pid=b.pid
left join supplier c on c.sid=a.sid )a
where color='red';

#4
select A.pname from parts A
left join catalog B on A.pid=B.pid
left join supplier C on B.sid=C.sid where lower(c.sname)='acme widget'
and a.pname not in (select A.pname from parts A
left join catalog B on A.pid=B.pid
left join supplier C on B.sid=C.sid where lower(c.sname)<>'acme widget');

#5
select a.sid from
(select A.pid,C.sid,cost from parts A
left join catalog B on A.pid=B.pid
left join supplier C on B.sid=C.sid )A
left join (select A.pid,avg(cost) as cost from parts A
left join catalog B on A.pid=B.pid left join supplier C on B.sid=C.sid 
where cost is not null group by 1 )B on A.pid=B.pid where a.cost>b.cost;

#6
select pid,sname from
(select A.pid,C.sname,cost,rank() over(partition by pid order by cost desc) 
as rnk from parts A left join catalog B on A.pid=B.pid
left join supplier C on B.sid=C.sid)A where rnk=1 and cost is not null
order by sname;