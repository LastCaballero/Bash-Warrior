#! /usr/bin/bash

file="file.html"
help=${1:-grep}
cols=${2:-75}
env COLUMNS=$cols man $help 2>/dev/null > $file

sed -r -i '1 i \
<!DOCTYPE html> \
<html lang="en"> \
<head> \
    <meta charset="UTF-8"> \
    <title>'$help'</title> \
</head> \
<body style="margin: 45px"> \
<p><pre> ' $file
sed -r -i '$ a \
</pre></p> \
</body> \
</html>' $file

len=$(wc --bytes $file | cut -f 1 -d " ")

cat <<http  |  
HTTP/1.1 200 OK
Connection: close
Content-length: $len

$( cat $file )
http

netcat -l 4000

$0 $1 $2
