sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
cat mysql_credentials > ~/.my.cnf

usermod -d /var/lib/mysql/ mysql

/etc/init.d/mysql restart

ROOT_USER_EXISTS=`mysql -u root -s -N -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE User = 'root' AND Host = '%')"`
if [[ "$ROOT_USER_EXISTS" == 0 ]]
then
	mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'ims'";
	mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION";
	mysql -u root -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY ''"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

pkill -9 mysqld
sleep 5
mysqld_safe
