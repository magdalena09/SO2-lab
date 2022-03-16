#!/bin/bash

# trzy argumenty
SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

# jesli nie istnieje, tworze folder ${TARGET_DIR}
mkdir -p ${TARGET_DIR}

# iterowanie po zawartości pliku RM_LIST
for ELEMENT in $(cat ${RM_LIST}); do

    # jeżeli plik o takiej nazwie występuje w katalogu SOURCE_DIR, to go usuwam
    if [[ -f ${SOURCE_DIR}/${ELEMENT} ]]; then
        rm ${ELEMENT}
    fi

    # jeżeli jakiegoś pliku nie ma na liście, ale jest plikiem regularnym, to przenosze go do TARGET_DIR
    if [[ ! -f ${SOURCE_DIR}/${ELEMENT} ]]; then
        mv ${ELEMENT} ~/${TARGET_DIR}
    fi

    # jeżeli jakiegoś pliku nie ma na liście, ale jest katalogiem, to kopiuje go do TARGET_DIR z zawartością
    if [[ ! -d ${SOURCE_DIR}/${ELEMENT} ]]; then
        cp -r ${ELEMENT} ${TARGET_DIR}
    fi
done

# pakowanie
zip -r bakap_$(date -I).zip ${TARGET_DIR}