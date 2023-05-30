#! /bin/bash

function get_nwa(){
    echo "obase=2;$(( 2#$1 & 2#$2 ))" | bc
}

function to_bin(){
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

function show_bin(){
    local ip=$(to_bin $1)
    local mask=$(to_bin $2)
    local nwa=$(get_nwa $ip $mask)
    local left=30
    printf "%-${left}s %s\n" "your ip:" "$ip"
    printf "%-${left}s %s\n" "your mask:" "$mask"
    printf "%-${left}s %s\n" "your network address:" "$nwa"
}

show_bin 192.168.178.20 255.255.255.0
