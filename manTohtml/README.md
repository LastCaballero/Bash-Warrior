# Bash man To html
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
