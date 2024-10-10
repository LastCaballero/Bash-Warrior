#  ManPage To HTML
Es handelt sich um einen kleinen HTTP-Server, der Manpages lokal für Browser erreichbar zur Verfügung stellt. Gestartet wird einfach mit:
```sh
./server
```
Hierbei wird aber nur die Standard-Seite mit Grep angezeigt. Will man die Manpage für eine andere Seite angezeigt bekommen. Muss man diese angeben:
```sh
./server sed
./server sed 70 # mit angabe der Spalten für die Manpage
```
## Das Skript kurz erklärt
### Grundlegendes
Erst mal werden grundlegende Dinge festgelegt.
```sh
#! /usr/bin/bash
file="file.html"
help=${1:-grep}
cols=${2:-75}
env COLUMNS=$cols man $help 2>/dev/null > $file
```
1. Die Datei in die die Manpage geleitet wird.
2. Die Parameter werden abgefragt oder einfach mit Standard-Werten belegt.
3. Die Manpage wird erzeugt und in die vorher festgelegte Datei geleitet.

### Die Vearbeitung mit Sed
Sed macht aus der Manpage in der Datei eine Webseite.
```sh
sed -r -i '1 i \
<!DOCTYPE html> \
<html lang="en"> \
<head> \
    <meta charset="UTF-8"> \
    <title>Manpage</title> \
</head> \
<body style="margin: 45px"> \
<p><pre> ' $file
sed -r -i '$ a \
</pre></p> \
</body> \
</html>' $file

len=$(wc --bytes $file | cut -f 1 -d " ")
```
Nachdem Sed seine Arbeit erledigt hat, wird die Länge der Datei in Bytes ermittelt und in einer Variablen gespeichert.
### Das starten des Webservers
Schließlich wird mithilfe eins Here-Documents HTTP-Code erzeugt und an Netcat weitergeleitet, welches dann am angegebenen Port lauscht.

```sh
cat <<http  |  
HTTP/1.1 200 OK
Connection: close
Content-length: $len

$( cat $file )
http

netcat -l 4000

$0 $1 $2
```






