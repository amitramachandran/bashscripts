#!/bin/bash
#out=$(date | awk '{print $3$2$6}') # test value 
curr=$(date | awk '{print $3$2$6}')
mid= amit.r@compucom.com ankita.sharma@compucom.com
for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 
do 
	out=$(curl -slv https://view$n.compucom.com 2>&1 | awk '/expire/ {print $6$7}') 
	x=$(curl -slv https://view$n.compucom.com 2>&1 | awk '/expire/ {print $5}') 
	y=01    #notification day before the certificate expiry
	res=`expr $x - $y`
	if [ "$res" -lt "10" ] 
	then 
		fin= '0'$res$out
	else
		fin= $res$out
	fi
	viewname=$(curl -slv https://view$n.compucom.com 2>&1 | awk '/https/  {print $5}' | cut -d'/' -f3 | cut -d'.' -f1) 
	if [ "$fin" = "$curr" ]
	then 
		echo $viewname ":certificates expires tomorrow" | mail -s "webservers certificate expiry" sunita.pradhan@compucom.com -c $mid
	else 
		break
	fi
done
