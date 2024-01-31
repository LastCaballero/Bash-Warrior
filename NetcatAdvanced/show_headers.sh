#! /bin/bash

URL=$1

echo "GET / HTTP/1.1
Host: $URL
User-Agent: Netcat
Accept: */*
Accept-Encoding: identity
Connection: Keep-Alive
" | ncat --ssl $URL 443 |
    sed -n -r '
        1 p ;
        :loop
        /:/ { p ; n ; b loop }
    '
