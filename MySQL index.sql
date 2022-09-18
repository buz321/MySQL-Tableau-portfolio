/* INDEX */
CREATE INDEX i_hire_date ON employees(hire_date);
CREATE INDEX i_composite ON employees(first_name, last_name);

SHOW INDEX FROM employees FROM employees;

/* samll datasets = the costs of having an index might be higher than the benefits */
/* large datasets = a well-optimised index can make a positive impact on the search process */



ALTER TABLE employees

DROP INDEX i_hire_date;


/* Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.

Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement. */
Select * from salaries where salary > 89000;
CREATE INDEX i_salary ON salaries(salary);

SELECT

    *

FROM

    salaries

WHERE

    salary > 89000;
