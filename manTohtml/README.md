#  ManPage To HTML
Hier zeige ich, wie man mit einfachen Mitteln einen Webserver programmieren kann und eine statische Seite, z.B. eine Manpage zur Verfügung stellen kann. 

Gestartet wird einfach mit:
```sh
./server
```
Hierbei wird aber nur die Standard-Seite mit Grep angezeigt. Will man eine andere Manpage angezeigt bekommen, so startet man das Skript mit Parametern.

Entweder kann nur eine Manpage angegeben werden, oder aber man gibt die Manpage mit einer Angabe mit Spaltenbreite an.

Das sieht dann so aus:
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
Die letzte Zeile bewirkt einfach nur, dass das Skript von Neuem gestartet wird. Mit **Strg-C** kann man das Ganze beenden.





