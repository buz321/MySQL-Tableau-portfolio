/* stored procedures */
/* need to put () right next to the name */
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN 

	SELECT * FROM employees
    LIMIT 1000;

END$$

DELIMITER ;


/* to run the stored procedures 
1. go on schema 
2. use CALL 
3. manually 
*/

/* CALL */
call employees.select_employees();
call select_employees();

/* Create a procedure that will provide the average salary of all employees. */
DELIMITER $$ 
CREATE PROCEDURE average_salary()
BEGIN
	SELECT AVG(salary) AS average_salary FROM salaries;
END$$

DELIMITER ;

CALL average_salary();


/* another way to create a procedure 
1. go on views
2. find lightening mark on selected stored procedures, and right click on it
3. then, write or change the code and click the Apply button */

/* DROP PROCEDURE will drop the stored procedure */


/* stored procedures with an input parameter */
USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$ 
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM 
	employees e
		Join
	salaries s ON e.emp_no = s.emp_no
WHERE 
	e.emp_no = p_emp_no;
END$$

DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT e.first_name, e.last_name, avg(s.salary)
FROM 
	employees e
		Join
	salaries s ON e.emp_no = s.emp_no
WHERE 
	e.emp_no = p_emp_no;
END$$

DELIMITER ;


call emp_avg_salary(11300);


/* stored procedures with an output parameter */
USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$ 
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, out p_avg_salary DECIMAL (10.2))
BEGIN
	SELECT avg(s.salary) INTO p_avg_salary 
FROM 
	employees e
		Join
	salaries s ON e.emp_no = s.emp_no
WHERE 
	e.emp_no = p_emp_no;
END$$

DELIMITER ;

/* every time you create a procedure containing both an IN and an OUT parameter, you need to use the SELECT - INTO structure */ 

/*Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number. */
DELIMITER $$ 
CREATE PROCEDURE emp_info(IN p_first_name varchar(255), in p_last_name varchar (255), out p_emp_no INTEGER)
BEGIN
	SELECT e.emp_no INTO p_emp_no
FROM 
	employees e

WHERE 
	e.first_name = p_first_name AND e.last_anme = p.last_name;
END$$

DELIMITER ;

/* A variable in SQL is an object that can hold a single data value of a specific type. In contrast, a parameter in SQL is an object that can exchange data between stored procedures and functions. */

/* variables */
SET @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
SELECT @v_avg_salary;

/* Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise. */
/* Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively. */
/* Finally, select the obtained output. */
SET @v_emp_no = 0;
call emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

/* User-defined functions */
USE employees;
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$ 
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL (10,2) 
DETERMINISTIC      /* error 1418 = NO SQL, READS SQL DATA */
BEGIN

DECLARE v_avg_salary DECIMAL (10,2);              /* new variable here */

	SELECT AVG(s.salary) INTO v_avg_salary
FROM 
	employees e JOIN salaries s ON e.emp_no = s.emp_no

WHERE 
	e.emp_no = p.emp_no;
RETURN v_avg_salary;
END$$

DELIMITER ;


/* call function */
SELECT f_emp_avg_salary(11300);

/*Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee. */
USE employees;
DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$



CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;



SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END$$



DELIMITER ;



SELECT EMP_INFO('Aruna', 'Journel');


/* PROCEDURES = can have multiple out parameters (appropriate for INSERT UPDATE DELEITE,
FUNCTIONS can return a single value only (not appropriate) */

/* DECLARE is a keyword that can be used when creating local variables only */



