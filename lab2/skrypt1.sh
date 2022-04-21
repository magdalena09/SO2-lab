#!/bin/bash -eu

#Napisać skrypt, który przyjmuje 2 parametry – 2 ścieżki do katalogów.

#kody bledow
DIR_NOT_FOUND=11
ARG_NOT_FOUND=99

if [[ $# -eq 0 ]]; then
  echo "Nie podano argumentow"
  exit ${ARG_NOT_FOUND}
fi

DIR1=${1}
DIR2=${2}

if [[ ! -d ${DIR1} ]] || [[ ! -d ${DIR2} ]]; then
    echo "Nie istnieje taki katalog"
    exit ${DIR_NOT_FOUND}
fi

FILES1=$(ls ${DIR1})

for FILE in ${FILES1}; do

  FILE_UP=${FILE^^}

  if [[ -d ${DIR1}/${FILE} ]]; then
    echo "${FILE} - katalog"
    ln -s $(pwd "{DIR1}")/${DIR1}/${FILE} ${DIR2}/${FILE_UP}_ln 
  fi

  if [[ -f ${DIR1}/${FILE} ]]; then
    echo "${FILE} - plik regularny"
    ln -s $(pwd "{DIR1}")/${DIR1}/${FILE} ${DIR2}/${FILE_UP%.*}_ln.${FILE##*.} #DIR2/uppercase nazwy bez rozszerzenia.rozszerzenie
  fi  

  if [[ -L ${DIR1}/${FILE} ]]; then
    echo "${FILE} - dowiazanie symboliczne"
  fi  

done