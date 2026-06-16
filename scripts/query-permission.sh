#!/usr/bin/env bash
if [[ "$1" == "--help" ]]; then
    echo "usage: add-relation <subject-id> <object-type> <object-id> <permission>"
    exit
fi
readonly subject_id="$(jq -sRr 'trim | @uri' <<<"$1")"
readonly object_type="$(jq -sRr 'trim | @uri' <<<"$2")"
readonly object_id="$(jq -sRr 'trim | @uri' <<<"$3")"
readonly permission="$(jq -sRr 'trim | @uri' <<<"$4")"

readonly uri="localhost:3000/authorize?type=$object_type&objectId=$object_id&permission=$permission&userId=$subject_id"
body=$(curl "$uri"\
    -H 'Accept: application/json' \
    --max-time 5 \
    --fail-with-body \
    --silent
)

if [[ $? == 0 ]]; then
    readonly GREEN="\033[0;32m"
    echo -e "${GREEN}Has Permission!"
else
    if [[ "$body" != "" ]]; then
        echo "$body"
    fi
    readonly RED="\033[0;31m"
    echo -e "${RED}Permission Denied!"
fi
