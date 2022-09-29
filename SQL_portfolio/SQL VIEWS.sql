/* SQL VIEW = a virtual table whose contents are obtained from an existing table or tables, called base tables */
/* creates a shortcut */
/* check VIEW on schema */
/* they are temporary virtual data */
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date FROM dept_emp GROUP BY emp_no; 

/*Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent. */
CREATE OR REPLACE VIEW v_managers_average_salary AS SELECT AVG(salary) AS average_salary FROM salaries s JOIN dept_manager m ON s.emp_no = m.emp_no;
