#! /bin/bash

url="$1"

echo -e "GET / HTTP/1.1\n\n" |
    ncat $url 443 |
    sed -n -r '
        1 p ;
        /:/ p ;
    '
