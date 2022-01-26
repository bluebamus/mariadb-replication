#!/bin/bash

master_log_file=($(sudo docker exec mariadb-001 mysql -uroot -proot -N -e  "show master status\G" 2>&1))

echo $master_log_file

master_log_file=${master_log_file[-2]}
master_log_pos=${master_log_file[-1]}

echo "master_log_pos : " $master_log_file
echo "master_log_pos : " $master_log_pos

a=2

until [ $a -ge 4 ]
do
	echo "mariadb-00$a start"
	echo $(sudo sudo docker exec mariadb-00$a mysql -uroot -proot -e  "stop slave" 2>&1 | grep -v "Using a password")
	echo $(sudo sudo docker exec mariadb-00$a mysql -uroot -proot -e  "reset master" 2>&1 | grep -v "Using a password")
	
	echo $(sudo docker exec mariadb-00$a mysql -uroot -proot -e  "CHANGE MASTER TO MASTER_HOST='mariadb-001', MASTER_USER='repl', MASTER_PASSWORD='repl', MASTER_LOG_FILE='$master_log_file', MASTER_LOG_POS=$master_log_pos" 2>&1 | grep -v "Using a password")
	
	echo $(sudo docker exec mariadb-00$a mysql -uroot -proot -e  "START SLAVE" 2>&1 | grep -v "Using a password")
	echo "mariadb-00$a finish"
	
	a=$(expr $a + 1)
done

