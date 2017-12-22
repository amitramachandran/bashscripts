#!/bin/bash/
#this script is to check the service status and warn about the stopped services

servername=`hostname`
findb=`hostname | awk '/0.b/ {print $0}'`
Path=/opt/APG/APG/bin/
cd $Path
if [ "$servername" != "$findb" ] 
then

	./manage-modules.sh service status all > /tmp/new.txt
	services=`./manage-modules.sh service status all | grep 'stopped' |wc -l`
	output=`awk '/stopped/ {printf ("%s %s\n", $4,$5)}' /tmp/new.txt`

	if [ $services -gt 0 ]
	then
			echo "These services are stopped:  "$output | mail -s "services $services"
	else
			break
	fi

else
	
	./manage-modules.sh service status all > /tmp/new.txt
	services=`./manage-modules.sh service status all | grep 'stopped' |wc -l`
	sa1=collector-manager Load-Balancer
	sa2=collector-manager emc-watch4net-health
	output=`awk -v var1="sa1" -v var2="sa2" '$4$5==var1 && $/stopped/ || $4$5==var2 && $/stopped/ {printf ("%s %s\n", $4,$5)}' /tmp/new.txt`
	
	if [ $services -gt 0 ]
	then
			echo "These services are stopped:  "$output | mail -s "services $services"
	else
			break
	fi
	 
	
	
	
	
fi
