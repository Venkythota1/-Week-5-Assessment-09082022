Q.1 How to create table with same structure with data?
-> Let us consider that user wants to create a copy of table named ‘Student’.
   Create table Student_Copy as Select * from Student;

   Explanation :
   The above query will create the same table as student named ‘Student_Copy’ with its data.



Q.2 How to create table with same structure without data?
-> CREATE TABLE new_table
  AS (SELECT *
      FROM old_table WHERE 1=2);


Q.3 How to display Last 10 records from Student table. And How to fetch maximum
salary of Employee and minimum salary of Employee together from Employee table.

-> SELECT * FROM Student
ORDER BY StudentID DESC LIMIT 5;

->SELECT MAX(salary), MIN(salary) 
     FROM Employee;

Q.4 Create a SQL Table and Read it’s record by using Template.
->  Template in action :
	create table transactions (transaction_id int,user_id int,transaction_date date,store_id int,payment_method varchar(10),amount float)	;
	insert into transactions(transaction_id, user_id, transaction_date, store_id, payment_method, amount) values
    (1, 1234, ‘2019–03–02’, 1, 'cash', 9.25),
    (1, 1234, ‘2019–03–01’, 1, 'credit', 15.75),
    (1, 1234, ‘2019–03–02’, 2, 'cash', 30.50),
    (1, 1234, ‘2019–03–03’, 2, 'credit', 15.00),
    (1, 4321, ‘2019–03–01’, 2, 'cash', 30.00),
    (1, 4321, ‘2019–03–02’, 2, 'debit', 40.00),
    (1, 4321, ‘2019–03–03’, 1, 'cash', 5.00);
		_BASIC_STATS_TEMPLATE = '''
		select
    	{{ 
		dim | sqlsafe 
	}}
    		, count(*) as num_transactions
    		, sum(amount) as total_amount
    		, avg(amount) as avg_amount
	    from transactions group by
    	{{ 
	    dim | sqlsafe 
	}}
	    order by total_amount desc


Q.5 List the Students whose name starts with P and surname starts with S.
-> SELECT * FROM Students
    WHERE FirstName LIKE 'P%' and Surname LIKE 'S%';


Q.6 How to fetch last record from Student table.
-> SELECT * FROM Student ORDER BY ID DESC LIMIT 1;


Q.7 Give a Example with Sample Data for Common Table Expression.
-> CREATE TABLE Employees
   (
    EmployeeID int NOT NULL PRIMARY KEY,
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    ManagerID int NULL
    )
   INSERT INTO Employees VALUES(1,'AJAY', 'bhat',NULL)
   INSERT INTO Employees VALUES(2,'Nilay', 'Bhandari',1)
   INSERT INTO Employees VALUES(3,'Udbhav', 'saboji',1)
   INSERT INTO Employees VALUES(4,'harsha', 'reddy',2)
   INSERT INTO Employees VALUES(5,'jai', 'Simha',2)
   WITH
      cteReports(EmpID, FirstName,LastName,MgrID,EmpLevel)
    AS
    (
        SELECT EMPLOYEEID, FirstName,LastName,ManagerID,1
        FROM Employees
        WHERE ManagerID IS NULL
        UNION ALL
        SELECT e.EmployeeID, e.FirstName, e.LastName, e.ManagerID,
            r.EmpLevel +1
            FROM Employees e 
            INNER JOIN cteReports r 
            ON e.ManagerID = r.EmpID
    )

    SELECT 
        FirstName + ' ' + LastName As FullName,
        EmpLevel,
        (SELECT FirstName + ' ' + LASTName FROM Employees
        WHERE EmployeeID = cteReports.MgrID) AS Manager
        From cteReports
        ORDER BY EmpLevel, MgrID


Q.8 Give a Example of Trigger Update &amp; Delete Event.
->UPDATE TRIGGER : 

 	 CREATE TRIGGER ItemUpdate AFTER UPDATE ON Items
 	 BEGIN
   	  IF (New.TotalValue <> OLD.TotalValue) THEN
       	    UPDATE Sales set value = value - OLD.TotalValue+ New.TotalValue WHERE Order = OLD.Order;
  	 END 
                   
 DELETE TRIGGER :

  	delimiter //
  	CREATE TRIGGER DelItem AFTER DELETE ON Items
  	BEGIN
      	  UPDATE Sales set value = value - OLD.ValueTotal
       	  WHERE Order = OLD.Order;
  	END //