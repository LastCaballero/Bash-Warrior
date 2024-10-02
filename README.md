# Die Bash

## manchmal ein bisschen komplex...

Im Allgmeineen ist die Bash ziemlich schwierig zu handhaben und Code auch schlecht zu lesen. Mit ein paar Kniffen, kann man das aber ändern. Es ist auch nicht erforderlich, immer in irgendwelchen Tutorials oder so nachzugucken, wenn man etwas nicht weiß.
Z.B. kann es sein, dass man nicht genau weiß, welcher Port von ssh-Servern benutzt wird. Man könnte jetzt einfach dumm googlen oder die allgegenwärtig künstliche Intelligenz befragen. Man könnte aber auch nmap benutzen.

```sh
nmap -p 22 200.200.200.33
```
Als Antwort bekommt man dann ungefähr das zu lesen:
```sh
###
PORT   STATE  SERVICE
22/tcp closed ssh
MAC Address: 04:B4:FE:B8:4C:FE (Unknown)
###
```
So hat man eine Antwort bekommen, die sich einprägt und hat nicht erst genervt gegoogelt und sich von der Sache an sich ablenken lassen. Und dazu hat man noch ein wenig gelernt mit nmap umzugehen. Man sollte sich selber auch nicht daran messen, was man am Anfang oder vielleicht auch später programmiert kriegt. Das **Wichtige** ist, dass man etwas beim Programmieren lernt. Und irgendwann kann man dann tatsächlich auch was. Man sollte nicht vergessen, dass Programmieren im Endeffekt das Lösen von Problemen ist, und auch den Fokus darauf legen sollte Probleme auf eigene Art und Weise zu lösen. Im Endeffekt ist das auch viel interessanter.


## Variablen
bei Variablen ist das Problem, dass man alles eng zusammen schreiben muss, wenn man eine Zuweisung machen will.

```sh
eins=22
 abc=55
 wort="hallo"
wort+=" Welt"
# Hallo Welt darf natürlich nicht fehlen :-)
```
Man kann es ein wenig schöner machen, indem alles etwas ungewönlich einrückt. Wenn man jetzt einer Variablen eine Zahl zuweist, dann heißt das nicht, dass man wie gewohnt damit rechnen kann. Es ist dann erst mal nur ein **String**. Will man rechnen, dann sieht das so aus:

```sh
zahl=22
(( zahl += 44 ))
(( zahl++     ))
zahl2=$(( zahl += 100 ))
```
Man sieht auch schon an der Schreibweise, dass man innerhalb doppelter Klammern auch etwas schöner formatierter schreiben kann.

## einfache Arrays ( Datenketten )
```sh
 one=(1 2 3)    # deklarieren und befüllen
one+=(44 55)    # etwas hinzufügen
declare -a zwei # so kann man auch einen Array deklarieren
```
Man sollte sich auch fragen, wofür man Arrays gebrauchen könnte, um dann auch sogleich etwas damit anfangen zu können. Grundlegende Operationen sind:

### Was machen mit Datenketten ?
+ Datenkette abspeichern ( z.B. die Zeilen einer Datei )
  ```sh
  text_array=( $( cat datei ) ) # der Text der Datei würde in einem Array gespeichert
      zahlen=( 1 2 3 4 5)       # Zahlen in einem Array
  ```


## Tricks
### eine einfache Matrix
Eine einfache Matrix-Simulation in einem Terminal zu erzeugen ist ziemlich einfach.
```sh
shuf -i 0-9 -z -r
```

