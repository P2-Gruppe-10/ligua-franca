#!/usr/bin/env bash
if [[ "$1" == "--help" ]]; then
    echo "usage: add-object.sh <object-type> <object-id>"
    exit
fi

curl 'localhost:3000/objects' \
        -d "{
                \"type\": \"$1\",
                \"identifier\": \"$2\"
            }" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        --max-time 5
