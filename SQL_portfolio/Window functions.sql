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
  

  
 
/* PARTITION BY = doesn't reduce the observation returns
GROUP BY = IT does reduce the number of returns as it only shows for each value */

/* Exercise #1:

Find out the lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.

Also, to obtain the desired result set, refer only to data from the “salaries” table. */
SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

GROUP BY emp_no;

/* Exercise #2:

Again, find out the lowest salary value each employee has ever signed a contract for. Once again, to obtain the desired output, use a subquery containing a window function. This time, however, introduce the window specification in the field list of the given subquery.

To obtain the desired result set, refer only to data from the “salaries” table. */
SELECT a.emp_no,

       MIN(salary) AS min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num

FROM

salaries) a

GROUP BY emp_no;

/* Exercise #3:

Once again, find out the lowest salary value each employee has ever signed a contract for. This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery.

To obtain the desired result set, refer only to data from the “salaries” table. */
SELECT

    a.emp_no, MIN(salary) AS min_salary

FROM

    (SELECT

        emp_no, salary

    FROM

        salaries) a

GROUP BY emp_no;

/* Exercise #4:

Once more, find out the lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword. Moreover, obtain the output without using a GROUP BY clause in the outer query.

To obtain the desired result set, refer only to data from the “salaries” table. */
SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=1;

/* Exercise #5:

Find out the second-lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword. Moreover, obtain the desired result set without using a GROUP BY clause in the outer query.

To obtain the desired result set, refer only to data from the “salaries” table. */
SELECT a.emp_no,

a.salary as min_salary FROM (

SELECT

emp_no, salary, ROW_NUMBER() OVER w AS row_num

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a

WHERE a.row_num=2;


/* RANK() = the number of values we have in our output */
USE employees;

SELECT
	emp_no, salary, RANK() OVER w AS rank_num 
FROM 
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* DENSE_RANK() = the ranking of the values itself */
USE employees;

SELECT
	emp_no, salary, DENSE_RANK() OVER w AS rank_num 
FROM 
	salaries
WHERE emp_no = 11839
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* Exercise #1:

Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.

Order and display the obtained salary values from highest to lowest.
*/
SELECT
	emp_no, salary, ROW_NUMBER() OVER w AS row_num 
FROM 
	salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* Exercise #2:

Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company.
*/
SELECT 
    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts
FROM
    dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no;

/* Exercise #3:

Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed.
*/
SELECT
emp_no,
salary,
RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* Exercise #4:

Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed.
*/
SELECT
emp_no,
salary,
DENSE_RANK() OVER w AS rank_num
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);


/* Exercise #1:

Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 10500 and 10600 inclusive. 
Let equal salary values for one and the same employee bear the same rank. 
Also, allow gaps in the ranks obtained for their subsequent rows.

Use a join on the “employees” and “salaries” tables to obtain the desired result. */
SELECT 
e.emp_no,
s.salary,
RANK() OVER w AS rank_num
FROM
	employees e
		JOIN
        salaries s ON e.emp_no = s.emp_no
        WHERE e.emp_no between 10500 and 10600
WINDOW w AS (PARTITION BY e.emp_no ORDER BY s.salary DESC);


/* Exercise #2:

Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:

- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.

- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.

In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.

Use a join on the “employees” and “salaries” tables to obtain the desired result. */
SELECT
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM
employees e
JOIN
    salaries s ON s.emp_no = e.emp_no
    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);


/* LAG() = returns the value from a specified field of a record that precedes!! the current row */
/* LEAD() = returns the value from a specified field of a record that follows!! the current row */
SELECT 
	salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(salary) OVER w AS diff_salary_next_current
FROM
	salaries
WHERE emp_no = 10001
WINDOW w AS (order by salary);


/* Exercise #1:

Write a query that can extract the following information from the "employees" database:

- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive

- a column showing the previous salary from the given ordered list

- a column showing the subsequent salary from the given ordered list

- a column displaying the difference between the current salary of a certain employee and their previous salary

- a column displaying the difference between the next salary of a certain employee and their current salary

Limit the output to salary values higher than $80,000 only.

Also, to obtain a meaningful result, partition the data by employee number.
*/
SELECT
	salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
    LEAD(salary) OVER w AS diff_salary_next_current
FROM
	salaries
WHERE salary > 80000 and emp_no between 10500 and 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

/* Exercise #2:

The MySQL LAG() and LEAD() value window functions can have a second argument, designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.

With that in mind, create a query whose result set contains data arranged by the salary values associated to each employee number (in ascending order). Let the output contain the following six columns:

- the employee number

- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)

- the employee's previous salary

- the employee's contract salary value preceding their previous salary

- the employee's next salary

- the employee's contract salary value subsequent to their next salary

Restrict the output to the first 1000 records you can obtain.
*/
SELECT
	emp_no,
    salary AS current_salary,
	LAG(salary,2) OVER w AS 1_before_previous_salary,
    LEAD(salary) OVER w AS next_salary,
    LEAD(salary,2) OVER w AS 1_after_next_salary
FROM 
	salaries
    WINDOW w AS (PARTITION BY emp_no ORDER BY salary ASC)
Limit 1000;

/* SYSDATE() = today's date in the system */
USE employees;

SELECT SYSDATE();

SELECT
	emp_no, salary, from_date, to_date
FROM
	salaries
WHERE
	to_date > SYSDATE();
    
    
/* be aware of the error code: 1055 */
SELECT
	emp_no, salary, MAX(from_date), to_date
FROM
	salaries
WHERE
	to_date > SYSDATE()
GROUP BY emp_no;


/* solve the problem above */
SELECT
	s1.emp_no, s.salary, s.from_date, s.to_date
FROM
	salaries s
    JOIN
    (SELECT
	emp_no, MAX(from_date) AS from_date
FROM
	salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
	to_date > SYSDATE()
AND s.from_date = s1.from_date;

/* Exercise #1:

Create a query that upon execution returns a result set containing the employee numbers, contract salary values, start, and end dates of the first ever contracts that each employee signed for the company.

To obtain the desired output, refer to the data stored in the "salaries" table. 
*/
SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    
 
 /* Exercise #1:

Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).

Create a MySQL query that will extract the following information about these employees:

- Their employee number

- The salary values of the latest contracts they have signed during the suggested time period

- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)

- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".



Note1: This exercise is not related neither to the query you created nor to the output you obtained while solving the exercises after the previous lecture.

Note2: Now we are asking you to practically create the same query as the one we worked on during the video lecture; the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.

Note3: We invite you solve this task after assuming that the "to_date" values stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables. If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!

Hint: If you've worked correctly, you should obtain an output containing 200 rows. */

SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
(SELECT
emp_no, MAX(from_date) AS from_date
FROM
dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
    de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN
    (SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
    JOIN
    (SELECT
emp_no, MAX(from_date) AS from_date
FROM
salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
    departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;

