#! /bin/bash

test -p attacks || mkfifo attacks
ports=${@:-"4000 4001 4002 4003"}

if ! [[ $ports =~ ^[0-9\ ]+$ ]]; then
	echo "we need only numbers or a port range"
fi

start_fake_service(){
	port=$1
	while true
	do
		netcat -W 1 -l $port
		echo "attack at $(date) at $port" >> attacks
	done
}

for run in $ports 
do
	start_fake_service $run &
done

while true
do
	cat attacks
	sleep 1
done
