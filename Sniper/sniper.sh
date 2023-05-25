#! /bin/bash

LOCALNETWORK=$( ip route show | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}" )

services=$(cat /etc/services | gawk '
BEGIN {
     FS = "/| |\t+"
}
/^[a-zA-Z]/{
     print $1, $2, $3
}
' | sort -k 3)

tcp_ports=( $(grep -i "tcp" <<<$services) )
udp_ports=( $(grep -i "udp" <<<$services) )

filter_host_ip='grep -Eo "[^ ]+ (([0-9]{1,3}\.){3}[0-9]{1,3}" | sed "s/(//'

declare -A nmap_scan_techniques=(
    ["TCP SYN scan"]="-sS"
    ["TCP connect scan"]="-sT"
    ["UDP scan"]="-sU"
    ["TCP Null scan"]="-sN"
    ["TCP FIN scan"]="-sF"
    ["TCP Xmas scan"]="-sX"
    ["TCP ACK scan"]="-sA"
    ["TCP Window scan"]="-sW"
        ["UP Scan"]="-sn"
)

declare -A netcat_scan_techniques=(
    ["TCP SYN scan"]="-zvn -sS"
    ["TCP connect scan"]="-zvn -sT"
    ["UDP scan"]="-zvn -u"
    ["TCP Null scan"]="-zvn -sN"
    ["TCP FIN scan"]="-zvn -sF"
    ["TCP Xmas scan"]="-zvn -sX"
    ["TCP ACK scan"]="-zvn -sA"
)
