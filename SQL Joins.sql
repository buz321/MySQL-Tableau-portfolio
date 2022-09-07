/* INNER JOIN */
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
    
    
