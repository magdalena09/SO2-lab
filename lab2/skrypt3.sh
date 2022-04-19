#!/bin/bash -eu

#kody bledow
DIR_NOT_FOUND=11
ARG_NOT_FOUND=99

if [[ $# -eq 0 ]]; then
  echo "Nie podano argumentow"
  exit ${ARG_NOT_FOUND}
fi

DIR1=${1}
DIR2=${2}

if [[ ! -d "${DIR1}" ]] || [[ ! -d "${DIR2}" ]]; then
    echo "Nie istnieje taki katalog"
    exit ${DIR_NOT_FOUND}
fi