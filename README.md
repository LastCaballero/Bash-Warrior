# Die Bash

## manchmal ein bisschen komplex...

Im Allgmeineen ist die Bash ziemlich schwierig zu handhaben und Code auch schlecht zu lesen. Die Dokumentationen dazu hat auch nicht gerade ein Schriftsteller geschrieben, und ich kann nicht empfehlen, diese zu lesen.



## Variablen
bei Variablen ist das Problem, dass man alles eng zusammen schreiben muss, wenn man eine Zuweisung machen will.

```sh
eins=22
 abc=55
 wort="hallo"
wort+=" Welt"
```
Wenn man das so macht, sind die Zuweisungen für die Bash erst einmal nur Strings. Mann kann aber schon einiges damit anfangen.

```sh
octet="[0-9]{1,3}"
point="\."
reg_ip_addr="${octet}${point}${octet}${point}${octet}${point}${octet}"
grep -Eo $reg_ip_addr text_datei
```
Man könnte zum Beispiel den regulären Ausdruck für eine Ip etwas leserlicher schreiben, wenn dieses überhaupt möglich ist.

## Einfache Befehle
Wie der Name es schon sagt, wird es nicht besonders schwer. Einfache Befehle sehen so aus:

```sh
cat datei
ls
ls verzeichnis
wc datei
```
## Pipes oder Tunnel
Pipes sind im Prinzip auch nicht so schwer nachzuvollziehen. Im Prinzip ist da nur Befehle durch **Tunnel** miteinader zu verbinden.

**befehl1**  |  **befehl2**  |  **befehl3**

```sh
cat datei1 datei2 datei3  | less     # 3 Dateien auf einmal ausgeben und dann an den Pager Less weiter leiten.
grep "Suche" datei        | nl       # Etwas in einer Datei suchen und nummeriert ausgeben.
```

## Loops
hier beschreibe ich mal den **While**- und den **For**-Loop:

```sh
while true
do
   echo hallo
done
```
Es würde unendliche Male hallo geschrieben. Sicherlich kann man sinnvolleres Programmieren. Z.B. könnte man versuchen eine Matrix-Programm zu programmieren. 
```sh
for zahl in 1 2 3
do
   echo $zahl
done
```
Der For-Loop ist erst mal selbst erklärend. Listen könne auch mit `{1..10}` erzeugt werden.



## einfache Arrays ( Datenketten )
```sh
   one=(   1 2 3     )        # deklarieren und befüllen
  one+=(   44 55     )        # etwas hinzufügen
zahlen=(  {1..100}   ) # 1 bis 100 würde in einem Array abgespeichert werden.
```
Mann kann das auch beim Programmieren so "eigenartig" einrücken oder formatieren, um keinen **Augenkrebs** zu bekommen. Man braucht keine Angst zu haben, dass dann vielleicht zu viel Luft im Array ist. Die Größe eines Arrays erhält man folgendermaßen:
```sh
echo "Die größe des Arrays zahlen ist ${#zahlen[@]}"
```
## Assoziative Arrays
Anstatt Indexe und Werte haben assoziative Arrays Schlüssel und die dazugehörigen Werte.

```sh
declare -A ar=(
              a 1
              b 2
              c 3
              d 4
           )

echo  ${ar[a]] # es würde eine 1 ausgegeben.

echo  ${ar[@]] # alle Elemente werden ausgegeben
echo  ${ar[*]] # alle Elemente werden ausgegeben

echo ${!ar[@]] # Sie Schlüssel werden ausgegeben
echo ${!ar[*]] # Sie Schlüssel werden ausgegeben
```
Auch hier spielt die viele Luft im Array keine Rolle. Man will ja schließlich erkennen können, was man programmiert oder erklärt.



## Skripte
Skripte sind im Prinzip auch nicht so schwer.
```sh
#! /usr/bin/bash

echo "Das  erste Argument ist $1"
echo "Das zweite Argument ist $2"

echo "wenn \$1 und \$2 zahlen sind, dann kann man..."
echo "Das Ergebnis ist $(($1 + $2)) ausrechnen"

echo "Es wurden $# Argumente übergeben"

```







