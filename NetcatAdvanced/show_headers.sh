#! /bin/bash

URL=$1

echo "HEAD / HTTP/1.1
Host: $URL
User-Agent: Netcat
Accept: */*
Accept-Encoding: identity
Connection: close

" | ncat $URL 443 |
    sed -n -r '
        1 p ;
        :loop
        /:/ { p ; n ; b loop }
    '
