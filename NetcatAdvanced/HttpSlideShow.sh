#! /usr/bin/bash

if [ ! -z $1 ]; then
    IMAGEDIR=$1
else
    echo "directory with images inside is needed"
    echo "f.e. ./slideshow Pictures"
fi

if [ -z $2 ]; then
    TIME=5
else
    TIME=$2
fi



IMAGES=( $( ls $IMAGEDIR/*{jpg,png,JPG,PNG} 2>/dev/null ) )

for image in ${IMAGES[@]}; do
    len=$( wc --bytes $image )
    type=""
    case $image in
        jpg|JPG) type="image/jpeg" ;;
        png|PNG) type="image/png" ;;
    esac

{ cat <<HTTP ; cat $image ; }  | netcat -N -l 4000 
HTTP/1.1 200 Ok
Content-Type: $type
Content-Length: $len
Refresh: $TIME
Connection: close

HTTP

done

