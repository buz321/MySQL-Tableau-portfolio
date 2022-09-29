/* INNER JOIN */ /* you may want to stick to m column after ORDER BY */
SELECT m.dept_no, m.emp_no, d.dept_name FROM dept_manager_dup m INNER JOIN departments_dup d on m.dept_no = d.dept_no ORDER BY m.dept_no;

/* Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */
SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date

FROM

    employees e

        JOIN

    dept_manager dm ON e.emp_no = dm.emp_no;
    
    
/* INNER JOIN = JOIN*/ 

/*to avoid the duplicate records, GROUP BY the field that differs the most among recrods */
SELECT m.dept_no, m.emp_no, d.dept_name FROM dept_manager_dup m INNER JOIN departments_dup d on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY m.dept_no;

/* remove the duplicates from the two tables */
DELETE FROM dept_manager_dup WHERE emp_no = '110228';
DELETE FROM departments_dup WHERE dept_no = 'd009';

/* add back the initial records */
INSERT INTO dept_manager_dup VALUE ('110228', 'd003', '1992-03-21', '9999-01-01');
INSERT INTO departments_dup VALUE ('d009', 'Customer Service');

/* LEFT JOIN */
SELECT m.dept_no, m.emp_no, d.dept_name FROM dept_manager_dup m LEFT JOIN departments_dup d on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY m.dept_no;

/* LEFT JOIN (switching the side) */
SELECT d.dept_no, m.emp_no, d.dept_name FROM departments_dup d LEFT JOIN dept_manager_dup m  on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY d.dept_no;

/* LEFT JOIN = LEFT OUTER JOIN */
SELECT d.dept_no, m.emp_no, d.dept_name FROM departments_dup d LEFT OUTER JOIN dept_manager_dup m  on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY d.dept_no;
/*Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. See if the output contains a manager with that name.  */
SELECT e.emo_no, e.first_name, e.last_name, d.dept_no, d.from_date FROM employees e LEFT JOIN dept_manager d on e.emp_no = d.emp_no WHERE e.last_name = 'Markovitch' ORDER BY d.emp_no DESC, e.emp_no;

/* RIGHT JOIN */
SELECT m.dept_no, m.emp_no, d.dept_name FROM dept_manager_dup m RIGHT JOIN departments_dup d on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY m.dept_no;

/* RIGHT JOIN (switching the side) */
SELECT d.dept_no, m.emp_no, d.dept_name FROM departments_dup d RIGHT JOIN dept_manager_dup m  on m.dept_no = d.dept_no GROUP BY m.emp_no ORDER BY d.dept_no;


/* using WHERE is more time-consuming, professionals prefer JOIN as it allows you to modify the connection between tables easily */

/* Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. Use the old type of join syntax to obtain the result. */
SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date

FROM

    employees e,

    dept_manager dm

WHERE

    e.emp_no = dm.emp_no;



New Join Syntax:

SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

    dm.dept_no,

    e.hire_date

FROM

    employees e

        JOIN

    dept_manager dm ON e.emp_no = dm.emp_no; 
    
  
  /* JOIN + WHERE */
SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

	s.salary

FROM

    employees e

JOIN 
	salaries s on e.emp_no=s.emp_no

WHERE

   s.salary>145000
   ;
   
/* Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”. */
SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

	e.hire_date,
	
    t.title

FROM

    employees e

JOIN 
	titles t on e.emp_no=t.emp_no

WHERE

   e.first_name ='Margareta' AND e.last_name ='Markovitch'
   ;

/* CORSS JOIN = connects all the values, not just those that match (useful when the tables in a database are not well connected */
SELECT dm.*, d.* FROM dept_manager dm CROSS JOIN departments d ORDER BY dm.emp_no , d.dept_no;

/* INNER JOIN without any conditions is not the best, CROSS JOIN is*/

/* CROSS JOIN + INNER JOIN (ON) + WHERE */
SELECT dm.*, d.* FROM departments d CROSS JOIN dept_manager dm JOIN employees e ON dm.emp_no=e.emp_no Where d.dept_no <> dm.dept_no  ORDER BY dm.emp_no , d.dept_no;

/* Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.*/
SELECT dm.*, d.* FROM departments d CROSS JOIN dept_manager dm  Where d.dept_no = 'd009'  ORDER BY d.dept_no;

/* Return a list with the first 10 employees with all the departments they can be assigned to. */
SELECT e.*, d.* FROM employees e CROSS JOIN departments d WHERE e.emp_no < 10011 ORDER BY e.emp_no, d.dept_name;

/* JOINs + aggregate functions */
/* Find the average salaries of men and women in the company */
SELECT e.gender, AVG(s.salary) AS average_salary FROM employees e JOIN salaries s ON e.emp_no = s.emp_no GROUP BY gender;

/*JOIN more than two tables */
SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name FROM employees e JOIN dept_manager m ON e.emp_no = m.emp_no JOIN departments d ON m.dept_no = d.dept_no;

/* Select all managers’ first and last name, hire date, job title, start date, and department name. */
SELECT e.first_name, e.last_name, e.hire_date, m.from_date, t.title, d.dept_name FROM employees e JOIN dept_manager m ON e.emp_no = m.emp_no JOIN titles t ON t.emp_no= e.emp_no JOIN departments d on m.dept_no = d.dept_no;

SELECT d.dept_name, AVG(salary) AS average_salary FROM departments d JOIN dept_manager m ON d.dept_no = m.dept_no JOIN salaries s ON m.emp_no = s.emp_no GROUP BY d.dept_name HAVING average_salary >60000 ORDER BY average_salary DESC;

/* How many male and how many female managers do we have in the ‘employees’ database? */
SELECT e.gender, COUNT(e.emp_no) FROM employees e JOIN dept_manager m ON e.emp_no = m.emp_no GROUP BY e.gender;

/* UNION ALL = to combine a few SELECT statements in a single output */
SELECT e.emp_no, e.first_name, e.last_name , NULL AS dept_no, NULL AS from_date FROM employees_dup e WHERE e.emp_no = 10001 UNION ALL SELECT NULL AS emp_no, NULL AS first_name, NULL AS last_name, m.dept_no, m.from_date FROM dept_manager m;

-- UNION displays only distinct values in the output, UNION ALL retreves the duplicates as well --
-- for better result = use UNION, for optimising performance = use UNION ALL --


-- minus (-) sign does switch the order (e.g. DESC to ASC) -- 
