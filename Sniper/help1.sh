#! /bin/bash

services=$(cat /etc/services | gawk '
BEGIN {
     FS = "/| |\t+"
}
/^[a-zA-Z]/{
     print $1, $2, $3
}
' | sort -k 3)

tcp=( $(grep -i "tcp" <<<$services) )
udp=( $(grep -i "udp" <<<$services) )
