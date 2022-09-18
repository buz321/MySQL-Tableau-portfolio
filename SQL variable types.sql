/* Session variable = a variable that exists only for the session in which you are operating */

/* Gloval variable = system variables are required: 
.max_connections() - indicates the maximum number of connections to a server that can be established at a certain point in time,
.max_join_size() - sets the maximum memory space allocated for the joins created by a certain connection */

/* To use GLOBAL variables (GLOBAL or @@global)*/
SET GLOBAL max_connections = 10000;
SET @@global max_connections = 1;

/* system variables can be set as session variables or as global variables (not all system variables can be set as session tho!!) */
