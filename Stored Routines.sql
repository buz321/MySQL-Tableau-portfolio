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

