#! /bin/bash


if [ ! -z $1 && cd $1 ]; then

    FILES=( $( ls $1 ) )
        
    for file in ${FILES[@]}; do
        cat $file | netcat -N -l 4000
    done

elif [ -z $1 ]; then

    FILES=( $( ls $1 ) )    
    for file in ${FILES[@]}; do
        cat $file | netcat -N -l 4000
    done

else
        MESSAGE="No Files available or some other error occured"
        echo $MESSAGE | netcat -N -l 4000
        exit 1
fi

