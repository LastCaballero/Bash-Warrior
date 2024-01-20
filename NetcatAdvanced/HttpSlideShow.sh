#! /bin/bash
DIRECTORY=$1
TIME=$2

sedcode=''


for image in $( ls *jpg ) 
do
	sed $sedcode <<HTTP | netcat -N - l 4000
	
	
	HTTP

done
