# Fake-Service 
Ein Fake-Serice ist ein Fake-Service, der gar kein richtiger Service ist. Der Zweck ist einfach festzustellen, ob oft versucht wird, diesen Port anzusprechen.

## Wie man das Skript starten kann.
Kann man zum Beispiel starten, indem man einfach `./fake.sh` auf der Kommandozeile eingibt. Mit Argumenten würde man `./fake.sh 4000 4010` starten. Es geht aber auch intelligenter, indem man `./fake.sh {4000..4010}` auf der Kommandozeile eingibt.

```sh
./fake.sh 4000
./fake.sh {4000..4010}
```
## Das Skript kurz erklärt
Das Skript startet auf folgende Weise:

```sh
#! /usr/bin/bash

LOGFILE="attacks.log"
declare -a ports

show_help () {
    local format="%-20s %s\n"
    printf  "$format"    "start:"        "fake 4000 {5000..5005}"
    printf  "$format"    "list:"         "ps -e | sort -k 4"
    printf  "$format"    "terminate:"    "killall {fake.sh,netcat}"
}
```

Einige Variablen werden deklariert, die man dann später auch gebraucht. Die Funktion `show_help` dient dazu, die Hilfe anzuzeigen. Der Inhalt der Funktion ist tabellenartig formatiert, was jetzt vielleicht nicht typisch Programmierer ist, aber ich denke, dass dies die Übersicht erhöht.

Als nächstes kommt der Code, der darüber entscheidet, ob die Hilfe angezeigt wird oder nicht.

```sh
if ( grep -q -E "help|h" <<<$@ ) || (( $# == 0 ))
then
    show_help
    exit 1
fi
```

Es wird abgefragt, ob in den Argumenten "help" oder "h" enthalten ist, und auch ob die Argument-Anzahl bei 0 liegt. Ist das der Fall, wird die Hilfe angezeigt. Die Funktion `random_data` ist dafür zuständig, dass sinnlose Daten verschickt werden.

```sh
random_data () {
    for (( i = 0 ; i < $(( $RANDOM % 50 + 10 )) ; i++ )) ; do
        echo $(( $RANDOM % 256 ))
    done
}
```
Ist dicherlich keine einfach zu lesende Funktion, aber wenn man vernünftig formatiert und einfach mal was auseinander zieht, daann ist das sicherlich nicht ganz so unleserlich.

Schließlich kommt dann noch die Funktion, die dafür sorgt, dass ein **Fake-Service** erzeugt wird.
```sh
fake_listener () {
    local port=$1
    while true ; do
        random_data |
        netcat -l $port | read -t 1
        echo "$(date) connect on port $port" >> $LOGFILE
    done
}
```
Die braucht halt einen Port als Parameter. In einem While-Loop wird dann Netcat in Zusammenarbeit mit anderen Funktionen gestartet.
Als letztes kommt dann noch:

```sh
for port in $@ ; do
    fake_listener $port &
    ports+=( "$port " )
done
```
Dieser For-Loop verarbeitet die Argumente und startet einzelne Instanzen von Fake-Services im Hintergrund.
