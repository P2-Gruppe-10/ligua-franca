#!/usr/bin/env bash
if [[ "$1" == "--help" ]]; then
    echo "usage: add-subject.sh <subject-id>"
    exit
fi

curl 'localhost:3000/subjects' \
        -d "{\"userId\": $1}" \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        --max-time 5
