#! /bin/bash

test -p attacks || mkfifo attacks

start_fake_service(){
        port=$1
        while true
        do
                netcat -W 1 -l $port
                echo "attack at $(date) at $port" > attacks
        done
}

for run in {4000..4004}
do
        start_fake_service $run &
done

while true
do
        cat < attacks
        sleep 1
done
