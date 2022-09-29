/*DELETE */
DELETE FROM employees WHERE emp_no = 999903;

/*if a specific value from the parent table's primary key has been deleted, all the records from the child table referring to this value will be removed as well!!! */


/*Remove the department number 10 record from the “departments” table.*/
DELETE FROM departments WHERE emp_no = 'd010';


/* DROP = will lose everything, once you drop the table, it won't be able to roll back !! */
/* TRUNCATE = DELETE without WHERE, when truncating, auto-increment values will be reset !! */
/* DELETE = removes records row by row */
