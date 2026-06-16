#!/usr/bin/env bash

if [[ "$1" == "--help" ]]; then
    echo "usage: add-relation.sh <subject-id> <relation-name> <object-type> <object-id>"
    exit
fi

post_body=$(cat <<END
    {
        "object": {
            "type": "$3",
            "identifier": "$4"
        },
        "name": "$2",
        "subject": $1
    }
END
)

curl 'localhost:3000/relations' \
        -d "$post_body" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        --max-time 5
