#! /bin/bash

function get_nwa(){
    echo "obase=2;$(( 2#$1 & 2#$2 ))" | bc
}

function translate_ip(){
    local ip=$1
    local octets=( $( sed 's/\./ /g' <<< $ip ) )
    local result=$((
        ( ${octets[0]} << 24 )
            +
        ( ${octets[1]} << 16 )
            +
        ( ${octets[2]} << 8  )
            +
        ( ${octets[3]} )
    ))
    echo "obase = 2; $result" | bc
}

translate_ip "192.168.178.20"
translate_ip "255.255.255.0"
get_nwa $(translate_ip "192.168.178.20") $(translate_ip "255.255.255.0")
