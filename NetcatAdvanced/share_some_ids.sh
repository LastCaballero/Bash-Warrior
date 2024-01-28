#! /bin/bash


IDS=( {1..1000} )

for id in ${IDS[@]}
do
    echo $id | netcat -N -l 4000
    echo "$id shared ..."
done
