#! /usr/bin/bash

if [ ! -z $1 ]; then
    IMAGEDIR=$1
    echo $IMAGEDIR
else
    echo "directory where images are needed"
    echo "f.e. ./slideshow Pictures"
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
Refresh: 5
Connection: close

HTTP

done

