#!/bin/bash -eu

FILE_NOT_FOUND=11
DIR_NOT_FOUND=99

FILE="access_log"

if [[ ! -f "${FILE}" ]]; then
    echo "Nie ma takiego pliku"
    exit ${FILE_NOT_FOUND}
fi

# Znajdź w pliku access_log zapytania, które mają frazę "denied" w linku
cat ${FILE} | grep "\/denied."

# Znajdź w pliku access_log zapytania wysłane z IP: 64.242.88.10
cat ${FILE} | grep "^64\.242\.88\.10 "

# Znajdź w pliku access_log wszystkie zapytania NIEWYSŁANE z adresu IP tylko z FQDN
cat ${FILE} | grep -Ev "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Znajdź w pliku access_log unikalne zapytania typu DELETE
cat ${FILE} | grep  "\"DELETE " | sort -u
 
#------------------------------------------------------------------------

FILE2="yolo.csv"

if [[ ! -f "${FILE2}" ]]; then
    echo "Nie ma takiego pliku"
    exit ${FILE_NOT_FOUND}
fi


# Z pliku yolo.csv wypisz wszystkich, których id jest liczbą nieparzystą. Wyniki zapisz na standardowe wyjście błędów.
cat ${FILE2} | grep -E "^[0-9]{0,}[13579]," >&2

# Z pliku yolo.csv wypisz każdego, kto jest wart dokładnie $2.99 lub $5.99 lub $9.99. Nie wazne czy milionów, czy miliardów (tylko nazwisko i wartość).
# Wyniki zapisz na standardowe wyjście błędów
cat ${FILE2} | grep "\$[259]\.99.$" | cut -d',' -f3,7 >&2

#------------------------------------------------------------------------

DIR="groovies"

if [[ ! -d "${DIR}" ]]; then
    echo "Nie ma takiego katalogu"
    exit ${DIR_NOT_FOUND}
fi

FILES=$(ls ${DIR})

cd ${DIR}

for FILE in ${FILES}; do
    # We wszystkich plikach w katalogu ‘groovies’ zamień $HEADER$ na /temat/
    sed -i 's|\$HEADER\$|\/temat\/|g' ${FILE}

    # We wszystkich plikach w katalogu ‘groovies’ usuń linijki zawierające frazę 'Help docs:'
    sed -i '/Help docs:/d' ${FILE}
done