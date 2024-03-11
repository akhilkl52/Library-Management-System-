create database library;
use library;

create table Branch (Branch_no int not null primary key,Manager_id int not null,Branch_address varchar(35),contact_no int,
 check(contact_no > 999999999 and contact_no <= 9999999999));
desc Branch;
insert into branch values(101,1001,'Central library palakkad',1846232321);
insert into branch values(102,1002,'Central library Thrissur',1445676711);
insert into branch values(103,1003,'Central library Kochi',1845676711);
insert into branch values(104,1004,'Central library Wayanad',1745676711);
insert into branch values(105,1005,'Central library TVM',1454676711);
select * from branch;

create table Employee(Emp_id int not null primary key,Emp_Name varchar(25),Position varchar(25),Salary int,
Branch_no int,FOREIGN KEY (Branch_no)REFERENCES Branch(Branch_no)ON DELETE CASCADE);
drop table Employee;
insert into Employee values(1001,'Ram','Manger',55000,101);
insert into Employee values(1002,'Akhila','Accountant',52000,102);
insert into Employee values(1003,'Athira','Manger',65000,103);
insert into Employee values(1004,'Nirmala','Cleaner',35000,104);
insert into Employee values(1005,'vinu','Trainee.Ass',25000,105);
insert into Employee values(1006,'ramu','System librarian',47000,102);
insert into Employee values(1007,'getha','information Manger',40000,104);
select * from employee;
create table Book (ISBN int not null primary key,Book_title varchar(35),Category varchar(25),Rental_Price int,Status_b varchar(5),Author varchar(30),Publisher varchar(30));
insert into book values(1111,'IT','Horror',150,'yes','Stephen King','Nation Press');
insert into book values(2222,'Dune','Science fiction',100,'yes','Frank Herbert','Penguin Books India');
insert into book values(2020,'Jaws','Horror',170,'No','Peter Benchley','Nation Press');
insert into book values(4444,'Macbeth','Classics',250,'yes','William Sakespeare','Macmillan');
insert into book values(5050,'X','Detective',50,'yes','Stephen King','Harper Collins');
insert into book values(1511,'Emma','Historical',180,'yes','Stephen King','Nation Press');
insert into book values(7171,'Goldfinger','Detective',210,'No','Stephen King','Macmillan');
insert into book values(1212,'Mockingjay','Romance',210,'No','Stephen King','Simon And Schuster');
select * from book;
create table Customer (Customer_id int not null primary key,Customer_Name varchar(15),Customer_address varchar(25),Reg_Date date);
desc Customer;
insert into Customer values(1,'Manu','NH 66 main st','2024-06-12');
insert into Customer values(2,'mani','NH 666  st','2023-09-02');
insert into Customer values(3,'Anu','NH 606 main st','2024-08-21');
insert into Customer values(4,'anju','NH 616 main st','2024-11-13');
insert into Customer values(6,'ravi','NH 67 main Road','2024-12-10');
insert into Customer values(7,'Rahul','NH 46 main st','2024-09-09');
insert into Customer values(8,'radha','NH 56 main st','2024-01-09');
insert into Customer values(9,'ganesh','NH 86 main st','2024-12-10');
insert into Customer values(10,'Abhi','NH 460  st','2024-04-14');
insert into Customer values(5,'Abhinav','NH 40  st','2021-01-14');
select * from Customer;
update Customer set Reg_Date='2021-04-14' where Customer_id='4';
create table IssueStatus (Issue_id int not null primary key,issued_book_name varchar(25),issue_date date,
ISBN_book int,FOREIGN KEY (ISBN_book) REFERENCES Book(ISBN) ON DELETE CASCADE, Issued_cust int,
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_id) ON DELETE CASCADE);
desc IssueStatus;
select * from IssueStatus;
insert into IssueStatus values(21,'IT','2024-09-19','1111',1);
insert into IssueStatus values(22,'Dune','2024-12-29','2222',2);
insert into IssueStatus values(23,'2020','2024-04-17','2020',3);
insert into IssueStatus values(24,'Macbeth','2024-10-15','4444',4);
insert into IssueStatus values(25,'X','2024-05-03','5050',6);
insert into IssueStatus values(26,'Emma','2024-01-02','1511',7);
insert into IssueStatus values(27,'Goldfinger','2024-06-12','7171',6);
insert into IssueStatus values(28,'Mockingjay','2024-12-22','1212',8);
insert into IssueStatus values(29,'Dune','2024-11-09','2222',1);
insert into IssueStatus values(30,'Macbeth','2024-09-19','4444',10);


create table ReturnStatus (Return_id int not null primary key,Return_cust int,Return_book_name varchar(25),
Return_Date date,ISBN_book2 int , foreign key (ISBN_book2) references  Book(ISBN) ON DELETE CASCADE);
desc ReturnStatus;
select * from ReturnStatus;
insert into ReturnStatus (Return_id,Return_cust,Return_book_name,Return_Date,ISBN_book2) values
						(2,1,'Dune','2024-10-19',2222),
						(3,3,'Jaws','2024-09-22',2020),
						(4,4,'Macbeth','2024-08-25',4444),
						(5,5,'X','2024-10-22',5050),
						(6,6,'Emma','2024-09-28',1511),
						(7,7,'Goldfinger','2024-11-22',7171),
						(8,8,'Mockingjay','2024-10-27',1212);
show tables in library;


#1. Retrieve the book title, category, and rental price of all available books.
select Book_Title,Category,Rental_Price from Book;



#2. List the employee names and their respective salaries in descending order of salary.
select Emp_Name, Salary  from Employee order by Salary desc;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
select Book_Title,Customer_Name from IssueStatus i join Book b on i.ISBN_book =b.ISBN join Customer c on i.Issued_cust = c.Customer_id ;


#4. Display the total count of books in each category.
select Category,count(*) as 'Count of books' from book group  by Category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select Emp_Name,Position from Employee where Salary > 50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
select Customer_Name from customer where Reg_Date <'2022-01-01' and Customer_id not in (select Issued_cust from IssueStatus);



#7. Display the branch numbers and the total count of employees in each branch.
select Branch_no,count(Emp_Name) as Emp_count from Employee group by Branch_no;


#8. Display the names of customers who have issued books in the month of sep 2023.
select Customer_Name from IssueStatus i join Customer c on i.Issued_cust =c.Customer_id where month(issue_date) =09 ;


#9. Retrieve book_title from book table containing Historical.
select Book_title from Book where Category ='Historical';


#10.Retrieve the branch numbers along with the count of employees for branches having more than 1 employees
select Branch_no,count(Emp_Name) as Emp_count  from Employee group by Branch_no having count(Emp_Name) >1;









