#!/bin/bash

# trzy argumenty
SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}

# stworze sobie SOURCE_DIR poza poleceniem
mkdir ${SOURCE_DIR}

# jesli nie istnieje, tworze folder ${TARGET_DIR}
mkdir -p ${TARGET_DIR}

LIST=$(cat ${RM_LIST})

# iterowanie po zawartości pliku RM_LIST
for ELEMENT in ${LIST}; do

    # jeżeli plik o takiej nazwie występuje w katalogu SOURCE_DIR, to go usuwam
    if [[ -f ${SOURCE_DIR}/${ELEMENT} ]]; then
        rm ${ELEMENT}

    # jeżeli jakiegoś pliku nie ma, ale jest plikiem regularnym, to przenosze go do TARGET_DIR
    elif [[ -f ${ELEMENT} ]]; then
        mv ${ELEMENT} ~/${TARGET_DIR}
    
    # jeżeli jakiegoś pliku nie ma na liście, ale jest katalogiem, to kopiuje go do TARGET_DIR z zawartością
    elif [[ -d ${ELEMENT} ]]; then
        cp -r ${ELEMENT} ${TARGET_DIR}
    fi
done

# jeżeli po zakończeniu operacji są jeszcze jakieś pliki w katalogu SOURCE_DIR
# piszemy na konsolę oraz
# jeżeli co najmniej 2 pliki, to wypisujemy: „zostały co najmniej 2 pliki”
# jeżeli więcej niż 4, to wypisujemy: „zostało więcej niż 4 pliki”
# jeżeli nie więcej, niż 4, ale co najmniej 2, to też coś piszemy
# Jeżeli nic nie zostało, to informujemy o tym słowami
cd ${SOURCE_DIR}
CONTENT=$(ls | wc -l)
if [[ ${CONTENT} -gt 0 ]]; then
    echo "cos tu zostalo"
    if [[ ${CONTENT} -ge 2 ]]; then
        echo "zostaly co najmniej 2 pliki"
    fi

    if [[ ${CONTENT} -gt 4 ]]; then
        echo "zostalo wiecej niz 4 pliki"
    else
        echo "cos piszemy"
    fi
else
    echo "ludzie, tu nikogo nie ma"
fi

cd ..
# pakowanie
zip -r bakap_$(date -I).zip ${TARGET_DIR}