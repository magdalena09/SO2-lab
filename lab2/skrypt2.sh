#!/bin/bash -eu

#Napisać skrypt, który w zadanym katalogu (1. parametr) usunie wszystkie uszkodzone dowiązania symboliczne, 
#a ich nazwy, małymi literami wpisze do pliku (2. parametr), wraz z dzisiejszą datą w formacie ISO 8601.

#kody bledow
DIR_NOT_FOUND=11
ARG_NOT_FOUND=99

if [[ $# -eq 0 ]]; then
  echo "Nie podano argumentow"
  exit ${ARG_NOT_FOUND}
fi

DIR=${1}
FILE=${2}
DATE=$(date --iso-8601)

if [[ ! -d "${DIR}" ]]; then
    echo "Nie istnieje taki katalog"
    exit ${DIR_NOT_FOUND}
fi
#zwraca uszkodzone linki
LINK=$(find ${DIR} -xtype l)

#zapisuje do pliku z data
echo "${DATE} ${LINK,,}" >> ${FILE}

#usuwanie
find ${DIR} -xtype l -exec rm {} \;