#! /usr/bin/bash

network=$( ip addr show | grep -Eo "[0-9.]*/24" )

if [ -z $( nmap 2>/dev/null ) ]; then
    scanner="nmap.exe"
else
    scanner="nmap"
fi

$scanner -sL $network | sort
