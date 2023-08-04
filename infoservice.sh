#! /bin/bash

FIFO=highway
test -p $FIFO || mkfifo $FIFO

function get_response(){
    read line < $FIFO
    case $line in
        uptime) uptime ;;
        df) df ;;
        *) echo "some error occurred..." ;;
    esac
}


while true
do
    get_response | netcat -l 4000 > $FIFO
done
