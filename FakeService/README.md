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

Einige Variablen werden deklariert, die man dann später auch gebraucht. Die Funktion `show_help` dient dazu, die Hilfe anzuzeigen.



