# Useful SQL queries / questions

# Tableau Tasks
# Task 1
A visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990.


![Task 1](https://user-images.githubusercontent.com/107760647/192154919-b9125dae-b211-446a-8291-f3754624313d.png)

# Task 2
Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.

''' MySQL
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
'''

![Chart 2](https://user-images.githubusercontent.com/107760647/192645106-0532022a-5385-4166-8483-bc6b01cac4ea.png)
