
#!/bin/bash

#path= `cat /opt/APG/APG/Web-servers/Tomcat/3575/temp/APG-reports/severetestlogfortomcat.txt`
#file= "/opt/APG/APG/Web-servers/Tomcat/3575/temp/APG-reports/severetestlogfortomcat.txt"

read file   #user to give the path of the file for which the script works


#find -type f -mmin 60 #to find the latest modified file 

output=`awk '/SEVERE/ {print $0}' $file | sort | uniq -c`
output1=`awk '/WARNING/ {print $0}' $file | sort | uniq -c`


echo `awk 'BEGIN { printf "NUM\tLOGMESSAGE\n" }'` 
echo '=====  ===================================='
echo $output
echo $output1
