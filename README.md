# Useful SQL queries / questions

# Tableau Tasks

## Task 1
A visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990.
``` MySQL
SELECT 
    YEAR(d.from_date) AS calendar_year,
    e.gender,    
    COUNT(e.emp_no) AS num_of_employees
FROM     
     t_employees e         
          JOIN    
     t_dept_emp d ON d.emp_no = e.emp_no
GROUP BY calendar_year , e.gender 
HAVING calendar_year >= 1990;
```

![Task 1](https://user-images.githubusercontent.com/107760647/192154919-b9125dae-b211-446a-8291-f3754624313d.png)

## Task 2
Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.

(*Tableau automatically aggregates the numeric values of a field*)

(*hovering over certain parts of the visualisation allows you to obtain specific quantitative information*)

``` MySQL
SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calendar_year,
    CASE
        WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
        ELSE 0
    END AS active
FROM
    (SELECT 
        YEAR(hire_date) AS calendar_year
    FROM
        t_employees
    GROUP BY calendar_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN 
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year;
```

![Chart 2](https://user-images.githubusercontent.com/107760647/192645106-0532022a-5385-4166-8483-bc6b01cac4ea.png)

## Task 3
Compare the average salary of female versus male employees in the entire company until year 2002, and add a filter allowing you to see that per each department.

(*when you are using a measure in the "Rows" section in Tableau, you must always aggregate the data in a certain way*)

(note: you can select each department in Tableau)

``` MySQL
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;
```

![Chart 3](https://user-images.githubusercontent.com/107760647/192647774-ee6ffeb9-e077-491e-9305-f5564708016e.png)


## Task 4
Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.

Finally, visualize the obtained result-set in Tableau as a double bar chart.

``` MySQL
DELIMITER $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
	e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS avg_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END $$

DELIMITER ;

CALL filter_salary(50000,90000);
```

![Chart 4](https://user-images.githubusercontent.com/107760647/192895140-e2b30881-aa51-4fa5-ac89-e9eca2802526.png)

## Dash Board
![대시보드 1](https://user-images.githubusercontent.com/107760647/192897232-e1da5ba1-c70c-4092-85d2-4778f1d5c81a.png)
