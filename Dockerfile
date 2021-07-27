##########################################
#Wordpress Docker file
#########################################


#set the base image for thi insrtallation
FROM centos:7

#File Author or Maintainer
MAINTAINER Jahnavi

#Files that need to be added 
ADD mysql_setup.sql /tmp/
ADD wordpress.conf /var/httpd/conf.d/

# pre-reqs
RUN yum clean all && \
yum -y  update && \
yum -y install httpd mod_rewrite mod_ssl mod_env php php-common php-cli php-mysql mysql-server unzip wget && \
rm -rf /var/cache/* 


#Applicatiopn Install 
RUN wget -P /var/www/html/ https://wordpress.org/latest.zip && \
unzip /var/www/html/latest.zip -d /var/www/html/ && \
rm -rf /var/www/html/latest.zip

#Start service mysql
#RUN service mysqld start && \
#mysql < /tmp/mysql_setup.sql && \
#rm -rf /tmp/mysql_setup.sql* && \
#service mysqld stop
CMD ["mysqld"]

#copy the WP-config file 
RUN cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

#Edit wp-config file
RUN sed -ie 's/database_name_here/wordprss/g' /var/www/html/wordpress/wp-config.php && \
sed -ie 's/username_here/wpuser/g' /var/www/html/wordpress/wp-config.php && \
sed -ie 's/password_here/P@sswo@rd/g' /var/www/html/wordpress/wp-config.php

#changing permission of file
RUN chown -R apache:apache /var/www/html/wordpress && \
chmod -R 775 /var/www/html/wordpress

#start sql and apache on boot
#RUN echo "service mysqld start" >> ~/.bashrc && \
RUN echo "service httpd start" >> ~/.bashrc
CMD ["mysqld"]
#Express necessary ports
EXPOSE 80



