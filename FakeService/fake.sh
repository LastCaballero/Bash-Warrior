#! /usr/bin/bash

LOGFILE="attacks.log"

fake_listener () {
    local port=$1
    while true ; do
        netcat -l $port | read -t 1
        echo "$(date) attack on port $port" >> $LOGFILE
    done
}

 pids=()
ports=()

for port in $@ ; do
    fake_listener $port &
    ports+=( "$port " )
     pids+=( "$! " )
done

echo "Running job-ids: ${pids[@]}"
echo "Listening ports: ${ports[@]}"
