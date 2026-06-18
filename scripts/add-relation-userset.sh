#!/usr/bin/env bash

if [[ "$1" == "--help" ]]; then
    echo "usage: add-relation-userset.sh <userset-relation> <userset-object-type> <userset-object-id> <relation-name> <object-type> <object-id>"
    exit
fi

readonly userset_relation="$1"
readonly userset_obj_type="$2"
readonly userset_obj_id="$3"
readonly relation="$4"
readonly object_type="$5"
readonly object_id="$6"

post_body=$(cat <<END
    {
        "subject": {
            "object": {
                "type": "$userset_obj_type",
                "identifier": "$userset_obj_id"
            },
            "relationName": "$userset_relation"
        },
        "name": "$relation",
        "object": {
            "type": "$object_type",
            "identifier": "$object_id"
        }
    }
END
)

curl 'localhost:3000/relations' \
        -d "$post_body" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        --max-time 5
