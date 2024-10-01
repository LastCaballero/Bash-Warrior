# Die Bash
Im Allgmeineen ist die Bash ziemlich schwierig zu handhaben und Code auch schlecht zu lesen. Mit ein paar Kniffen, kann man das aber ändern.
## Variablen
bei Variablen ist das Problem, dass man alles eng zusammen schreiben muss, wenn man eine Zuweisung machen will.

```sh
eins=22
 abc=55
   a="hallo"
```
Man kann es ein wenig schöner machen, indem alles etwas ungewönlich einrückt. 

## einfach Arrays
```sh
 one=(1 2 3)    # deklarieren und befüllen
one+=(44 55)    # etwas hinzufügen
declare -a zwei # so kann man auch einen Array deklarieren
```

