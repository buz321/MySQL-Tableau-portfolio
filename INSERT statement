/*INSERT STATEMENT*/
/* String can be automatically changed to integar (plain number), but try to avoid it */
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date) VALUES (999901, '1986-04-21', 'John', 'Smith', 'M', '2011-01-01');

/* we must put the VALUES in the exact order we have listed the column names*/

/*Select ten records from the “titles” table to get a better idea about its content.

Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.
*/

Select * from titles;
INSERT INTO titles (emp_no, title, from_date) VALUES (999903, 'Senior Engineer', '1997-10-01');

/* Insert information about the individual with employee number 999903 into the “dept_emp” table. He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.*/
SELECT

    *

FROM

    dept_emp

ORDER BY emp_no DESC

LIMIT 10;
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) VALUES (999903, '5', '1997-10-01', '9999-01-01');

/* INSERT INTO (copy the values from the original table)*/
INSERT INTO departments_dup  (dept_no, dept_name) SELECT * FROM departments;
SELECT * FROM departments_dup ORDER BY dept_no;

/* Create a new department called “Business Analysis”. Register it under number ‘d010’. */
INSERT INTO departments (dept_no, dept_name) VALUES ('d010', 'Business Analysis');
SELECT * FROM departments ORDER BY dept_no;
