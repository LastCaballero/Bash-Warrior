#! /bin/bash

function and_operation(){
    local first=$1
    local second=$2
    local result=$(( 2#$first & 2#$second ))
    echo "obase = 2; $first" | bc
    echo "obase = 2; $second" | bc
    echo "obase = 2; $result" | bc
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

