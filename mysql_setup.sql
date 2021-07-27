SET PASSWORD FOR 'root'@'localhost' = PASSWORD('P@ssw@rd');
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost' IDENTIFIED BY 'P@ssw@rd'; 
DROP DATABASE test;	
