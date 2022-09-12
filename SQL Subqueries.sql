/* subqueries with IN nested inside WHERE */
SELECT e.first_name, e.last_name FROM employees e WHERE e.emp_no IN (SELECT dm.emp_no FROM dept_manager dm);

/* Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995. */
SELECT * FROM dept_manager WHERE emp_no IN (SELECT emp_no FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01') ;

/* subqueries with EXISTS-NOT EXISTS nested inside WHERE */
SELECT e.first_name, e.last_name FROM employees e WHERE EXISTS (SELECT * FROM dept_manager dm WHERE dm.emp_no = e.emp_no);

/* add ORDER BY out of the nest */
SELECT e.first_name, e.last_name FROM employees e WHERE EXISTS (SELECT * FROM dept_manager dm WHERE dm.emp_no = e.emp_no) ORDER BY emp_no;

/* Select the entire information for all employees whose job title is “Assistant Engineer”.  */
SELECT * FROM employees e WHERE EXISTS (SELECT * FROM titles t WHERE t.emp_no = e.emp_no and title = 'Assistant Engineer' ) ORDER BY emp_no;

/* EXISTS = tests row values for existence = quicker in retrieving large amounts of data */
/* In = searches among values = faster with smaller datasets */


/* A and B should be the same subsets used in the last lecture (SQL Subqueries Nested in SELECT and FROM). In other words, assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).

Use the structure of subset A to create subset C, where you must assign employee number 110039 as a manager to employee 110022.

Following the same logic, create subset D. Here you must do the opposite - assign employee 110022 as a manager to employee 110039. */

INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
