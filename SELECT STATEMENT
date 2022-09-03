/*SELECT STATEMENT Queries */

/* Control + B = to clean the query*/


SELECT 
    first_name, last_name
FROM
    employees;

/* here, '*' means all */    
SELECT * FROM employees;

SELECT * FROM employees WHERE first_name = 'Denis';

SELECT * FROM employees WHERE first_name = 'Elvis';



/* AND = combine two condiotions */

SELECT * FROM employees WHERE first_name = 'Denis' AND gender = 'M';


/* OR = meet one of the conditions */
SELECT * FROM employees WHERE first_name = 'Denis' AND first_name = 'Elvis';

/* Operator Precedence (AND > OR) */
SELECT * FROM employees WHERE first_name = 'Denis' AND (gender = 'M' OR gender='F');

/* IN ( more than 2 conditions) */
SELECT * FROM employees WHERE first_name IN ('Cathie', 'Mark', 'Nathan');

/* NOT IN (exclude selected samples */
SELECT * FROM employees WHERE first_name NOT IN ('John', 'Mark', 'Jacob');

/* LIKE % = sequence, _ = single character         ----- Cap deson't matter in between ''----     */
SELECT * FROM employees WHERE first_name LIKE ('AR%');
SELECT * FROM employees WHERE first_name LIKE ('%AR%');
SELECT * FROM employees WHERE first_name LIKE ('%AR');
SELECT * FROM employees WHERE first_name LIKE ('MAR_');


SELECT * FROM employees WHERE first_name LIKE ('MARK%');

SELECT * FROM employees WHERE hire_date LIKE('%2000%');

SELECT * FROM employees WHERE emp_no LIKE ('1000_');

/* NOT LIKE (exclude) */
SELECT * FROM employees WHERE first_name NOT LIKE ('%MAR%');

/* BETWEEN ~ AND (범위 e.g 날짜, 숫자, string) */
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * FROM employees WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';

/* IS NOT NULL & IS NULL  */
SELECT * FROM employees WHERE first_name IS NOT NULL;

SELECT * FROM employees WHERE first_name IS  NULL;


/* <>, != Not Equal operators  */
SELECT * FROM employees WHERE first_name != 'Mark';

SELECT * FROM employees WHERE first_name <> 'Mark';

/* SELECT Distinct  */
SELECT DISTINCT gender FROM employees;

/* COUNT() 카운트 다음에 띄어쓰기 X */
SELECT COUNT(emp_no) FROM employees;

/* COUNT(DISTINCT ~~~) how many distinct values */
SELECT COUNT(Distinct first_name) FROM employees;

/* ORDER BY (in sequence) [ASC=Ascending, DESC=Descending]*/
SELECT * FROM employees ORDER BY first_name;

SELECT * FROM employees ORDER BY first_name ASC;

SELECT * FROM employees ORDER BY first_name DESC;

SELECT * FROM employees ORDER BY first_name, last_name DESC;

/* GROUP BY,  #GROUP BY vs SELECT DISTINCT = sorted in a different way*/
SELECT first_name, COUNT(first_name) FROM employees GROUP BY first_name ORDER BY first_name DESC;

/* Aliases (AS)  = rename the selection of the query */
SELECT first_name, COUNT(first_name) AS names_count FROM employees GROUP BY first_name ORDER BY first_name DESC;

/* HAVING (similar to WHERE, but applied to the GROUP BY block) # WHERE cannot use aggregate functions with within its conditions*/
/* HAVING should come after the GROUP BY block */
SELECT first_name, COUNT(first_name) AS names_count FROM employees GROUP BY first_name HAVING COUNT(first_name) >250 ORDER BY first_name;

/* Select all employees whose average salary is higher than $120,000 per annum. */
SELECT emp_no, AVG(salary) FROM salaries GROUP BY emp_no Having AVG(salary) > 120000 ORDER BY emp_no;

/* When to use WHERE, HAVING */
SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
WHERE
    hire_date > '1990-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY first_name DESC;

/****** you cannot use both aggregated and non-aggregated HAVING queries at the same time *****/

/*Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000. */
SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;


/* change the limit of rows = Edit - Preference - SQL Editor - SQL Execution - change the limit */
/* LIMIT*/
SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;


