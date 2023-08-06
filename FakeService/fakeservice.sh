#! /bin/bash

start_fake_service(){
	port=$1
	logfile="${port}.log"
	while true
	do
		netcat -v -l $port 2>&1 |
		while read line
			do echo "$(date) $line"
		done >> $logfile
	done
}

for fake in $@
do
	start_fake_service $fake &
done
