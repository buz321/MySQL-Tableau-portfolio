/* ROW_NUMBER - ranking window
ROW_NUMBER() presents all rows 
*/
USE employees;

SELECT emp_no,
		salary,
        ROW_NUMBER() OVER() AS row_num
FROM 
	salaries;
    
/* ROW_NUMBER - PARTITION BY in OVER() = organised into partitions 
ORDER BY can be used within OVER() as well
*/

SELECT emp_no,
		dept_no,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM 
	salaries;
    


/* Exercise #1 :
Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database (regardless of their department). 
Let the numbering disregard the department the managers have worked in. Also, let it start from the value of 1. Assign that value to the manager with the lowest employee number. */
SELECT emp_no,
		salary,
        ROW_NUMBER() OVER(ORDER BY emp_no DESC) AS row_num
FROM 
	dept_manager;

/* Exercise #2:
Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table. Partition the data by the employee's first name and order it by their last name in ascending order (for each partition). */
SELECT emp_no,
		first_name,
        last_name,
        ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name ASC) AS row_num
FROM 
	employees;
  
  
 /* Exercise #1:

Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:

- a column containing the row number of each row from the obtained dataset, starting from 1.

- a column containing the sequential row numbers associated to the rows for each manager, where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.

Finally, while presenting the output, make sure that the data has been ordered by the values in the first of the row number columns, and then by the salary values for each partition in ascending order. */

SELECT dm.emp_no,
		salary,
        ROW_NUMBER() OVER() AS row_num1,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM 
	dept_manager dm
    JOIN
    salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;


/* Exercise #2:

Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.

Use window functions to add the following two columns to the final output:

- a column containing the row numbers associated to each manager, where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.

- a column containing the row numbers associated to each manager, where their highest salary has been given the number of 1, and the lowest - a value equal to the number of rows in the given partition.

Let your output be ordered by the salary values associated to each manager in descending order. */

SELECT dm.emp_no,
		salary,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
        ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM 
	dept_manager dm
    JOIN
    salaries s ON dm.emp_no = s.emp_no;
  
  
 
/* Window Function Syntax */
SELECT emp_no,
		salary,
        ROW_NUMBER() OVER w AS row_num
FROM 
	salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* Write a query that provides row numbers for all workers from the "employees" table, partitioning the data by their first names and ordering each partition by their employee number in ascending order. */
SELECT emp_no,
		first_name,
        ROW_NUMBER() OVER w AS row_num
FROM 
	employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no ASC);
  

  
 
