#!/bin/bash/

echo Bash file is running!!!
echo " "
systemctl status apache2| grep 'Active:'
systemctl status apache2| grep 'Active: active' > status.txt 
echo "___________________________________________"
cat status.txt | cut -d " " -f 7 > status.txt

check=$"$(cat status.txt)"

if [[  $check == 'active' ]]
then 
	echo 'Service Status: active'
	process_id=$"$(pidof apache2)"
	echo "Apache2 service is Now getting Killed :("
	echo " "
	sudo kill $process_id
	sleep 3
	systemctl status apache2 | grep 'Active:'
	echo "Service will be restarted after 10s"
	echo " "
	echo "___________________________________________"
	sleep 10
	sudo systemctl start apache2
	systemctl status apache2 | grep 'Active:'

else
	echo 'Service Status: inactive'

fi


rm status.txt
