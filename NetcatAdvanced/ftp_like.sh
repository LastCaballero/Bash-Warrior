#! /bin/bash


######## Server ########

while true; do
        filename=$(netcat -l 4001)
        netcat -l 4000 > $filename
done

#########################



######## Client ##########

echo $(basename file) | netcat -N targethost 4001 &&
cat file | netcat -N targethost 4000

##########################
