/* UPDATE = to update the observation */
UPDATE employees SET first_name ='Stella', last_name = 'Parkinson', birth_date='1990-12-31', gender='F' WHERE emp_no = 999901;

/* for UPDATE, WHERE condition is crucial */
/* Once you execute COMMIT, you cannot reverse any change */
/*ROLLBACK*/
COMMIT;
ROLLBACK;


/*Change the “Business Analysis” department name to “Data Analysis”.*/
SELECT * FROM departments;
UPDATE departments SET dept_name = 'Data Analysis' WHERE dept_name = 'Business Analysis';
