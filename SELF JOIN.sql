/* SELF JOIN = applied when a table must join itself */
SELECT e1.* FROM emp_manager e1 JOIN emp_manager e2 oN e1.emp_no = e2.manager_no;

SELECT DISTINCT e1.* FROM emp_manager e1 JOIN emp_manager e2 oN e1.emp_no = e2.manager_no;

SELECT e1.* FROM emp_manager e1 JOIN emp_manager e2 oN e1.emp_no = e2.manager_no WHERE e2.emp_no IN (SELECT manager_no FROM emp_manager);
