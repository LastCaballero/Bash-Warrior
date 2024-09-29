#! /usr/bin/bash

LOGFILE="attacks.log"
declare -a ports

show_help () {
    local format="%-20s %s\n"
    printf  "$format"    "start:"        "fake 4000 {5000..5005}"
    printf  "$format"    "list:"         "ps -e | sort -k 4"
    printf  "$format"    "terminate:"    "killall {fake.sh,netcat}"
}

if ( grep -q -E "help|h" <<<$@ ) || (( $# == 0 ))
then
    show_help
    exit 1
fi

random_data () {
    for (( i = 0 ; i < $(( $RANDOM % 50 + 10 )) ; i++ )) ; do
        echo $(( $RANDOM % 256 ))
    done
}

fake_listener () {
    local port=$1
    while true ; do
        random_data |
        netcat -l $port | read -t 1
        echo "$(date) connect on port $port" >> $LOGFILE
    done
}

for port in $@ ; do
    fake_listener $port &
    ports+=( "$port " )
done

echo "Listening ports: ${ports[@]}"
