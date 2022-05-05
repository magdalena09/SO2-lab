#!/bin/bash -eu

FILE_NOT_FOUND=11

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




