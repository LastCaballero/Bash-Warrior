#! /usr/bin/bash

while true; do

date=$( date )
len=$( wc --bytes <<<$date )

cat <<HTTP | netcat -N -l 4000 
HTTP/1.1 200 OK
Connection: close
Refresh: 1
Content-Length: $len

$date
HTTP

done
