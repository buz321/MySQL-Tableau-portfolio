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
    
    
