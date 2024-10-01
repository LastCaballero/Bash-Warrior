# Die Bash
Im Allgmeineen ist die Bash ziemlich schwierig zu handhaben und Code auch schlecht zu lesen. Mit ein paar Kniffen, kann man das aber ändern.
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

## einfach Arrays
```sh
 one=(1 2 3)    # deklarieren und befüllen
one+=(44 55)    # etwas hinzufügen
declare -a zwei # so kann man auch einen Array deklarieren
```

