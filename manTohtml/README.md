# Bash man To html
Es handelt sich um einen kleinen HTTP-Server, der Manpages lokal für Browser erreichbar zur Verfügung stellt. Gestartet wird einfach mit:
```sh
./server
```
Hierbei wird aber nur die Standard-Seite mit Grep angezeigt. Will man die Manpage für eine andere Seite angezeigt bekommen. Muss man diese angeben:
```sh
./server sed
```
